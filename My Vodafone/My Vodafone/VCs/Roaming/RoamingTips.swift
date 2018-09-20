//
//  RoamingTips.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 20/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class RoamingTips: baseViewControllerM {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground
        setUpViewSmart()
        if AcctType == "PHONE_MOBILE_PRE_P" {
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
        backButton.addTarget(self, action: #selector(goToTravelling), for: .touchUpInside)
        
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
        lblSelectedOffer.text = "Roaming Tips"
        lblSelectedOffer.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        lblSelectedOffer.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 70).isActive = true
        lblSelectedOffer.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        lblSelectedOffer.numberOfLines = 0
        lblSelectedOffer.lineBreakMode = .byWordWrapping
        
        //Roaming Bundles
        let roamingBundlesCard = UIView()
        scrollView.addSubview(roamingBundlesCard)
        roamingBundlesCard.translatesAutoresizingMaskIntoConstraints = false
        roamingBundlesCard.backgroundColor = UIColor.white
        roamingBundlesCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
        roamingBundlesCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        roamingBundlesCard.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 20).isActive = true
        roamingBundlesCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        roamingBundlesCard.layer.cornerRadius = 2
        roamingBundlesCard.layer.shadowOffset = CGSize(width: 0, height: 5)
        roamingBundlesCard.layer.shadowColor = UIColor.black.cgColor
        roamingBundlesCard.layer.shadowOpacity = 0.2
        
        let roamingCardRec = UITapGestureRecognizer(target: self, action: #selector(gotToRoamingPartners(_sender:)))
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
        roamingBLabel.text = "Roaming Partners"
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
        roamingBDesc.text = "Roaming partners info"
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
        roamingTLabel.text = "Rates & Discounts"
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
        roamingTDesc.text = "Rates for supported countries"
        roamingTDesc.textColor = UIColor.black
        roamingTDesc.font = UIFont(name: String.defaultFontR, size: 15)
        roamingTDesc.leadingAnchor.constraint(equalTo: roamingRLeft.trailingAnchor, constant: 10).isActive = true
        roamingTDesc.topAnchor.constraint(equalTo: roamingTLabel.bottomAnchor, constant: 10).isActive = true
        roamingTDesc.trailingAnchor.constraint(equalTo: roamingTipsCard.trailingAnchor, constant: -5).isActive = true
        roamingTDesc.numberOfLines = 0
        roamingTDesc.lineBreakMode = .byWordWrapping
        
        //Report Fault
        let faultReportCard = UIView()
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
        faultLabel.text = "Roaming FAQs"
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
        faultDesc.text = "Requently asked questions"
        faultDesc.textColor = UIColor.black
        faultDesc.font = UIFont(name: String.defaultFontR, size: 15)
        faultDesc.leadingAnchor.constraint(equalTo: faultLeft.trailingAnchor, constant: 10).isActive = true
        faultDesc.topAnchor.constraint(equalTo: faultLabel.bottomAnchor, constant: 10).isActive = true
        faultDesc.trailingAnchor.constraint(equalTo: faultReportCard.trailingAnchor, constant: -5).isActive = true
        faultDesc.numberOfLines = 0
        faultDesc.lineBreakMode = .byWordWrapping
        
        
        scrollView.contentSize.height = 680
        
    }
    
    @objc func gotToRoamingPartners(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Roaming", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "RoamingPartners")
        present(moveTo, animated: true, completion: nil)
    }

}
