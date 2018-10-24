//
//  LoginViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 20/06/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit
import LocalAuthentication

class OldLoginViewController: baseViewControllerM {

    var primaryID: String?
    var defaultAccName: String?
    var defaultMSISDN: String?
    var username: String?
    var password: String?
    
    
    @IBOutlet weak var loginHeader: UILabel!
    
    @IBOutlet weak var error_dialog_bg: UIImageView!
    @IBOutlet weak var img_info: UIImageView!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnForgottenPassword: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    
    //Constraints
    @IBOutlet weak var usernameTopConstraint: NSLayoutConstraint!
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    let login_api = URL(string: String.MVA_LOGIN)

    let keyChain = KeychainSwift()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        btnForgottenPassword.addTarget(self, action: #selector(goToPasswordRec), for: .touchUpInside)
        
        loginHeader.text = "Log in to \nMy Vodafone"
        indicator.isHidden = true
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkIfTouchIDEnabled()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        username = txtUsername.text
        password = txtPassword.text
        username?.trimmingCharacters(in: .whitespacesAndNewlines)
        password?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if username == "" || password == "" {
            usernameTopConstraint.constant = 90
            error_dialog_bg.isHidden = false
            img_info.isHidden = false
            errorMessage.text = "Provide Username / Password"
            errorMessage.isHidden = false
        }else{
            usernameTopConstraint.constant = 30
            error_dialog_bg.isHidden = true
            img_info.isHidden = true
            errorMessage.isHidden = true
            
            txtUsername.resignFirstResponder()
            txtPassword.resignFirstResponder()
            
            //check if there is internet connection
            if !CheckInternet.Connection(){
                let storyboard = UIStoryboard(name: "Support", bundle: nil)
                let moveTo = storyboard.instantiateViewController(withIdentifier: "NointernetViewController")
                self.addChildViewController(moveTo)
                moveTo.view.frame = self.view.frame
                self.view.addSubview(moveTo.view)
                moveTo.didMove(toParentViewController: self)
            }else{
                startAsyncLoader()
               callLoginToAccount(url: login_api!, rawPassword: password!, username: username!)
            }
            
        }
    }
    
    //Function to start Indicator or loader
    func startAsyncLoader(){
        indicator.isHidden = false
        indicator.hidesWhenStopped = true
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        indicator.startAnimating()
        btnLogin.isHidden = true
        btnRegister.isEnabled = false
        btnForgottenPassword.isEnabled = false
    }
    
    //Function to stop Indicator
    func stopAsyncLoader(){
        indicator.isHidden = true
        indicator.stopAnimating()
        btnLogin.isHidden = false
        btnRegister.isEnabled = true
        btnForgottenPassword.isEnabled = true
    }
    
    //Function to make async call with parameters
    func callLoginToAccount(url: URL, rawPassword: String, username: String){
        let request = NSMutableURLRequest(url: url)
//        let urlConfig = URLSessionConfiguration.default
//        urlConfig.timeoutIntervalForRequest = 30.0
//        urlConfig.timeoutIntervalForResource = 60.0
        request.httpMethod = "POST"
        
        //hash password
        let securedPass = md5(rawPassword)
        let hashPass = securedPass.sha1()
        
        let postParameters:Dictionary<String, Any> = [
            "username":username,
            "password":hashPass,
            "action":"loginToAccount",
            "os":getAppVersion()
        ]
//        print("hashii:: \(hashPass)")
        if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
            request.httpBody = postData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            //creating a task to send the post request
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                if error != nil{
                    print("error is \(error!.localizedDescription)")
                    DispatchQueue.main.async {
                        //Todo
                        self.stopAsyncLoader()
                        self.errorMessage.isHidden = false
                        self.img_info.isHidden = false
                        self.error_dialog_bg.isHidden = false
                        self.errorMessage.text = error!.localizedDescription
                        self.usernameTopConstraint.constant = 90
                    }
                    return;
                }
                //parsing the response
                do{
                    //converting response to NSDictionary
                    let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    //parsing the json
                    if let parseJSON = myJSON {
                        print("here")
                        //creating variables to hold response
                        var responseCode: Int!
                        var responseMessage: String!
                        var responseData: NSDictionary!
                        var responseSession: NSDictionary!
                        print(parseJSON)
                        //getting the json response
                        responseCode = parseJSON["RESPONSECODE"] as! Int?
                        responseMessage = parseJSON["RESPONSEMESSAGE"] as! String?
                        responseData = parseJSON["RESPONSEDATA"] as! NSDictionary?
                        responseSession = parseJSON["SESSION"] as! NSDictionary?
                        
                        if responseData != nil {
                            self.preference.set(responseData["ServiceList"] as! NSArray, forKey: UserDefaultsKeys.ServiceList.rawValue)
                            let obj = responseData["AccountStatus"] as! String
                            let Services = self.preference.object(forKey: UserDefaultsKeys.ServiceList.rawValue)
                            let default_service = responseData["DefaultService"] as! String
                            self.preference.set(default_service, forKey: "DefaultService")
                            let defaultService = self.preference.object(forKey: "DefaultService") as! String
                            if let array = Services as? NSArray {
                                var foundDefault = false
                                
                                for obj in array {
                                    if foundDefault == false{
                                        if let dict = obj as? NSDictionary {
                                            // Now reference the data you need using:
                                            self.ServiceID = dict.value(forKey: "ID") as! String?
                                            self.AcctType = dict.value(forKey: "Type") as! String?
                                            
                                            if(self.ServiceID == defaultService){
                                                self.defaultAccName = dict.value(forKey: "DisplayName") as! String?
                                                self.primaryID = dict.value(forKey: "primaryID") as! String?
                                                self.AcctType = dict.value(forKey: "Type") as! String?
                                                foundDefault = true
                                                print("Got it") 
                                            }else{
                                                print("this happened")
                                                //Just pick one to display
                                                self.defaultAccName = dict.value(forKey: "DisplayName") as! String?
                                                self.ServiceID = dict.value(forKey: "ID") as! String?
                                                self.AcctType = dict.value(forKey: "Type") as! String?
                                                self.primaryID = dict.value(forKey: "primaryID") as! String?
//                                                self.preference.set(self.ServiceID, forKey: "DefaultService")
                                                //                            foundDefault = true
                                            }
                                        }
                                    }
                                    
                                }
                            }
//                            print("Primary ID:: \(self.primaryID!)")
//                            print("Display Name:: \(self.defaultAccName!)")
                            let defaultNum = self.primaryID?.dropFirst(3)
                            self.primaryID = "0\(defaultNum!)"
                            self.preference.set(self.primaryID, forKey: "defaultMSISDN")
                            self.preference.set(self.defaultAccName, forKey: UserDefaultsKeys.defaultName.rawValue)
                            self.preference.set(self.ServiceID, forKey: UserDefaultsKeys.defaultName.rawValue)
                            print("Account stat: \(obj)")
                            
                            let session = responseSession["session"] as! String
                            let secret = responseSession["secret"] as! String
                            let key = responseSession["key"] as! String
                            
                            //Save secrets
                            self.preference.set(session, forKey: UserDefaultsKeys.userSession.rawValue)
                            self.preference.set(secret, forKey: UserDefaultsKeys.userSecret.rawValue)
                            self.preference.set(key, forKey: UserDefaultsKeys.userKey.rawValue)
                        }
                        
                        
                        print(responseCode)
                        print("-------------- response data -------------")
                        
//                        self.stopAsyncLoader()
                        DispatchQueue.main.async { // Correct
                            if responseCode == 0{
                                
                                self.stopAsyncLoader()
                                self.preference.set("Yes", forKey: "loginStatus")
                                self.preference.set(responseData, forKey: "responseData")
                                
                                self.keyChain.set(hashPass, forKey: keyChainKeys.secretPassword.rawValue)
                                self.keyChain.set(username, forKey: keyChainKeys.secretUser.rawValue)
                                self.keyHardening()
                                
                                if(self.AcctType == "PHONE_MOBILE_PRE_P"){
                                    //go to home screen
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let moveTo = storyboard.instantiateViewController(withIdentifier: "homeVC")
                                    self.present(moveTo, animated: true, completion: nil)
                                }else if(self.AcctType == "PHONE_MOBILE_POST_P"){
                                    //go to home screen
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let moveTo = storyboard.instantiateViewController(withIdentifier: "homeVC")
                                    self.present(moveTo, animated: true, completion: nil)
                                }else if(self.AcctType == "PHONE_MOBILE_HYBRID"){
                                    //go to home screen
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let moveTo = storyboard.instantiateViewController(withIdentifier: "homeVC")
                                    self.present(moveTo, animated: true, completion: nil)
                                }else{
                                    print("fbb here")
                                    //go to home screen
                                    let storyboard = UIStoryboard(name: "Broadband", bundle: nil)
                                    let moveTo = storyboard.instantiateViewController(withIdentifier: "broadbandHome")
                                    self.present(moveTo, animated: true, completion: nil)
                                }
                                
                            }else{
                                print("Was zero \(responseCode)")
                                self.stopAsyncLoader()
                                //display error message
                                self.errorMessage.isHidden = false
                                self.img_info.isHidden = false
                                self.error_dialog_bg.isHidden = false
                                self.errorMessage.text = responseMessage
                                self.usernameTopConstraint.constant = 90
                            }
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.stopAsyncLoader()
                        self.errorMessage.isHidden = false
                        self.img_info.isHidden = false
                        self.error_dialog_bg.isHidden = false
                        self.errorMessage.text = error.localizedDescription
                        self.usernameTopConstraint.constant = 90
                    }
                    print(error)
                }
            }
            //executing the task
            task.resume()
        }
        
    }
    //Hashing function
    func md5(_ string: String) -> String {
        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
        var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5_Init(context)
        CC_MD5_Update(context, string, CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8)))
        CC_MD5_Final(&digest, context)
        context.deallocate(capacity: 1)
        var hexString = ""
        for byte in digest {
            hexString += String(format:"%02x", byte)
        }
        return hexString
    }

    //Check if touch id is enabled
    func checkIfTouchIDEnabled(){
        let touchStatus = preference.object(forKey: UserDefaultsKeys.touchIDEnabled.rawValue) as? Bool
        
        if touchStatus == true {
            print("Pop up finger print")
            authenticateUsingTouchID()
        }else{
            print("Dont pop up finger print")
        }
    }
    
    
    //Touch ID authentication
    func authenticateUsingTouchID(){
        let authContext = LAContext()
        
        let secretUser = keyChain.get(keyChainKeys.secretUser.rawValue)
        
        
        let authReason = "Please use touch ID to log in to  \(secretUser!)'s account"
        var authError: NSError?
        
        txtUsername.text = secretUser!
        
        if authContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError){
            authContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: authReason, reply: { (success, error) in
                if success{
                    print("successful")
                    // UI Code here
                    DispatchQueue.main.async {
                        self.startAsyncLoader()
                        
                        let secretPassword = self.keyChain.get(keyChainKeys.secretPassword.rawValue)
                        let getUser = self.txtUsername.text!
                        self.txtPassword.text = "******"
                        self.touchAPICall(url: self.login_api!, secretPass: secretPassword!, username: getUser)
                    }
                }else {
                    if let error = error {
                        self.reportTouchIDError(error: error as NSError)
                    }
                }
            })
        }else{
            //error
            print(authError?.localizedDescription)
            //show login
        }
    }
    //Function to report touch ID Error
    func reportTouchIDError(error: NSError){
        switch error.code {
        case LAError.authenticationFailed.rawValue:
            print("Authentication failed")
        case LAError.passcodeNotSet.rawValue:
            print("passcode not set")
        case LAError.systemCancel.rawValue:
            print("authentication was canceled by the system")
        case LAError.userCancel.rawValue:
            print("user canceled auth")
        case LAError.biometryNotEnrolled.rawValue:
            print("user has not enrolled any finger on touch id")
        case LAError.biometryNotAvailable.rawValue:
            print("Touch id is not available")
        case LAError.userFallback.rawValue:
            print("user tapped enter password")
        default:
            print(error.localizedDescription)
        }
    }
    
    func touchAPICall(url: URL, secretPass: String, username: String){
        print("called touchAPI")
        let request = NSMutableURLRequest(url: url)
        let urlConfig = URLSessionConfiguration.default
        urlConfig.timeoutIntervalForRequest = 30.0
        urlConfig.timeoutIntervalForResource = 60.0
        request.httpMethod = "POST"
       
        
        let postParameters:Dictionary<String, Any> = [
            "username":username,
            "password":secretPass,
            "action":"loginToAccount",
            "os":getAppVersion()
        ]
        if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
            request.httpBody = postData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            //creating a task to send the post request
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                if error != nil{
                    print("error is \(error!.localizedDescription)")
                    DispatchQueue.main.async {
                        //Todo
                        self.stopAsyncLoader()
                        self.errorMessage.isHidden = false
                        self.img_info.isHidden = false
                        self.error_dialog_bg.isHidden = false
                        self.errorMessage.text = error!.localizedDescription
                        self.usernameTopConstraint.constant = 90
                    }
                    return;
                }
                //parsing the response
                do{
                    //converting response to NSDictionary
                    let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    //parsing the json
                    if let parseJSON = myJSON {
                        
                        //creating variables to hold response
                        var responseCode: Int!
                        var responseMessage: String!
                        var responseData: NSDictionary!
                        var responseSession: NSDictionary!
                        //getting the json response
                        responseCode = parseJSON["RESPONSECODE"] as! Int?
                        responseMessage = parseJSON["RESPONSEMESSAGE"] as! String
                        responseData = parseJSON["RESPONSEDATA"] as! NSDictionary?
                        responseSession = parseJSON["SESSION"] as! NSDictionary?
                        print("responseDatasss:: \(responseData)")
                        
                        if responseData != nil {
                            self.preference.set(responseData["ServiceList"] as! NSArray, forKey: UserDefaultsKeys.ServiceList.rawValue)
                            let obj = responseData["AccountStatus"] as! String
                            let Services = self.preference.object(forKey: UserDefaultsKeys.ServiceList.rawValue)
                            let default_service = responseData["DefaultService"] as! String
                            self.preference.set(default_service, forKey: "DefaultService")
                            let defaultService = self.preference.object(forKey: "DefaultService") as! String
                            if let array = Services as? NSArray {
                                var foundDefault = false
                                
                                for obj in array {
                                    if foundDefault == false{
                                        if let dict = obj as? NSDictionary {
                                            // Now reference the data you need using:
                                            self.ServiceID = dict.value(forKey: "ID") as! String?
                                            self.AcctType = dict.value(forKey: "Type") as! String?
                                            
                                            if(self.ServiceID == defaultService){
                                                self.defaultAccName = dict.value(forKey: "DisplayName") as! String?
                                                self.primaryID = dict.value(forKey: "primaryID") as! String?
                                                self.AcctType = dict.value(forKey: "Type") as! String?
                                                foundDefault = true
                                                print("Got it")
                                                
                                            }else{
                                                //Just pick one to display
                                                self.defaultAccName = dict.value(forKey: "DisplayName") as! String?
                                                self.ServiceID = dict.value(forKey: "ID") as! String?
                                                self.AcctType = dict.value(forKey: "Type") as! String?
                                                self.primaryID = dict.value(forKey: "primaryID") as! String?
                                                //                            foundDefault = true
                                            }
                                        }
                                    }
                                    
                                }
                            }
                            print("Primary ID:: \(self.primaryID!)")
                            print("Display Name:: \(self.defaultAccName!)")
                            let defaultNum = self.primaryID?.dropFirst(3)
                            self.primaryID = "0\(defaultNum!)"
                            self.preference.set(self.primaryID, forKey: "defaultMSISDN")
                            self.preference.set(self.defaultAccName, forKey: UserDefaultsKeys.defaultName.rawValue)
                            print("Account stat: \(obj)")
                            
                            let session = responseSession["session"] as! String
                            let secret = responseSession["secret"] as! String
                            let key = responseSession["key"] as! String
                            
                            
                            //Save secrets
                            self.preference.set(session, forKey: UserDefaultsKeys.userSession.rawValue)
                            self.preference.set(secret, forKey: UserDefaultsKeys.userSecret.rawValue)
                            self.preference.set(key, forKey: UserDefaultsKeys.userKey.rawValue)
                        }
                        
                        
                        print(responseCode)
                        print("-------------- response data -------------")
                        print(parseJSON)
                        //                        self.stopAsyncLoader()
                        DispatchQueue.main.async { // Correct
                            if responseCode == 0{
                                self.stopAsyncLoader()
                                self.preference.set("Yes", forKey: "loginStatus")
                                self.preference.set(responseData, forKey: "responseData")
                                self.keyHardening()
                                
                                if(self.AcctType == "PHONE_MOBILE_PRE_P"){
                                    //go to home screen
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let moveTo = storyboard.instantiateViewController(withIdentifier: "homeVC")
                                    self.present(moveTo, animated: true, completion: nil)
                                }else if(self.AcctType == "PHONE_MOBILE_POST_P"){
                                    //go to home screen
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let moveTo = storyboard.instantiateViewController(withIdentifier: "homeVC")
                                    self.present(moveTo, animated: true, completion: nil)
                                }else if(self.AcctType == "PHONE_MOBILE_HYBRID"){
                                    //go to home screen
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let moveTo = storyboard.instantiateViewController(withIdentifier: "homeVC")
                                    self.present(moveTo, animated: true, completion: nil)
                                }else{
                                    print("fbb here")
                                    //go to home screen
                                    let storyboard = UIStoryboard(name: "Broadband", bundle: nil)
                                    let moveTo = storyboard.instantiateViewController(withIdentifier: "broadbandHome")
                                    self.present(moveTo, animated: true, completion: nil)
                                }
                            }else{
                                self.stopAsyncLoader()
                                //display error message
                                self.errorMessage.isHidden = false
                                self.img_info.isHidden = false
                                self.error_dialog_bg.isHidden = false
                                self.errorMessage.text = responseMessage
                                self.usernameTopConstraint.constant = 90
                            }
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.stopAsyncLoader()
                        self.errorMessage.isHidden = false
                        self.img_info.isHidden = false
                        self.error_dialog_bg.isHidden = false
                        self.errorMessage.text = error.localizedDescription
                        self.usernameTopConstraint.constant = 90
                    }
                    print(error)
                }
            }
            //executing the task
            task.resume()
        }
    }
    
    @objc func goToPasswordRec(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "ForgotPassword")
        present(moveTo, animated: true, completion: nil)
    }

}

extension String {
    func sha1() -> String {
        let data = self.data(using: String.Encoding.utf8)!
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA1($0, CC_LONG(data.count), &digest)
        }
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
    }
}
