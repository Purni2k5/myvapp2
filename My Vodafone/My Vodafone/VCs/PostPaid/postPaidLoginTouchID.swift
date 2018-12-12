//
//  postPaidLoginTouchID.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 12/12/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit
import LocalAuthentication

class postPaidLoginTouchID: baseViewControllerM {

    var username: String?
    var msisdn: String?
    var currentSpend: String?
    var excludeValue: String?
    var currSpendDesc: String?
    
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
    
    
    
    let btnGoBack: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.grayButton
        view.setTitle("Use login details", for: .normal)
        view.heightAnchor.constraint(equalToConstant: 55).isActive = true
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
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
        authenticateUsingTouchID()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        btnGoBack.isHidden = true
    }
    
    //Function to stopIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        btnGoBack.isHidden = false
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
        darkViewHeight = darkView.heightAnchor.constraint(equalToConstant: 250)
        darkViewHeight.isActive = true
        
        let loginDesc = UILabel()
        loginDesc.translatesAutoresizingMaskIntoConstraints = false
        darkView.addSubview(loginDesc)
        loginDesc.textColor = UIColor.white
        loginDesc.text = "You are about to see sensitive information. Please confirm your details to continue. \n\n Please use your touch ID button to verify your identity"
        loginDesc.textAlignment = .center
        loginDesc.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        loginDesc.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 20).isActive = true
        loginDesc.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        loginDesc.numberOfLines = 0
        loginDesc.lineBreakMode = .byWordWrapping
        loginDesc.font = UIFont(name: String.defaultFontR, size: 19)
        
        darkView.addSubview(btnGoBack)
        btnGoBack.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        btnGoBack.topAnchor.constraint(equalTo: loginDesc.bottomAnchor, constant: 30).isActive = true
        btnGoBack.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        btnGoBack.addTarget(self, action: #selector(closeModalB), for: .touchUpInside)
        
        
        
        darkView.addSubview(activity_loader)
//        activity_loader.centerXAnchor.constraint(equalTo: darkView.centerXAnchor).isActive = true
//        activity_loader.topAnchor.constraint(equalTo: lblRemember.bottomAnchor, constant: 30).isActive = true
        
        
        
        
        
        
        
        scrollView.contentSize.height = viewHeight + 60
    }
    //Function to report touch ID Error
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
    
    //Touch ID authentication
    func authenticateUsingTouchID(){
        let authContext = LAContext()
        
        let secretUser = keyChain.get(keyChainKeys.secretUser.rawValue)
        
        
        let authReason = "Please use touch ID to log in to  \(secretUser!)'s account"
        var authError: NSError?
        
        
        
        if authContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError){
            authContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: authReason, reply: { (success, error) in
                if success{
                    print("successful")
                    // UI Code here
                    DispatchQueue.main.async {
                        self.start_activity_loader()
                        
                        let secretPassword = self.keyChain.get(keyChainKeys.secretPassword.rawValue)
                        
                        self.goToCurrSpends()
                        
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
    
    
    func goToCurrSpends(){
        let storyboard = UIStoryboard(name: "PostPaid", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "currentSpendsBills") as? currentSpendsBills else {return}
        moveTo.currSpend = self.currentSpend
        self.present(moveTo, animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
}
