//
//  ListServices.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 20/12/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit
import SDWebImage

class ListServices: baseViewControllerM {

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
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.grayBackground
        super.viewDidLoad()

        setUpViewsListServices()
        let Services = preference.object(forKey: UserDefaultsKeys.ServiceList.rawValue) as? NSArray
        if let array = Services {
            var cardTopConstraint: CGFloat = 20
            for obj in array {
                if let dict = obj as? NSDictionary {
                    let displayName = dict.value(forKey: "DisplayName") as? String
                    let imageUrl = dict.value(forKey: "DisplayImageUrl") as? String
                    var primaryID = dict.value(forKey: "primaryID") as? String
                    let type = dict.value(forKey: "Type") as? String
                    let serviceID = dict.value(forKey: "ID") as? String
                    
                    let cardView = UserDetailsCard()
                    cardView.translatesAutoresizingMaskIntoConstraints = false
                    scrollView.addSubview(cardView)
                    cardView.backgroundColor = UIColor.white
                    cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
                    cardView.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: cardTopConstraint).isActive = true
                    cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
                    cardView.heightAnchor.constraint(equalToConstant: 130).isActive = true
                    cardView.displayName = displayName
                    cardView.ID = serviceID
                    cardView.displayImageUrl = imageUrl
                    
                    let cardRec = UITapGestureRecognizer(target: self, action: #selector(moveToEdit))
                    cardView.addGestureRecognizer(cardRec)
                    
                    let cardLeftImage = UIImageView()
                    cardLeftImage.translatesAutoresizingMaskIntoConstraints = false
                    cardView.addSubview(cardLeftImage)
                    cardLeftImage.backgroundColor = UIColor.cardImageColour
                    cardLeftImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
                    cardLeftImage.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
                    cardLeftImage.widthAnchor.constraint(equalToConstant: 10).isActive = true
                    cardLeftImage.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
                    
                    let defaultImage = UIImageView()
                    defaultImage.translatesAutoresizingMaskIntoConstraints = false
                    cardView.addSubview(defaultImage)
                    defaultImage.leadingAnchor.constraint(equalTo: cardLeftImage.leadingAnchor, constant: 20).isActive = true
                    defaultImage.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20).isActive = true
                    defaultImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
                    defaultImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
                    defaultImage.layer.cornerRadius = 30
                    defaultImage.clipsToBounds = true
                    if let type = type{
                        if type.contains("BB_FIXED"){
                            defaultImage.sd_setImage(with: URL(string: imageUrl ?? ""), placeholderImage: UIImage(named: "fbb"), options: [.continueInBackground, .progressiveDownload])
                        }else{
                            defaultImage.sd_setImage(with: URL(string: imageUrl ?? ""), placeholderImage: UIImage(named: "default_profile"), options: [.continueInBackground, .progressiveDownload])
                        }
                    }else{
                        defaultImage.sd_setImage(with: URL(string: imageUrl ?? ""), placeholderImage: UIImage(named: "default_profile"), options: [.continueInBackground, .progressiveDownload])
                    }
                    
                    
                    let lblDisplayName = UILabel()
                    cardView.addSubview(lblDisplayName)
                    lblDisplayName.translatesAutoresizingMaskIntoConstraints = false
                    lblDisplayName.font = UIFont(name: String.defaultFontR, size: 20)
                    lblDisplayName.textColor = UIColor.black
                    if let displayName = displayName{
                        lblDisplayName.text = displayName
                        cardView.displayName = displayName
                    }
                    lblDisplayName.leadingAnchor.constraint(equalTo: defaultImage.trailingAnchor, constant: 20).isActive = true
                    lblDisplayName.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 30).isActive = true
                    lblDisplayName.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
                    lblDisplayName.numberOfLines = 0
                    lblDisplayName.lineBreakMode = .byWordWrapping
                    
                    let lblDisplayNumber = UILabel()
                    cardView.addSubview(lblDisplayNumber)
                    lblDisplayNumber.translatesAutoresizingMaskIntoConstraints = false
                    lblDisplayNumber.font = UIFont(name: String.defaultFontR, size: 15)
                    lblDisplayNumber.textColor = UIColor.black
                    if let displayNumber = primaryID{
                        if displayNumber.contains("233"){
                            let number = displayNumber.dropFirst(3)
                            primaryID = "0\(number)"
                            lblDisplayNumber.text = primaryID
                            cardView.msisdn = primaryID
                        }else{
                            lblDisplayNumber.text = displayNumber
                            cardView.msisdn = displayNumber
                        }
                        
                    }
                    lblDisplayNumber.leadingAnchor.constraint(equalTo: defaultImage.trailingAnchor, constant: 20).isActive = true
                    lblDisplayNumber.topAnchor.constraint(equalTo: lblDisplayName.bottomAnchor, constant: 10).isActive = true
                    lblDisplayNumber.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
                    lblDisplayNumber.numberOfLines = 0
                    lblDisplayNumber.lineBreakMode = .byWordWrapping
                    
                    let rightArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
                    cardView.addSubview(rightArrow)
                    rightArrow.translatesAutoresizingMaskIntoConstraints = false
                    rightArrow.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 50).isActive = true
                    rightArrow.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
                    rightArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
                    rightArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
                    
                    cardTopConstraint = cardTopConstraint + 150
                    scrollView.contentSize.height = cardTopConstraint + 150
                }
            }
        }
        if AcctType == "PHONE_MOBILE_PRE_P" || AcctType == "BB_FIXED_PRE_P"{
            prePaidMenu()
        }else{
            prePaidMenu()
        }
    }
    
    func setUpViewsListServices(){
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
        lblSelectedOffer.text = "Select Service"
        lblSelectedOffer.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        lblSelectedOffer.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 70).isActive = true
        lblSelectedOffer.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        lblSelectedOffer.numberOfLines = 0
        lblSelectedOffer.lineBreakMode = .byWordWrapping
        
    }
    
    @objc func moveToEdit(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "UpdateProfile") as? UpdateProfile else {return}
        guard let gestureVariable = _sender.view as? UserDetailsCard else {return}
        print(gestureVariable.ID)
        moveTo.msisdn = gestureVariable.msisdn
        moveTo.displayName = gestureVariable.displayName
        moveTo.displayImage = gestureVariable.displayImageUrl
        moveTo.id = gestureVariable.ID
        present(moveTo, animated: true, completion: nil)
    }

}
