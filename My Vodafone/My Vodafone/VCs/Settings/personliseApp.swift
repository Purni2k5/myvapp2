//
//  personliseApp.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 01/10/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class personliseApp: baseViewControllerM {

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
    let cardView1: UIView = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground

        setUpViewsPersonlise()
        if AcctType == "PHONE_MOBILE_PRE_P" || AcctType == "BB_FIXED_PRE_P"{
            prePaidMenu()
        }else{
            prePaidMenu()
        }
    }

    func setUpViewsPersonlise(){
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
        lblSelectedOffer.text = "Personalise your app"
        lblSelectedOffer.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        lblSelectedOffer.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 70).isActive = true
        lblSelectedOffer.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        lblSelectedOffer.numberOfLines = 0
        lblSelectedOffer.lineBreakMode = .byWordWrapping
        
        view.addSubview(cardView1)
        cardView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cardView1.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 20).isActive = true
        cardView1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        cardView1.heightAnchor.constraint(equalToConstant: 130).isActive = true
        let card1Rec = UITapGestureRecognizer(target: self, action: #selector(goToListServices))
        cardView1.addGestureRecognizer(card1Rec)
        
        //Left Image
        let autoLeftImage = UIImageView()
        cardView1.addSubview(autoLeftImage)
        autoLeftImage.translatesAutoresizingMaskIntoConstraints = false
        autoLeftImage.backgroundColor = UIColor.cardImageColour
        autoLeftImage.widthAnchor.constraint(equalToConstant: 12).isActive = true
        autoLeftImage.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor).isActive = true
        autoLeftImage.topAnchor.constraint(equalTo: cardView1.topAnchor).isActive = true
        autoLeftImage.bottomAnchor.constraint(equalTo: cardView1.bottomAnchor).isActive = true
        
        let lblCardName = UILabel()
        cardView1.addSubview(lblCardName)
        lblCardName.translatesAutoresizingMaskIntoConstraints = false
        lblCardName.text = "Personalise your services"
        lblCardName.font = UIFont(name: String.defaultFontR, size: 22)
        lblCardName.textColor = UIColor.black
        lblCardName.leadingAnchor.constraint(equalTo: autoLeftImage.trailingAnchor, constant: 20).isActive = true
        lblCardName.topAnchor.constraint(equalTo: cardView1.topAnchor, constant: 30).isActive = true
        lblCardName.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
        lblCardName.numberOfLines = 0
        lblCardName.lineBreakMode = .byWordWrapping
        
        let lblAutoDesc = UILabel()
        cardView1.addSubview(lblAutoDesc)
        lblAutoDesc.translatesAutoresizingMaskIntoConstraints = false
        lblAutoDesc.text = "Add account names and profile picture"
        lblAutoDesc.font = UIFont(name: String.defaultFontR, size: 16)
        lblAutoDesc.leadingAnchor.constraint(equalTo: autoLeftImage.trailingAnchor, constant: 20).isActive = true
        lblAutoDesc.topAnchor.constraint(equalTo: lblCardName.bottomAnchor, constant: 10).isActive = true
        lblAutoDesc.numberOfLines = 0
        lblAutoDesc.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -30).isActive = true
        lblAutoDesc.lineBreakMode = .byWordWrapping
        
        let rightArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        cardView1.addSubview(rightArrow)
        rightArrow.translatesAutoresizingMaskIntoConstraints = false
        rightArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
        rightArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
        rightArrow.topAnchor.constraint(equalTo: cardView1.topAnchor, constant: 40).isActive = true
        rightArrow.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
        
        view.addSubview(cardView2)
        cardView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cardView2.topAnchor.constraint(equalTo: cardView1.bottomAnchor, constant: 20).isActive = true
        cardView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        cardView2.heightAnchor.constraint(equalToConstant: 130).isActive = true
        let card2Rec = UITapGestureRecognizer(target: self, action: #selector(goToSelDefaultService))
        cardView2.addGestureRecognizer(card2Rec)
        
        //Left Image
        let leftImage = UIImageView()
        cardView2.addSubview(leftImage)
        leftImage.translatesAutoresizingMaskIntoConstraints = false
        leftImage.backgroundColor = UIColor.cardImageColour
        leftImage.widthAnchor.constraint(equalToConstant: 12).isActive = true
        leftImage.leadingAnchor.constraint(equalTo: cardView2.leadingAnchor).isActive = true
        leftImage.topAnchor.constraint(equalTo: cardView2.topAnchor).isActive = true
        leftImage.bottomAnchor.constraint(equalTo: cardView2.bottomAnchor).isActive = true
        
        let lblCardName1 = UILabel()
        cardView2.addSubview(lblCardName1)
        lblCardName1.translatesAutoresizingMaskIntoConstraints = false
        lblCardName1.text = "Select home screen service"
        lblCardName1.font = UIFont(name: String.defaultFontR, size: 22)
        lblCardName1.textColor = UIColor.black
        lblCardName1.leadingAnchor.constraint(equalTo: autoLeftImage.trailingAnchor, constant: 20).isActive = true
        lblCardName1.topAnchor.constraint(equalTo: cardView2.topAnchor, constant: 30).isActive = true
        lblCardName1.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -10).isActive = true
        lblCardName1.numberOfLines = 0
        lblCardName1.lineBreakMode = .byWordWrapping
        
        let lblAutoDesc2 = UILabel()
        cardView2.addSubview(lblAutoDesc2)
        lblAutoDesc2.translatesAutoresizingMaskIntoConstraints = false
        lblAutoDesc2.text = "You can change the service that you see first on the home screen"
        lblAutoDesc2.font = UIFont(name: String.defaultFontR, size: 16)
        lblAutoDesc2.leadingAnchor.constraint(equalTo: leftImage.trailingAnchor, constant: 20).isActive = true
        lblAutoDesc2.topAnchor.constraint(equalTo: lblCardName1.bottomAnchor, constant: 10).isActive = true
        lblAutoDesc2.numberOfLines = 0
        lblAutoDesc2.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -30).isActive = true
        lblAutoDesc2.lineBreakMode = .byWordWrapping
        
        let rightArrow2 = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        cardView2.addSubview(rightArrow2)
        rightArrow2.translatesAutoresizingMaskIntoConstraints = false
        rightArrow2.widthAnchor.constraint(equalToConstant: 10).isActive = true
        rightArrow2.heightAnchor.constraint(equalToConstant: 25).isActive = true
        rightArrow2.topAnchor.constraint(equalTo: cardView2.topAnchor, constant: 40).isActive = true
        rightArrow2.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -10).isActive = true
        
        
    }
    
    @objc func goToSelDefaultService(){
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "chooseDefaultService")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToListServices(){
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "ListServices")
        present(moveTo, animated: true, completion: nil)
    }
    
}
