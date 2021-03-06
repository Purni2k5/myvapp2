//
//  TouchID.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 27/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class TouchID: baseViewControllerM {

    var touchIDEnabled: Bool?
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
        view.layer.cornerRadius = 2
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        return view
    }()
    
    //create a closure for activity loader
    let activity_loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        view.hidesWhenStopped = true
        view.color = UIColor.vodaRed
        return view
    }()
    
    let switchButton = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.grayBackground
        touchIDEnabled = preference.object(forKey: UserDefaultsKeys.touchIDEnabled.rawValue) as? Bool
        
        
        setUpViewsTouchID()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let viewHeight = view.frame.size.height
        let cardHeight = cardView.frame.size.height
        if cardHeight > viewHeight {
            scrollView.contentSize.height =  viewHeight + cardHeight
        }else{
            scrollView.contentSize.height =  viewHeight
        }
        
    }
    
    func setUpViewsTouchID(){
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
        backButton.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        
        //Selected Offer
        let lblSelectedOffer = UILabel()
        scrollView.addSubview(lblSelectedOffer)
        lblSelectedOffer.translatesAutoresizingMaskIntoConstraints = false
        lblSelectedOffer.textColor = UIColor.white
        lblSelectedOffer.textAlignment = .center
        lblSelectedOffer.font = UIFont(name: String.defaultFontR, size: 31)
        lblSelectedOffer.text = "Touch ID"
        lblSelectedOffer.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        lblSelectedOffer.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 70).isActive = true
        lblSelectedOffer.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        lblSelectedOffer.numberOfLines = 0
        lblSelectedOffer.lineBreakMode = .byWordWrapping
        
        scrollView.addSubview(cardView)
        cardView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cardView.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 10).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        cardView.addSubview(switchButton)
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        
        switchButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        switchButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        switchButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -30).isActive = true
        switchButton.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 40).isActive = true
        switchButton.addTarget(self, action: #selector(toggleSwitch), for: .touchUpInside)
        
        if let touchIDEnabled = touchIDEnabled {
            print("touch Stats:: \(touchIDEnabled)")
            let touchStatus = touchIDEnabled
            if touchStatus == false{
                switchButton.isOn = false
                preference.set(false, forKey: UserDefaultsKeys.touchIDEnabled.rawValue)
            }else{
                switchButton.isOn = true
                preference.set(true, forKey: UserDefaultsKeys.touchIDEnabled.rawValue)
            }
            
        }
        
        let switchLabel = UILabel()
        cardView.addSubview(switchLabel)
        switchLabel.translatesAutoresizingMaskIntoConstraints = false
        switchLabel.text = "Tailored service and \n recommendations"
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
        desc.text = "Use touch ID instead of password to login and to make the in-app purchase on My Vodafone App."
        desc.numberOfLines = 0
        desc.lineBreakMode = .byWordWrapping
        desc.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 30).isActive = true
        desc.topAnchor.constraint(equalTo: separator1.bottomAnchor, constant: 30).isActive = true
        desc.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -30).isActive = true
        
        let separator2 = UIView()
        cardView.addSubview(separator2)
        separator2.translatesAutoresizingMaskIntoConstraints = false
        separator2.backgroundColor = UIColor.black
        separator2.heightAnchor.constraint(equalToConstant: 0.9).isActive = true
        separator2.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 30).isActive = true
        separator2.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: 20).isActive = true
        separator2.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -30).isActive = true
        
        let descQues = UILabel()
        cardView.addSubview(descQues)
        descQues.translatesAutoresizingMaskIntoConstraints = false
        descQues.text = "Who can access this app using Touch ID?"
        descQues.font = UIFont(name: String.defaultFontR, size: 22)
        descQues.numberOfLines = 0
        descQues.lineBreakMode = .byWordWrapping
        descQues.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 30).isActive = true
        descQues.topAnchor.constraint(equalTo: separator2.bottomAnchor, constant: 20).isActive = true
        descQues.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -30).isActive = true
        
        
        let quesAns = UILabel()
        cardView.addSubview(quesAns)
        quesAns.translatesAutoresizingMaskIntoConstraints = false
        quesAns.font = UIFont(name: String.defaultFontR, size: 19)
        quesAns.numberOfLines = 0
        quesAns.lineBreakMode = .byWordWrapping
        quesAns.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 30).isActive = true
        quesAns.topAnchor.constraint(equalTo: descQues.bottomAnchor, constant: 30).isActive = true
        quesAns.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -30).isActive = true
        quesAns.text = "Any fingerprint registered under Touch ID on this device can login and make purchases. Manage fingerprints from device settings."
        
        let btnGoSettings = UIButton()
        cardView.addSubview(btnGoSettings)
        btnGoSettings.translatesAutoresizingMaskIntoConstraints = false
        btnGoSettings.backgroundColor = UIColor.grayButton
        btnGoSettings.setTitle("Go to device settings", for: .normal)
        btnGoSettings.setTitleColor(UIColor.white, for: .normal)
        btnGoSettings.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnGoSettings.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 30).isActive = true
        btnGoSettings.topAnchor.constraint(equalTo: quesAns.bottomAnchor, constant: 30).isActive = true
        btnGoSettings.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -30).isActive = true
        btnGoSettings.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnGoSettings.addTarget(self, action: #selector(goDeviceSettings), for: .touchUpInside)
        
        
        
        
        
        
        
        
    }
    
    @objc func toggleSwitch(){
        if switchButton.isOn == true {
            preference.set(true, forKey: UserDefaultsKeys.touchIDEnabled.rawValue)
        }else{
            preference.set(false, forKey: UserDefaultsKeys.touchIDEnabled.rawValue)
        }
    }

    @objc func goDeviceSettings(){
        guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)") // Prints true
            })
        }
    }
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        
    }
    
    //Function to stopIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        
    }
}
