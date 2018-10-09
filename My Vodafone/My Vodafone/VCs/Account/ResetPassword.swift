//
//  ResetPassword.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 09/10/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class ResetPassword: baseViewControllerM {

    var username: String?
    //create a motherView
    let motherViewR: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    //closure for scroll view
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backgroundImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let btnBack: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let darkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
    
    //error dialog
    let errorDialog = UIImageView(image: #imageLiteral(resourceName: "error_dialog_bg"))
    let lblResponseMessage = UILabel()
    let messImage = UIImageView()
    
    var lblEnterUserTopConstraint: NSLayoutConstraint?
    var darkViewHeight: NSLayoutConstraint?
    
    let btnContinue = UIButton()
    let btnGoBack = UIButton()
    let txtCode = UITextField()
    let txtNewPass = UITextField()
    let txtConfPass = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewsResetPassword()
        hideKeyboardWhenTappedAround()
        
    }
    
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        btnContinue.isHidden = true
    }
    
    //Function to stopIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        btnContinue.isHidden = false
    }

    func setUpViewsResetPassword(){
        view.addSubview(backgroundImage)
        let backImage = UIImage(named: "bg_afternoon")
        backgroundImage.image = backImage
        backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
        view.addSubview(motherViewR)
        motherViewR.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        motherViewR.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        motherViewR.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        motherViewR.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
        motherViewR.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: motherViewR.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: motherViewR.safeTopAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: motherViewR.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: motherViewR.safeBottomAnchor).isActive = true
//        scrollView.contentSize.height = 1000
        
        
        scrollView.addSubview(btnBack)
        let backArrow = UIImage(named: "leftArrow")
        let backTint = backArrow?.withRenderingMode(.alwaysTemplate)
        btnBack.setImage(backTint, for: .normal)
        btnBack.tintColor = UIColor.white
        btnBack.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnBack.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnBack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        btnBack.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 10).isActive = true
        btnBack.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
        
        //Header
        let lblHeader = UILabel()
        scrollView.addSubview(lblHeader)
        lblHeader.translatesAutoresizingMaskIntoConstraints = false
        lblHeader.text = "Reset your password"
        lblHeader.font = UIFont(name: String.defaultFontR, size: 32)
        lblHeader.textColor = UIColor.white
        lblHeader.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50).isActive = true
        lblHeader.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor).isActive = true
        
        scrollView.addSubview(darkView)
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.40)
        darkView.isOpaque = false
        darkView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 20).isActive = true
        darkView.topAnchor.constraint(equalTo: lblHeader.bottomAnchor, constant: 30).isActive = true
        darkView.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -20).isActive = true
        darkViewHeight = darkView.heightAnchor.constraint(equalToConstant: 420)
        darkViewHeight?.isActive = true
        
        let lblUsername = UILabel()
        scrollView.addSubview(lblUsername)
        lblUsername.translatesAutoresizingMaskIntoConstraints = false
        lblUsername.textColor = UIColor.white
        lblUsername.text = "Enter your recovery code"
        lblUsername.font = UIFont(name: String.defaultFontR, size: 18)
        lblUsername.numberOfLines = 0
        lblUsername.lineBreakMode = .byWordWrapping
        lblUsername.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        lblEnterUserTopConstraint = lblUsername.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 20)
        lblEnterUserTopConstraint?.isActive = true
        lblUsername.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -10).isActive = true
        
        darkView.addSubview(txtCode)
        txtCode.translatesAutoresizingMaskIntoConstraints = false
        txtCode.backgroundColor = UIColor.white
        txtCode.borderStyle = .roundedRect
        txtCode.font = UIFont(name: String.defaultFontR, size: 17)
        txtCode.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        txtCode.topAnchor.constraint(equalTo: lblUsername.bottomAnchor, constant: 5).isActive = true
        txtCode.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        txtCode.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtCode.autocapitalizationType = .none
        
        let lblNewPass = UILabel()
        darkView.addSubview(lblNewPass)
        lblNewPass.translatesAutoresizingMaskIntoConstraints = false
        lblNewPass.textColor = UIColor.white
        lblNewPass.text = "Enter new password"
        lblNewPass.font = UIFont(name: String.defaultFontR, size: 18)
        lblNewPass.numberOfLines = 0
        lblNewPass.lineBreakMode = .byWordWrapping
        lblNewPass.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        lblNewPass.topAnchor.constraint(equalTo: txtCode.bottomAnchor, constant: 20).isActive = true
        lblNewPass.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -10).isActive = true
        
        darkView.addSubview(txtNewPass)
        txtNewPass.translatesAutoresizingMaskIntoConstraints = false
        txtNewPass.backgroundColor = UIColor.white
        txtNewPass.borderStyle = .roundedRect
        txtNewPass.font = UIFont(name: String.defaultFontR, size: 17)
        txtNewPass.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        txtNewPass.topAnchor.constraint(equalTo: lblNewPass.bottomAnchor, constant: 5).isActive = true
        txtNewPass.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        txtNewPass.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtNewPass.isSecureTextEntry = true
        
        let lblConfPass = UILabel()
        darkView.addSubview(lblConfPass)
        lblConfPass.translatesAutoresizingMaskIntoConstraints = false
        lblConfPass.textColor = UIColor.white
        lblConfPass.text = "Confirm new password"
        lblConfPass.font = UIFont(name: String.defaultFontR, size: 18)
        lblConfPass.numberOfLines = 0
        lblConfPass.lineBreakMode = .byWordWrapping
        lblConfPass.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        lblConfPass.topAnchor.constraint(equalTo: txtNewPass.bottomAnchor, constant: 20).isActive = true
        lblConfPass.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -10).isActive = true
        
        darkView.addSubview(txtConfPass)
        txtConfPass.translatesAutoresizingMaskIntoConstraints = false
        txtConfPass.backgroundColor = UIColor.white
        txtConfPass.borderStyle = .roundedRect
        txtConfPass.font = UIFont(name: String.defaultFontR, size: 17)
        txtConfPass.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        txtConfPass.topAnchor.constraint(equalTo: lblConfPass.bottomAnchor, constant: 5).isActive = true
        txtConfPass.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        txtConfPass.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtConfPass.isSecureTextEntry = true
        
        darkView.addSubview(btnContinue)
        btnContinue.translatesAutoresizingMaskIntoConstraints = false
        btnContinue.backgroundColor = UIColor.grayButton
        btnContinue.setTitle("Continue", for: .normal)
        btnContinue.setTitleColor(UIColor.white, for: .normal)
        btnContinue.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnContinue.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        btnContinue.topAnchor.constraint(equalTo: txtConfPass.bottomAnchor, constant: 20).isActive = true
        btnContinue.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        btnContinue.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnContinue.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        btnContinue.isEnabled = false
        
        darkView.addSubview(btnGoBack)
        btnGoBack.translatesAutoresizingMaskIntoConstraints = false
        btnGoBack.backgroundColor = UIColor.gray
        btnGoBack.setTitle("Go Back", for: .normal)
        btnGoBack.setTitleColor(UIColor.black, for: .normal)
        btnGoBack.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnGoBack.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        btnGoBack.topAnchor.constraint(equalTo: btnContinue.bottomAnchor, constant: 10).isActive = true
        btnGoBack.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        btnGoBack.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnGoBack.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
        
        darkView.addSubview(errorDialog)
        errorDialog.translatesAutoresizingMaskIntoConstraints = false
        errorDialog.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        errorDialog.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 10).isActive = true
        errorDialog.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -5).isActive = true
        errorDialog.heightAnchor.constraint(equalToConstant: 70).isActive = true
        errorDialog.isHidden = true
        
        errorDialog.addSubview(messImage)
        messImage.translatesAutoresizingMaskIntoConstraints = false
        messImage.image = UIImage(named: "info")
        messImage.leadingAnchor.constraint(equalTo: errorDialog.leadingAnchor, constant: 10).isActive = true
        messImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        messImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        messImage.topAnchor.constraint(equalTo: errorDialog.topAnchor, constant: 20).isActive = true
        
        errorDialog.addSubview(lblResponseMessage)
        lblResponseMessage.translatesAutoresizingMaskIntoConstraints = false
        lblResponseMessage.textColor = UIColor.white
        lblResponseMessage.font = UIFont(name: String.defaultFontR, size: 16)
        lblResponseMessage.numberOfLines = 0
        lblResponseMessage.lineBreakMode = .byWordWrapping
        lblResponseMessage.leadingAnchor.constraint(equalTo: messImage.trailingAnchor, constant: 10).isActive = true
        lblResponseMessage.topAnchor.constraint(equalTo: errorDialog.topAnchor, constant: 20).isActive = true
        lblResponseMessage.trailingAnchor.constraint(equalTo: errorDialog.trailingAnchor, constant: -5).isActive = true
        
        //activity loader
        darkView.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.topAnchor.constraint(equalTo: txtConfPass.bottomAnchor, constant: 20).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize.height = darkView.frame.size.height
        txtCode.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
        txtNewPass.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
        txtConfPass.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
    }
    
    @objc func checkInputs(){
        let code = txtCode.text
        let newPass = txtNewPass.text!
        let confPass = txtConfPass.text!
        if let code = code {
            if code.isEmpty || code.count < 5 || newPass.isEmpty || newPass.count < 4 || confPass.isEmpty || confPass.count < 4{
                btnContinue.isEnabled = false
                btnContinue.backgroundColor = UIColor.grayButton
            }else{
                btnContinue.isEnabled = true
                btnContinue.backgroundColor = UIColor.vodaRed
            }
        }
        
    }
    
    @objc func changePassword(){
        if !CheckInternet.Connection(){
            displayNoInternet()
        }else{
            let verifyCode = txtCode.text!
            let newPass = txtNewPass.text!
            let confPass = txtConfPass.text!
            if newPass != confPass {
                lblEnterUserTopConstraint?.constant = 80
                darkViewHeight?.constant = 480
                lblResponseMessage.text = "Passwords do not match"
                errorDialog.isHidden = false
            }else{
                lblEnterUserTopConstraint?.constant = 20
                darkViewHeight?.constant = 420
                errorDialog.isHidden = true
                let pass = md5Base(newPass).sha1()
                start_activity_loader()
                let async_call = URL(string: String.userSVC)
                let request = NSMutableURLRequest(url: async_call!)
                request.httpMethod = "POST"
                
                let postParameters: Dictionary<String, Any> = [
                    "action":"changeForgottenPassword",
                    "username":username!,
                    "verifyCode":verifyCode,
                    "password":pass,
                    "passClone":pass,
                    "os":getDeviceOS()
                ]
                
                if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
                    request.httpBody = postData
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                    
                    let task = URLSession.shared.dataTask(with: request as URLRequest){
                        data, response, error in
                        if error != nil {
                            DispatchQueue.main.async {
                                print("error is:: \(error!.localizedDescription)")
                                self.stop_activity_loader()
                            }
                            return;
                        }
                        do {
                            let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            if let parseJSON = myJSON {
                                var responseCode: Int?
                                
                                responseCode = parseJSON["RESPONSECODE"] as! Int?
                                DispatchQueue.main.async {
                                    if responseCode == 0 {
                                        if let responseMessage = parseJSON["RESPONSEMESSAGE"] as! String? {
                                            
                                            
                                            UIView.animate(withDuration: 0.5, delay: 5, options: .curveEaseIn, animations: {
//                                                self.lblResponseMessage.text = responseMessage
                                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "correct")), toast_message: responseMessage)
                                                self.errorDialog.isHidden = true
                                            }, completion: { (true) in
                                                //go to home screen
                                                let login_api = URL(string: "https://myvodafoneappmw.vodafone.com.gh/MyVodafoneAPI/UserSvc")
                                                self.loginToAccount(url: login_api!, password: pass, username: self.username!)
                                            })
                                        }
                                    }else if responseCode == 1 {
                                        self.stop_activity_loader()
                                        self.lblEnterUserTopConstraint?.constant = 80
                                        self.darkViewHeight?.constant = 480
                                        if let responseMessage = parseJSON["RESPONSEMESSAGE"] as! String? {
                                            self.lblResponseMessage.text = responseMessage
                                            self.errorDialog.isHidden = false
                                        }
                                    }
                                    else{
                                        self.stop_activity_loader()
                                        self.lblEnterUserTopConstraint?.constant = 80
                                        self.darkViewHeight?.constant = 480
                                        if let responseMessage = parseJSON["RESPONSEMESSAGE"] as! String? {
                                            self.lblResponseMessage.text = "Password reset was unsuccessful.."
                                            print("response:: \(responseMessage)")
                                            self.errorDialog.isHidden = false
                                        }
                                    }
                                    
                                }
                            }
                        }catch{
                            DispatchQueue.main.async {
                                self.stop_activity_loader()
                                print("error is:: \(error.localizedDescription)")
                            }
                        }
                    }
                    task.resume()
                }
            }
            
            
            
            
            
            
            
            
            
            
            
        }
        
    }
}
