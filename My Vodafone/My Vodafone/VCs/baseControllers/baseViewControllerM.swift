//
//  baseViewControllerM.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 29/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class baseViewControllerM: UIViewController {

   
    let preference = UserDefaults.standard
    var altDisplayName: String?
    var altServiceID: String?
    var altAcctType: String?
    var ServiceID: String?
    var AcctType: String?
    var deviceOs: String?
    var defaultService: String?
    
    let kVersion = "CFBundleShortVersionString"
    
    
    var mssgTopConstraint1: NSLayoutConstraint?
    var mssgTopConstraint2: NSLayoutConstraint?
    var mssgIconTop1: NSLayoutConstraint?
    var mssgIconTop2: NSLayoutConstraint?
    var isCheviClicked: Bool = false
    var motherViewTrailing1: NSLayoutConstraint?
    var motherViewTrailing2: NSLayoutConstraint?
    var menuShowing: Bool = false
    
    //create a closure for background image
    let vcHomeImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // create closure for mother view
    let motherView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    //create a closure for scrollView
    let scrollViewBase: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    //create a closure for hamburger
    let vcHamburger: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Dark view to display offer usage
    let bottomDarkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.60)
        view.isOpaque = false
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deviceOs = getDeviceOS()
        
        if let UserData = preference.object(forKey: "responseData") as! NSDictionary?{
            defaultService = UserData["DefaultService"] as! String
        }
        
        
//        print("yo:: \(defaultService)")
        let Services = preference.object(forKey: "ServiceList")
//                print(Services)
        if let array = Services as? NSArray {
            
            for obj in array {
                if let dict = obj as? NSDictionary {
                    // Now reference the data you need using:
                    
                    ServiceID = dict.value(forKey: "ID") as! String?
                    AcctType = dict.value(forKey: "Type") as! String?
                    
                    
                    if(ServiceID == defaultService){
                        if(AcctType == "PHONE_MOBILE_PRE_P"){
                            print("prepaid")
                        }else if(AcctType == "PHONE_MOBILE_POST_P"){
                            print("postpaid")
                        }else if(AcctType == "PHONE_MOBILE_HYBRID"){
                            print("hybrid")
                        }else{
                            print("fbb")
                        }
                        
                    }else{
                        //Just pick one to display
                        
                    }
                }
            }
        }
        setUpViews()
        // Check for internet connection
        checkConnection()
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        
       
    }
    
    func getAppVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let appVersion = dictionary[kVersion] as! String
        return "IOS \(appVersion)"
    }
    func setUpViews(){
        
        
        
        
        scrollViewBase.contentSize.height = 950
    }
    
    @objc func showMenu(){
        if menuShowing {
            self.motherViewTrailing1?.isActive = true
            self.motherViewTrailing2?.isActive = false
        }else{
            self.motherViewTrailing1?.isActive = false
            self.motherViewTrailing2?.isActive = true
            
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        menuShowing = !menuShowing
    }
    
    func prePaidMenu(){
        
        let motherView = UIView()
        self.view.addSubview(motherView)
        motherView.translatesAutoresizingMaskIntoConstraints = false
        motherView.topAnchor.constraint(equalTo: self.view.safeTopAnchor).isActive = true
        motherViewTrailing1 = motherView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 320)
        motherViewTrailing2 = motherView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        motherViewTrailing1?.isActive = true
        motherView.bottomAnchor.constraint(equalTo: self.view.safeBottomAnchor).isActive = true
        motherView.widthAnchor.constraint(equalToConstant: 320).isActive = true
        motherView.backgroundColor = UIColor.black.withAlphaComponent(0.80)
        motherView.isOpaque = false
        
        //Scroll View
        let scrollViewBase = UIScrollView()
        motherView.addSubview(scrollViewBase)
        scrollViewBase.translatesAutoresizingMaskIntoConstraints = false
        scrollViewBase.backgroundColor = UIColor.clear
        scrollViewBase.leadingAnchor.constraint(equalTo: motherView.leadingAnchor).isActive = true
        scrollViewBase.topAnchor.constraint(equalTo: motherView.topAnchor).isActive = true
        scrollViewBase.trailingAnchor.constraint(equalTo: motherView.trailingAnchor).isActive = true
        scrollViewBase.bottomAnchor.constraint(equalTo: motherView.bottomAnchor).isActive = true
        scrollViewBase.contentSize.height = 750
        
        //close button
        let btnClose = UIButton()
        scrollViewBase.addSubview(btnClose)
        btnClose.translatesAutoresizingMaskIntoConstraints = false
        let close_image = UIImage(named: "ic_close")
        btnClose.setImage(close_image, for: .normal)
        btnClose.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnClose.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnClose.topAnchor.constraint(equalTo: scrollViewBase.topAnchor, constant: 10).isActive = true
        btnClose.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -10).isActive = true
        btnClose.addTarget(self, action: #selector(closeMenu), for: .touchUpInside)
        
        //home icon
        let homeIcon = UIImageView(image: #imageLiteral(resourceName: "ic_home"))
        scrollViewBase.addSubview(homeIcon)
        homeIcon.image = homeIcon.image?.withRenderingMode(.alwaysTemplate)
        homeIcon.tintColor = UIColor.white
        homeIcon.translatesAutoresizingMaskIntoConstraints = false
        homeIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        homeIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        homeIcon.topAnchor.constraint(equalTo: scrollViewBase.topAnchor, constant: 50).isActive = true
        homeIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
//        btnHome.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
        //home button
        let btnHome = UIButton()
        scrollViewBase.addSubview(btnHome)
        btnHome.translatesAutoresizingMaskIntoConstraints = false
        btnHome.setTitle("Home", for: .normal)
        btnHome.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnHome.setTitleColor(UIColor.white, for: .normal)
        btnHome.leadingAnchor.constraint(equalTo: homeIcon.trailingAnchor, constant: 16).isActive = true
        btnHome.topAnchor.constraint(equalTo: scrollViewBase.topAnchor, constant: 55).isActive = true
        btnHome.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
        
        //Mobile icon
        let mobileIcon = UIButton()
        scrollViewBase.addSubview(mobileIcon)
        mobileIcon.translatesAutoresizingMaskIntoConstraints = false
        let mobileImage = UIImage(named: "ic_mobile")
        let mobileTintColor = mobileImage?.withRenderingMode(.alwaysTemplate)
        mobileIcon.setImage(mobileTintColor, for: .normal)
        mobileIcon.tintColor = UIColor.white
        mobileIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        mobileIcon.topAnchor.constraint(equalTo: homeIcon.bottomAnchor, constant: 20).isActive = true
        mobileIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        mobileIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        mobileIcon.addTarget(self, action: #selector(goToProducts), for: .touchUpInside)
        //My products and services
        let btnPdt = UIButton()
        scrollViewBase.addSubview(btnPdt)
        btnPdt.translatesAutoresizingMaskIntoConstraints = false
        btnPdt.setTitle("My products and services", for: .normal)
        btnPdt.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnPdt.setTitleColor(UIColor.white, for: .normal)
        btnPdt.leadingAnchor.constraint(equalTo: mobileIcon.trailingAnchor, constant: 16).isActive = true
        btnPdt.topAnchor.constraint(equalTo: btnHome.bottomAnchor, constant: 21).isActive = true
        btnPdt.addTarget(self, action: #selector(goToProducts), for: .touchUpInside)
        
        //Offers and extras
        let extraIcon = UIButton()
        scrollViewBase.addSubview(extraIcon)
        extraIcon.translatesAutoresizingMaskIntoConstraints = false
        let extrasImage = UIImage(named: "ic_ratings")
        let extraTint = extrasImage?.withRenderingMode(.alwaysTemplate)
        extraIcon.setImage(extraTint, for: .normal)
        extraIcon.tintColor = UIColor.white
        extraIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        extraIcon.topAnchor.constraint(equalTo: mobileIcon.bottomAnchor, constant: 20).isActive = true
        extraIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        extraIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        extraIcon.addTarget(self, action: #selector(goToOffers), for: .touchUpInside)
        //My products and services
        let btnExtras = UIButton()
        scrollViewBase.addSubview(btnExtras)
        btnExtras.translatesAutoresizingMaskIntoConstraints = false
        btnExtras.setTitle("Offers and Extras for you", for: .normal)
        btnExtras.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnExtras.setTitleColor(UIColor.white, for: .normal)
        btnExtras.leadingAnchor.constraint(equalTo: extraIcon.trailingAnchor, constant: 16).isActive = true
        btnExtras.topAnchor.constraint(equalTo: btnPdt.bottomAnchor, constant: 23).isActive = true
        btnExtras.addTarget(self, action: #selector(goToOffers), for: .touchUpInside)
        
        //Top up
        let topUpIcon = UIButton()
        scrollViewBase.addSubview(topUpIcon)
        topUpIcon.translatesAutoresizingMaskIntoConstraints = false
        let topUpImage = UIImage(named: "ic_top_up")
        let topUpTint = topUpImage?.withRenderingMode(.alwaysTemplate)
        topUpIcon.setImage(topUpTint, for: .normal)
        topUpIcon.tintColor = UIColor.white
        topUpIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        topUpIcon.topAnchor.constraint(equalTo: extraIcon.bottomAnchor, constant: 20).isActive = true
        topUpIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        topUpIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        topUpIcon.addTarget(self, action: #selector(goToTopUpM), for: .touchUpInside)
        //Top up
        let btnTopUp = UIButton()
        scrollViewBase.addSubview(btnTopUp)
        btnTopUp.translatesAutoresizingMaskIntoConstraints = false
        btnTopUp.setTitle("Top up", for: .normal)
        btnTopUp.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnTopUp.setTitleColor(UIColor.white, for: .normal)
        btnTopUp.leadingAnchor.constraint(equalTo: topUpIcon.trailingAnchor, constant: 16).isActive = true
        btnTopUp.topAnchor.constraint(equalTo: btnExtras.bottomAnchor, constant: 25).isActive = true
        btnTopUp.addTarget(self, action: #selector(goToTopUpM), for: .touchUpInside)
        
        //Travelling abroad
        let travellingIcon = UIButton()
        scrollViewBase.addSubview(travellingIcon)
        travellingIcon.translatesAutoresizingMaskIntoConstraints = false
        let travellingImage = UIImage(named: "ic_roaming")
        let travTint = travellingImage?.withRenderingMode(.alwaysTemplate)
        travellingIcon.setImage(travTint, for: .normal)
        travellingIcon.tintColor = UIColor.white
        travellingIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        travellingIcon.topAnchor.constraint(equalTo: topUpIcon.bottomAnchor, constant: 20).isActive = true
        travellingIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        travellingIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        travellingIcon.addTarget(self, action: #selector(goToTravelling), for: .touchUpInside)
        //Travelling abroad
        let btnTravel = UIButton()
        scrollViewBase.addSubview(btnTravel)
        btnTravel.translatesAutoresizingMaskIntoConstraints = false
        btnTravel.setTitle("Travelling abroad", for: .normal)
        btnTravel.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnTravel.setTitleColor(UIColor.white, for: .normal)
        btnTravel.leadingAnchor.constraint(equalTo: travellingIcon.trailingAnchor, constant: 16).isActive = true
        btnTravel.topAnchor.constraint(equalTo: btnTopUp.bottomAnchor, constant: 25).isActive = true
        btnTravel.addTarget(self, action: #selector(goToTravelling), for: .touchUpInside)
        
        //24/7
        let twoFourSevenIcon = UIButton()
        scrollViewBase.addSubview(twoFourSevenIcon)
        twoFourSevenIcon.translatesAutoresizingMaskIntoConstraints = false
        let twoFourImage = UIImage(named: "ic_online_support")
        let twoFourTint = twoFourImage?.withRenderingMode(.alwaysTemplate)
        twoFourSevenIcon.setImage(twoFourTint, for: .normal)
        twoFourSevenIcon.tintColor = UIColor.white
        twoFourSevenIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        twoFourSevenIcon.topAnchor.constraint(equalTo: travellingIcon.bottomAnchor, constant: 20).isActive = true
        twoFourSevenIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        twoFourSevenIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        twoFourSevenIcon.addTarget(self, action: #selector(goToTwoFour), for: .touchUpInside)
        //24/7
        let btnTwoFour = UIButton()
        scrollViewBase.addSubview(btnTwoFour)
        btnTwoFour.translatesAutoresizingMaskIntoConstraints = false
        btnTwoFour.setTitle("24/7 support", for: .normal)
        btnTwoFour.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnTwoFour.setTitleColor(UIColor.white, for: .normal)
        btnTwoFour.leadingAnchor.constraint(equalTo: twoFourSevenIcon.trailingAnchor, constant: 16).isActive = true
        btnTwoFour.topAnchor.constraint(equalTo: btnTravel.bottomAnchor, constant: 25).isActive = true
        btnTwoFour.addTarget(self, action: #selector(goToTwoFour), for: .touchUpInside)
        
        //Store locator
        let locatorIcon = UIButton()
        scrollViewBase.addSubview(locatorIcon)
        locatorIcon.translatesAutoresizingMaskIntoConstraints = false
        let locatorImage = UIImage(named: "ic_location_marker")
        let locatorTint = locatorImage?.withRenderingMode(.alwaysTemplate)
        locatorIcon.setImage(locatorTint, for: .normal)
        locatorIcon.tintColor = UIColor.white
        locatorIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        locatorIcon.topAnchor.constraint(equalTo: twoFourSevenIcon.bottomAnchor, constant: 20).isActive = true
        locatorIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        locatorIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        locatorIcon.addTarget(self, action: #selector(goToLocator), for: .touchUpInside)
        //Store Locator
        let btnLocator = UIButton()
        scrollViewBase.addSubview(btnLocator)
        btnLocator.translatesAutoresizingMaskIntoConstraints = false
        btnLocator.setTitle("Store Locator", for: .normal)
        btnLocator.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnLocator.setTitleColor(UIColor.white, for: .normal)
        btnLocator.leadingAnchor.constraint(equalTo: twoFourSevenIcon.trailingAnchor, constant: 16).isActive = true
        btnLocator.topAnchor.constraint(equalTo: btnTwoFour.bottomAnchor, constant: 24).isActive = true
        btnLocator.addTarget(self, action: #selector(goToLocator), for: .touchUpInside)
        
        //Network
        let networkIcon = UIButton()
        scrollViewBase.addSubview(networkIcon)
        networkIcon.translatesAutoresizingMaskIntoConstraints = false
        let networkImage = UIImage(named: "ic_network")
        let networkTint = networkImage?.withRenderingMode(.alwaysTemplate)
        networkIcon.setImage(networkTint, for: .normal)
        networkIcon.tintColor = UIColor.white
        networkIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        networkIcon.topAnchor.constraint(equalTo: locatorIcon.bottomAnchor, constant: 20).isActive = true
        networkIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        networkIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
//        networkIcon.addTarget(self, action: #selector(goToLocator), for: .touchUpInside)
        //Network
        let btnNetwork = UIButton()
        scrollViewBase.addSubview(btnNetwork)
        btnNetwork.translatesAutoresizingMaskIntoConstraints = false
        btnNetwork.setTitle("Network", for: .normal)
        btnNetwork.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnNetwork.setTitleColor(UIColor.white, for: .normal)
        btnNetwork.leadingAnchor.constraint(equalTo: networkIcon.trailingAnchor, constant: 16).isActive = true
        btnNetwork.topAnchor.constraint(equalTo: btnLocator.bottomAnchor, constant: 24).isActive = true
//        networkIcon.addTarget(self, action: #selector(goToLocator), for: .touchUpInside)
        //Arrow down
        let chevron = UIButton()
        scrollViewBase.addSubview(chevron)
        chevron.translatesAutoresizingMaskIntoConstraints = false
        let chevImage = UIImage(named: "dropdown")
        let chevTint = chevImage?.withRenderingMode(.alwaysTemplate)
        chevron.setImage(chevTint, for: .normal)
        chevron.tintColor = UIColor.white
        chevron.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -20).isActive = true
        chevron.topAnchor.constraint(equalTo: btnLocator.bottomAnchor, constant: 28).isActive = true
        chevron.widthAnchor.constraint(equalToConstant: 25).isActive = true
        chevron.heightAnchor.constraint(equalToConstant: 15).isActive = true
//        chevron.addTarget(self, action: #selector(dropDown), for: .touchUpInside)
        
        //btn speed checker
        let btnSpeedChecker = UIButton()
        scrollViewBase.addSubview(btnSpeedChecker)
        btnSpeedChecker.translatesAutoresizingMaskIntoConstraints = false
        btnSpeedChecker.leadingAnchor.constraint(equalTo: locatorIcon.trailingAnchor, constant: 16).isActive = true
        btnSpeedChecker.topAnchor.constraint(equalTo: btnNetwork.bottomAnchor, constant: 13).isActive = true
        btnSpeedChecker.setTitle("Speed Checker", for: .normal)
        btnSpeedChecker.titleLabel?.font = UIFont(name: String.defaultFontR, size: 19)
        btnSpeedChecker.setTitleColor(UIColor.gray, for: .normal)
        btnSpeedChecker.isHidden = true
        
        //btn network usage
        let btnNetworkUsage = UIButton()
        scrollViewBase.addSubview(btnNetworkUsage)
        btnNetworkUsage.translatesAutoresizingMaskIntoConstraints = false
        btnNetworkUsage.leadingAnchor.constraint(equalTo: locatorIcon.trailingAnchor, constant: 16).isActive = true
        btnNetworkUsage.topAnchor.constraint(equalTo: btnSpeedChecker.bottomAnchor, constant: 13).isActive = true
        btnNetworkUsage.setTitle("Network Usage", for: .normal)
        btnNetworkUsage.titleLabel?.font = UIFont(name: String.defaultFontR, size: 19)
        btnNetworkUsage.setTitleColor(UIColor.gray, for: .normal)
        btnNetworkUsage.isHidden = true
        
        //btn Broadband finder
        let btnBBFinder = UIButton()
        scrollViewBase.addSubview(btnBBFinder)
        btnBBFinder.translatesAutoresizingMaskIntoConstraints = false
        btnBBFinder.leadingAnchor.constraint(equalTo: locatorIcon.trailingAnchor, constant: 16).isActive = true
        btnBBFinder.topAnchor.constraint(equalTo: btnNetworkUsage.bottomAnchor, constant: 13).isActive = true
        btnBBFinder.setTitle("Broadband Finder", for: .normal)
        btnBBFinder.titleLabel?.font = UIFont(name: String.defaultFontR, size: 19)
        btnBBFinder.setTitleColor(UIColor.gray, for: .normal)
        btnBBFinder.isHidden = true
        
        //btn Network Coverage
        let btnNetworkCov = UIButton()
        scrollViewBase.addSubview(btnNetworkCov)
        btnNetworkCov.translatesAutoresizingMaskIntoConstraints = false
        btnNetworkCov.leadingAnchor.constraint(equalTo: locatorIcon.trailingAnchor, constant: 16).isActive = true
        btnNetworkCov.topAnchor.constraint(equalTo: btnBBFinder.bottomAnchor, constant: 13).isActive = true
        btnNetworkCov.setTitle("Network Coverage", for: .normal)
        btnNetworkCov.titleLabel?.font = UIFont(name: String.defaultFontR, size: 19)
        btnNetworkCov.setTitleColor(UIColor.gray, for: .normal)
        btnNetworkCov.isHidden = true
        
        //Messages
        let mssgIcon = UIButton()
        scrollViewBase.addSubview(mssgIcon)
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
        mssgIcon.addTarget(self, action: #selector(goToMessages), for: .touchUpInside)
        let btnMessage = UIButton()
        scrollViewBase.addSubview(btnMessage)
        btnMessage.translatesAutoresizingMaskIntoConstraints = false
        btnMessage.setTitle("My Messages", for: .normal)
        btnMessage.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnMessage.setTitleColor(UIColor.white, for: .normal)
        btnMessage.leadingAnchor.constraint(equalTo: mssgIcon.trailingAnchor, constant: 16).isActive = true
        mssgTopConstraint1 = btnMessage.topAnchor.constraint(equalTo: btnNetwork.bottomAnchor, constant: 24)
        mssgTopConstraint2 = btnMessage.topAnchor.constraint(equalTo: btnNetwork.bottomAnchor, constant: 94)
        mssgTopConstraint1?.isActive = true
        btnMessage.addTarget(self, action: #selector(goToMessages), for: .touchUpInside)
        
        //Profile
        let profileIcon = UIButton()
        scrollViewBase.addSubview(profileIcon)
        profileIcon.translatesAutoresizingMaskIntoConstraints = false
        let profileImage = UIImage(named: "ic_profile")
        let profileTint = profileImage?.withRenderingMode(.alwaysTemplate)
        profileIcon.setImage(profileTint, for: .normal)
        profileIcon.tintColor = UIColor.white
        profileIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        profileIcon.topAnchor.constraint(equalTo: mssgIcon.bottomAnchor, constant: 20).isActive = true
        profileIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        profileIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        profileIcon.addTarget(self, action: #selector(goToProfile), for: .touchUpInside)
        //Top up
        let btnProfile = UIButton()
        scrollViewBase.addSubview(btnProfile)
        btnProfile.translatesAutoresizingMaskIntoConstraints = false
        btnProfile.setTitle("My profile", for: .normal)
        btnProfile.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnProfile.setTitleColor(UIColor.white, for: .normal)
        btnProfile.leadingAnchor.constraint(equalTo: profileIcon.trailingAnchor, constant: 16).isActive = true
        btnProfile.topAnchor.constraint(equalTo: btnMessage.bottomAnchor, constant: 25).isActive = true
        btnProfile.addTarget(self, action: #selector(goToProfile), for: .touchUpInside)
        
        //Settings
        let settingsIcon = UIButton()
        scrollViewBase.addSubview(settingsIcon)
        settingsIcon.translatesAutoresizingMaskIntoConstraints = false
        let settingsImage = UIImage(named: "ic_settings")
        let settingsTint = settingsImage?.withRenderingMode(.alwaysTemplate)
        settingsIcon.setImage(settingsTint, for: .normal)
        settingsIcon.tintColor = UIColor.white
        settingsIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        settingsIcon.topAnchor.constraint(equalTo: profileIcon.bottomAnchor, constant: 20).isActive = true
        settingsIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        settingsIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        settingsIcon.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        //Settings
        let btnSettings = UIButton()
        scrollViewBase.addSubview(btnSettings)
        btnSettings.translatesAutoresizingMaskIntoConstraints = false
        btnSettings.setTitle("Settings", for: .normal)
        btnSettings.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnSettings.setTitleColor(UIColor.white, for: .normal)
        btnSettings.leadingAnchor.constraint(equalTo: settingsIcon.trailingAnchor, constant: 16).isActive = true
        btnSettings.topAnchor.constraint(equalTo: btnProfile.bottomAnchor, constant: 25).isActive = true
        btnSettings.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        
        //About
        let aboutIcon = UIButton()
        scrollViewBase.addSubview(aboutIcon)
        aboutIcon.translatesAutoresizingMaskIntoConstraints = false
        let aboutImage = UIImage(named: "ic_info")
        let aboutTint = aboutImage?.withRenderingMode(.alwaysTemplate)
        aboutIcon.setImage(aboutTint, for: .normal)
        aboutIcon.tintColor = UIColor.white
        aboutIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        aboutIcon.topAnchor.constraint(equalTo: settingsIcon.bottomAnchor, constant: 20).isActive = true
        aboutIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        aboutIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        aboutIcon.addTarget(self, action: #selector(goToAbout), for: .touchUpInside)
        //About
        let btnAbout = UIButton()
        scrollViewBase.addSubview(btnAbout)
        btnAbout.translatesAutoresizingMaskIntoConstraints = false
        btnAbout.setTitle("About", for: .normal)
        btnAbout.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnAbout.setTitleColor(UIColor.white, for: .normal)
        btnAbout.leadingAnchor.constraint(equalTo: aboutIcon.trailingAnchor, constant: 16).isActive = true
        btnAbout.topAnchor.constraint(equalTo: btnSettings.bottomAnchor, constant: 25).isActive = true
        btnAbout.addTarget(self, action: #selector(goToAbout), for: .touchUpInside)
        
        //Logout
        let logoutIcon = UIButton()
        scrollViewBase.addSubview(logoutIcon)
        logoutIcon.translatesAutoresizingMaskIntoConstraints = false
        let logoutImage = UIImage(named: "ic_log_out")
        let logoutint = logoutImage?.withRenderingMode(.alwaysTemplate)
        logoutIcon.setImage(logoutint, for: .normal)
        logoutIcon.tintColor = UIColor.white
        logoutIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        logoutIcon.topAnchor.constraint(equalTo: aboutIcon.bottomAnchor, constant: 20).isActive = true
        logoutIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        logoutIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        logoutIcon.addTarget(self, action: #selector(goToLogout), for: .touchUpInside)
        //Logout
        let btnLogout = UIButton()
        scrollViewBase.addSubview(btnLogout)
        btnLogout.translatesAutoresizingMaskIntoConstraints = false
        btnLogout.setTitle("Logout", for: .normal)
        btnLogout.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnLogout.setTitleColor(UIColor.white, for: .normal)
        btnLogout.leadingAnchor.constraint(equalTo: logoutIcon.trailingAnchor, constant: 16).isActive = true
        btnLogout.topAnchor.constraint(equalTo: btnAbout.bottomAnchor, constant: 25).isActive = true
        btnLogout.addTarget(self, action: #selector(goToLogout), for: .touchUpInside)
    }
    
    @objc func closeMenu(){
        self.motherViewTrailing2?.isActive = false
        self.motherViewTrailing1?.isActive = true
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        menuShowing = !menuShowing
    }
    
    @objc func goToHome(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "homeVC")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToLogout(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "LogoutViewController") as! LogoutViewController
        
        self.addChildViewController(moveTo)
        moveTo.view.frame = self.view.frame
        self.view.addSubview(moveTo.view)
        moveTo.didMove(toParentViewController: self)
    }
    
    @objc func goToProducts(){
        let storyboard = UIStoryboard(name: "ProductsServices", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "ProductsServicesViewController")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToOffers(){
        let storyboard = UIStoryboard(name: "OffersExtras", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "OffersExtrasViewController")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToTopUpM(){
        let storyboard = UIStoryboard(name: "TopUp", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "TopUpViewController")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToTravelling(){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "OffersExtrasViewController")
        present(moveTo!, animated: true, completion: nil)
    }
    
    @objc func goToTwoFour(){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "supportVC")
        present(moveTo!, animated: true, completion: nil)
    }
    
    @objc func goToLocator(){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "OffersExtrasViewController")
        present(moveTo!, animated: true, completion: nil)
    }
    
    @objc func goToAbout(){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "AboutViewController")
        present(moveTo!, animated: true, completion: nil)
    }
    
    @objc func goToMessages(){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "OffersExtrasViewController")
        present(moveTo!, animated: true, completion: nil)
    }
    
    @objc func goToProfile(){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "OffersExtrasViewController")
        present(moveTo!, animated: true, completion: nil)
    }
    
    @objc func goToSettings(){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "OffersExtrasViewController")
        present(moveTo!, animated: true, completion: nil)
    }

    @objc func closeModalB(){
        self.view.removeFromSuperview()
    }
}
