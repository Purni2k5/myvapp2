//
//  postPaidLogin.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 08/11/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit
import LocalAuthentication

class postPaidLogin: baseViewControllerM {
    
    var username: String?
    var msisdn: String?
    
    let keyChain = KeychainSwift()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let bgImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let motherViewPPLogin: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate var darkViewHeight: NSLayoutConstraint!
    fileprivate var usernameTop: NSLayoutConstraint!
    
    let darkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        view.isOpaque = false
        return view
    }()
    
    let txtUsername: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        view.heightAnchor.constraint(equalToConstant: 45).isActive = true
        view.backgroundColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 16)
        view.autocapitalizationType = .none
        return view
    }()
    
    let txtPassword: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        view.heightAnchor.constraint(equalToConstant: 45).isActive = true
        view.backgroundColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 16)
        view.placeholder = "e.g. ****"
        return view
    }()
    
    let btnConfirm: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.grayButton
        view.setTitle("Confirm", for: .normal)
        view.heightAnchor.constraint(equalToConstant: 55).isActive = true
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        view.isEnabled = false
        return view
    }()
    
    let btnCancel: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray
        view.setTitle("Cancel", for: .normal)
        view.heightAnchor.constraint(equalToConstant: 55).isActive = true
        view.setTitleColor(UIColor.black, for: .normal)
        view.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        return view
    }()
    
    let btnUserTouchID: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.vodaRed
        view.setTitle("User Touch ID", for: .normal)
        view.heightAnchor.constraint(equalToConstant: 55).isActive = true
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        return view
    }()
    
    let btnRemember: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        let checkBoxImage = UIImage(named: "Checkbox")
        view.setImage(checkBoxImage, for: .normal)
        return view
    }()
    
    //create a closure for activity loader
    let activity_loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        view.hidesWhenStopped = true
        return view
    }()
    
    var isChecked: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        
        hideKeyboardWhenTappedAround()
        let responseData = preference.object(forKey: "responseData") as! NSDictionary
        username = responseData["Username"] as? String
        
        setUpViewsPPLogin()
        
        checkConnection()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        txtUsername.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
        txtPassword.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
    }
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        btnConfirm.isHidden = true
    }
    
    //Function to stopIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        btnConfirm.isHidden = false
    }

    func setUpViewsPPLogin(){
        let viewWidth = view.frame.width
        let viewHeight = view.frame.height
        view.addSubview(bgImage)
        let timeOfDay = greetings()
        if timeOfDay == "morning"{
            bgImage.image = UIImage(named: "morning_bg_")
        }else if timeOfDay == "afternoon" {
            bgImage.image = UIImage(named: "bg_afternoon")
        }else{
            bgImage.image = UIImage(named: "evening_bg_")
        }
        
        bgImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bgImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bgImage.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        bgImage.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
        view.addSubview(motherViewPPLogin)
        motherViewPPLogin.backgroundColor = UIColor.clear
        motherViewPPLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        motherViewPPLogin.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        motherViewPPLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        motherViewPPLogin.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        motherViewPPLogin.addSubview(scrollView)
        scrollView.backgroundColor = UIColor.clear
        scrollView.leadingAnchor.constraint(equalTo: motherViewPPLogin.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: motherViewPPLogin.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: motherViewPPLogin.safeTopAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: motherViewPPLogin.safeBottomAnchor).isActive = true
        
        //app logo
        let app_logo = UIImageView(image: #imageLiteral(resourceName: "voda_logo"))
        scrollView.addSubview(app_logo)
        app_logo.translatesAutoresizingMaskIntoConstraints = false
        app_logo.heightAnchor.constraint(equalToConstant: 48).isActive = true
        app_logo.widthAnchor.constraint(equalToConstant: 48).isActive = true
        app_logo.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10).isActive = true
        app_logo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        
        let lblHeader = UILabel()
        scrollView.addSubview(lblHeader)
        lblHeader.translatesAutoresizingMaskIntoConstraints = false
        lblHeader.text = "Please login"
        lblHeader.textColor = UIColor.white
        lblHeader.numberOfLines = 0
        lblHeader.lineBreakMode = .byWordWrapping
        lblHeader.centerXAnchor.constraint(equalTo: motherViewPPLogin.centerXAnchor).isActive = true
        lblHeader.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40).isActive = true
        lblHeader.font = UIFont(name: String.defaultFontR, size: 31)
        
        scrollView.addSubview(darkView)
        darkView.leadingAnchor.constraint(equalTo: motherViewPPLogin.leadingAnchor, constant: 20).isActive = true
        darkView.topAnchor.constraint(equalTo: lblHeader.bottomAnchor, constant: 20).isActive = true
        darkView.trailingAnchor.constraint(equalTo: motherViewPPLogin.trailingAnchor, constant: -20).isActive = true
        darkViewHeight = darkView.heightAnchor.constraint(equalToConstant: 600)
        darkViewHeight.isActive = true
        
        let loginDesc = UILabel()
        loginDesc.translatesAutoresizingMaskIntoConstraints = false
        darkView.addSubview(loginDesc)
        loginDesc.textColor = UIColor.white
        loginDesc.text = "You are about to see sensitive information. Please confirm your details to continue."
        loginDesc.textAlignment = .center
        loginDesc.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        loginDesc.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 20).isActive = true
        loginDesc.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        loginDesc.numberOfLines = 0
        loginDesc.lineBreakMode = .byWordWrapping
        loginDesc.font = UIFont(name: String.defaultFontR, size: 16)
        
        let lblUsername = UILabel()
        darkView.addSubview(lblUsername)
        lblUsername.translatesAutoresizingMaskIntoConstraints = false
        lblUsername.text = "Username"
        lblUsername.textColor = UIColor.white
        lblUsername.font = UIFont(name: String.defaultFontR, size: 15)
        lblUsername.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        usernameTop = lblUsername.topAnchor.constraint(equalTo: loginDesc.bottomAnchor, constant: 20)
        usernameTop?.isActive = true
        lblUsername.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        
        darkView.addSubview(txtUsername)
        txtUsername.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        txtUsername.topAnchor.constraint(equalTo: lblUsername.bottomAnchor, constant: 10).isActive = true
        txtUsername.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        if let username = username {
            txtUsername.text = username
        }
        
        let lblPassword = UILabel()
        darkView.addSubview(lblPassword)
        lblPassword.translatesAutoresizingMaskIntoConstraints = false
        lblPassword.text = "Password"
        lblPassword.textColor = UIColor.white
        lblPassword.font = UIFont(name: String.defaultFontR, size: 15)
        lblPassword.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        lblPassword.topAnchor.constraint(equalTo: txtUsername.bottomAnchor, constant: 30).isActive = true
        lblPassword.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        
        darkView.addSubview(txtPassword)
        txtPassword.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        txtPassword.topAnchor.constraint(equalTo: lblPassword.bottomAnchor, constant: 10).isActive = true
        txtPassword.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        txtPassword.isSecureTextEntry = true
        
        darkView.addSubview(btnRemember)
        btnRemember.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        btnRemember.topAnchor.constraint(equalTo: txtPassword.bottomAnchor, constant: 20).isActive = true
        btnRemember.widthAnchor.constraint(equalToConstant: 20).isActive = true
        btnRemember.heightAnchor.constraint(equalToConstant: 20).isActive = true
        btnRemember.addTarget(self, action: #selector(checkButtonFunction), for: .touchUpInside)
        
        let lblRemember = UILabel()
        lblRemember.translatesAutoresizingMaskIntoConstraints = false
        darkView.addSubview(lblRemember)
        lblRemember.text = "Remember my account details"
        lblRemember.textColor = UIColor.white
        lblRemember.font = UIFont(name: String.defaultFontR, size: 17)
        lblRemember.leadingAnchor.constraint(equalTo: btnRemember.trailingAnchor, constant: 5).isActive = true
        lblRemember.topAnchor.constraint(equalTo: txtPassword.bottomAnchor, constant: 25).isActive = true
        lblRemember.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -10).isActive = true
        lblRemember.numberOfLines = 0
        lblRemember.lineBreakMode = .byWordWrapping
        
        darkView.addSubview(btnConfirm)
        btnConfirm.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        btnConfirm.topAnchor.constraint(equalTo: lblRemember.bottomAnchor, constant: 30).isActive = true
        btnConfirm.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        btnConfirm.addTarget(self, action: #selector(confirmUser), for: .touchUpInside)
        
        darkView.addSubview(btnCancel)
        btnCancel.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        btnCancel.topAnchor.constraint(equalTo: btnConfirm.bottomAnchor, constant: 10).isActive = true
        btnCancel.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        btnCancel.addTarget(self, action: #selector(closeModalB), for: .touchUpInside)
        
        let separator = UIView()
        darkView.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor.gray
        separator.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        separator.topAnchor.constraint(equalTo: btnCancel.bottomAnchor, constant: 30).isActive = true
        separator.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        
        darkView.addSubview(btnUserTouchID)
        btnUserTouchID.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        btnUserTouchID.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 20).isActive = true
        btnUserTouchID.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
//        btnUserTouchID.addTarget(self, action: #selector(closeModalB), for: .touchUpInside)
        
        darkView.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: darkView.centerXAnchor).isActive = true
        activity_loader.topAnchor.constraint(equalTo: lblRemember.bottomAnchor, constant: 30).isActive = true
    
        
        
        
        
        
        
        scrollView.contentSize.height = viewHeight + 60
    }
    /*//Function to report touch ID Error
    func checkForTouchID(error: NSError)-> Bool{
        var output = true
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
            output = false
        case LAError.biometryNotAvailable.rawValue:
            print("Touch id is not available")
            output = false
        case LAError.userFallback.rawValue:
            print("user tapped enter password")
        default:
            print(error.localizedDescription)
        }
        return output
    }*/

    @objc func checkButtonFunction(_ sender: UIButton){
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (success) in
            sender.isSelected = !sender.isSelected
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.transform = .identity
                if self.isChecked == true {
                    self.btnRemember.setImage(UIImage(named: "UnCheckbox"), for: .normal)
                    
                    
                }else{
                    
                    self.btnRemember.setImage(UIImage(named: "Checkbox"), for: .normal)
                }
                self.isChecked = !self.isChecked
                print(self.isChecked)
            }, completion: nil)
        }
    }
    
    @objc func checkInputs(){
        let username = txtUsername.text!
        let password = txtPassword.text!
        
        if username.isEmpty || username.count < 1 || password.isEmpty || password.count < 4 {
            btnConfirm.isEnabled = false
            btnConfirm.backgroundColor = UIColor.grayButton
        }else{
            btnConfirm.isEnabled = true
            btnConfirm.backgroundColor = UIColor.vodaRed
        }
    }
    
    @objc func confirmUser(){
        if !CheckInternet.Connection(){
            displayNoInternet()
        }else{
            let username = txtUsername.text!
            var password = txtPassword.text!
            password = md5Base(password)
            password = password.sha1()
            
            start_activity_loader()
            
            let postParameters:Dictionary<String, Any> = [
                "username":username,
                "password":password,
                "action":"loginToAccount",
                "os":getAppVersion()
            ]
            
            let async_call = URL(string: String.oldUserSVC)
            let request = NSMutableURLRequest(url: async_call!)
            request.httpMethod = "POST"
            if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
                request.httpBody = postData
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                
                let task = URLSession.shared.dataTask(with: request as URLRequest){
                    data, response, error in
                    if error != nil {
                        print("error is \(error!.localizedDescription)")
                        DispatchQueue.main.async {
                            self.stop_activity_loader()
                            self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process your request. Try again later...")
                        }
                        return
                    }
                    do{
                        let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        if let parseJSON = myJSON {
                            var responseCode: Int!
                            var responseMessage: String!
                            var responseData: NSDictionary!
                            var responseSession: NSDictionary!
                            print(parseJSON)
                            
                            //getting the json response
                            responseCode = parseJSON["RESPONSECODE"] as! Int?
                            responseMessage = parseJSON["RESPONSEMESSAGE"] as! String?
                            responseData = parseJSON["RESPONSEDATA"] as! NSDictionary?
                            
                            
                            
                            DispatchQueue.main.async {
                                if responseCode == 0 {
                                    
                                    if self.isChecked == true {
                                        self.preference.set(true, forKey: UserDefaultsKeys.isSensitiveDataAllowed.rawValue)
                                    }
                                    let storyboard = UIStoryboard(name: "PostPaid", bundle: nil)
                                    let moveTo = storyboard.instantiateViewController(withIdentifier: "currentSpendsBills")
                                    self.present(moveTo, animated: true, completion: nil)
                                }else if responseCode == 1 {
                                    self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: responseMessage)
                                }else{
                                    self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process your request. Try again later...")
                                }
                                self.stop_activity_loader()
                            }
                        }
                    }catch{
                        print("catch err \(error.localizedDescription)")
                        DispatchQueue.main.async {
                            self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process your request. Try again later...")
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
}
