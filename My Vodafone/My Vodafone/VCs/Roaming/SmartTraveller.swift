//
//  SmartTraveller.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 20/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class SmartTraveller: baseViewControllerM {

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
    
    let faultReportCard = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground
        setUpViewSmart()
        if AcctType == "PHONE_MOBILE_PRE_P" || AcctType == "BB_FIXED_PRE_P"{
            prePaidMenu()
        }else if AcctType == "PHONE_MOBILE_POST_P" {
            postPaidMenu()
        }
        else{
            prePaidMenu()
        }
    }
    
    func setUpViewSmart(){
        view.addSubview(scrollView)
        
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
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
        lblSelectedOffer.text = "Travelling abroad"
        lblSelectedOffer.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        lblSelectedOffer.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 70).isActive = true
        lblSelectedOffer.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        lblSelectedOffer.numberOfLines = 0
        lblSelectedOffer.lineBreakMode = .byWordWrapping
        
        // Roaming Header
        let lblRInfo = UILabel()
        scrollView.addSubview(lblRInfo)
        lblRInfo.translatesAutoresizingMaskIntoConstraints = false
        lblRInfo.text = "Roaming Information"
        lblRInfo.textColor = UIColor.support_voilet
        lblRInfo.textAlignment = .center
        lblRInfo.font = UIFont(name: String.defaultFontR, size: 33)
        lblRInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        lblRInfo.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 20).isActive = true
        lblRInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        lblRInfo.numberOfLines = 0
        lblRInfo.lineBreakMode = .byWordWrapping
        
        //Roaming Bundles
        let roamingBundlesCard = UIView()
        scrollView.addSubview(roamingBundlesCard)
        roamingBundlesCard.translatesAutoresizingMaskIntoConstraints = false
        roamingBundlesCard.backgroundColor = UIColor.white
        roamingBundlesCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
        roamingBundlesCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        roamingBundlesCard.topAnchor.constraint(equalTo: lblRInfo.bottomAnchor, constant: 20).isActive = true
        roamingBundlesCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        roamingBundlesCard.layer.cornerRadius = 2
        roamingBundlesCard.layer.shadowOffset = CGSize(width: 0, height: 5)
        roamingBundlesCard.layer.shadowColor = UIColor.black.cgColor
        roamingBundlesCard.layer.shadowOpacity = 0.2
        
        let roamingCardRec = UITapGestureRecognizer(target: self, action: #selector(gotToRoamingBundles(_sender:)))
        roamingBundlesCard.addGestureRecognizer(roamingCardRec)
        
        let roamingRLeft = UIImageView()
        roamingBundlesCard.addSubview(roamingRLeft)
        roamingRLeft.translatesAutoresizingMaskIntoConstraints = false
        roamingRLeft.backgroundColor = UIColor.cardImageColour
        roamingRLeft.leadingAnchor.constraint(equalTo: roamingBundlesCard.leadingAnchor).isActive = true
        roamingRLeft.topAnchor.constraint(equalTo: roamingBundlesCard.topAnchor).isActive = true
        roamingRLeft.widthAnchor.constraint(equalToConstant: 12).isActive = true
        roamingRLeft.bottomAnchor.constraint(equalTo: roamingBundlesCard.bottomAnchor).isActive = true
        
        let roamingBLabel = UILabel()
        roamingBundlesCard.addSubview(roamingBLabel)
        roamingBLabel.translatesAutoresizingMaskIntoConstraints = false
        roamingBLabel.text = "Roaming Bundles"
        roamingBLabel.textColor = UIColor.black
        roamingBLabel.font = UIFont(name: String.defaultFontR, size: 26)
        roamingBLabel.leadingAnchor.constraint(equalTo: roamingRLeft.trailingAnchor, constant: 10).isActive = true
        roamingBLabel.topAnchor.constraint(equalTo: roamingBundlesCard.topAnchor, constant: 30).isActive = true
        roamingBLabel.trailingAnchor.constraint(equalTo: roamingBundlesCard.trailingAnchor, constant: -5).isActive = true
        roamingBLabel.numberOfLines = 0
        roamingBLabel.lineBreakMode = .byWordWrapping
        
        let roamingBDesc = UILabel()
        roamingBundlesCard.addSubview(roamingBDesc)
        roamingBDesc.translatesAutoresizingMaskIntoConstraints = false
        roamingBDesc.text = "Roaming packages & bundles"
        roamingBDesc.textColor = UIColor.black
        roamingBDesc.font = UIFont(name: String.defaultFontR, size: 15)
        roamingBDesc.leadingAnchor.constraint(equalTo: roamingRLeft.trailingAnchor, constant: 10).isActive = true
        roamingBDesc.topAnchor.constraint(equalTo: roamingBLabel.bottomAnchor, constant: 10).isActive = true
        roamingBDesc.trailingAnchor.constraint(equalTo: roamingBundlesCard.trailingAnchor, constant: -5).isActive = true
        roamingBDesc.numberOfLines = 0
        roamingBDesc.lineBreakMode = .byWordWrapping
        
        //Roaming Tips
        let roamingTipsCard = UIView()
        scrollView.addSubview(roamingTipsCard)
        roamingTipsCard.translatesAutoresizingMaskIntoConstraints = false
        roamingTipsCard.backgroundColor = UIColor.white
        roamingTipsCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
        roamingTipsCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        roamingTipsCard.topAnchor.constraint(equalTo: roamingBundlesCard.bottomAnchor, constant: 20).isActive = true
        roamingTipsCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        roamingTipsCard.layer.cornerRadius = 2
        roamingTipsCard.layer.shadowOffset = CGSize(width: 0, height: 5)
        roamingTipsCard.layer.shadowColor = UIColor.black.cgColor
        roamingTipsCard.layer.shadowOpacity = 0.2
        
        let roamingTipsCardRec = UITapGestureRecognizer(target: self, action: #selector(gotToRoamingTips(_sender:)))
        roamingTipsCard.addGestureRecognizer(roamingTipsCardRec)
        
        let roamingTLeft = UIImageView()
        roamingTipsCard.addSubview(roamingTLeft)
        roamingTLeft.translatesAutoresizingMaskIntoConstraints = false
        roamingTLeft.backgroundColor = UIColor.cardImageColour
        roamingTLeft.leadingAnchor.constraint(equalTo: roamingTipsCard.leadingAnchor).isActive = true
        roamingTLeft.topAnchor.constraint(equalTo: roamingTipsCard.topAnchor).isActive = true
        roamingTLeft.widthAnchor.constraint(equalToConstant: 12).isActive = true
        roamingTLeft.bottomAnchor.constraint(equalTo: roamingTipsCard.bottomAnchor).isActive = true
        
        let roamingTLabel = UILabel()
        roamingTipsCard.addSubview(roamingTLabel)
        roamingTLabel.translatesAutoresizingMaskIntoConstraints = false
        roamingTLabel.text = "Roaming Tips"
        roamingTLabel.textColor = UIColor.black
        roamingTLabel.font = UIFont(name: String.defaultFontR, size: 26)
        roamingTLabel.leadingAnchor.constraint(equalTo: roamingTLeft.trailingAnchor, constant: 10).isActive = true
        roamingTLabel.topAnchor.constraint(equalTo: roamingTipsCard.topAnchor, constant: 30).isActive = true
        roamingTLabel.trailingAnchor.constraint(equalTo: roamingTipsCard.trailingAnchor, constant: -5).isActive = true
        roamingTLabel.numberOfLines = 0
        roamingTLabel.lineBreakMode = .byWordWrapping
        
        let roamingTDesc = UILabel()
        roamingTipsCard.addSubview(roamingTDesc)
        roamingTDesc.translatesAutoresizingMaskIntoConstraints = false
        roamingTDesc.text = "Tips on using your phone abroad"
        roamingTDesc.textColor = UIColor.black
        roamingTDesc.font = UIFont(name: String.defaultFontR, size: 15)
        roamingTDesc.leadingAnchor.constraint(equalTo: roamingRLeft.trailingAnchor, constant: 10).isActive = true
        roamingTDesc.topAnchor.constraint(equalTo: roamingTLabel.bottomAnchor, constant: 10).isActive = true
        roamingTDesc.trailingAnchor.constraint(equalTo: roamingTipsCard.trailingAnchor, constant: -5).isActive = true
        roamingTDesc.numberOfLines = 0
        roamingTDesc.lineBreakMode = .byWordWrapping
        
        //Report Fault
        
        scrollView.addSubview(faultReportCard)
        faultReportCard.translatesAutoresizingMaskIntoConstraints = false
        faultReportCard.backgroundColor = UIColor.white
        faultReportCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
        faultReportCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        faultReportCard.topAnchor.constraint(equalTo: roamingTipsCard.bottomAnchor, constant: 20).isActive = true
        faultReportCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        faultReportCard.layer.cornerRadius = 2
        faultReportCard.layer.shadowOffset = CGSize(width: 0, height: 5)
        faultReportCard.layer.shadowColor = UIColor.black.cgColor
        faultReportCard.layer.shadowOpacity = 0.2
        
        let faultReportCardRec = UITapGestureRecognizer(target: self, action: #selector(gotToFaultReporting(_sender:)))
        faultReportCard.addGestureRecognizer(faultReportCardRec)
        
        let faultLeft = UIImageView()
        faultReportCard.addSubview(faultLeft)
        faultLeft.translatesAutoresizingMaskIntoConstraints = false
        faultLeft.backgroundColor = UIColor.cardImageColour
        faultLeft.leadingAnchor.constraint(equalTo: faultReportCard.leadingAnchor).isActive = true
        faultLeft.topAnchor.constraint(equalTo: faultReportCard.topAnchor).isActive = true
        faultLeft.widthAnchor.constraint(equalToConstant: 12).isActive = true
        faultLeft.bottomAnchor.constraint(equalTo: faultReportCard.bottomAnchor).isActive = true
        
        let faultLabel = UILabel()
        faultReportCard.addSubview(faultLabel)
        faultLabel.translatesAutoresizingMaskIntoConstraints = false
        faultLabel.text = "Report a fault"
        faultLabel.textColor = UIColor.black
        faultLabel.font = UIFont(name: String.defaultFontR, size: 26)
        faultLabel.leadingAnchor.constraint(equalTo: faultLeft.trailingAnchor, constant: 10).isActive = true
        faultLabel.topAnchor.constraint(equalTo: faultReportCard.topAnchor, constant: 30).isActive = true
        faultLabel.trailingAnchor.constraint(equalTo: faultReportCard.trailingAnchor, constant: -5).isActive = true
        faultLabel.numberOfLines = 0
        faultLabel.lineBreakMode = .byWordWrapping
        
        let faultDesc = UILabel()
        faultReportCard.addSubview(faultDesc)
        faultDesc.translatesAutoresizingMaskIntoConstraints = false
        faultDesc.text = "Report fault and make requests"
        faultDesc.textColor = UIColor.black
        faultDesc.font = UIFont(name: String.defaultFontR, size: 15)
        faultDesc.leadingAnchor.constraint(equalTo: faultLeft.trailingAnchor, constant: 10).isActive = true
        faultDesc.topAnchor.constraint(equalTo: faultLabel.bottomAnchor, constant: 10).isActive = true
        faultDesc.trailingAnchor.constraint(equalTo: faultReportCard.trailingAnchor, constant: -5).isActive = true
        faultDesc.numberOfLines = 0
        faultDesc.lineBreakMode = .byWordWrapping
        
        if AcctType == "PHONE_MOBILE_POST_P" {
            // Roaming Header
            let lblRInfo = UILabel()
            scrollView.addSubview(lblRInfo)
            lblRInfo.translatesAutoresizingMaskIntoConstraints = false
            lblRInfo.text = "Roaming Requests"
            lblRInfo.textColor = UIColor.support_voilet
            lblRInfo.textAlignment = .center
            lblRInfo.font = UIFont(name: String.defaultFontR, size: 33)
            lblRInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
            lblRInfo.topAnchor.constraint(equalTo: faultReportCard.bottomAnchor, constant: 40).isActive = true
            lblRInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
            lblRInfo.numberOfLines = 0
            lblRInfo.lineBreakMode = .byWordWrapping
            
            //Roaming Request
            let requestRoamingCard = UIView()
            scrollView.addSubview(requestRoamingCard)
            requestRoamingCard.translatesAutoresizingMaskIntoConstraints = false
            requestRoamingCard.backgroundColor = UIColor.white
            requestRoamingCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
            requestRoamingCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            requestRoamingCard.topAnchor.constraint(equalTo: lblRInfo.bottomAnchor, constant: 20).isActive = true
            requestRoamingCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            requestRoamingCard.layer.cornerRadius = 2
            requestRoamingCard.layer.shadowOffset = CGSize(width: 0, height: 5)
            requestRoamingCard.layer.shadowColor = UIColor.black.cgColor
            requestRoamingCard.layer.shadowOpacity = 0.2
            
            let requestRoamingRec = UITapGestureRecognizer(target: self, action: #selector(gotToRequestRoaming(_sender:)))
            requestRoamingCard.addGestureRecognizer(requestRoamingRec)
            
            let requestRoamingLeft = UIImageView()
            requestRoamingCard.addSubview(requestRoamingLeft)
            requestRoamingLeft.translatesAutoresizingMaskIntoConstraints = false
            requestRoamingLeft.backgroundColor = UIColor.cardImageColour
            requestRoamingLeft.leadingAnchor.constraint(equalTo: requestRoamingCard.leadingAnchor).isActive = true
            requestRoamingLeft.topAnchor.constraint(equalTo: requestRoamingCard.topAnchor).isActive = true
            requestRoamingLeft.widthAnchor.constraint(equalToConstant: 12).isActive = true
            requestRoamingLeft.bottomAnchor.constraint(equalTo: requestRoamingCard.bottomAnchor).isActive = true
            
            let requestRoamingLabel = UILabel()
            requestRoamingCard.addSubview(requestRoamingLabel)
            requestRoamingLabel.translatesAutoresizingMaskIntoConstraints = false
            requestRoamingLabel.text = "Request Roaming"
            requestRoamingLabel.textColor = UIColor.black
            requestRoamingLabel.font = UIFont(name: String.defaultFontR, size: 26)
            requestRoamingLabel.leadingAnchor.constraint(equalTo: requestRoamingLeft.trailingAnchor, constant: 10).isActive = true
            requestRoamingLabel.topAnchor.constraint(equalTo: requestRoamingCard.topAnchor, constant: 30).isActive = true
            requestRoamingLabel.trailingAnchor.constraint(equalTo: requestRoamingCard.trailingAnchor, constant: -5).isActive = true
            requestRoamingLabel.numberOfLines = 0
            requestRoamingLabel.lineBreakMode = .byWordWrapping
            
            let requestRoamingDesc = UILabel()
            requestRoamingCard.addSubview(requestRoamingDesc)
            requestRoamingDesc.translatesAutoresizingMaskIntoConstraints = false
            requestRoamingDesc.text = "Request for roaming activation"
            requestRoamingDesc.textColor = UIColor.black
            requestRoamingDesc.font = UIFont(name: String.defaultFontR, size: 15)
            requestRoamingDesc.leadingAnchor.constraint(equalTo: requestRoamingLeft.trailingAnchor, constant: 10).isActive = true
            requestRoamingDesc.topAnchor.constraint(equalTo: requestRoamingLabel.bottomAnchor, constant: 10).isActive = true
            requestRoamingDesc.trailingAnchor.constraint(equalTo: requestRoamingCard.trailingAnchor, constant: -5).isActive = true
            requestRoamingDesc.numberOfLines = 0
            requestRoamingDesc.lineBreakMode = .byWordWrapping
            
            //Set consumption limit
            let consumptionCard = UIView()
            scrollView.addSubview(consumptionCard)
            consumptionCard.translatesAutoresizingMaskIntoConstraints = false
            consumptionCard.backgroundColor = UIColor.white
            consumptionCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
            consumptionCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            consumptionCard.topAnchor.constraint(equalTo: requestRoamingCard.bottomAnchor, constant: 20).isActive = true
            consumptionCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            consumptionCard.layer.cornerRadius = 2
            consumptionCard.layer.shadowOffset = CGSize(width: 0, height: 5)
            consumptionCard.layer.shadowColor = UIColor.black.cgColor
            consumptionCard.layer.shadowOpacity = 0.2
            
            let consumptionRec = UITapGestureRecognizer(target: self, action: #selector(gotToSetConsumption(_sender:)))
            consumptionCard.addGestureRecognizer(consumptionRec)
            
            let consumptionLeft = UIImageView()
            consumptionCard.addSubview(consumptionLeft)
            consumptionLeft.translatesAutoresizingMaskIntoConstraints = false
            consumptionLeft.backgroundColor = UIColor.cardImageColour
            consumptionLeft.leadingAnchor.constraint(equalTo: consumptionCard.leadingAnchor).isActive = true
            consumptionLeft.topAnchor.constraint(equalTo: consumptionCard.topAnchor).isActive = true
            consumptionLeft.widthAnchor.constraint(equalToConstant: 12).isActive = true
            consumptionLeft.bottomAnchor.constraint(equalTo: consumptionCard.bottomAnchor).isActive = true
            
            let consumptionLabel = UILabel()
            consumptionCard.addSubview(consumptionLabel)
            consumptionLabel.translatesAutoresizingMaskIntoConstraints = false
            consumptionLabel.text = "Set Consumption Limit"
            consumptionLabel.textColor = UIColor.black
            consumptionLabel.font = UIFont(name: String.defaultFontR, size: 26)
            consumptionLabel.leadingAnchor.constraint(equalTo: consumptionLeft.trailingAnchor, constant: 10).isActive = true
            consumptionLabel.topAnchor.constraint(equalTo: consumptionCard.topAnchor, constant: 30).isActive = true
            consumptionLabel.trailingAnchor.constraint(equalTo: consumptionCard.trailingAnchor, constant: -5).isActive = true
            consumptionLabel.numberOfLines = 0
            consumptionLabel.lineBreakMode = .byWordWrapping
            
            let consumptionDesc = UILabel()
            consumptionCard.addSubview(consumptionDesc)
            consumptionDesc.translatesAutoresizingMaskIntoConstraints = false
            consumptionDesc.text = "Send a request to adjust your consumption limit"
            consumptionDesc.textColor = UIColor.black
            consumptionDesc.font = UIFont(name: String.defaultFontR, size: 15)
            consumptionDesc.leadingAnchor.constraint(equalTo: consumptionLeft.trailingAnchor, constant: 10).isActive = true
            consumptionDesc.topAnchor.constraint(equalTo: consumptionLabel.bottomAnchor, constant: 10).isActive = true
            consumptionDesc.trailingAnchor.constraint(equalTo: consumptionCard.trailingAnchor, constant: -5).isActive = true
            consumptionDesc.numberOfLines = 0
            consumptionDesc.lineBreakMode = .byWordWrapping
            
            //Enable Disable Roaming
            let enableDisableCard = UIView()
            scrollView.addSubview(enableDisableCard)
            enableDisableCard.translatesAutoresizingMaskIntoConstraints = false
            enableDisableCard.backgroundColor = UIColor.white
            enableDisableCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
            enableDisableCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            enableDisableCard.topAnchor.constraint(equalTo: consumptionCard.bottomAnchor, constant: 20).isActive = true
            enableDisableCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            enableDisableCard.layer.cornerRadius = 2
            enableDisableCard.layer.shadowOffset = CGSize(width: 0, height: 5)
            enableDisableCard.layer.shadowColor = UIColor.black.cgColor
            enableDisableCard.layer.shadowOpacity = 0.2
            
            let enableDisableCardRec = UITapGestureRecognizer(target: self, action: #selector(gotToEnableDisable(_sender:)))
            enableDisableCard.addGestureRecognizer(enableDisableCardRec)
            
            let enableDisableLeft = UIImageView()
            enableDisableCard.addSubview(enableDisableLeft)
            enableDisableLeft.translatesAutoresizingMaskIntoConstraints = false
            enableDisableLeft.backgroundColor = UIColor.cardImageColour
            enableDisableLeft.leadingAnchor.constraint(equalTo: enableDisableCard.leadingAnchor).isActive = true
            enableDisableLeft.topAnchor.constraint(equalTo: enableDisableCard.topAnchor).isActive = true
            enableDisableLeft.widthAnchor.constraint(equalToConstant: 12).isActive = true
            enableDisableLeft.bottomAnchor.constraint(equalTo: enableDisableCard.bottomAnchor).isActive = true
            
            let enableDisableLabel = UILabel()
            enableDisableCard.addSubview(enableDisableLabel)
            enableDisableLabel.translatesAutoresizingMaskIntoConstraints = false
            enableDisableLabel.text = "Enable or Disable Roaming"
            enableDisableLabel.textColor = UIColor.black
            enableDisableLabel.font = UIFont(name: String.defaultFontR, size: 26)
            enableDisableLabel.leadingAnchor.constraint(equalTo: enableDisableLeft.trailingAnchor, constant: 10).isActive = true
            enableDisableLabel.topAnchor.constraint(equalTo: enableDisableCard.topAnchor, constant: 30).isActive = true
            enableDisableLabel.trailingAnchor.constraint(equalTo: enableDisableCard.trailingAnchor, constant: -5).isActive = true
            enableDisableLabel.numberOfLines = 0
            enableDisableLabel.lineBreakMode = .byWordWrapping
            
            let enableDisableDesc = UILabel()
            enableDisableCard.addSubview(enableDisableDesc)
            enableDisableDesc.translatesAutoresizingMaskIntoConstraints = false
            enableDisableDesc.text = "Send a request to enable or disable roaming"
            enableDisableDesc.textColor = UIColor.black
            enableDisableDesc.font = UIFont(name: String.defaultFontR, size: 15)
            enableDisableDesc.leadingAnchor.constraint(equalTo: enableDisableLeft.trailingAnchor, constant: 10).isActive = true
            enableDisableDesc.topAnchor.constraint(equalTo: enableDisableLabel.bottomAnchor, constant: 10).isActive = true
            enableDisableDesc.trailingAnchor.constraint(equalTo: enableDisableCard.trailingAnchor, constant: -5).isActive = true
            enableDisableDesc.numberOfLines = 0
            enableDisableDesc.lineBreakMode = .byWordWrapping
            
            scrollView.contentSize.height = 680 + 550
        }else{
            scrollView.contentSize.height = 680
        }
        
        
        
        
    }
    
    @objc func gotToRoamingBundles(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Roaming", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "RoamingBundles")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func gotToRequestRoaming(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Roaming", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "requestRoaming")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func gotToEnableDisable(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Roaming", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "disableEnableRoaming")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func gotToRoamingTips(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Roaming", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "RoamingTips")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func gotToFaultReporting(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Roaming", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "RoamingFaultReporting")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func gotToSetConsumption(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "PostPaid", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "SetConsumptionLimit")
        present(moveTo, animated: true, completion: nil)
    }
    
    
    
    
    
    

}
