//
//  ChangePasswordInApp.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 26/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class ChangePasswordInApp: baseViewControllerM {

    fileprivate var lblCurrentPassTop1: NSLayoutConstraint?
    fileprivate var lblCurrentPassTop2: NSLayoutConstraint?
    fileprivate var cardHeight1: NSLayoutConstraint?
    fileprivate var cardHeight2: NSLayoutConstraint?
    // back button
    let backButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Menu button
    let btnMenu: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //create a closure for background Image
    let backImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //create a motherView
    let motherViewC: UIView = {
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
    
    //create cardView
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.60)
        view.isOpaque = false
        return view
    }()
    
    //create support header view
    let supportHView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.support_white1
        return view
    }()
    
    let errorDialogBg = UIImageView(image: #imageLiteral(resourceName: "error_dialog_bg"))
    let lblErrorMessage = UILabel()
    let txtCurrPass = UITextField()
    let txtNewPass = UITextField()
    let txtConfPass = UITextField()
    let btnContinue = UIButton()
    let btnGoBack = UIButton()
    
    //support icon red
    let supportIcon = UIImageView(image: #imageLiteral(resourceName: "support_red"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViewsChangePass()
        hideKeyboardWhenTappedAround()
        checkConnection()
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize.height = view.frame.size.height + cardView.frame.size.height
    }
    
    func setUpViewsChangePass(){
        view.addSubview(backImage)
        backImage.image = UIImage(named: "morning_bg_")
        backImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backImage.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        backImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backImage.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
        view.addSubview(motherViewC)
        motherViewC.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        motherViewC.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        motherViewC.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        motherViewC.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
        motherViewC.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: motherViewC.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: motherViewC.safeTopAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: motherViewC.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: motherViewC.safeBottomAnchor).isActive = true
        
        
        scrollView.addSubview(backButton)
        let leftImage = UIImage(named: "leftArrow")
        let backTint = leftImage?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(backTint, for: .normal)
        backButton.tintColor = UIColor.white
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: motherViewC.leadingAnchor, constant: 10).isActive = true
        backButton.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        
        scrollView.addSubview(btnMenu)
        let menuImage = UIImage(named: "menu")
        btnMenu.setImage(menuImage, for: .normal)
        btnMenu.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnMenu.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnMenu.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        btnMenu.trailingAnchor.constraint(equalTo: motherViewC.trailingAnchor, constant: -10).isActive = true
        btnMenu.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        
        //Menu label
        let lblMenu = UILabel()
        scrollView.addSubview(lblMenu)
        lblMenu.translatesAutoresizingMaskIntoConstraints = false
        lblMenu.textColor = UIColor.white
        lblMenu.text = "MENU"
        lblMenu.font = UIFont(name: String.defaultFontR, size: 13)
        lblMenu.topAnchor.constraint(equalTo: btnMenu.bottomAnchor, constant: -3).isActive = true
        lblMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14).isActive = true
        
        let lblChangePassword = UILabel()
        scrollView.addSubview(lblChangePassword)
        lblChangePassword.translatesAutoresizingMaskIntoConstraints = false
        lblChangePassword.text = "Change your password"
        lblChangePassword.textColor = UIColor.white
        lblChangePassword.textAlignment = .center
        lblChangePassword.font = UIFont(name: String.defaultFontR, size: 33)
        lblChangePassword.numberOfLines = 0
        lblChangePassword.lineBreakMode = .byWordWrapping
        lblChangePassword.centerXAnchor.constraint(equalTo: motherViewC.centerXAnchor).isActive = true
        lblChangePassword.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 70).isActive = true
        
        scrollView.addSubview(cardView)
        cardView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 25).isActive = true
        cardView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 140).isActive = true
        cardView.trailingAnchor.constraint(equalTo: motherViewC.trailingAnchor, constant: -25).isActive = true
        cardHeight1 = cardView.heightAnchor.constraint(equalToConstant: 430)
        cardHeight2 = cardView.heightAnchor.constraint(equalToConstant: 800)
        cardHeight1?.isActive = true
        
        cardView.addSubview(errorDialogBg)
        errorDialogBg.translatesAutoresizingMaskIntoConstraints = false
        errorDialogBg.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        errorDialogBg.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20).isActive = true
        errorDialogBg.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        errorDialogBg.heightAnchor.constraint(equalToConstant: 80).isActive = true
        errorDialogBg.isHidden = true
        let errorImage = UIImageView(image: #imageLiteral(resourceName: "info"))
        errorDialogBg.addSubview(errorImage)
        errorImage.translatesAutoresizingMaskIntoConstraints = false
        errorImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        errorImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        errorImage.leadingAnchor.constraint(equalTo: errorDialogBg.leadingAnchor, constant: 20).isActive = true
        errorImage.topAnchor.constraint(equalTo: errorDialogBg.topAnchor, constant: 20).isActive = true
        
        errorDialogBg.addSubview(lblErrorMessage)
        lblErrorMessage.translatesAutoresizingMaskIntoConstraints = false
        lblErrorMessage.font = UIFont(name: String.defaultFontR, size: 16)
        lblErrorMessage.textColor = UIColor.white
        lblErrorMessage.numberOfLines = 0
        lblErrorMessage.lineBreakMode = .byWordWrapping
        lblErrorMessage.leadingAnchor.constraint(equalTo: errorImage.trailingAnchor, constant: 10).isActive = true
        lblErrorMessage.topAnchor.constraint(equalTo: errorDialogBg.topAnchor, constant: 23).isActive = true
        lblErrorMessage.trailingAnchor.constraint(equalTo: errorDialogBg.trailingAnchor, constant: -10).isActive = true
        
        let lblCurrentPass = UILabel()
        cardView.addSubview(lblCurrentPass)
        lblCurrentPass.translatesAutoresizingMaskIntoConstraints = false
        lblCurrentPass.textColor = UIColor.white
        lblCurrentPass.text = "Current Password"
        lblCurrentPass.font = UIFont(name: String.defaultFontR, size: 18)
        lblCurrentPass.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblCurrentPassTop1 = lblCurrentPass.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20)
        lblCurrentPassTop2 = lblCurrentPass.topAnchor.constraint(equalTo: errorDialogBg.bottomAnchor, constant: 20)
        lblCurrentPassTop1?.isActive = true
        lblCurrentPass.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        
        cardView.addSubview(txtCurrPass)
        txtCurrPass.translatesAutoresizingMaskIntoConstraints = false
        txtCurrPass.font = UIFont(name: String.defaultFontR, size: 16)
        txtCurrPass.borderStyle = .roundedRect
        txtCurrPass.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtCurrPass.topAnchor.constraint(equalTo: lblCurrentPass.bottomAnchor, constant: 5).isActive = true
        txtCurrPass.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtCurrPass.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtCurrPass.isSecureTextEntry = true
        txtCurrPass.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
        
        let lblNewPass = UILabel()
        cardView.addSubview(lblNewPass)
        lblNewPass.translatesAutoresizingMaskIntoConstraints = false
        lblNewPass.textColor = UIColor.white
        lblNewPass.text = "New Password"
        lblNewPass.font = UIFont(name: String.defaultFontR, size: 18)
        lblNewPass.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblNewPass.topAnchor.constraint(equalTo: txtCurrPass.bottomAnchor, constant: 20).isActive = true
        lblNewPass.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        
        cardView.addSubview(txtNewPass)
        txtNewPass.translatesAutoresizingMaskIntoConstraints = false
        txtNewPass.font = UIFont(name: String.defaultFontR, size: 16)
        txtNewPass.borderStyle = .roundedRect
        txtNewPass.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtNewPass.topAnchor.constraint(equalTo: lblNewPass.bottomAnchor, constant: 5).isActive = true
        txtNewPass.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtNewPass.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtNewPass.isSecureTextEntry = true
        txtNewPass.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
        
        let lblConfPass = UILabel()
        cardView.addSubview(lblConfPass)
        lblConfPass.translatesAutoresizingMaskIntoConstraints = false
        lblConfPass.textColor = UIColor.white
        lblConfPass.text = "Confirm Password"
        lblConfPass.font = UIFont(name: String.defaultFontR, size: 18)
        lblConfPass.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblConfPass.topAnchor.constraint(equalTo: txtNewPass.bottomAnchor, constant: 20).isActive = true
        lblConfPass.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        
        cardView.addSubview(txtConfPass)
        txtConfPass.translatesAutoresizingMaskIntoConstraints = false
        txtConfPass.font = UIFont(name: String.defaultFontR, size: 16)
        txtConfPass.borderStyle = .roundedRect
        txtConfPass.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtConfPass.topAnchor.constraint(equalTo: lblConfPass.bottomAnchor, constant: 5).isActive = true
        txtConfPass.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtConfPass.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtConfPass.isSecureTextEntry = true
        txtCurrPass.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
        
        cardView.addSubview(btnContinue)
        btnContinue.translatesAutoresizingMaskIntoConstraints = false
        btnContinue.backgroundColor = UIColor.grayButton
        btnContinue.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnContinue.setTitle("Continue", for: .normal)
        btnContinue.setTitleColor(UIColor.white, for: .normal)
        btnContinue.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        btnContinue.topAnchor.constraint(equalTo: txtConfPass.bottomAnchor, constant: 30).isActive = true
        btnContinue.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        btnContinue.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        cardView.addSubview(btnGoBack)
        btnGoBack.translatesAutoresizingMaskIntoConstraints = false
        btnGoBack.backgroundColor = UIColor.gray
        btnGoBack.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnGoBack.setTitle("Go Back", for: .normal)
        btnGoBack.setTitleColor(UIColor.black, for: .normal)
        btnGoBack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        btnGoBack.topAnchor.constraint(equalTo: btnContinue.bottomAnchor, constant: 10).isActive = true
        btnGoBack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        btnGoBack.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnGoBack.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        
    }
    
    @objc func checkInputs(){
        
        let totalCurrPass = txtCurrPass.text!
        let totalConfPass = txtConfPass.text!
        if txtCurrPass.text == "" || txtNewPass.text == "" || txtConfPass.text == "" {
            btnContinue.backgroundColor = UIColor.grayButton
            print("can't")
            
        }else{
            btnContinue.backgroundColor = UIColor.vodaRed
            print("doing")
        }
    }
   
}
