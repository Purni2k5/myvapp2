//
//  speedChecker.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 02/10/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class speedChecker: baseViewControllerM {

    var username: String?
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
    
    //create card view
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        
        var offerVariable: String?
        return view
    }()
    
    //dark view
    let darkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.60)
        view.isOpaque = false
        return view
    }()
    
    let btnWifi = UIView()
    let btnNetwork = UIView()
    let redView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.grayBackground
        setUpViewsSpeedChecker()
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        username = UserData["Username"] as? String
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.contentSize.height = view.frame.size.height + topImage.frame.size.height + cardView.frame.size.height
    }

    func setUpViewsSpeedChecker(){
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
        
        scrollView.addSubview(topImage)
        topImage.image = UIImage(named: "bg2")
        topImage.heightAnchor.constraint(equalToConstant: 400).isActive = true
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
        
        //Selected Offer
        let lblSelectedOffer = UILabel()
        scrollView.addSubview(lblSelectedOffer)
        lblSelectedOffer.translatesAutoresizingMaskIntoConstraints = false
        lblSelectedOffer.textColor = UIColor.white
        lblSelectedOffer.textAlignment = .center
        lblSelectedOffer.font = UIFont(name: String.defaultFontR, size: 31)
        lblSelectedOffer.text = "Speed Checker"
        lblSelectedOffer.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        lblSelectedOffer.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 60).isActive = true
        lblSelectedOffer.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        lblSelectedOffer.numberOfLines = 0
        lblSelectedOffer.lineBreakMode = .byWordWrapping
        
        topImage.addSubview(darkView)
        darkView.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        darkView.topAnchor.constraint(equalTo: lblSelectedOffer.bottomAnchor, constant: 20).isActive = true
        darkView.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        darkView.bottomAnchor.constraint(equalTo: topImage.bottomAnchor, constant: -24).isActive = true
        
        let speedCheckerImage = UIImageView(image: #imageLiteral(resourceName: "speedChecker"))
        darkView.addSubview(speedCheckerImage)
        speedCheckerImage.translatesAutoresizingMaskIntoConstraints = false
        speedCheckerImage.centerXAnchor.constraint(equalTo: darkView.centerXAnchor).isActive = true
        speedCheckerImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        speedCheckerImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        speedCheckerImage.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 5).isActive = true
        
        let lblCheck = UILabel()
        darkView.addSubview(lblCheck)
        lblCheck.translatesAutoresizingMaskIntoConstraints = false
        lblCheck.font = UIFont(name: String.defaultFontR, size: 25)
        lblCheck.text = "Check your network or Wi-Fi Speed now"
        lblCheck.textColor = UIColor.white
        lblCheck.textAlignment = .center
        lblCheck.numberOfLines = 0
        lblCheck.lineBreakMode = .byWordWrapping
        lblCheck.topAnchor.constraint(equalTo: speedCheckerImage.bottomAnchor, constant: 5).isActive = true
        lblCheck.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 30).isActive = true
        lblCheck.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -30).isActive = true
        
        let btnStart = UIButton()
        darkView.addSubview(btnStart)
        btnStart.translatesAutoresizingMaskIntoConstraints = false
        btnStart.backgroundColor = UIColor.vodaRed
        btnStart.setTitle("Start test", for: .normal)
        btnStart.setTitleColor(UIColor.white, for: .normal)
        btnStart.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnStart.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnStart.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        btnStart.topAnchor.constraint(equalTo: lblCheck.bottomAnchor, constant: 10).isActive = true
        btnStart.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        
        let lblDisclaimer = UILabel()
        darkView.addSubview(lblDisclaimer)
        lblDisclaimer.translatesAutoresizingMaskIntoConstraints = false
        lblDisclaimer.text = "*Speed tests are free on your < home > network"
        lblDisclaimer.font = UIFont(name: String.defaultFontR, size: 16)
        lblDisclaimer.textColor = UIColor.white
        lblDisclaimer.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 10).isActive = true
        lblDisclaimer.topAnchor.constraint(equalTo: btnStart.bottomAnchor, constant: 10).isActive = true
        lblDisclaimer.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -10).isActive = true
        lblDisclaimer.numberOfLines = 0
        lblDisclaimer.lineBreakMode = .byWordWrapping
        
        let lblPrevious = UILabel()
        view.addSubview(lblPrevious)
        lblPrevious.translatesAutoresizingMaskIntoConstraints = false
        lblPrevious.text = "Previous speed tests"
        lblPrevious.textColor = UIColor.support_voilet
        lblPrevious.textAlignment = .center
        lblPrevious.font = UIFont(name: String.defaultFontR, size: 31)
        lblPrevious.numberOfLines = 0
        lblPrevious.lineBreakMode = .byWordWrapping
        lblPrevious.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        lblPrevious.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 5).isActive = true
        lblPrevious.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = UIColor.white
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cardView.topAnchor.constraint(equalTo: lblPrevious.bottomAnchor, constant: 10).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        cardView.addSubview(btnWifi)
        btnWifi.translatesAutoresizingMaskIntoConstraints = false
        btnWifi.backgroundColor = UIColor.gray
        btnWifi.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnWifi.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        btnWifi.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        btnWifi.widthAnchor.constraint(equalToConstant: 170).isActive = true
        
        cardView.addSubview(btnNetwork)
        btnNetwork.translatesAutoresizingMaskIntoConstraints = false
        btnNetwork.backgroundColor = UIColor.vodaRed
        btnNetwork.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnNetwork.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        btnNetwork.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        btnNetwork.trailingAnchor.constraint(equalTo: btnWifi.leadingAnchor).isActive = true
        
        
        
        
        
    }

}
