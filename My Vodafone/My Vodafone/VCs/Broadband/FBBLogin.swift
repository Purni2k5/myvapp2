//
//  FBBLogin.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 03/01/2019.
//  Copyright © 2019 Chef Dennis Barimah. All rights reserved.
//

import UIKit
import LocalAuthentication

class FBBLogin: baseViewControllerM {

    let keyChain = KeychainSwift()
    let login_api = URL(string: String.MVA_LOGIN)
    
    var userID: String?
    var password: String?
    var accountNumber: String?
    
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
        label.text = "Fixed Broadband Login to \nMy Vodafone"
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
    
    let lblUserID: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 17)
        view.text = "User ID"
        return view
    }()
    
    let lblAccNumber: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 17)
        view.text = "Account Number"
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
    
    let txtUserID: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        view.backgroundColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 18)
        view.placeholder = "e.g. VodAfone1"
        return view
    }()
    
    let txtAccountNumber: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        view.backgroundColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 18)
        view.placeholder = "e.g. 10000000"
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
    
    let btnMSISDNLogin: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.grayButton
        btn.setTitle("Login with your Vodafone Number", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: String.defaultFontR, size: 20)
        
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

        setUpViewsFBBLogin()
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

    func setUpViewsFBBLogin(){
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
        lblHeader.leadingAnchor.constraint(equalTo: new_logo.trailingAnchor, constant: 20).isActive = true
        lblHeader.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30).isActive = true
        lblHeader.trailingAnchor.constraint(equalTo: motherViewLogin.trailingAnchor, constant: -40).isActive = true
        lblHeader.font = UIFont(name: String.defaultFontR, size: 31)
        
        //DarkView
        scrollView.addSubview(darkView)
        darkView.leadingAnchor.constraint(equalTo: motherViewLogin.leadingAnchor, constant: 20).isActive = true
        darkView.topAnchor.constraint(equalTo: lblHeader.bottomAnchor, constant: 20).isActive = true
        darkView.trailingAnchor.constraint(equalTo: motherViewLogin.trailingAnchor, constant: -20).isActive = true
        darkViewHeight = darkView.heightAnchor.constraint(equalToConstant: 680)
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
        
        darkView.addSubview(lblUserID)
        lblUserID.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        lblUsernameTop = lblUserID.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 20)
        lblUsernameTop?.isActive = true
        lblUserID.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        
        darkView.addSubview(txtUserID)
        txtUserID.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        txtUserID.topAnchor.constraint(equalTo: lblUserID.bottomAnchor, constant: 10).isActive = true
        txtUserID.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        txtUserID.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtUserID.autocapitalizationType = .none
        
        darkView.addSubview(lblAccNumber)
        lblAccNumber.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        lblAccNumber.topAnchor.constraint(equalTo: txtUserID.bottomAnchor, constant: 20).isActive = true
        lblAccNumber.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        
        darkView.addSubview(txtAccountNumber)
        txtAccountNumber.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        txtAccountNumber.topAnchor.constraint(equalTo: lblAccNumber.bottomAnchor, constant: 10).isActive = true
        txtAccountNumber.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        txtAccountNumber.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        darkView.addSubview(lblPassword)
        lblPassword.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        lblPassword.topAnchor.constraint(equalTo: txtAccountNumber.bottomAnchor, constant: 20).isActive = true
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
        
        darkView.addSubview(btnMSISDNLogin)
        btnMSISDNLogin.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        btnMSISDNLogin.topAnchor.constraint(equalTo: btnRegister.bottomAnchor, constant: 10).isActive = true
        btnMSISDNLogin.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        btnMSISDNLogin.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnMSISDNLogin.addTarget(self, action: #selector(goToMSISDNLogin), for: .touchUpInside)
        
        darkView.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: darkView.centerXAnchor).isActive = true
        activity_loader.topAnchor.constraint(equalTo: txtPassword.bottomAnchor, constant: 40).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        txtUserID.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
        txtPassword.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
        scrollView.contentSize.height = (lblHeader.frame.size.height + darkView.frame.size.height) + 50
    }
    
    @objc func checkInputs(){
        let userID = txtUserID.text
        let password = txtPassword.text
        let accountNumber = txtAccountNumber.text
        
        if userID != "" && password != "" && (password?.count)! >= 4 && accountNumber != "" {
            btnLogin.backgroundColor = UIColor.vodaRed
        }else{
            btnLogin.backgroundColor = UIColor.grayButton
        }
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
        
        txtUserID.text = secretUser!
        
        if authContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError){
            authContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: authReason, reply: { (success, error) in
                if success{
                    print("successful")
                    // UI Code here
                    DispatchQueue.main.async {
                        self.start_activity_loader()
                        
                        let secretPassword = self.keyChain.get(keyChainKeys.secretPassword.rawValue)
                        let getUser = self.txtUserID.text!
                        self.txtPassword.text = "******"
//                        self.touchAPICall(url: self.login_api!, secretPass: secretPassword!, username: getUser)
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
    
    @objc func goToForgottenPass(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "ForgotPassword")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToRegister(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "RegisterViewController")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToMSISDNLogin(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        present(moveTo, animated: true, completion: nil)
    }

    @objc func loginUser(){
        userID = txtUserID.text
        password = txtPassword.text
        userID = userID?.trimmingCharacters(in: .whitespacesAndNewlines)
        password = password?.trimmingCharacters(in: .whitespacesAndNewlines)
        accountNumber = txtAccountNumber.text
        
        if userID == "" {
            lblUsernameTop?.constant = 90
            errorDialog.isHidden = false
            lblErrorMessage.text = "Provide User ID"
            darkViewHeight?.constant = 735
            scrollView.contentSize.height = (lblHeader.frame.size.height + darkView.frame.size.height) + 120
        }else if accountNumber == "" {
            lblUsernameTop?.constant = 90
            errorDialog.isHidden = false
            lblErrorMessage.text = "Provide Account Number"
            darkViewHeight?.constant = 735
            scrollView.contentSize.height = (lblHeader.frame.size.height + darkView.frame.size.height) + 120
        }
            else if password == ""{
                lblUsernameTop?.constant = 90
                errorDialog.isHidden = false
                lblErrorMessage.text = "Provide Password"
                darkViewHeight?.constant = 735
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
                callLoginToAccount(url: login_api!, rawPassword: password!, username: userID!, accountNumber: accountNumber!)
            }
        }
    }
    
    //Function to make async call with parameters
    func callLoginToAccount(url: URL, rawPassword: String, username: String, accountNumber: String){
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        
        //hash password
        let securedPass = md5(rawPassword)
        let hashPass = securedPass.sha1()
        
        let postParameters:Dictionary<String, Any> = [
            "username":userID!,
            "account":accountNumber,
            "password":hashPass,
            "passClone":hashPass,
            "action":"fbbLoginToAccount",
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
                        self.darkViewHeight?.constant = 735
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
                        return
                        //getting the json response
                        responseCode = parseJSON["RESPONSECODE"] as! Int?
                        responseMessage = parseJSON["RESPONSEMESSAGE"] as? String
                        responseData = parseJSON["RESPONSEDATA"] as? NSDictionary
                        responseSession = parseJSON["SESSION"] as? NSDictionary
                        
                        DispatchQueue.main.async {
                            if responseCode == 0 {
                                if let responseData = responseData{
                                    let responseUsername = responseData["Username"] as! String
                                }
                            }else if responseCode == 1{
                                
                            }else{
                                
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
                        self.darkViewHeight?.constant = 735
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
}
