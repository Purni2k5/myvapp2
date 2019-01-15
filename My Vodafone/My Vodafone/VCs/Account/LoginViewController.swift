//
//  LoginViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 24/10/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: baseViewControllerM {

    var primaryID: String?
    var defaultAccName: String?
    var defaultMSISDN: String?
    var username: String?
    var password: String?
    var defaultSrve: String?
    
    let login_api = URL(string: String.MVA_LOGIN)
    
    let keyChain = KeychainSwift()
    
    fileprivate var lblUsernameTop: NSLayoutConstraint?
    fileprivate var darkViewHeight: NSLayoutConstraint?
    
    //create a closure for background Image
    let backImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //create a motherView
    let motherViewLogin: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    //create a scrollView
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    // Logo
    let new_logo: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "new_logo"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //header
    let lblHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Log in to \nMy Vodafone"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    //DarkView
    let darkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.60)
        view.isOpaque = false
        return view
    }()
    
    //Error dialog image
    let errorDialog: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "error_dialog_bg"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let errorImage: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "info"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblErrorMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.text = "Sorry you can't go to the system buyakkakl inside the Lorem ipsum magnita bombokin dae maleash"
        label.font = UIFont(name: String.defaultFontR, size: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let lblUsername: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 17)
        view.text = "Username"
        return view
    }()
    
    let lblPassword: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 17)
        view.text = "Password"
        return view
    }()
    
    let txtUsername: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        view.backgroundColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 18)
        view.placeholder = "e.g. kofi or 050555511"
        return view
    }()
    
    let txtPassword: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        view.backgroundColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 18)
        view.placeholder = "e.g. ****"
        view.isSecureTextEntry = true
        return view
    }()
    
    let btnLogin: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.grayButton
        btn.setTitle("Log in", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: String.defaultFontR, size: 20)
        return btn
    }()
    
    let btnForgottenPassword: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.gray
        btn.setTitle("Forgotten password", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: String.defaultFontR, size: 20)
        return btn
    }()
    
    let btnRegister: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.vodaRed
        btn.setTitle("Register now", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: String.defaultFontR, size: 20)
        return btn
    }()
    
    let btnFBBLogin: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.grayButton
        btn.setTitle("Login with Fixed Broadband", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: String.defaultFontR, size: 20)
        btn.isHidden = true
        return btn
    }()
    
    //create a closure for activity loader
    let activity_loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        view.hidesWhenStopped = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViewsLogin()
        checkConnection()
        hideKeyboardWhenTappedAround()
        checkIfTouchIDEnabled()
    }
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        btnLogin.isHidden = true
    }
    
    //Function to stopIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        btnLogin.isHidden = false
    }
    
    func setUpViewsLogin(){
        view.addSubview(backImage)
        let timeOfDay = greetings()
        if timeOfDay == "morning"{
            backImage.image = UIImage(named: "morning_bg_")
        }else if timeOfDay == "afternoon" {
            backImage.image = UIImage(named: "bg_afternoon")
        }else{
            backImage.image = UIImage(named: "evening_bg_")
        }
        backImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backImage.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        backImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backImage.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
        view.addSubview(motherViewLogin)
        motherViewLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        motherViewLogin.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        motherViewLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        motherViewLogin.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
        motherViewLogin.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: motherViewLogin.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: motherViewLogin.safeTopAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: motherViewLogin.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: motherViewLogin.safeBottomAnchor).isActive = true
        
        
        scrollView.addSubview(new_logo)
        new_logo.widthAnchor.constraint(equalToConstant: 50).isActive = true
        new_logo.heightAnchor.constraint(equalToConstant: 50).isActive = true
        new_logo.leadingAnchor.constraint(equalTo: motherViewLogin.leadingAnchor, constant: 20).isActive = true
        new_logo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        
        scrollView.addSubview(lblHeader)
        lblHeader.leadingAnchor.constraint(equalTo: motherViewLogin.leadingAnchor, constant: 40).isActive = true
        lblHeader.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30).isActive = true
        lblHeader.trailingAnchor.constraint(equalTo: motherViewLogin.trailingAnchor, constant: -40).isActive = true
        lblHeader.font = UIFont(name: String.defaultFontR, size: 31)
        
        //DarkView
        scrollView.addSubview(darkView)
        darkView.leadingAnchor.constraint(equalTo: motherViewLogin.leadingAnchor, constant: 20).isActive = true
        darkView.topAnchor.constraint(equalTo: lblHeader.bottomAnchor, constant: 20).isActive = true
        darkView.trailingAnchor.constraint(equalTo: motherViewLogin.trailingAnchor, constant: -20).isActive = true
        darkViewHeight = darkView.heightAnchor.constraint(equalToConstant: 580)
        darkViewHeight?.isActive = true
        
        //Error Dialog
        darkView.addSubview(errorDialog)
        errorDialog.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        errorDialog.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 20).isActive = true
        errorDialog.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        errorDialog.heightAnchor.constraint(equalToConstant: 80).isActive = true
        errorDialog.isHidden = true
        
        errorDialog.addSubview(errorImage)
        errorImage.leadingAnchor.constraint(equalTo: errorDialog.leadingAnchor, constant: 10).isActive = true
        errorImage.topAnchor.constraint(equalTo: errorDialog.topAnchor, constant: 15).isActive = true
        errorImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        errorImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        errorDialog.addSubview(lblErrorMessage)
        lblErrorMessage.leadingAnchor.constraint(equalTo: errorImage.trailingAnchor, constant: 10).isActive = true
        lblErrorMessage.topAnchor.constraint(equalTo: errorDialog.topAnchor, constant: 15).isActive = true
        lblErrorMessage.trailingAnchor.constraint(equalTo: errorDialog.trailingAnchor, constant: -10).isActive = true
        
        darkView.addSubview(lblUsername)
        lblUsername.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        lblUsernameTop = lblUsername.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 20)
        lblUsernameTop?.isActive = true
        lblUsername.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        
        darkView.addSubview(txtUsername)
        txtUsername.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        txtUsername.topAnchor.constraint(equalTo: lblUsername.bottomAnchor, constant: 10).isActive = true
        txtUsername.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        txtUsername.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtUsername.autocapitalizationType = .none
        
        darkView.addSubview(lblPassword)
        lblPassword.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        lblPassword.topAnchor.constraint(equalTo: txtUsername.bottomAnchor, constant: 20).isActive = true
        lblPassword.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        
        darkView.addSubview(txtPassword)
        txtPassword.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        txtPassword.topAnchor.constraint(equalTo: lblPassword.bottomAnchor, constant: 10).isActive = true
        txtPassword.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        txtPassword.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        darkView.addSubview(btnLogin)
        btnLogin.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        btnLogin.topAnchor.constraint(equalTo: txtPassword.bottomAnchor, constant: 40).isActive = true
        btnLogin.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        btnLogin.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnLogin.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
        
        darkView.addSubview(btnForgottenPassword)
        btnForgottenPassword.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        btnForgottenPassword.topAnchor.constraint(equalTo: btnLogin.bottomAnchor, constant: 10).isActive = true
        btnForgottenPassword.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        btnForgottenPassword.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnForgottenPassword.addTarget(self, action: #selector(goToForgottenPass), for: .touchUpInside)
        
        let lblRegister = UILabel()
        scrollView.addSubview(lblRegister)
        lblRegister.translatesAutoresizingMaskIntoConstraints = false
        lblRegister.textColor = UIColor.white
        lblRegister.text = "Not registered with \nMy Vodafone?"
        lblRegister.textAlignment = .center
        lblRegister.numberOfLines = 0
        lblRegister.lineBreakMode = .byWordWrapping
        lblRegister.font = UIFont(name: String.defaultFontR, size: 30)
        lblRegister.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        lblRegister.topAnchor.constraint(equalTo: btnForgottenPassword.bottomAnchor, constant: 30).isActive = true
        lblRegister.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        
        darkView.addSubview(btnRegister)
        btnRegister.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        btnRegister.topAnchor.constraint(equalTo: lblRegister.bottomAnchor, constant: 20).isActive = true
        btnRegister.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        btnRegister.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnRegister.addTarget(self, action: #selector(goToRegister), for: .touchUpInside)
        
        darkView.addSubview(btnFBBLogin)
        btnFBBLogin.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        btnFBBLogin.topAnchor.constraint(equalTo: btnRegister.bottomAnchor, constant: 10).isActive = true
        btnFBBLogin.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        btnFBBLogin.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnFBBLogin.addTarget(self, action: #selector(goToFBBLogin), for: .touchUpInside)
        
        darkView.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: darkView.centerXAnchor).isActive = true
        activity_loader.topAnchor.constraint(equalTo: txtPassword.bottomAnchor, constant: 40).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        txtUsername.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
        txtPassword.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
        scrollView.contentSize.height = (lblHeader.frame.size.height + darkView.frame.size.height) + 50
    }
    
    @objc func checkInputs(){
        let username = txtUsername.text
        let password = txtPassword.text
        
        if username != "" && password != "" && (password?.count)! >= 4 {
            btnLogin.backgroundColor = UIColor.vodaRed
            btnLogin.isEnabled = true
        }else{
            btnLogin.backgroundColor = UIColor.grayButton
            btnLogin.isEnabled = false
        }
    }
    
    @objc func goToForgottenPass(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "ForgotPassword")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToFBBLogin(){
        let storyboard = UIStoryboard(name: "FBB", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "FBBLogin")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToRegister(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "RegisterViewController")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func loginUser(){
        username = txtUsername.text
        password = txtPassword.text
        username = username?.trimmingCharacters(in: .whitespacesAndNewlines)
        password = password?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if username == "" || password == "" {
            lblUsernameTop?.constant = 90
            errorDialog.isHidden = false
            lblErrorMessage.text = "Provide Username / Password"
            darkViewHeight?.constant = 660
            scrollView.contentSize.height = (lblHeader.frame.size.height + darkView.frame.size.height) + 120
        }else {
            lblUsernameTop?.constant = 20
            errorDialog.isHidden = true
            darkViewHeight?.constant = 600
            
            //check if there is internet connection
            if !CheckInternet.Connection(){
                let storyboard = UIStoryboard(name: "Support", bundle: nil)
                let moveTo = storyboard.instantiateViewController(withIdentifier: "NointernetViewController")
                self.addChildViewController(moveTo)
                moveTo.view.frame = self.view.frame
                self.view.addSubview(moveTo.view)
                moveTo.didMove(toParentViewController: self)
            }else{
                start_activity_loader()
                callLoginToAccount(url: login_api!, rawPassword: password!, username: username!)
            }
        }
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
                        self.stop_activity_loader()
                        self.errorDialog.isHidden = false
                        self.lblErrorMessage.text = error!.localizedDescription
                        self.lblUsernameTop?.constant = 90
                        self.darkViewHeight?.constant = 660
                        self.scrollView.contentSize.height = (self.lblHeader.frame.size.height + self.darkView.frame.size.height) + 90
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
                            let default_service = responseData["DefaultService"] as? String
                            self.preference.set(default_service, forKey: "DefaultService")
                            let defaultService = self.preference.object(forKey: "DefaultService") as? String
                            if let defaultSrve = defaultService {
                                print("defaultSrve \(defaultSrve)")
                            }else{
                                print("Doing this")
                                DispatchQueue.main.async {
                                    self.preference.set(responseData, forKey: "responseData")
                                    
                                    let storyboard = UIStoryboard(name: "ProductsServices", bundle: nil)
                                    let moveTo = storyboard.instantiateViewController(withIdentifier: "ProductsServicesViewController")
                                    self.present(moveTo, animated: true, completion: nil)
                                }
                                return
                            }
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
                                
                                self.stop_activity_loader()
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
                                }else if self.AcctType == "PHONE_MOBILE_POST_P"{
                                    let storyboard = UIStoryboard(name: "PostPaid", bundle: nil)
                                    let moveTo = storyboard.instantiateViewController(withIdentifier: "postPaidHome")
                                    self.present(moveTo, animated: true, completion: nil)
                                }
                                else{
                                    print("fbb here")
                                    //go to home screen
                                    let storyboard = UIStoryboard(name: "Broadband", bundle: nil)
                                    let moveTo = storyboard.instantiateViewController(withIdentifier: "broadbandHome")
                                    self.present(moveTo, animated: true, completion: nil)
                                }
                                
                            }else{
                                print("Was zero \(responseCode)")
                                self.stop_activity_loader()
                                //display error message
                                self.errorDialog.isHidden = false
                                self.lblErrorMessage.text = responseMessage
                                self.lblUsernameTop?.constant = 90
                                self.darkViewHeight?.constant = 660
                                self.scrollView.contentSize.height = (self.lblHeader.frame.size.height + self.darkView.frame.size.height) + 90
                            }
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.stop_activity_loader()
                        //display error message
                        self.errorDialog.isHidden = false
                        self.lblErrorMessage.text = error.localizedDescription
                        self.lblUsernameTop?.constant = 90
                        self.darkViewHeight?.constant = 660
                        self.scrollView.contentSize.height = (self.lblHeader.frame.size.height + self.darkView.frame.size.height) + 90
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
                        self.start_activity_loader()
                        
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
                        self.stop_activity_loader()
                        self.errorDialog.isHidden = false
                        self.lblErrorMessage.text = error!.localizedDescription
                        self.lblUsernameTop?.constant = 90
                        self.darkViewHeight?.constant = 660
                        self.scrollView.contentSize.height = (self.lblHeader.frame.size.height + self.darkView.frame.size.height) + 90
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
                                self.stop_activity_loader()
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
                                }else if self.AcctType == "PHONE_MOBILE_POST_P"{
                                    let storyboard = UIStoryboard(name: "PostPaid", bundle: nil)
                                    let moveTo = storyboard.instantiateViewController(withIdentifier: "postPaidHome")
                                    self.present(moveTo, animated: true, completion: nil)
                                }
                                else{
                                    print("fbb here")
                                    //go to home screen
                                    let storyboard = UIStoryboard(name: "Broadband", bundle: nil)
                                    let moveTo = storyboard.instantiateViewController(withIdentifier: "broadbandHome")
                                    self.present(moveTo, animated: true, completion: nil)
                                }
                            }else{
                                self.stop_activity_loader()
                                //display error message
                                self.errorDialog.isHidden = false
                                self.lblErrorMessage.text = responseMessage
                                self.lblUsernameTop?.constant = 90
                                self.darkViewHeight?.constant = 660
                                self.scrollView.contentSize.height = (self.lblHeader.frame.size.height + self.darkView.frame.size.height) + 90
                            }
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.stop_activity_loader()
                        //display error message
                        self.errorDialog.isHidden = false
                        self.lblErrorMessage.text = error.localizedDescription
                        self.lblUsernameTop?.constant = 90
                        self.darkViewHeight?.constant = 660
                        self.scrollView.contentSize.height = (self.lblHeader.frame.size.height + self.darkView.frame.size.height) + 90
                    }
                    print(error)
                }
            }
            //executing the task
            task.resume()
        }
    }

}
