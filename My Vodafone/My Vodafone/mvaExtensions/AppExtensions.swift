//
//  AppExtensions.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 07/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // Line spacing attribute
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
}

extension UITextField {
    
    func borderBottomColour(){
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 3.0
    }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
   
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func prePaidMenu(){
        
        
        var mssgTopConstraint1: NSLayoutConstraint?
        var mssgTopConstraint2: NSLayoutConstraint?
        var mssgIconTop1: NSLayoutConstraint?
        var mssgIconTop2: NSLayoutConstraint?
        var isCheviClicked: Bool = false
        
        
        let motherView = UIView()
        self.view.addSubview(motherView)
        motherView.translatesAutoresizingMaskIntoConstraints = false
        motherView.topAnchor.constraint(equalTo: self.view.safeTopAnchor).isActive = true
        motherView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        motherView.bottomAnchor.constraint(equalTo: self.view.safeBottomAnchor).isActive = true
        motherView.widthAnchor.constraint(equalToConstant: 320).isActive = true
        motherView.backgroundColor = UIColor.black.withAlphaComponent(0.80)
        motherView.isOpaque = false
        
        //Scroll View
        let scrollView = UIScrollView()
        motherView.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.clear
        scrollView.leadingAnchor.constraint(equalTo: motherView.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: motherView.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: motherView.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: motherView.bottomAnchor).isActive = true
        scrollView.contentSize.height = 750
        
        //close button
        let btnClose = UIButton()
        scrollView.addSubview(btnClose)
        btnClose.translatesAutoresizingMaskIntoConstraints = false
        let close_image = UIImage(named: "ic_close")
        btnClose.setImage(close_image, for: .normal)
        btnClose.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnClose.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnClose.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        btnClose.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -10).isActive = true
        
        //home icon
        let homeIcon = UIImageView(image: #imageLiteral(resourceName: "ic_home"))
        scrollView.addSubview(homeIcon)
        homeIcon.image = homeIcon.image?.withRenderingMode(.alwaysTemplate)
        homeIcon.tintColor = UIColor.white
        homeIcon.translatesAutoresizingMaskIntoConstraints = false
        homeIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        homeIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        homeIcon.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50).isActive = true
        homeIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        //home button
        let btnHome = UIButton()
        scrollView.addSubview(btnHome)
        btnHome.translatesAutoresizingMaskIntoConstraints = false
        btnHome.setTitle("Home", for: .normal)
        btnHome.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnHome.setTitleColor(UIColor.white, for: .normal)
        btnHome.leadingAnchor.constraint(equalTo: homeIcon.trailingAnchor, constant: 16).isActive = true
        btnHome.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 55).isActive = true
        
        //Mobile icon
        let mobileIcon = UIButton()
        scrollView.addSubview(mobileIcon)
        mobileIcon.translatesAutoresizingMaskIntoConstraints = false
        let mobileImage = UIImage(named: "ic_mobile")
        let mobileTintColor = mobileImage?.withRenderingMode(.alwaysTemplate)
        mobileIcon.setImage(mobileTintColor, for: .normal)
        mobileIcon.tintColor = UIColor.white
        mobileIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        mobileIcon.topAnchor.constraint(equalTo: homeIcon.bottomAnchor, constant: 20).isActive = true
        mobileIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        mobileIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        //My products and services
        let btnPdt = UIButton()
        scrollView.addSubview(btnPdt)
        btnPdt.translatesAutoresizingMaskIntoConstraints = false
        btnPdt.setTitle("My products and services", for: .normal)
        btnPdt.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnPdt.setTitleColor(UIColor.white, for: .normal)
        btnPdt.leadingAnchor.constraint(equalTo: mobileIcon.trailingAnchor, constant: 16).isActive = true
        btnPdt.topAnchor.constraint(equalTo: btnHome.bottomAnchor, constant: 21).isActive = true
        
        //Offers and extras
        let extraIcon = UIButton()
        scrollView.addSubview(extraIcon)
        extraIcon.translatesAutoresizingMaskIntoConstraints = false
        let extrasImage = UIImage(named: "ic_ratings")
        let extraTint = extrasImage?.withRenderingMode(.alwaysTemplate)
        extraIcon.setImage(extraTint, for: .normal)
        extraIcon.tintColor = UIColor.white
        extraIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        extraIcon.topAnchor.constraint(equalTo: mobileIcon.bottomAnchor, constant: 20).isActive = true
        extraIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        extraIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        //My products and services
        let btnExtras = UIButton()
        scrollView.addSubview(btnExtras)
        btnExtras.translatesAutoresizingMaskIntoConstraints = false
        btnExtras.setTitle("Offers and Extras for you", for: .normal)
        btnExtras.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnExtras.setTitleColor(UIColor.white, for: .normal)
        btnExtras.leadingAnchor.constraint(equalTo: extraIcon.trailingAnchor, constant: 16).isActive = true
        btnExtras.topAnchor.constraint(equalTo: btnPdt.bottomAnchor, constant: 23).isActive = true
        
        //Top up
        let topUpIcon = UIButton()
        scrollView.addSubview(topUpIcon)
        topUpIcon.translatesAutoresizingMaskIntoConstraints = false
        let topUpImage = UIImage(named: "ic_top_up")
        let topUpTint = topUpImage?.withRenderingMode(.alwaysTemplate)
        topUpIcon.setImage(topUpTint, for: .normal)
        topUpIcon.tintColor = UIColor.white
        topUpIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        topUpIcon.topAnchor.constraint(equalTo: extraIcon.bottomAnchor, constant: 20).isActive = true
        topUpIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        topUpIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        //Top up
        let btnTopUp = UIButton()
        scrollView.addSubview(btnTopUp)
        btnTopUp.translatesAutoresizingMaskIntoConstraints = false
        btnTopUp.setTitle("Top up", for: .normal)
        btnTopUp.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnTopUp.setTitleColor(UIColor.white, for: .normal)
        btnTopUp.leadingAnchor.constraint(equalTo: topUpIcon.trailingAnchor, constant: 16).isActive = true
        btnTopUp.topAnchor.constraint(equalTo: btnExtras.bottomAnchor, constant: 25).isActive = true
        
        //Travelling abroad
        let travellingIcon = UIButton()
        scrollView.addSubview(travellingIcon)
        travellingIcon.translatesAutoresizingMaskIntoConstraints = false
        let travellingImage = UIImage(named: "ic_roaming")
        let travTint = travellingImage?.withRenderingMode(.alwaysTemplate)
        travellingIcon.setImage(travTint, for: .normal)
        travellingIcon.tintColor = UIColor.white
        travellingIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        travellingIcon.topAnchor.constraint(equalTo: topUpIcon.bottomAnchor, constant: 20).isActive = true
        travellingIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        travellingIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        //Travelling abroad
        let btnTravel = UIButton()
        scrollView.addSubview(btnTravel)
        btnTravel.translatesAutoresizingMaskIntoConstraints = false
        btnTravel.setTitle("Travelling abroad", for: .normal)
        btnTravel.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnTravel.setTitleColor(UIColor.white, for: .normal)
        btnTravel.leadingAnchor.constraint(equalTo: travellingIcon.trailingAnchor, constant: 16).isActive = true
        btnTravel.topAnchor.constraint(equalTo: btnTopUp.bottomAnchor, constant: 25).isActive = true
        
        //24/7
        let twoFourSevenIcon = UIButton()
        scrollView.addSubview(twoFourSevenIcon)
        twoFourSevenIcon.translatesAutoresizingMaskIntoConstraints = false
        let twoFourImage = UIImage(named: "ic_online_support")
        let twoFourTint = twoFourImage?.withRenderingMode(.alwaysTemplate)
        twoFourSevenIcon.setImage(twoFourTint, for: .normal)
        twoFourSevenIcon.tintColor = UIColor.white
        twoFourSevenIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        twoFourSevenIcon.topAnchor.constraint(equalTo: travellingIcon.bottomAnchor, constant: 20).isActive = true
        twoFourSevenIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        twoFourSevenIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        //24/7
        let btnTwoFour = UIButton()
        scrollView.addSubview(btnTwoFour)
        btnTwoFour.translatesAutoresizingMaskIntoConstraints = false
        btnTwoFour.setTitle("24/7 support", for: .normal)
        btnTwoFour.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnTwoFour.setTitleColor(UIColor.white, for: .normal)
        btnTwoFour.leadingAnchor.constraint(equalTo: twoFourSevenIcon.trailingAnchor, constant: 16).isActive = true
        btnTwoFour.topAnchor.constraint(equalTo: btnTravel.bottomAnchor, constant: 25).isActive = true
        
        //Store locator
        let locatorIcon = UIButton()
        scrollView.addSubview(locatorIcon)
        locatorIcon.translatesAutoresizingMaskIntoConstraints = false
        let locatorImage = UIImage(named: "ic_location_marker")
        let locatorTint = locatorImage?.withRenderingMode(.alwaysTemplate)
        locatorIcon.setImage(locatorTint, for: .normal)
        locatorIcon.tintColor = UIColor.white
        locatorIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        locatorIcon.topAnchor.constraint(equalTo: twoFourSevenIcon.bottomAnchor, constant: 20).isActive = true
        locatorIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        locatorIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        //Store Locator
        let btnLocator = UIButton()
        scrollView.addSubview(btnLocator)
        btnLocator.translatesAutoresizingMaskIntoConstraints = false
        btnLocator.setTitle("Store Locator", for: .normal)
        btnLocator.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnLocator.setTitleColor(UIColor.white, for: .normal)
        btnLocator.leadingAnchor.constraint(equalTo: twoFourSevenIcon.trailingAnchor, constant: 16).isActive = true
        btnLocator.topAnchor.constraint(equalTo: btnTwoFour.bottomAnchor, constant: 24).isActive = true
        
        //Network
        let networkIcon = UIButton()
        scrollView.addSubview(networkIcon)
        networkIcon.translatesAutoresizingMaskIntoConstraints = false
        let networkImage = UIImage(named: "ic_network")
        let networkTint = networkImage?.withRenderingMode(.alwaysTemplate)
        networkIcon.setImage(networkTint, for: .normal)
        networkIcon.tintColor = UIColor.white
        networkIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        networkIcon.topAnchor.constraint(equalTo: locatorIcon.bottomAnchor, constant: 20).isActive = true
        networkIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        networkIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        //Network
        let btnNetwork = UIButton()
        scrollView.addSubview(btnNetwork)
        btnNetwork.translatesAutoresizingMaskIntoConstraints = false
        btnNetwork.setTitle("Network", for: .normal)
        btnNetwork.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnNetwork.setTitleColor(UIColor.white, for: .normal)
        btnNetwork.leadingAnchor.constraint(equalTo: networkIcon.trailingAnchor, constant: 16).isActive = true
        btnNetwork.topAnchor.constraint(equalTo: btnLocator.bottomAnchor, constant: 24).isActive = true
        //Arrow down
        let chevron = UIButton()
        scrollView.addSubview(chevron)
        chevron.translatesAutoresizingMaskIntoConstraints = false
        let chevImage = UIImage(named: "dropdown")
        let chevTint = chevImage?.withRenderingMode(.alwaysTemplate)
        chevron.setImage(chevTint, for: .normal)
        chevron.tintColor = UIColor.white
        chevron.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -20).isActive = true
        chevron.topAnchor.constraint(equalTo: btnLocator.bottomAnchor, constant: 28).isActive = true
        chevron.widthAnchor.constraint(equalToConstant: 25).isActive = true
        chevron.heightAnchor.constraint(equalToConstant: 15).isActive = true
        chevron.addTarget(self, action: #selector(dropDown), for: .touchUpInside)
        
        //btn speed checker
        let btnSpeedChecker = UIButton()
        scrollView.addSubview(btnSpeedChecker)
        btnSpeedChecker.translatesAutoresizingMaskIntoConstraints = false
        btnSpeedChecker.leadingAnchor.constraint(equalTo: locatorIcon.trailingAnchor, constant: 16).isActive = true
        btnSpeedChecker.topAnchor.constraint(equalTo: btnNetwork.bottomAnchor, constant: 13).isActive = true
        btnSpeedChecker.setTitle("Speed Checker", for: .normal)
        btnSpeedChecker.titleLabel?.font = UIFont(name: String.defaultFontR, size: 19)
        btnSpeedChecker.setTitleColor(UIColor.gray, for: .normal)
        btnSpeedChecker.isHidden = true
        
        //btn network usage
        let btnNetworkUsage = UIButton()
        scrollView.addSubview(btnNetworkUsage)
        btnNetworkUsage.translatesAutoresizingMaskIntoConstraints = false
        btnNetworkUsage.leadingAnchor.constraint(equalTo: locatorIcon.trailingAnchor, constant: 16).isActive = true
        btnNetworkUsage.topAnchor.constraint(equalTo: btnSpeedChecker.bottomAnchor, constant: 13).isActive = true
        btnNetworkUsage.setTitle("Network Usage", for: .normal)
        btnNetworkUsage.titleLabel?.font = UIFont(name: String.defaultFontR, size: 19)
        btnNetworkUsage.setTitleColor(UIColor.gray, for: .normal)
        btnNetworkUsage.isHidden = true
        
        //btn Broadband finder
        let btnBBFinder = UIButton()
        scrollView.addSubview(btnBBFinder)
        btnBBFinder.translatesAutoresizingMaskIntoConstraints = false
        btnBBFinder.leadingAnchor.constraint(equalTo: locatorIcon.trailingAnchor, constant: 16).isActive = true
        btnBBFinder.topAnchor.constraint(equalTo: btnNetworkUsage.bottomAnchor, constant: 13).isActive = true
        btnBBFinder.setTitle("Broadband Finder", for: .normal)
        btnBBFinder.titleLabel?.font = UIFont(name: String.defaultFontR, size: 19)
        btnBBFinder.setTitleColor(UIColor.gray, for: .normal)
        btnBBFinder.isHidden = true
        
        //btn Network Coverage
        let btnNetworkCov = UIButton()
        scrollView.addSubview(btnNetworkCov)
        btnNetworkCov.translatesAutoresizingMaskIntoConstraints = false
        btnNetworkCov.leadingAnchor.constraint(equalTo: locatorIcon.trailingAnchor, constant: 16).isActive = true
        btnNetworkCov.topAnchor.constraint(equalTo: btnBBFinder.bottomAnchor, constant: 13).isActive = true
        btnNetworkCov.setTitle("Network Coverage", for: .normal)
        btnNetworkCov.titleLabel?.font = UIFont(name: String.defaultFontR, size: 19)
        btnNetworkCov.setTitleColor(UIColor.gray, for: .normal)
        btnNetworkCov.isHidden = true
        
        //Messages
        let mssgIcon = UIButton()
        scrollView.addSubview(mssgIcon)
        mssgIcon.translatesAutoresizingMaskIntoConstraints = false
        let mssgImage = UIImage(named: "ic_mail")
        let mssTint = mssgImage?.withRenderingMode(.alwaysTemplate)
        mssgIcon.setImage(mssTint, for: .normal)
        mssgIcon.tintColor = UIColor.white
        mssgIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        mssgIconTop1 = mssgIcon.topAnchor.constraint(equalTo: networkIcon.bottomAnchor, constant: 20)
        mssgIconTop2 = mssgIcon.topAnchor.constraint(equalTo: networkIcon.bottomAnchor, constant: 90)
        mssgIconTop1?.isActive = true
        mssgIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        mssgIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        let btnMessage = UIButton()
        scrollView.addSubview(btnMessage)
        btnMessage.translatesAutoresizingMaskIntoConstraints = false
        btnMessage.setTitle("My Messages", for: .normal)
        btnMessage.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnMessage.setTitleColor(UIColor.white, for: .normal)
        btnMessage.leadingAnchor.constraint(equalTo: mssgIcon.trailingAnchor, constant: 16).isActive = true
        mssgTopConstraint1 = btnMessage.topAnchor.constraint(equalTo: btnNetwork.bottomAnchor, constant: 24)
        mssgTopConstraint2 = btnMessage.topAnchor.constraint(equalTo: btnNetwork.bottomAnchor, constant: 94)
        mssgTopConstraint1?.isActive = true
        
        //Profile
        let profileIcon = UIButton()
        scrollView.addSubview(profileIcon)
        profileIcon.translatesAutoresizingMaskIntoConstraints = false
        let profileImage = UIImage(named: "ic_profile")
        let profileTint = profileImage?.withRenderingMode(.alwaysTemplate)
        profileIcon.setImage(profileTint, for: .normal)
        profileIcon.tintColor = UIColor.white
        profileIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        profileIcon.topAnchor.constraint(equalTo: mssgIcon.bottomAnchor, constant: 20).isActive = true
        profileIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        profileIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        //Top up
        let btnProfile = UIButton()
        scrollView.addSubview(btnProfile)
        btnProfile.translatesAutoresizingMaskIntoConstraints = false
        btnProfile.setTitle("My profile", for: .normal)
        btnProfile.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnProfile.setTitleColor(UIColor.white, for: .normal)
        btnProfile.leadingAnchor.constraint(equalTo: profileIcon.trailingAnchor, constant: 16).isActive = true
        btnProfile.topAnchor.constraint(equalTo: btnMessage.bottomAnchor, constant: 25).isActive = true
        
        //Settings
        let settingsIcon = UIButton()
        scrollView.addSubview(settingsIcon)
        settingsIcon.translatesAutoresizingMaskIntoConstraints = false
        let settingsImage = UIImage(named: "ic_settings")
        let settingsTint = settingsImage?.withRenderingMode(.alwaysTemplate)
        settingsIcon.setImage(settingsTint, for: .normal)
        settingsIcon.tintColor = UIColor.white
        settingsIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        settingsIcon.topAnchor.constraint(equalTo: profileIcon.bottomAnchor, constant: 20).isActive = true
        settingsIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        settingsIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        //Settings
        let btnSettings = UIButton()
        scrollView.addSubview(btnSettings)
        btnSettings.translatesAutoresizingMaskIntoConstraints = false
        btnSettings.setTitle("Settings", for: .normal)
        btnSettings.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnSettings.setTitleColor(UIColor.white, for: .normal)
        btnSettings.leadingAnchor.constraint(equalTo: settingsIcon.trailingAnchor, constant: 16).isActive = true
        btnSettings.topAnchor.constraint(equalTo: btnProfile.bottomAnchor, constant: 25).isActive = true
        
        //About
        let aboutIcon = UIButton()
        scrollView.addSubview(aboutIcon)
        aboutIcon.translatesAutoresizingMaskIntoConstraints = false
        let aboutImage = UIImage(named: "ic_info")
        let aboutTint = aboutImage?.withRenderingMode(.alwaysTemplate)
        aboutIcon.setImage(aboutTint, for: .normal)
        aboutIcon.tintColor = UIColor.white
        aboutIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        aboutIcon.topAnchor.constraint(equalTo: settingsIcon.bottomAnchor, constant: 20).isActive = true
        aboutIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        aboutIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        //About
        let btnAbout = UIButton()
        scrollView.addSubview(btnAbout)
        btnAbout.translatesAutoresizingMaskIntoConstraints = false
        btnAbout.setTitle("About", for: .normal)
        btnAbout.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnAbout.setTitleColor(UIColor.white, for: .normal)
        btnAbout.leadingAnchor.constraint(equalTo: aboutIcon.trailingAnchor, constant: 16).isActive = true
        btnAbout.topAnchor.constraint(equalTo: btnSettings.bottomAnchor, constant: 25).isActive = true
        
        //Logout
        let logoutIcon = UIButton()
        scrollView.addSubview(logoutIcon)
        logoutIcon.translatesAutoresizingMaskIntoConstraints = false
        let logoutImage = UIImage(named: "ic_log_out")
        let logoutint = logoutImage?.withRenderingMode(.alwaysTemplate)
        logoutIcon.setImage(logoutint, for: .normal)
        logoutIcon.tintColor = UIColor.white
        logoutIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        logoutIcon.topAnchor.constraint(equalTo: aboutIcon.bottomAnchor, constant: 20).isActive = true
        logoutIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        logoutIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        //Logout
        let btnLogout = UIButton()
        scrollView.addSubview(btnLogout)
        btnLogout.translatesAutoresizingMaskIntoConstraints = false
        btnLogout.setTitle("Logout", for: .normal)
        btnLogout.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnLogout.setTitleColor(UIColor.white, for: .normal)
        btnLogout.leadingAnchor.constraint(equalTo: logoutIcon.trailingAnchor, constant: 16).isActive = true
        btnLogout.topAnchor.constraint(equalTo: btnAbout.bottomAnchor, constant: 25).isActive = true
    }
    
    func toast(toast_img: UIImageView, toast_message: String){
        let messageUIView = UIView()
        let warningMessage = UILabel()
        messageUIView.alpha = 0
        warningMessage.alpha = 0
        toast_img.alpha = 0
        
        UIView.animate(withDuration: 2, animations: {
            //View to hold message
            
            self.view.addSubview(messageUIView)
            messageUIView.alpha = 0.85
            messageUIView.translatesAutoresizingMaskIntoConstraints = false
            messageUIView.backgroundColor = UIColor.black
            messageUIView.isOpaque = false
            messageUIView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
            messageUIView.bottomAnchor.constraint(equalTo: self.view.safeBottomAnchor, constant: 0).isActive = true
            messageUIView.heightAnchor.constraint(equalToConstant: 110).isActive = true
            
            // warning icon
            
            self.view.addSubview(toast_img)
            toast_img.translatesAutoresizingMaskIntoConstraints = false
            toast_img.leadingAnchor.constraint(equalTo: messageUIView.leadingAnchor, constant: 30).isActive = true
            toast_img.widthAnchor.constraint(equalToConstant: 20).isActive = true
            toast_img.heightAnchor.constraint(equalToConstant: 20).isActive = true
            toast_img.topAnchor.constraint(equalTo: messageUIView.topAnchor, constant: 40).isActive = true
            toast_img.alpha = 1
            
            //warning message
            
            self.view.addSubview(warningMessage)
            warningMessage.translatesAutoresizingMaskIntoConstraints = false
            warningMessage.textColor = UIColor.white
            warningMessage.font = UIFont(name: String.defaultFontR, size: 17)
            warningMessage.text = toast_message
            warningMessage.leadingAnchor.constraint(equalTo: toast_img.trailingAnchor, constant: 20).isActive = true
            warningMessage.trailingAnchor.constraint(equalTo: messageUIView.trailingAnchor, constant: -10).isActive = true
            warningMessage.topAnchor.constraint(equalTo: messageUIView.topAnchor, constant: 40).isActive = true
            warningMessage.numberOfLines = 0
            warningMessage.lineBreakMode = .byWordWrapping
            warningMessage.alpha = 1
        }, completion: { (true) in
            UIView.animate(withDuration: 3, delay: 3, animations: {
                messageUIView.alpha = 0
                warningMessage.alpha = 0
                toast_img.alpha = 0
            }, completion: nil)
        })
    }
    
    @objc func dropDown(){
        
    }
    
    func checkConnection(){
        if !CheckInternet.Connection(){
            toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "You're offline")
            print("You dont have internet")
        }else{
            print("You have internet")
        }
    }
}

