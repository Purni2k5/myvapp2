//
//  SettingsVc.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 26/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class SettingsVc: baseViewControllerM {
    var msisdn: String?
    var autoLoginStatus: String?

    //closure for scroll view
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // top Image for
    let topImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    //create Automatic Login card view
    let autoLoginCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 2
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        return view
    }()
    
    //create change password card view
    let changePasswordCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 2
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        return view
    }()
    
    //create Touch ID card view
    let touchIDCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 2
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        return view
    }()
    
    //create Personalized app card view
    let personailizedAppCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        
        view.layer.cornerRadius = 2
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        return view
    }()
    
    //create Privacy card view
    let privacyCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 2
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        return view
    }()
    
    //create notification card view
    let notificationCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        
        view.layer.cornerRadius = 2
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        return view
    }()
    
    //create Terms&Condition card view
    let termsConditionCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        
        view.layer.cornerRadius = 2
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        return view
    }()
    //create Privacy Policy card view
    let privacyPolicyCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        
        view.layer.cornerRadius = 2
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        return view
    }()
    
    let autoSwitch = UISwitch()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground

        SetUpViewsSettings()
        let defaultMSISDN = preference.object(forKey: "defaultMSISDN")
        if let defaultMSISDN = defaultMSISDN {
            msisdn = defaultMSISDN as? String
            print(defaultMSISDN)
        }else{
            
        }
        
        
        
        
        
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(autoLoginCard.frame.size.height)
        scrollView.contentSize.height = view.frame.size.height + autoLoginCard.frame.size.height + changePasswordCard.frame.size.height + touchIDCard.frame.size.height + personailizedAppCard.frame.size.height + privacyCard.frame.size.height + notificationCard.frame.size.height + termsConditionCard.frame.size.height + privacyPolicyCard.frame.size.height
//        scrollView.contentSize.height = 2000
    }

    func SetUpViewsSettings(){
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
        
        scrollView.addSubview(topImage)
        topImage.image = UIImage(named: "bg2")
        topImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        topImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImage.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        topImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        scrollView.addSubview(backButton)
        let backImage = UIImage(named: "leftArrow")
        let backTint = backImage?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(backTint, for: .normal)
        backButton.tintColor = UIColor.white
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 10).isActive = true
        backButton.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
        
        scrollView.addSubview(btnMenu)
        let menuImage = UIImage(named: "menu")
        btnMenu.setImage(menuImage, for: .normal)
        btnMenu.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnMenu.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnMenu.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 10).isActive = true
        btnMenu.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -10).isActive = true
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
        
        //Selected Offer
        let lblSelectedOffer = UILabel()
        scrollView.addSubview(lblSelectedOffer)
        lblSelectedOffer.translatesAutoresizingMaskIntoConstraints = false
        lblSelectedOffer.textColor = UIColor.white
        lblSelectedOffer.textAlignment = .center
        lblSelectedOffer.font = UIFont(name: String.defaultFontR, size: 31)
        lblSelectedOffer.text = "Settings"
        lblSelectedOffer.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        lblSelectedOffer.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 70).isActive = true
        lblSelectedOffer.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        lblSelectedOffer.numberOfLines = 0
        lblSelectedOffer.lineBreakMode = .byWordWrapping
        
        //Account label
        let lblAccLabel = UILabel()
        scrollView.addSubview(lblAccLabel)
        lblAccLabel.translatesAutoresizingMaskIntoConstraints = false
        lblAccLabel.text = "My Account"
        lblAccLabel.textColor = UIColor.support_voilet
        lblAccLabel.font = UIFont(name: String.defaultFontR, size: 33)
        lblAccLabel.textAlignment = .center
        lblAccLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        lblAccLabel.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 20).isActive = true
        lblAccLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
        //Automatic login
        scrollView.addSubview(autoLoginCard)
        autoLoginCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        autoLoginCard.topAnchor.constraint(equalTo: lblAccLabel.bottomAnchor, constant: 20).isActive = true
        autoLoginCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        autoLoginCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        //Left Image
        let autoLeftImage = UIImageView()
        autoLoginCard.addSubview(autoLeftImage)
        autoLeftImage.translatesAutoresizingMaskIntoConstraints = false
        autoLeftImage.backgroundColor = UIColor.cardImageColour
        autoLeftImage.widthAnchor.constraint(equalToConstant: 12).isActive = true
        autoLeftImage.leadingAnchor.constraint(equalTo: autoLoginCard.leadingAnchor).isActive = true
        autoLeftImage.topAnchor.constraint(equalTo: autoLoginCard.topAnchor).isActive = true
        autoLeftImage.bottomAnchor.constraint(equalTo: autoLoginCard.bottomAnchor).isActive = true
        
        let lblCardName = UILabel()
        autoLoginCard.addSubview(lblCardName)
        lblCardName.translatesAutoresizingMaskIntoConstraints = false
        lblCardName.text = "Automatic Log in"
        lblCardName.font = UIFont(name: String.defaultFontR, size: 22)
        lblCardName.textColor = UIColor.black
        lblCardName.leadingAnchor.constraint(equalTo: autoLeftImage.trailingAnchor, constant: 20).isActive = true
        lblCardName.topAnchor.constraint(equalTo: autoLoginCard.topAnchor, constant: 30).isActive = true
        lblCardName.trailingAnchor.constraint(equalTo: autoLoginCard.trailingAnchor, constant: -10).isActive = true
        lblCardName.numberOfLines = 0
        lblCardName.lineBreakMode = .byWordWrapping
        
        let lblAutoDesc = UILabel()
        autoLoginCard.addSubview(lblAutoDesc)
        lblAutoDesc.translatesAutoresizingMaskIntoConstraints = false
        lblAutoDesc.text = "Login without entering your details"
        lblAutoDesc.font = UIFont(name: String.defaultFontR, size: 16)
        lblAutoDesc.leadingAnchor.constraint(equalTo: autoLeftImage.trailingAnchor, constant: 20).isActive = true
        lblAutoDesc.topAnchor.constraint(equalTo: lblCardName.bottomAnchor, constant: 10).isActive = true
        lblAutoDesc.numberOfLines = 0
        lblAutoDesc.trailingAnchor.constraint(equalTo: autoLoginCard.trailingAnchor, constant: -30).isActive = true
        lblAutoDesc.lineBreakMode = .byWordWrapping
        
        autoLoginCard.addSubview(autoSwitch)
        autoSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        autoSwitch.trailingAnchor.constraint(equalTo: autoLoginCard.trailingAnchor, constant: -20).isActive = true
        autoSwitch.topAnchor.constraint(equalTo: autoLoginCard.topAnchor, constant: 40).isActive = true
        autoSwitch.heightAnchor.constraint(equalToConstant: 40).isActive = true
        autoSwitch.widthAnchor.constraint(equalToConstant: 40).isActive = true
        autoSwitch.addTarget(self, action: #selector(turnIsLogin), for: .touchUpInside)
        autoLoginStatus = preference.object(forKey: "loginStatus") as? String
        print("Login stat \(autoLoginStatus)")
        if autoLoginStatus == "Yes"{
            autoSwitch.isOn = true
        }else{
            autoSwitch.isOn = false
            
        }
        
        //Change Password
        scrollView.addSubview(changePasswordCard)
        changePasswordCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        changePasswordCard.topAnchor.constraint(equalTo: autoLoginCard.bottomAnchor, constant: 20).isActive = true
        changePasswordCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        changePasswordCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        let changePassRec = UITapGestureRecognizer(target: self, action: #selector(goToChangePass))
        changePasswordCard.addGestureRecognizer(changePassRec)
        
        //Left Image
        let changePLeftImage = UIImageView()
        changePasswordCard.addSubview(changePLeftImage)
        changePLeftImage.translatesAutoresizingMaskIntoConstraints = false
        changePLeftImage.backgroundColor = UIColor.cardImageColour
        changePLeftImage.widthAnchor.constraint(equalToConstant: 12).isActive = true
        changePLeftImage.leadingAnchor.constraint(equalTo: changePasswordCard.leadingAnchor).isActive = true
        changePLeftImage.topAnchor.constraint(equalTo: changePasswordCard.topAnchor).isActive = true
        changePLeftImage.bottomAnchor.constraint(equalTo: changePasswordCard.bottomAnchor).isActive = true
        
        let lblChangePName = UILabel()
        changePasswordCard.addSubview(lblChangePName)
        lblChangePName.translatesAutoresizingMaskIntoConstraints = false
        lblChangePName.text = "Change Password"
        lblChangePName.font = UIFont(name: String.defaultFontR, size: 22)
        lblChangePName.textColor = UIColor.black
        lblChangePName.leadingAnchor.constraint(equalTo: changePLeftImage.trailingAnchor, constant: 20).isActive = true
        lblChangePName.topAnchor.constraint(equalTo: changePasswordCard.topAnchor, constant: 30).isActive = true
        lblChangePName.trailingAnchor.constraint(equalTo: changePasswordCard.trailingAnchor, constant: -10).isActive = true
        lblChangePName.numberOfLines = 0
        lblChangePName.lineBreakMode = .byWordWrapping
        
        let lblChangeDesc = UILabel()
        changePasswordCard.addSubview(lblChangeDesc)
        lblChangeDesc.translatesAutoresizingMaskIntoConstraints = false
        lblChangeDesc.text = "Change your current password"
        lblChangeDesc.font = UIFont(name: String.defaultFontR, size: 16)
        lblChangeDesc.leadingAnchor.constraint(equalTo: changePLeftImage.trailingAnchor, constant: 20).isActive = true
        lblChangeDesc.topAnchor.constraint(equalTo: lblChangePName.bottomAnchor, constant: 10).isActive = true
        lblChangeDesc.numberOfLines = 0
        lblChangeDesc.trailingAnchor.constraint(equalTo: changePasswordCard.trailingAnchor, constant: -30).isActive = true
        lblChangeDesc.lineBreakMode = .byWordWrapping
        
        let changePRightArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        changePasswordCard.addSubview(changePRightArrow)
        changePRightArrow.translatesAutoresizingMaskIntoConstraints = false
        changePRightArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
        changePRightArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
        changePRightArrow.topAnchor.constraint(equalTo: changePasswordCard.topAnchor, constant: 40).isActive = true
        changePRightArrow.trailingAnchor.constraint(equalTo: changePasswordCard.trailingAnchor, constant: -10).isActive = true
        
        //Touch ID
        scrollView.addSubview(touchIDCard)
        touchIDCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        touchIDCard.topAnchor.constraint(equalTo: changePasswordCard.bottomAnchor, constant: 20).isActive = true
        touchIDCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        touchIDCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        let touchIDRec = UITapGestureRecognizer(target: self, action: #selector(goToTouchID(_sender:)))
        touchIDCard.addGestureRecognizer(touchIDRec)
        
        //Left Image
        let touchIDLeftImage = UIImageView()
        touchIDCard.addSubview(touchIDLeftImage)
        touchIDLeftImage.translatesAutoresizingMaskIntoConstraints = false
        touchIDLeftImage.backgroundColor = UIColor.cardImageColour
        touchIDLeftImage.widthAnchor.constraint(equalToConstant: 12).isActive = true
        touchIDLeftImage.leadingAnchor.constraint(equalTo: touchIDCard.leadingAnchor).isActive = true
        touchIDLeftImage.topAnchor.constraint(equalTo: touchIDCard.topAnchor).isActive = true
        touchIDLeftImage.bottomAnchor.constraint(equalTo: touchIDCard.bottomAnchor).isActive = true
        
        let lblTouchIDName = UILabel()
        touchIDCard.addSubview(lblTouchIDName)
        lblTouchIDName.translatesAutoresizingMaskIntoConstraints = false
        lblTouchIDName.text = "Touch ID"
        lblTouchIDName.font = UIFont(name: String.defaultFontR, size: 22)
        lblTouchIDName.textColor = UIColor.black
        lblTouchIDName.leadingAnchor.constraint(equalTo: changePLeftImage.trailingAnchor, constant: 20).isActive = true
        lblTouchIDName.topAnchor.constraint(equalTo: touchIDCard.topAnchor, constant: 30).isActive = true
        lblTouchIDName.trailingAnchor.constraint(equalTo: touchIDCard.trailingAnchor, constant: -10).isActive = true
        lblTouchIDName.numberOfLines = 0
        lblTouchIDName.lineBreakMode = .byWordWrapping
        
        let lblTouchIDDesc = UILabel()
        touchIDCard.addSubview(lblTouchIDDesc)
        lblTouchIDDesc.translatesAutoresizingMaskIntoConstraints = false
        lblTouchIDDesc.text = "Access the app using your touch ID"
        lblTouchIDDesc.font = UIFont(name: String.defaultFontR, size: 16)
        lblTouchIDDesc.leadingAnchor.constraint(equalTo: touchIDLeftImage.trailingAnchor, constant: 20).isActive = true
        lblTouchIDDesc.topAnchor.constraint(equalTo: lblTouchIDName.bottomAnchor, constant: 10).isActive = true
        lblTouchIDDesc.numberOfLines = 0
        lblTouchIDDesc.trailingAnchor.constraint(equalTo: touchIDCard.trailingAnchor, constant: -30).isActive = true
        lblTouchIDDesc.lineBreakMode = .byWordWrapping
        
        let touchIDRightArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        touchIDCard.addSubview(touchIDRightArrow)
        touchIDRightArrow.translatesAutoresizingMaskIntoConstraints = false
        touchIDRightArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
        touchIDRightArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
        touchIDRightArrow.topAnchor.constraint(equalTo: touchIDCard.topAnchor, constant: 40).isActive = true
        touchIDRightArrow.trailingAnchor.constraint(equalTo: touchIDCard.trailingAnchor, constant: -10).isActive = true
        
        
        //Personalized label
        let lblPersonLabel = UILabel()
        scrollView.addSubview(lblPersonLabel)
        lblPersonLabel.translatesAutoresizingMaskIntoConstraints = false
        lblPersonLabel.text = "Personalise my app"
        lblPersonLabel.textColor = UIColor.support_voilet
        lblPersonLabel.font = UIFont(name: String.defaultFontR, size: 35)
        lblPersonLabel.textAlignment = .center
        lblPersonLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        lblPersonLabel.topAnchor.constraint(equalTo: touchIDCard.bottomAnchor, constant: 60).isActive = true
        lblPersonLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
        //Personalized my app
        scrollView.addSubview(personailizedAppCard)
        personailizedAppCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        personailizedAppCard.topAnchor.constraint(equalTo: lblPersonLabel.bottomAnchor, constant: 20).isActive = true
        personailizedAppCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        personailizedAppCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        let personlisedRec = UITapGestureRecognizer(target: self, action: #selector(goToSettingsPersonlise(_sender:)))
        personailizedAppCard.addGestureRecognizer(personlisedRec)
        
        //Left Image
        let personalizedLeftImage = UIImageView()
        personailizedAppCard.addSubview(personalizedLeftImage)
        personalizedLeftImage.translatesAutoresizingMaskIntoConstraints = false
        personalizedLeftImage.backgroundColor = UIColor.cardImageColour
        personalizedLeftImage.widthAnchor.constraint(equalToConstant: 12).isActive = true
        personalizedLeftImage.leadingAnchor.constraint(equalTo: personailizedAppCard.leadingAnchor).isActive = true
        personalizedLeftImage.topAnchor.constraint(equalTo: personailizedAppCard.topAnchor).isActive = true
        personalizedLeftImage.bottomAnchor.constraint(equalTo: personailizedAppCard.bottomAnchor).isActive = true
        
        let lblPernalisedName = UILabel()
        personailizedAppCard.addSubview(lblPernalisedName)
        lblPernalisedName.translatesAutoresizingMaskIntoConstraints = false
        lblPernalisedName.text = "Personlised my app"
        lblPernalisedName.font = UIFont(name: String.defaultFontR, size: 22)
        lblPernalisedName.textColor = UIColor.black
        lblPernalisedName.leadingAnchor.constraint(equalTo: changePLeftImage.trailingAnchor, constant: 20).isActive = true
        lblPernalisedName.topAnchor.constraint(equalTo: personailizedAppCard.topAnchor, constant: 30).isActive = true
        lblPernalisedName.trailingAnchor.constraint(equalTo: personailizedAppCard.trailingAnchor, constant: -10).isActive = true
        lblPernalisedName.numberOfLines = 0
        lblPernalisedName.lineBreakMode = .byWordWrapping
        
        let lblPersonDesc = UILabel()
        personailizedAppCard.addSubview(lblPersonDesc)
        lblPersonDesc.translatesAutoresizingMaskIntoConstraints = false
        lblPersonDesc.text = "Add photos and profile name"
        lblPersonDesc.font = UIFont(name: String.defaultFontR, size: 16)
        lblPersonDesc.leadingAnchor.constraint(equalTo: touchIDLeftImage.trailingAnchor, constant: 20).isActive = true
        lblPersonDesc.topAnchor.constraint(equalTo: lblPernalisedName.bottomAnchor, constant: 10).isActive = true
        lblPersonDesc.numberOfLines = 0
        lblPersonDesc.trailingAnchor.constraint(equalTo: personailizedAppCard.trailingAnchor, constant: -30).isActive = true
        lblPersonDesc.lineBreakMode = .byWordWrapping
        
        let personalisedRightArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        personailizedAppCard.addSubview(personalisedRightArrow)
        personalisedRightArrow.translatesAutoresizingMaskIntoConstraints = false
        personalisedRightArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
        personalisedRightArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
        personalisedRightArrow.topAnchor.constraint(equalTo: personailizedAppCard.topAnchor, constant: 40).isActive = true
        personalisedRightArrow.trailingAnchor.constraint(equalTo: personailizedAppCard.trailingAnchor, constant: -10).isActive = true
        
        
        //Privacy
        scrollView.addSubview(privacyCard)
        privacyCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        privacyCard.topAnchor.constraint(equalTo: personailizedAppCard.bottomAnchor, constant: 20).isActive = true
        privacyCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        privacyCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        let privacyRec = UITapGestureRecognizer(target: self, action: #selector(goToSettingsPrivacy(_sender:)))
        privacyCard.addGestureRecognizer(privacyRec)
        
        //Left Image
        let privacyLeftImage = UIImageView()
        privacyCard.addSubview(privacyLeftImage)
        privacyLeftImage.translatesAutoresizingMaskIntoConstraints = false
        privacyLeftImage.backgroundColor = UIColor.cardImageColour
        privacyLeftImage.widthAnchor.constraint(equalToConstant: 12).isActive = true
        privacyLeftImage.leadingAnchor.constraint(equalTo: privacyCard.leadingAnchor).isActive = true
        privacyLeftImage.topAnchor.constraint(equalTo: privacyCard.topAnchor).isActive = true
        privacyLeftImage.bottomAnchor.constraint(equalTo: privacyCard.bottomAnchor).isActive = true
        
        let lblPrivacyName = UILabel()
        privacyCard.addSubview(lblPrivacyName)
        lblPrivacyName.translatesAutoresizingMaskIntoConstraints = false
        lblPrivacyName.text = "Privacy"
        lblPrivacyName.font = UIFont(name: String.defaultFontR, size: 22)
        lblPrivacyName.textColor = UIColor.black
        lblPrivacyName.leadingAnchor.constraint(equalTo: changePLeftImage.trailingAnchor, constant: 20).isActive = true
        lblPrivacyName.topAnchor.constraint(equalTo: privacyCard.topAnchor, constant: 30).isActive = true
        lblPrivacyName.trailingAnchor.constraint(equalTo: privacyCard.trailingAnchor, constant: -10).isActive = true
        lblPrivacyName.numberOfLines = 0
        lblPrivacyName.lineBreakMode = .byWordWrapping
        
        let lblPrivacyDesc = UILabel()
        privacyCard.addSubview(lblPrivacyDesc)
        lblPrivacyDesc.translatesAutoresizingMaskIntoConstraints = false
        lblPrivacyDesc.text = "Manage your data privacy"
        lblPrivacyDesc.font = UIFont(name: String.defaultFontR, size: 16)
        lblPrivacyDesc.leadingAnchor.constraint(equalTo: touchIDLeftImage.trailingAnchor, constant: 20).isActive = true
        lblPrivacyDesc.topAnchor.constraint(equalTo: lblPrivacyName.bottomAnchor, constant: 10).isActive = true
        lblPrivacyDesc.numberOfLines = 0
        lblPrivacyDesc.trailingAnchor.constraint(equalTo: privacyCard.trailingAnchor, constant: -30).isActive = true
        lblPrivacyDesc.lineBreakMode = .byWordWrapping
        
        let privacyRightArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        privacyCard.addSubview(privacyRightArrow)
        privacyRightArrow.translatesAutoresizingMaskIntoConstraints = false
        privacyRightArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
        privacyRightArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
        privacyRightArrow.topAnchor.constraint(equalTo: privacyCard.topAnchor, constant: 40).isActive = true
        privacyRightArrow.trailingAnchor.constraint(equalTo: privacyCard.trailingAnchor, constant: -10).isActive = true
        
        //Notification
        scrollView.addSubview(notificationCard)
        notificationCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        notificationCard.topAnchor.constraint(equalTo: privacyCard.bottomAnchor, constant: 20).isActive = true
        notificationCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        notificationCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        let notifRec = UITapGestureRecognizer(target: self, action: #selector(goToNotifications))
        notificationCard.addGestureRecognizer(notifRec)
        
        //Left Image
        let notifLeftImage = UIImageView()
        notificationCard.addSubview(notifLeftImage)
        notifLeftImage.translatesAutoresizingMaskIntoConstraints = false
        notifLeftImage.backgroundColor = UIColor.cardImageColour
        notifLeftImage.widthAnchor.constraint(equalToConstant: 12).isActive = true
        notifLeftImage.leadingAnchor.constraint(equalTo: notificationCard.leadingAnchor).isActive = true
        notifLeftImage.topAnchor.constraint(equalTo: notificationCard.topAnchor).isActive = true
        notifLeftImage.bottomAnchor.constraint(equalTo: notificationCard.bottomAnchor).isActive = true
        
        let lblNotifName = UILabel()
        notificationCard.addSubview(lblNotifName)
        lblNotifName.translatesAutoresizingMaskIntoConstraints = false
        lblNotifName.text = "Notifications"
        lblNotifName.font = UIFont(name: String.defaultFontR, size: 22)
        lblNotifName.textColor = UIColor.black
        lblNotifName.leadingAnchor.constraint(equalTo: notifLeftImage.trailingAnchor, constant: 20).isActive = true
        lblNotifName.topAnchor.constraint(equalTo: notificationCard.topAnchor, constant: 30).isActive = true
        lblNotifName.trailingAnchor.constraint(equalTo: notificationCard.trailingAnchor, constant: -10).isActive = true
        lblNotifName.numberOfLines = 0
        lblNotifName.lineBreakMode = .byWordWrapping
        
        let lblNotifDesc = UILabel()
        notificationCard.addSubview(lblNotifDesc)
        lblNotifDesc.translatesAutoresizingMaskIntoConstraints = false
        lblNotifDesc.text = "Control how we communicate with you"
        lblNotifDesc.font = UIFont(name: String.defaultFontR, size: 16)
        lblNotifDesc.leadingAnchor.constraint(equalTo: touchIDLeftImage.trailingAnchor, constant: 20).isActive = true
        lblNotifDesc.topAnchor.constraint(equalTo: lblNotifName.bottomAnchor, constant: 10).isActive = true
        lblNotifDesc.numberOfLines = 0
        lblNotifDesc.trailingAnchor.constraint(equalTo: notificationCard.trailingAnchor, constant: -30).isActive = true
        lblNotifDesc.lineBreakMode = .byWordWrapping
        
        let notifRightArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        notificationCard.addSubview(notifRightArrow)
        notifRightArrow.translatesAutoresizingMaskIntoConstraints = false
        notifRightArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
        notifRightArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
        notifRightArrow.topAnchor.constraint(equalTo: notificationCard.topAnchor, constant: 40).isActive = true
        notifRightArrow.trailingAnchor.constraint(equalTo: notificationCard.trailingAnchor, constant: -10).isActive = true
        
        //Useful Information label
        let lblUsefulLabel = UILabel()
        scrollView.addSubview(lblUsefulLabel)
        lblUsefulLabel.translatesAutoresizingMaskIntoConstraints = false
        lblUsefulLabel.text = "Useful Information"
        lblUsefulLabel.textColor = UIColor.support_voilet
        lblUsefulLabel.font = UIFont(name: String.defaultFontR, size: 35)
        lblUsefulLabel.textAlignment = .center
        lblUsefulLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        lblUsefulLabel.topAnchor.constraint(equalTo: notificationCard.bottomAnchor, constant: 60).isActive = true
        lblUsefulLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
        //T & C
        scrollView.addSubview(termsConditionCard)
        termsConditionCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        termsConditionCard.topAnchor.constraint(equalTo: lblUsefulLabel.bottomAnchor, constant: 20).isActive = true
        termsConditionCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        termsConditionCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
        let termsConRec = UITapGestureRecognizer(target: self, action: #selector(goToTC))
        termsConditionCard.addGestureRecognizer(termsConRec)
        
        //Left Image
        let tCLeftImage = UIImageView()
        termsConditionCard.addSubview(tCLeftImage)
        tCLeftImage.translatesAutoresizingMaskIntoConstraints = false
        tCLeftImage.backgroundColor = UIColor.cardImageColour
        tCLeftImage.widthAnchor.constraint(equalToConstant: 12).isActive = true
        tCLeftImage.leadingAnchor.constraint(equalTo: termsConditionCard.leadingAnchor).isActive = true
        tCLeftImage.topAnchor.constraint(equalTo: termsConditionCard.topAnchor).isActive = true
        tCLeftImage.bottomAnchor.constraint(equalTo: termsConditionCard.bottomAnchor).isActive = true
        
        let lblTCName = UILabel()
        termsConditionCard.addSubview(lblTCName)
        lblTCName.translatesAutoresizingMaskIntoConstraints = false
        lblTCName.text = "Terms & Condition"
        lblTCName.font = UIFont(name: String.defaultFontR, size: 22)
        lblTCName.textColor = UIColor.black
        lblTCName.leadingAnchor.constraint(equalTo: notifLeftImage.trailingAnchor, constant: 20).isActive = true
        lblTCName.topAnchor.constraint(equalTo: termsConditionCard.topAnchor, constant: 30).isActive = true
        lblTCName.trailingAnchor.constraint(equalTo: termsConditionCard.trailingAnchor, constant: -10).isActive = true
        lblTCName.numberOfLines = 0
        lblTCName.lineBreakMode = .byWordWrapping
        
        let tCRightArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        termsConditionCard.addSubview(tCRightArrow)
        tCRightArrow.translatesAutoresizingMaskIntoConstraints = false
        tCRightArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
        tCRightArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
        tCRightArrow.topAnchor.constraint(equalTo: termsConditionCard.topAnchor, constant: 40).isActive = true
        tCRightArrow.trailingAnchor.constraint(equalTo: termsConditionCard.trailingAnchor, constant: -10).isActive = true
        
        //Privacy Policy
        scrollView.addSubview(privacyPolicyCard)
        privacyPolicyCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        privacyPolicyCard.topAnchor.constraint(equalTo: termsConditionCard.bottomAnchor, constant: 20).isActive = true
        privacyPolicyCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        privacyPolicyCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        //Left Image
        let pPLeftImage = UIImageView()
        privacyPolicyCard.addSubview(pPLeftImage)
        pPLeftImage.translatesAutoresizingMaskIntoConstraints = false
        pPLeftImage.backgroundColor = UIColor.cardImageColour
        pPLeftImage.widthAnchor.constraint(equalToConstant: 12).isActive = true
        pPLeftImage.leadingAnchor.constraint(equalTo: privacyPolicyCard.leadingAnchor).isActive = true
        pPLeftImage.topAnchor.constraint(equalTo: privacyPolicyCard.topAnchor).isActive = true
        pPLeftImage.bottomAnchor.constraint(equalTo: privacyPolicyCard.bottomAnchor).isActive = true
        
        let lblPPName = UILabel()
        privacyPolicyCard.addSubview(lblPPName)
        lblPPName.translatesAutoresizingMaskIntoConstraints = false
        lblPPName.text = "Privacy Policy"
        lblPPName.font = UIFont(name: String.defaultFontR, size: 22)
        lblPPName.textColor = UIColor.black
        lblPPName.leadingAnchor.constraint(equalTo: notifLeftImage.trailingAnchor, constant: 20).isActive = true
        lblPPName.topAnchor.constraint(equalTo: privacyPolicyCard.topAnchor, constant: 30).isActive = true
        lblPPName.trailingAnchor.constraint(equalTo: privacyPolicyCard.trailingAnchor, constant: -10).isActive = true
        lblPPName.numberOfLines = 0
        lblPPName.lineBreakMode = .byWordWrapping
        
        let privacyPolicyRec = UITapGestureRecognizer(target: self, action: #selector(goToPrivacyPolicy))
        privacyPolicyCard.addGestureRecognizer(privacyPolicyRec)
        
        let pPRightArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        privacyPolicyCard.addSubview(pPRightArrow)
        pPRightArrow.translatesAutoresizingMaskIntoConstraints = false
        pPRightArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
        pPRightArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
        pPRightArrow.topAnchor.constraint(equalTo: privacyPolicyCard.topAnchor, constant: 40).isActive = true
        pPRightArrow.trailingAnchor.constraint(equalTo: privacyPolicyCard.trailingAnchor, constant: -10).isActive = true
        
    }
    
    @objc func turnIsLogin(){
        if autoSwitch.isOn{
            preference.set("Yes", forKey: "loginStatus")
            autoLoginStatus = "Yes"
            print("Will auto")
        }else{
            preference.set("No", forKey: "loginStatus")
            autoLoginStatus = "No"
            print("Won't auto")
        }
    }
    
    @objc func goToChangePass(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "ChangePasswordInApp")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToTouchID(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "TouchID")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToNotifications(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "notifications")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToSettingsPrivacy(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "settingsPrivacy")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToSettingsPersonlise(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "personliseApp")
        present(moveTo, animated: true, completion: nil)
    }
}
