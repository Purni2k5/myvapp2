//
//  privacy.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 28/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class settingsPrivacy: baseViewControllerM {

    
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
    
    let btnSwitch1 = UISwitch()
    let btnSwitch2 = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.grayBackground
        setUpViewsPrivacy()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let viewHeight = view.frame.size.height
        let cardHeight = cardView.frame.size.height
        if cardHeight > viewHeight {
            scrollView.contentSize.height =  viewHeight + cardHeight
        }else{
            scrollView.contentSize.height =  viewHeight
        }
        
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
        cardView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cardView.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 10).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        cardView.addSubview(btnSwitch1)
        btnSwitch1.translatesAutoresizingMaskIntoConstraints = false
        
        btnSwitch1.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnSwitch1.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnSwitch1.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -30).isActive = true
        btnSwitch1.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 40).isActive = true
//        btnSwitch1.addTarget(self, action: #selector(toggleSwitch), for: .touchUpInside)
        
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
        separator2.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
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
    }

}
