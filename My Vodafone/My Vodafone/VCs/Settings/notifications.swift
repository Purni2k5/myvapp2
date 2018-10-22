//
//  notifications.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 28/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class notifications: baseViewControllerM {
    
    var isNotif: Bool?

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
    
    //create card view
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.heightAnchor.constraint(equalToConstant: 380).isActive = true
        var offerVariable: String?
        return view
    }()
    
    let switchButton = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground

        setUpViewsNotif()
        
        if AcctType == "PHONE_MOBILE_PRE_P" || AcctType == "BB_FIXED_PRE_P"{
            prePaidMenu()
        }else{
            prePaidMenu()
        }
    }
    
    func setUpViewsNotif(){
        view.addSubview(topImage)
        let timeOfDay = greetings()
        if timeOfDay == "morning"{
            topImage.image = UIImage(named: "bg2")
        }else if timeOfDay == "afternoon" {
            topImage.image = UIImage(named: "afternoon_bg")
        }else{
            topImage.image = UIImage(named: "evening_bg2")
        }
        topImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        topImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImage.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        topImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(backButton)
        let backImage = UIImage(named: "leftArrow")
        let backTint = backImage?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(backTint, for: .normal)
        backButton.tintColor = UIColor.white
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 10).isActive = true
        backButton.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        
        view.addSubview(btnMenu)
        let menuImage = UIImage(named: "menu")
        btnMenu.setImage(menuImage, for: .normal)
        btnMenu.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnMenu.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnMenu.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 10).isActive = true
        btnMenu.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -10).isActive = true
        btnMenu.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        
        //Menu label
        let lblMenu = UILabel()
        view.addSubview(lblMenu)
        lblMenu.translatesAutoresizingMaskIntoConstraints = false
        lblMenu.textColor = UIColor.white
        lblMenu.text = "MENU"
        lblMenu.font = UIFont(name: String.defaultFontR, size: 13)
        lblMenu.topAnchor.constraint(equalTo: btnMenu.bottomAnchor, constant: -3).isActive = true
        lblMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14).isActive = true
        
        //Selected Offer
        let lblSelectedOffer = UILabel()
        view.addSubview(lblSelectedOffer)
        lblSelectedOffer.translatesAutoresizingMaskIntoConstraints = false
        lblSelectedOffer.textColor = UIColor.white
        lblSelectedOffer.textAlignment = .center
        lblSelectedOffer.font = UIFont(name: String.defaultFontR, size: 31)
        lblSelectedOffer.text = "Notifications"
        lblSelectedOffer.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        lblSelectedOffer.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 70).isActive = true
        lblSelectedOffer.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        lblSelectedOffer.numberOfLines = 0
        lblSelectedOffer.lineBreakMode = .byWordWrapping
        
        view.addSubview(cardView)
        cardView.layer.cornerRadius = 2
        cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.2
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cardView.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 20).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        cardView.addSubview(switchButton)
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        
        switchButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        switchButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        switchButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -30).isActive = true
        switchButton.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 40).isActive = true
        switchButton.addTarget(self, action: #selector(toggleSwitch), for: .touchUpInside)
        isNotif = preference.object(forKey: UserDefaultsKeys.notificationEnabled.rawValue) as? Bool
        if let notifStatus = isNotif {
            if notifStatus == true {
                switchButton.isOn = true
            }else{
                switchButton.isOn = false
            }
        }else{
            switchButton.isOn = false
        }
        
        let switchLabel = UILabel()
        cardView.addSubview(switchLabel)
        switchLabel.translatesAutoresizingMaskIntoConstraints = false
        switchLabel.text = "Vodafone recommendations"
        switchLabel.textColor = UIColor.black
        switchLabel.font = UIFont(name: String.defaultFontR, size: 20)
        switchLabel.numberOfLines = 0
        switchLabel.lineBreakMode = .byWordWrapping
        switchLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 30).isActive = true
        switchLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 45).isActive = true
        switchLabel.trailingAnchor.constraint(equalTo: switchButton.leadingAnchor, constant: 30).isActive = true
        
        let separator1 = UIView()
        cardView.addSubview(separator1)
        separator1.translatesAutoresizingMaskIntoConstraints = false
        separator1.backgroundColor = UIColor.black
        separator1.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        separator1.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 30).isActive = true
        separator1.topAnchor.constraint(equalTo: switchLabel.bottomAnchor, constant: 40).isActive = true
        separator1.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -30).isActive = true
        
        let desc = UILabel()
        cardView.addSubview(desc)
        desc.translatesAutoresizingMaskIntoConstraints = false
        desc.font = UIFont(name: String.defaultFontR, size: 19)
        desc.text = "With this option switched ON, you will get the latest news, tailored recommendations and relevant messages directly on your home screen through push notifications. \n \n With this option switched OFF, you will still receive information about your bill and usage."
        desc.numberOfLines = 0
        desc.lineBreakMode = .byWordWrapping
        desc.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 30).isActive = true
        desc.topAnchor.constraint(equalTo: separator1.bottomAnchor, constant: 30).isActive = true
        desc.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -30).isActive = true
        
    }
    
    @objc func toggleSwitch(){
        if switchButton.isOn == true {
            preference.set(true, forKey: UserDefaultsKeys.notificationEnabled.rawValue)
        }else{
            preference.set(false, forKey: UserDefaultsKeys.notificationEnabled.rawValue)
        }
    }

}
