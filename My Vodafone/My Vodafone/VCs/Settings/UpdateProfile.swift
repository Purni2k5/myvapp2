//
//  UpdateProfile.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 20/12/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class UpdateProfile: baseViewControllerM {

    var msisdn: String?
    var displayName: String?
    var id: String?
    var displayImage: String?
    
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
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let lblSelectedOffer: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let darkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        return view
    }()
    
    let displayImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblDisplayName: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: String.defaultFontR, size: 20)
        view.textColor = UIColor.black
        return view
    }()
    
    let lblDisplayNumber: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: String.defaultFontR, size: 20)
        view.textColor = UIColor.black
        return view
    }()
    
    let btnChangeImage: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Change picture", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont(name: String.defaultFontR, size: 19)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground

        setUpViewsUpdateProfile()
        checkConnection()
        if AcctType == "PHONE_MOBILE_PRE_P" || AcctType == "BB_FIXED_PRE_P"{
            prePaidMenu()
        }else{
            prePaidMenu()
        }
    }

    func setUpViewsUpdateProfile(){
        view.addSubview(scrollView)
        scrollView.backgroundColor = UIColor.clear
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
        scrollView.addSubview(topImage)
        let timeOfDay = greetings()
        if timeOfDay == "morning"{
            topImage.image = UIImage(named: "bg2")
        }else if timeOfDay == "afternoon" {
            topImage.image = UIImage(named: "afternoon_bg")
        }else{
            topImage.image = UIImage(named: "evening_bg2")
        }
        topImage.heightAnchor.constraint(equalToConstant: 450).isActive = true
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
        backButton.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        
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
        
        scrollView.addSubview(lblSelectedOffer)
        lblSelectedOffer.translatesAutoresizingMaskIntoConstraints = false
        lblSelectedOffer.textColor = UIColor.white
        lblSelectedOffer.textAlignment = .center
        lblSelectedOffer.font = UIFont(name: String.defaultFontR, size: 31)
        lblSelectedOffer.text = "Services"
        lblSelectedOffer.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        lblSelectedOffer.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 70).isActive = true
        lblSelectedOffer.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        lblSelectedOffer.numberOfLines = 0
        lblSelectedOffer.lineBreakMode = .byWordWrapping
        
        topImage.addSubview(darkView)
        darkView.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        darkView.topAnchor.constraint(equalTo: lblSelectedOffer.bottomAnchor, constant: 5).isActive = true
        darkView.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        darkView.bottomAnchor.constraint(equalTo: topImage.bottomAnchor, constant: -30).isActive = true
        
        darkView.addSubview(displayImageView)
        displayImageView.centerXAnchor.constraint(equalTo: darkView.centerXAnchor).isActive = true
        displayImageView.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 30).isActive = true
        displayImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        displayImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        displayImageView.clipsToBounds = true
        displayImageView.layer.cornerRadius = 60
        displayImageView.layer.borderColor = UIColor.white.cgColor
        displayImageView.layer.borderWidth = 2
        
        darkView.addSubview(lblDisplayName)
        lblDisplayName.centerXAnchor.constraint(equalTo: darkView.centerXAnchor).isActive = true
        lblDisplayName.topAnchor.constraint(equalTo: displayImageView.bottomAnchor, constant: 20).isActive = true
        if let displayName = displayName {
            lblDisplayName.text = displayName
        }
        
        
        
        
        
        
        
        
    }
}
