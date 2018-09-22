//
//  StoreLocatorVc.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 21/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class StoreLocatorVc: baseViewControllerM {

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
    
    let txtSearch = UITextField()
    let btnSrch = UIButton()
    let btnGetLocation = UIButton()
    let currLocView = UIView()
    let lblCurrLoc = UILabel()
    let cardView = UIView()
    let btnListView = UIView()
    let btnMapView = UIView()
    let redView = UIView()
    
    fileprivate var redViewLeft1: NSLayoutConstraint?
    fileprivate var redViewLeft2: NSLayoutConstraint?
    fileprivate var redViewTop1: NSLayoutConstraint?
    fileprivate var redViewTop2: NSLayoutConstraint?
    fileprivate var redViewRight1: NSLayoutConstraint?
    fileprivate var redViewRight2: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground
        setUpViewsLocator()
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let viewHeight = view.frame.size.height
        let cardViewHeight = view.frame.size.width
        print("width \(cardViewHeight)")
        scrollView.contentSize.height = viewHeight + 70
    }

    func setUpViewsLocator() {
        view.addSubview(scrollView)
        
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
        
        scrollView.addSubview(topImage)
        topImage.image = UIImage(named: "bg2")
        topImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
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
        lblSelectedOffer.text = "Store Locator"
        lblSelectedOffer.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        lblSelectedOffer.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 50).isActive = true
        lblSelectedOffer.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        lblSelectedOffer.numberOfLines = 0
        lblSelectedOffer.lineBreakMode = .byWordWrapping
        
        let darkView = UIView()
        scrollView.addSubview(darkView)
        darkView.translatesAutoresizingMaskIntoConstraints = false
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        darkView.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 10).isActive = true
        darkView.topAnchor.constraint(equalTo: lblSelectedOffer.bottomAnchor, constant: 1).isActive = true
        darkView.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -10).isActive = true
        darkView.heightAnchor.constraint(equalToConstant: 155).isActive = true
        
        let lblDesc = UILabel()
        darkView.addSubview(lblDesc)
        lblDesc.translatesAutoresizingMaskIntoConstraints = false
        lblDesc.text = "Find the nearest vodafone agent"
        lblDesc.textColor = UIColor.white
        lblDesc.textAlignment = .center
        lblDesc.font = UIFont(name: String.defaultFontR, size: 17)
        lblDesc.numberOfLines = 0
        lblDesc.lineBreakMode = .byWordWrapping
        lblDesc.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        lblDesc.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 10).isActive = true
        lblDesc.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        
        darkView.addSubview(txtSearch)
        txtSearch.translatesAutoresizingMaskIntoConstraints = false
        txtSearch.backgroundColor = UIColor.white
        txtSearch.borderStyle = .roundedRect
        txtSearch.placeholder = "Type your location here"
        txtSearch.font = UIFont(name: String.defaultFontR, size: 20)
        txtSearch.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 10).isActive = true
        txtSearch.topAnchor.constraint(equalTo: lblDesc.bottomAnchor, constant: 30).isActive = true
        txtSearch.widthAnchor.constraint(equalToConstant: 200).isActive = true
        txtSearch.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        darkView.addSubview(btnSrch)
        btnSrch.translatesAutoresizingMaskIntoConstraints = false
        let srchImage = UIImage(named: "ic_action__search")
        let tintImage = srchImage?.withRenderingMode(.alwaysTemplate)
        btnSrch.backgroundColor = UIColor.vodaRed
        btnSrch.isEnabled = false
        btnSrch.leadingAnchor.constraint(equalTo: txtSearch.trailingAnchor, constant: 10).isActive = true
        btnSrch.topAnchor.constraint(equalTo: lblDesc.bottomAnchor, constant: 30).isActive = true
        btnSrch.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btnSrch.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnSrch.setImage(tintImage, for: .normal)
        btnSrch.tintColor = UIColor.white
        btnSrch.imageEdgeInsets = UIEdgeInsetsMake(50, 50, 50, 50)
        
        darkView.addSubview(btnGetLocation)
        btnGetLocation.translatesAutoresizingMaskIntoConstraints = false
        btnGetLocation.backgroundColor = UIColor.grayButton
        let getLocImage = UIImage(named: "ic_location_marker")
        let getLocTint = getLocImage?.withRenderingMode(.alwaysTemplate)
        btnGetLocation.setImage(getLocTint, for: .normal)
        btnGetLocation.imageEdgeInsets = UIEdgeInsetsMake(50, 50, 50, 50)
        btnGetLocation.tintColor = UIColor.white
        btnGetLocation.isEnabled = false
        btnGetLocation.leadingAnchor.constraint(equalTo: btnSrch.trailingAnchor, constant: 20).isActive = true
        btnGetLocation.topAnchor.constraint(equalTo: lblDesc.bottomAnchor, constant: 30).isActive = true
        btnGetLocation.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btnGetLocation.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        scrollView.addSubview(currLocView)
        currLocView.translatesAutoresizingMaskIntoConstraints = false
        currLocView.backgroundColor = UIColor.cardImageColour
        currLocView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        currLocView.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 10).isActive = true
        currLocView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        currLocView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        scrollView.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = UIColor.white
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cardView.topAnchor.constraint(equalTo: currLocView.bottomAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 320).isActive = true
        
        currLocView.addSubview(lblCurrLoc)
        lblCurrLoc.translatesAutoresizingMaskIntoConstraints = false
        lblCurrLoc.text = "Your location"
        lblCurrLoc.font = UIFont(name: String.defaultFontR, size: 20)
        lblCurrLoc.textColor = UIColor.white
        lblCurrLoc.textAlignment = .center
        lblCurrLoc.numberOfLines = 0
        lblCurrLoc.lineBreakMode = .byWordWrapping
        lblCurrLoc.leadingAnchor.constraint(equalTo: currLocView.leadingAnchor, constant: 30).isActive = true
        lblCurrLoc.topAnchor.constraint(equalTo: currLocView.topAnchor, constant: 20).isActive = true
        lblCurrLoc.trailingAnchor.constraint(equalTo: currLocView.trailingAnchor, constant: -30).isActive = true
        
        cardView.addSubview(btnListView)
        btnListView.translatesAutoresizingMaskIntoConstraints = false
        btnListView.backgroundColor = UIColor.white
        btnListView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        btnListView.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        btnListView.widthAnchor.constraint(equalToConstant: 187.5).isActive = true
        btnListView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnListView.layer.cornerRadius = 2
        btnListView.layer.shadowOffset = CGSize(width: 0, height: 5)
        btnListView.layer.shadowColor = UIColor.black.cgColor
        btnListView.layer.shadowOpacity = 0.2
        
        let lblListView = UILabel()
        btnListView.addSubview(lblListView)
        lblListView.translatesAutoresizingMaskIntoConstraints = false
        lblListView.text = "List View"
        lblListView.textColor = UIColor.black
        lblListView.font = UIFont(name: String.defaultFontB, size: 20)
        lblListView.textAlignment = .center
        lblListView.centerXAnchor.constraint(equalTo: btnListView.centerXAnchor).isActive = true
        lblListView.centerYAnchor.constraint(equalTo: btnListView.centerYAnchor).isActive = true
        
        cardView.addSubview(btnMapView)
        btnMapView.translatesAutoresizingMaskIntoConstraints = false
        btnMapView.backgroundColor = UIColor.white
        btnMapView.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        btnMapView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        btnMapView.widthAnchor.constraint(equalToConstant: 187.5).isActive = true
        btnMapView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnMapView.layer.cornerRadius = 2
        btnMapView.layer.shadowOffset = CGSize(width: 0, height: 5)
        btnMapView.layer.shadowColor = UIColor.black.cgColor
        btnMapView.layer.shadowOpacity = 0.2
        
        let lblMapView = UILabel()
        btnMapView.addSubview(lblMapView)
        lblMapView.translatesAutoresizingMaskIntoConstraints = false
        lblMapView.text = "Map View"
        lblMapView.textColor = UIColor.black
        lblMapView.font = UIFont(name: String.defaultFontB, size: 20)
        lblMapView.textAlignment = .center
        lblMapView.centerXAnchor.constraint(equalTo: btnMapView.centerXAnchor).isActive = true
        lblMapView.centerYAnchor.constraint(equalTo: btnMapView.centerYAnchor).isActive = true
        
        cardView.addSubview(redView)
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.backgroundColor = UIColor.red
        redView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        redViewLeft1 = redView.leadingAnchor.constraint(equalTo: btnListView.leadingAnchor)
        redViewLeft2 = redView.leadingAnchor.constraint(equalTo: btnMapView.leadingAnchor)
        redViewRight1 = redView.trailingAnchor.constraint(equalTo: btnListView.trailingAnchor)
        redViewRight2 = redView.trailingAnchor.constraint(equalTo: btnMapView.trailingAnchor)
        redViewTop1 = redView.topAnchor.constraint(equalTo: btnListView.bottomAnchor)
        redViewTop2 = redView.topAnchor.constraint(equalTo: btnMapView.bottomAnchor)
        redViewLeft1?.isActive = true
        redViewTop1?.isActive = true
        redViewRight1?.isActive = true
        
    }
}
