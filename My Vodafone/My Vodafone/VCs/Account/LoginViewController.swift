//
//  LoginViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 20/06/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class LoginViewController: baseViewControllerM {

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
    //http://testpay.vodafonecash.com.gh/MyVodafoneAPI/UserSvc
    let login_api = URL(string: "https://myvodafoneappmw.vodafone.com.gh/MyVodafoneAPI/UserSvc")
//    let preference = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
        loginHeader.text = "Log in to \nMy Vodafone"
        indicator.isHidden = true
        
        //print login status
//        let loginStatus = preference.object(forKey: "loginStatus")
//        print("login stat: \(loginStatus!)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        let username = txtUsername.text
        let password = txtPassword.text
        username?.trimmingCharacters(in: .whitespacesAndNewlines)
        password?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if username == "" || password == "" {
            usernameTopConstraint.constant = 90
            error_dialog_bg.isHidden = false
            img_info.isHidden = false
            errorMessage.text = "Provide Username / Password"
            errorMessage.isHidden = false
//            btnLogin.isEnabled = false
        }else{
            usernameTopConstraint.constant = 30
            error_dialog_bg.isHidden = true
            img_info.isHidden = true
            errorMessage.isHidden = true
            
            let userData = [
                "username":username,
                "password":password
            ]
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
        let urlConfig = URLSessionConfiguration.default
        urlConfig.timeoutIntervalForRequest = 30.0
        urlConfig.timeoutIntervalForResource = 60.0
        request.httpMethod = "POST"
        
        //hash password
        let securedPass = md5(rawPassword)
        let hashPass = securedPass.sha1()
        print("secured password: \(hashPass)")
        let postParameters:Dictionary<String, Any> = [
            "username":username,
            "password":hashPass,
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
                        //getting the json response
                        responseCode = parseJSON["RESPONSECODE"] as! Int?
                        responseMessage = parseJSON["RESPONSEMESSAGE"] as! String
                        responseData = parseJSON["RESPONSEDATA"] as! NSDictionary?
                        
                        if responseData != nil {
                            self.preference.set(responseData["ServiceList"] as! NSArray, forKey: "ServiceList")
                            let obj = responseData["AccountStatus"] as! String
                            print("Account stat: \(obj)")
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
                                //go to home screen
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let moveTo = storyboard.instantiateViewController(withIdentifier: "homeVC")
                                self.present(moveTo, animated: true, completion: nil)
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
