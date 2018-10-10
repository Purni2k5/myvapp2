//
//  ForgotPassword.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 09/10/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class ForgotPassword: baseViewControllerM {
    
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
    
    let btnContinue = UIButton()
    let txtUsername = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewsForgotPassword()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        txtUsername.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
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
    
    func setUpViewsForgotPassword(){
        view.addSubview(backgroundImage)
        let backImage = UIImage(named: "bg_afternoon")
        backgroundImage.image = backImage
        backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
        view.addSubview(btnBack)
        let backArrow = UIImage(named: "leftArrow")
        let backTint = backArrow?.withRenderingMode(.alwaysTemplate)
        btnBack.setImage(backTint, for: .normal)
        btnBack.tintColor = UIColor.white
        btnBack.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnBack.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnBack.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 10).isActive = true
        btnBack.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 10).isActive = true
        btnBack.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
        
        //Header
        let lblHeader = UILabel()
        backgroundImage.addSubview(lblHeader)
        lblHeader.translatesAutoresizingMaskIntoConstraints = false
        lblHeader.text = "Reset your password"
        lblHeader.font = UIFont(name: String.defaultFontR, size: 32)
        lblHeader.textColor = UIColor.white
        lblHeader.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 50).isActive = true
        lblHeader.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor).isActive = true
        
        view.addSubview(darkView)
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        darkView.isOpaque = false
        darkView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 20).isActive = true
        darkView.topAnchor.constraint(equalTo: lblHeader.bottomAnchor, constant: 30).isActive = true
        darkView.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -20).isActive = true
        darkView.heightAnchor.constraint(equalToConstant: 320).isActive = true
        
        let lblUsername = UILabel()
        darkView.addSubview(lblUsername)
        lblUsername.translatesAutoresizingMaskIntoConstraints = false
        lblUsername.textColor = UIColor.white
        lblUsername.text = "Enter your username or telephone number"
        lblUsername.font = UIFont(name: String.defaultFontR, size: 16)
        lblUsername.numberOfLines = 0
        lblUsername.lineBreakMode = .byWordWrapping
        lblUsername.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        lblEnterUserTopConstraint = lblUsername.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 20)
        lblEnterUserTopConstraint?.isActive = true
        lblUsername.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -10).isActive = true
        
        
        darkView.addSubview(txtUsername)
        txtUsername.translatesAutoresizingMaskIntoConstraints = false
        txtUsername.backgroundColor = UIColor.white
        txtUsername.borderStyle = .roundedRect
        txtUsername.font = UIFont(name: String.defaultFontR, size: 17)
        txtUsername.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        txtUsername.topAnchor.constraint(equalTo: lblUsername.bottomAnchor, constant: 5).isActive = true
        txtUsername.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        txtUsername.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtUsername.autocapitalizationType = .none
        
        darkView.addSubview(btnContinue)
        btnContinue.translatesAutoresizingMaskIntoConstraints = false
        btnContinue.backgroundColor = UIColor.grayButton
        btnContinue.setTitle("Continue", for: .normal)
        btnContinue.setTitleColor(UIColor.white, for: .normal)
        btnContinue.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnContinue.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        btnContinue.topAnchor.constraint(equalTo: txtUsername.bottomAnchor, constant: 20).isActive = true
        btnContinue.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        btnContinue.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnContinue.addTarget(self, action: #selector(checkUsername), for: .touchUpInside)
        btnContinue.isEnabled = false
        
        let btnReturn = UIButton()
        darkView.addSubview(btnReturn)
        btnReturn.translatesAutoresizingMaskIntoConstraints = false
        btnReturn.backgroundColor = UIColor.gray
        btnReturn.setTitle("Go Back", for: .normal)
        btnReturn.setTitleColor(UIColor.black, for: .normal)
        btnReturn.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnReturn.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        btnReturn.topAnchor.constraint(equalTo: btnContinue.bottomAnchor, constant: 10).isActive = true
        btnReturn.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        btnReturn.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnReturn.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
        
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
        activity_loader.topAnchor.constraint(equalTo: txtUsername.bottomAnchor, constant: 20).isActive = true
        
        
        
        
        
        
        
        
        
    }
    
    @objc func checkInputs(){
        let username = txtUsername.text
        if let username = username {
            if username.isEmpty{
                btnContinue.isEnabled = false
                btnContinue.backgroundColor = UIColor.grayButton
            }else{
                btnContinue.isEnabled = true
                btnContinue.backgroundColor = UIColor.vodaRed
            }
        }
       
    }
    
    @objc func checkUsername(){
        if !CheckInternet.Connection(){
            displayNoInternet()
        }else{
            start_activity_loader()
            let async_call = URL(string: String.userSVC)
            let request = NSMutableURLRequest(url: async_call!)
            request.httpMethod = "POST"
            let username = txtUsername.text!
            
            let postParameters: Dictionary<String, Any> = [
                "action":"sendAccountVerificationCode",
                "accountKey":username,
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
                                    if let responseData = parseJSON["RESPONSEDATA"] as? NSDictionary {
                                        let responseInfo = responseData["Info"] as! NSDictionary
                                        let responseUserName = responseInfo["Username"] as! String
                                    
                                    
                                    if let responseMessage = parseJSON["RESPONSEMESSAGE"] as! String? {
                                        UIView.animate(withDuration: 0.5, delay: 3, options: .curveEaseIn, animations: {
                                            self.lblEnterUserTopConstraint?.constant = 80
                                            self.lblResponseMessage.text = responseMessage
                                            self.errorDialog.isHidden = false
                                            self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "correct")), toast_message: responseMessage)
                                        }, completion: { (true) in
                                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                            guard let moveTo = storyboard.instantiateViewController(withIdentifier: "ResetPassword") as? ResetPassword else {return}
                                            moveTo.username = responseUserName
                                            self.present(moveTo, animated: true, completion: nil)
                                        })
                                    }
                                }else{
                                    self.lblEnterUserTopConstraint?.constant = 80
                                    if let responseMessage = parseJSON["RESPONSEMESSAGE"] as! String? {
                                        self.lblResponseMessage.text = responseMessage
                                        self.errorDialog.isHidden = false
                                    }
                                }
                                }
                                self.stop_activity_loader()
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
