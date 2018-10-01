//
//  AccountConfViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 10/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class AccountConfViewController: baseViewControllerM {
    
    var responseMessage:String?
    var username: String?
    var activationCode: String?
    var totalOTP: Int?
    
    let txtOTP = UITextField()
    let confirmButton = UIButton()
    let lblMessage = UILabel()
    
//    let preference = UserDefaults.standard
    
    //create closure for image view
    let closureImage: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //create closure for motherView
    let motherViewAcc: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    //create closure scroll view
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    //create activity loader closure
    let activity_loader: UIActivityIndicatorView = {
        let activity_loader = UIActivityIndicatorView()
        activity_loader.translatesAutoresizingMaskIntoConstraints = false
        activity_loader.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activity_loader.hidesWhenStopped = true
        return activity_loader
        
    }()

    override func viewDidAppear(_ animated: Bool) {
        txtOTP.addTarget(self, action: #selector(enableConfirmButton), for: .editingChanged)
        activity_loader.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewsAccC()
        self.hideKeyboardWhenTappedAround()
    }

    //Setup views
    func setUpViewsAccC(){
        //background Image
        let backgroundImage = closureImage
        view.addSubview(backgroundImage)
        backgroundImage.image = UIImage(named: "morning_bg_")
        backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //mother view
        view.addSubview(motherViewAcc)
        motherViewAcc.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        motherViewAcc.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        motherViewAcc.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        motherViewAcc.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //scrollview
        motherViewAcc.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: motherViewAcc.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: motherViewAcc.safeTopAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: motherViewAcc.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: motherViewAcc.bottomAnchor).isActive = true
        
        
        //app logo
        let app_logo = UIImageView(image: #imageLiteral(resourceName: "voda_logo"))
        scrollView.addSubview(app_logo)
        app_logo.translatesAutoresizingMaskIntoConstraints = false
        app_logo.heightAnchor.constraint(equalToConstant: 48).isActive = true
        app_logo.widthAnchor.constraint(equalToConstant: 48).isActive = true
        app_logo.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10).isActive = true
        app_logo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        
        //Account confirmation label
        let accountLbl = UILabel()
        scrollView.addSubview(accountLbl)
        accountLbl.translatesAutoresizingMaskIntoConstraints = false
        accountLbl.text = "Account Confirmation"
        accountLbl.textColor = UIColor.white
        accountLbl.textAlignment = .center
        accountLbl.font = UIFont(name: String.defaultFontB, size: 32)
        accountLbl.leadingAnchor.constraint(equalTo: motherViewAcc.leadingAnchor, constant: 20).isActive = true
        accountLbl.topAnchor.constraint(equalTo: app_logo.bottomAnchor, constant: 10).isActive = true
        accountLbl.trailingAnchor.constraint(equalTo: motherViewAcc.trailingAnchor, constant: -30).isActive = true
        accountLbl.numberOfLines = 0
        accountLbl.lineBreakMode = .byWordWrapping
        
        //activity description
        let actDesc = UILabel()
        scrollView.addSubview(actDesc)
        actDesc.translatesAutoresizingMaskIntoConstraints = false
        actDesc.textAlignment = .center
        actDesc.textColor = UIColor.white
        actDesc.text = "Kindly enter the activation pin sent to your phone below"
        actDesc.font = UIFont(name: String.defaultFontR, size: 22)
        actDesc.leadingAnchor.constraint(equalTo: motherViewAcc.leadingAnchor, constant: 30).isActive = true
        actDesc.trailingAnchor.constraint(equalTo: motherViewAcc.trailingAnchor, constant: -30).isActive = true
        actDesc.topAnchor.constraint(equalTo: accountLbl.bottomAnchor, constant: 10).isActive = true
        actDesc.numberOfLines = 0
        actDesc.lineBreakMode = .byWordWrapping
        
        // View to hold inputs
        let darkView = UIView()
        scrollView.addSubview(darkView)
        darkView.translatesAutoresizingMaskIntoConstraints = false
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.70)
        darkView.isOpaque = false
        darkView.heightAnchor.constraint(equalToConstant: 320).isActive = true
        darkView.leadingAnchor.constraint(equalTo: motherViewAcc.leadingAnchor, constant: 20).isActive = true
        darkView.trailingAnchor.constraint(equalTo: motherViewAcc.trailingAnchor, constant: -20).isActive = true
        darkView.topAnchor.constraint(equalTo: actDesc.bottomAnchor, constant: 30).isActive = true
        
        //confirm pin
        let lblConfirmPin = UILabel()
        scrollView.addSubview(lblConfirmPin)
        lblConfirmPin.translatesAutoresizingMaskIntoConstraints = false
        lblConfirmPin.text = "Confirm Pin"
        lblConfirmPin.textColor = UIColor.white
        lblConfirmPin.font = UIFont(name: String.defaultFontR, size: 20)
        lblConfirmPin.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        lblConfirmPin.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 20).isActive = true
        
        //txt otp
        
        scrollView.addSubview(txtOTP)
        txtOTP.translatesAutoresizingMaskIntoConstraints = false
        txtOTP.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtOTP.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        txtOTP.topAnchor.constraint(equalTo: lblConfirmPin.bottomAnchor, constant: 20).isActive = true
        txtOTP.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        txtOTP.backgroundColor = UIColor.white
        txtOTP.borderStyle = .roundedRect
        txtOTP.textAlignment = .center
        txtOTP.font = UIFont(name: String.defaultFontR, size: 17)
        txtOTP.keyboardType = .numberPad
        
        //confirm
        
        scrollView.addSubview(confirmButton)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.backgroundColor = UIColor.grayButton
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        confirmButton.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        confirmButton.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        confirmButton.topAnchor.constraint(equalTo: txtOTP.bottomAnchor, constant: 30).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        confirmButton.isEnabled = false
        confirmButton.addTarget(self, action: #selector(verifyOTP), for: .touchUpInside)
        
        //cancel
        let cancelButton = UIButton()
        scrollView.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.backgroundColor = UIColor.gray
        cancelButton.setTitle("Go Back", for: .normal)
        cancelButton.setTitleColor(UIColor.black, for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        cancelButton.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        cancelButton.topAnchor.constraint(equalTo: confirmButton.bottomAnchor, constant: 20).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        cancelButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        //View to hold message
        let messageUIView = UIView()
        scrollView.addSubview(messageUIView)
        messageUIView.translatesAutoresizingMaskIntoConstraints = false
        messageUIView.backgroundColor = UIColor.black.withAlphaComponent(0.80)
        messageUIView.isOpaque = false
        messageUIView.widthAnchor.constraint(equalTo: motherViewAcc.widthAnchor).isActive = true
        messageUIView.bottomAnchor.constraint(equalTo: motherViewAcc.bottomAnchor, constant: 0).isActive = true
        messageUIView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        //label to hold message to user
        
        scrollView.addSubview(lblMessage)
        lblMessage.translatesAutoresizingMaskIntoConstraints = false
        lblMessage.textColor = UIColor.white
        lblMessage.font = UIFont(name: String.defaultFontR, size: 16)
        lblMessage.text = responseMessage
        lblMessage.leadingAnchor.constraint(equalTo: messageUIView.leadingAnchor, constant: 10).isActive = true
        lblMessage.trailingAnchor.constraint(equalTo: messageUIView.trailingAnchor, constant: -10).isActive = true
        lblMessage.topAnchor.constraint(equalTo: messageUIView.topAnchor, constant: 60).isActive = true
        lblMessage.numberOfLines = 0
        lblMessage.lineBreakMode = .byWordWrapping
        
        scrollView.contentSize.height = (view.frame.size.height + accountLbl.frame.size.height + actDesc.frame.size.height + darkView.frame.size.height + lblConfirmPin.frame.size.height + txtOTP.frame.size.height + confirmButton.frame.size.height + cancelButton.frame.size.height)
        
        scrollView.addSubview(activity_loader)
        activity_loader.topAnchor.constraint(equalTo: txtOTP.bottomAnchor, constant: 30).isActive = true
        activity_loader.centerXAnchor.constraint(equalTo: motherViewAcc.centerXAnchor).isActive = true
    }
    
    
    //Function to check input activity and enable confirm button
    @objc func enableConfirmButton(){
        activationCode = txtOTP.text
        totalOTP = activationCode?.count
        if totalOTP! >= 5 {
            confirmButton.isEnabled = true
            confirmButton.backgroundColor = UIColor.vodaRed
        }
    }
    //Function to go back
    @objc func goBack(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "RegisterViewController")
        present(moveTo, animated: true, completion: nil)
    }
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        confirmButton.isHidden = true
    }
    
    //Function to startIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        confirmButton.isHidden = false
    }
    
    
    //Function to verfify OTP
    @objc func verifyOTP(){
        txtOTP.resignFirstResponder()
        let postParameters:Dictionary<String, Any> = [
            "action":"activateAccount",
            "username":username!,
            "activationCode":activationCode!,
            "os":getAppVersion()
        ]
        //Check if txt field is empty
        if txtOTP.text == "" {
            lblMessage.text = "Activation pin cannot be blank"
        }else{
            //Now check for internet connection
            if !CheckInternet.Connection(){
                let storyboard = UIStoryboard(name: "Support", bundle: nil)
                let moveTo = storyboard.instantiateViewController(withIdentifier: "NointernetViewController")
                self.addChildViewController(moveTo)
                moveTo.view.frame = self.view.frame
                self.view.addSubview(moveTo.view)
                moveTo.didMove(toParentViewController: self)
            }else{
                start_activity_loader()
                let asyn_api = URL(string: String.userSVC)
                let request = NSMutableURLRequest(url: asyn_api!)
                request.httpMethod = "POST"
                
                //Convert to JSON
                if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)) {
                    request.httpBody = postData
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                    
                    //creating a task to send request
                    let task = URLSession.shared.dataTask(with: request as URLRequest){
                        data, response, error in
                        if error != nil {
                            print("error is:: \(error!.localizedDescription)")
                            DispatchQueue.main.async {
                                //TODO
                                self.stop_activity_loader()
                                self.lblMessage.text = error!.localizedDescription
                            }
                            return;
                        }
                        
                        //Parsing the response
                        do {
                            //converting response to NSDictionary
                            let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            DispatchQueue.main.async {
                                if let parseJSON = myJSON{
                                    var responseCode: Int!
                                    var responseData: NSDictionary!
                                    var responseMessage: String!
                                    
                                    //getting the json response
                                    responseCode = parseJSON["RESPONSECODE"] as! Int?
                                    responseMessage = parseJSON["RESPONSEMESSAGE"] as! String?
                                    
                                    if responseCode == 1 {
                                        self.lblMessage.text = responseMessage
                                        self.stop_activity_loader()
                                    }else{
                                        
                                        responseData = parseJSON["RESPONSEDATA"] as! NSDictionary?
                                        self.preference.set("Yes", forKey: "loginStatus")
                                        self.preference.set(responseData["ServiceList"] as! NSArray, forKey: UserDefaultsKeys.ServiceList.rawValue)
                                        self.preference.set(responseData, forKey: "responseData")
                                        self.stop_activity_loader()
                                        //go to home screen
                                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                        let moveTo = storyboard.instantiateViewController(withIdentifier: "homeVC")
                                        self.present(moveTo, animated: true, completion: nil)
                                    }
                                }
                            }
                        }catch{
                            print("catch:: \(error.localizedDescription)")
                        }
                    }
                    task.resume()
                }
            }
        }
        
    }

}
