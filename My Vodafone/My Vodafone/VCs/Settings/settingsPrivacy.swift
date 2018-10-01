//
//  privacy.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 28/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class settingsPrivacy: baseViewControllerM {
    
    var isPrivacyEnabled: Bool?
    var isPrivateDataEnabled: Bool?

    fileprivate var cardView2Height1: NSLayoutConstraint?
    fileprivate var cardView2Height2: NSLayoutConstraint?
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
    
    let cardView2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 2
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        return view
    }()
    
    let btnSwitch1 = UISwitch()
    let btnSwitch2 = UISwitch()
    let btnPrivacy1 = UIButton()
    let btnPrivacy2 = UIButton()
    let hiddenView1 = UIView()
    let hiddenView2 = UIView()
    
    var isCollapse1Showing = false
    var isCollapse2Showing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.grayBackground
        setUpViewsPrivacy()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let viewHeight = view.frame.size.height
        let cardHeight = cardView.frame.size.height
        let hiddenView1Height = hiddenView1.frame.size.height
//        if cardHeight > viewHeight {
            scrollView.contentSize.height =  viewHeight + cardHeight + hiddenView1Height + 100
//        }else{
//            scrollView.contentSize.height =  viewHeight
//        }
        
    }

    func setUpViewsPrivacy(){
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
        backButton.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        
        //Selected Offer
        let lblSelectedOffer = UILabel()
        scrollView.addSubview(lblSelectedOffer)
        lblSelectedOffer.translatesAutoresizingMaskIntoConstraints = false
        lblSelectedOffer.textColor = UIColor.white
        lblSelectedOffer.textAlignment = .center
        lblSelectedOffer.font = UIFont(name: String.defaultFontR, size: 31)
        lblSelectedOffer.text = "Privacy"
        lblSelectedOffer.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        lblSelectedOffer.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 70).isActive = true
        lblSelectedOffer.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        lblSelectedOffer.numberOfLines = 0
        lblSelectedOffer.lineBreakMode = .byWordWrapping
        
        scrollView.addSubview(cardView)
        cardView.heightAnchor.constraint(equalToConstant: 320).isActive = true
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cardView.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 10).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        cardView.addSubview(btnSwitch1)
        btnSwitch1.translatesAutoresizingMaskIntoConstraints = false
        
        btnSwitch1.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnSwitch1.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnSwitch1.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -30).isActive = true
        btnSwitch1.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 40).isActive = true
        btnSwitch1.addTarget(self, action: #selector(btnSwitch1Action), for: .touchUpInside)
//        btnSwitch1.addTarget(self, action: #selector(toggleSwitch), for: .touchUpInside)
        isPrivacyEnabled = preference.object(forKey: UserDefaultsKeys.privacyEnabled.rawValue) as? Bool
        if let privacyEnabled = isPrivacyEnabled {
            if privacyEnabled == true{
                btnSwitch1.isOn = true
            }else{
                btnSwitch1.isOn = false
            }
        }else{
            btnSwitch1.isOn = false
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
        switchLabel.trailingAnchor.constraint(equalTo: btnSwitch1.leadingAnchor, constant: 30).isActive = true
        
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
        desc.text = "When can make personal recommendations and tailor our service based on your location and the quality and use of your connectivity services."
        desc.numberOfLines = 0
        desc.lineBreakMode = .byWordWrapping
        desc.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 30).isActive = true
        desc.topAnchor.constraint(equalTo: separator1.bottomAnchor, constant: 30).isActive = true
        desc.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -30).isActive = true
        
        let separator2 = UIView()
        cardView.addSubview(separator2)
        separator2.translatesAutoresizingMaskIntoConstraints = false
        separator2.backgroundColor = UIColor.black
        separator2.heightAnchor.constraint(equalToConstant: 0.8).isActive = true
        separator2.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 30).isActive = true
        separator2.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: 20).isActive = true
        separator2.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -30).isActive = true
        
        let descQues = UILabel()
        cardView.addSubview(descQues)
        descQues.translatesAutoresizingMaskIntoConstraints = false
        descQues.text = "What happens when you keep this on?"
        descQues.font = UIFont(name: String.defaultFontR, size: 22)
        descQues.numberOfLines = 0
        descQues.lineBreakMode = .byWordWrapping
        descQues.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 30).isActive = true
        descQues.topAnchor.constraint(equalTo: separator2.bottomAnchor, constant: 20).isActive = true
        descQues.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -30).isActive = true
        
        cardView.addSubview(btnPrivacy1)
        btnPrivacy1.translatesAutoresizingMaskIntoConstraints = false
        let privacyImage1 = UIImage(named: "dropdown")
        let cheTint = privacyImage1?.withRenderingMode(.alwaysTemplate)
        btnPrivacy1.setImage(cheTint, for: .normal)
        btnPrivacy1.tintColor = UIColor.red
        btnPrivacy1.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        btnPrivacy1.topAnchor.constraint(equalTo: separator2.bottomAnchor, constant: 25).isActive = true
        btnPrivacy1.widthAnchor.constraint(equalToConstant: 25).isActive = true
        btnPrivacy1.heightAnchor.constraint(equalToConstant: 15).isActive = true
        btnPrivacy1.addTarget(self, action: #selector(collapseOne), for: .touchUpInside)
        
        scrollView.addSubview(hiddenView1)
        hiddenView1.translatesAutoresizingMaskIntoConstraints = false
        hiddenView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        hiddenView1.topAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
        hiddenView1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        hiddenView1.heightAnchor.constraint(equalToConstant: 420).isActive = true
        hiddenView1.backgroundColor = UIColor.white
        hiddenView1.layer.cornerRadius = 2
        hiddenView1.layer.shadowOffset = CGSize(width: 0, height: 5)
        hiddenView1.layer.shadowColor = UIColor.black.cgColor
        hiddenView1.layer.shadowOpacity = 0.2
        hiddenView1.isHidden = true
        
        let ans1 = UILabel()
        hiddenView1.addSubview(ans1)
        ans1.translatesAutoresizingMaskIntoConstraints = false
        ans1.font = UIFont(name: String.defaultFontR, size: 18)
        ans1.numberOfLines = 0
        ans1.lineBreakMode = .byWordWrapping
        ans1.text = "By having this option switched ON, you can help us to: \n \n \u{2022} Improve your experience by monitoring signal strength and voice call quality. \n \n \u{2022} Discover what may hamper the performance of your app and phone and work to resolve it. \n \n \u{2022}  Recommend packages to suit your preferences and where you use your phone the most. \n \n \u{2022} Anticipate your needs by gathering data on the way you interact with your app. \n \n Be reassured that we will never collect or use information relating to your calls, your browsing history or any information that may be contained within any apps other than My Vodafone."
        
        ans1.leadingAnchor.constraint(equalTo: hiddenView1.leadingAnchor, constant: 30).isActive = true
        ans1.topAnchor.constraint(equalTo: hiddenView1.topAnchor, constant: 5).isActive = true
        ans1.trailingAnchor.constraint(equalTo: hiddenView1.trailingAnchor, constant: -30).isActive = true
        
        
        scrollView.addSubview(cardView2)
        cardView2.heightAnchor.constraint(equalToConstant: 320).isActive = true
        cardView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cardView2Height1 =  cardView2.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 20)
        cardView2Height2 =  cardView2.topAnchor.constraint(equalTo: hiddenView1.bottomAnchor, constant: 20)
        cardView2Height1?.isActive = true
        cardView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        cardView2.addSubview(btnSwitch2)
        btnSwitch2.translatesAutoresizingMaskIntoConstraints = false
        
        btnSwitch2.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnSwitch2.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnSwitch2.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -30).isActive = true
        btnSwitch2.topAnchor.constraint(equalTo: cardView2.topAnchor, constant: 40).isActive = true
        btnSwitch2.addTarget(self, action: #selector(btnSwitch2Action), for: .touchUpInside)
        //        btnSwitch1.addTarget(self, action: #selector(toggleSwitch), for: .touchUpInside)
        isPrivateDataEnabled = preference.object(forKey: UserDefaultsKeys.privateDataEnabled.rawValue) as? Bool
        if let privacyDataEnabled = isPrivateDataEnabled {
            if privacyDataEnabled == true {
                btnSwitch2.isOn = true
            }else{
                btnSwitch2.isOn = false
            }
        }else{
            btnSwitch2.isOn = false
        }
        
        
        let switchLabel2 = UILabel()
        cardView2.addSubview(switchLabel2)
        switchLabel2.translatesAutoresizingMaskIntoConstraints = false
        switchLabel2.text = "Share Private Data"
        switchLabel2.textColor = UIColor.black
        switchLabel2.font = UIFont(name: String.defaultFontR, size: 20)
        switchLabel2.numberOfLines = 0
        switchLabel2.lineBreakMode = .byWordWrapping
        switchLabel2.leadingAnchor.constraint(equalTo: cardView2.leadingAnchor, constant: 30).isActive = true
        switchLabel2.topAnchor.constraint(equalTo: cardView2.topAnchor, constant: 45).isActive = true
        switchLabel2.trailingAnchor.constraint(equalTo: btnSwitch2.leadingAnchor, constant: 30).isActive = true
        
        let separator3 = UIView()
        cardView2.addSubview(separator3)
        separator3.translatesAutoresizingMaskIntoConstraints = false
        separator3.backgroundColor = UIColor.black
        separator3.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        separator3.leadingAnchor.constraint(equalTo: cardView2.leadingAnchor, constant: 30).isActive = true
        separator3.topAnchor.constraint(equalTo: switchLabel2.bottomAnchor, constant: 40).isActive = true
        separator3.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -30).isActive = true
        
        let desc2 = UILabel()
        cardView2.addSubview(desc2)
        desc2.translatesAutoresizingMaskIntoConstraints = false
        desc2.font = UIFont(name: String.defaultFontR, size: 19)
        desc2.text = "By collecting data including location and the performance of your phone we can improve the service we offer to everyone. This data is not linked back to you in any way."
        desc2.numberOfLines = 0
        desc2.lineBreakMode = .byWordWrapping
        desc2.leadingAnchor.constraint(equalTo: cardView2.leadingAnchor, constant: 30).isActive = true
        desc2.topAnchor.constraint(equalTo: separator3.bottomAnchor, constant: 30).isActive = true
        desc2.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -30).isActive = true
        
        let separator4 = UIView()
        cardView2.addSubview(separator4)
        separator4.translatesAutoresizingMaskIntoConstraints = false
        separator4.backgroundColor = UIColor.black
        separator4.heightAnchor.constraint(equalToConstant: 0.8).isActive = true
        separator4.leadingAnchor.constraint(equalTo: cardView2.leadingAnchor, constant: 30).isActive = true
        separator4.topAnchor.constraint(equalTo: desc2.bottomAnchor, constant: 20).isActive = true
        separator4.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -30).isActive = true
        
        let descQues2 = UILabel()
        cardView2.addSubview(descQues2)
        descQues2.translatesAutoresizingMaskIntoConstraints = false
        descQues2.text = "What happens when you keep this on?"
        descQues2.font = UIFont(name: String.defaultFontR, size: 22)
        descQues2.numberOfLines = 0
        descQues2.lineBreakMode = .byWordWrapping
        descQues2.leadingAnchor.constraint(equalTo: cardView2.leadingAnchor, constant: 30).isActive = true
        descQues2.topAnchor.constraint(equalTo: separator4.bottomAnchor, constant: 20).isActive = true
        descQues2.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -30).isActive = true
        
        cardView2.addSubview(btnPrivacy2)
        btnPrivacy2.translatesAutoresizingMaskIntoConstraints = false
        let privacyImage2 = UIImage(named: "dropdown")
        let cheTint2 = privacyImage2?.withRenderingMode(.alwaysTemplate)
        btnPrivacy2.setImage(cheTint2, for: .normal)
        btnPrivacy2.tintColor = UIColor.red
        btnPrivacy2.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -10).isActive = true
        btnPrivacy2.topAnchor.constraint(equalTo: separator4.bottomAnchor, constant: 25).isActive = true
        btnPrivacy2.widthAnchor.constraint(equalToConstant: 25).isActive = true
        btnPrivacy2.heightAnchor.constraint(equalToConstant: 15).isActive = true
        btnPrivacy2.addTarget(self, action: #selector(collapseTwo), for: .touchUpInside)
        
        scrollView.addSubview(hiddenView2)
        hiddenView2.translatesAutoresizingMaskIntoConstraints = false
        hiddenView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        hiddenView2.topAnchor.constraint(equalTo: cardView2.bottomAnchor).isActive = true
        hiddenView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        hiddenView2.heightAnchor.constraint(equalToConstant: 320).isActive = true
        hiddenView2.backgroundColor = UIColor.white
        hiddenView2.layer.cornerRadius = 2
        hiddenView2.layer.shadowOffset = CGSize(width: 0, height: 5)
        hiddenView2.layer.shadowColor = UIColor.black.cgColor
        hiddenView2.layer.shadowOpacity = 0.2
        hiddenView2.isHidden = true
        
        let ans2 = UILabel()
        hiddenView2.addSubview(ans2)
        ans2.translatesAutoresizingMaskIntoConstraints = false
        ans2.font = UIFont(name: String.defaultFontR, size: 18)
        ans2.numberOfLines = 0
        ans2.lineBreakMode = .byWordWrapping
        ans2.text = "By having this option switched ON, you can help us to: \n \n \u{2022} Improve the network in locations where customers are most likely to their phones by using Speed Checker data. \n \n \u{2022} Improve our network by pinpointing areas where devices have not worked as well as they should. \n \n \u{2022}  Work with device manufacturers to improve how their devices work on our network. \n \n \u{2022} Offer data packages that reflect the way our customers use mobile data vs Wi-Fi."
        
        ans2.leadingAnchor.constraint(equalTo: hiddenView2.leadingAnchor, constant: 30).isActive = true
        ans2.topAnchor.constraint(equalTo: hiddenView2.topAnchor, constant: 5).isActive = true
        ans2.trailingAnchor.constraint(equalTo: hiddenView2.trailingAnchor, constant: -30).isActive = true
        
    }

    @objc func collapseOne(){
        
        if isCollapse1Showing {
            hiddenView1.isHidden = true
            cardView2Height2?.isActive = false
            cardView2Height1?.isActive = true
            UIView.animate(withDuration: 0.5, animations: {
                self.btnPrivacy1.transform = self.btnPrivacy1.transform.rotated(by: CGFloat(Double.pi / -1))
            })
        }else{
            cardView2Height1?.isActive = false
            cardView2Height2?.isActive = true
            hiddenView1.isHidden = false
            UIView.animate(withDuration: 0.5, animations: {
                self.btnPrivacy1.transform = self.btnPrivacy1.transform.rotated(by: CGFloat(Double.pi / -1))
            })
        }
        
        isCollapse1Showing = !isCollapse1Showing
    }
    
    @objc func collapseTwo(){
        
        if isCollapse2Showing {
            hiddenView2.isHidden = true
            cardView2Height2?.isActive = false
            cardView2Height1?.isActive = true
            UIView.animate(withDuration: 0.5, animations: {
                self.btnPrivacy2.transform = self.btnPrivacy2.transform.rotated(by: CGFloat(Double.pi / -1))
            })
        }else{
            hiddenView2.isHidden = false
            UIView.animate(withDuration: 0.5, animations: {
                self.btnPrivacy2.transform = self.btnPrivacy2.transform.rotated(by: CGFloat(Double.pi / -1))
            })
        }
        
        isCollapse2Showing = !isCollapse2Showing
    }
    
    @objc func btnSwitch1Action(){
        if btnSwitch1.isOn == true {
            preference.set(true, forKey: UserDefaultsKeys.privacyEnabled.rawValue)
        }else{
            preference.set(false, forKey: UserDefaultsKeys.privacyEnabled.rawValue)
        }
    }
    
    @objc func btnSwitch2Action(){
        if btnSwitch2.isOn == true {
            preference.set(true, forKey: UserDefaultsKeys.privateDataEnabled.rawValue)
        }else{
            preference.set(false, forKey: UserDefaultsKeys.privateDataEnabled.rawValue)
        }
    }
}
