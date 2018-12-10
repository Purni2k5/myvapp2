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
    var primaryIDB: String?
    var defaultAccNameB: String?
    var defaultMSISDNB: String?
    var dServiceBase: String?
    
    let kVersion = "CFBundleShortVersionString"
    let keyChainB = KeychainSwift()
    
    
    var mssgTopConstraint1: NSLayoutConstraint?
    var mssgTopConstraint2: NSLayoutConstraint?
    var mssgIconTop1: NSLayoutConstraint?
    var mssgIconTop2: NSLayoutConstraint?
    var isCheviClicked: Bool = false
    var motherViewTrailing1: NSLayoutConstraint?
    var motherViewTrailing2: NSLayoutConstraint?
    var menuShowing: Bool = false
    var networksShowing: Bool = false
    var btnProductsTop: NSLayoutConstraint!
    var pdtsImageTop: NSLayoutConstraint!
    
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
    let btnSpeedChecker = UIButton()
    let btnNetworkUsage = UIButton()
    let btnBBFinder = UIButton()
    let btnNetworkCov = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deviceOs = getDeviceOS()
        
        
        if let UserData = preference.object(forKey: "responseData") as! NSDictionary?{
            defaultService = UserData["DefaultService"] as? String
        }
        
        if let defaultServices = preference.object(forKey: UserDefaultsKeys.DefaultService.rawValue) as! String? {
            dServiceBase = defaultServices
            print("dService:: \(dServiceBase)")
        }else{
            //logout
//            print("Do this")
//            logout()
        }
        
        
//        print("yo:: \(defaultService)")
        let Services = preference.object(forKey: UserDefaultsKeys.ServiceList.rawValue)
//                print(Services)
        if let array = Services as? NSArray {
            var foundDefault = false
            print(foundDefault)
            for obj in array {
                if foundDefault == false{
                    if let dict = obj as? NSDictionary {
                        // Now reference the data you need using:
                        AcctType = dict.value(forKey: "Type") as! String?
                        
                        if(ServiceID == dServiceBase){
                            print("checked against \(defaultService)")
                            AcctType = dict.value(forKey: "Type") as! String?
                            foundDefault = true
                            print("Got it")
                            
                            
                        }else{
                            //Just pick one to display
                            //                            defaultAccName = dict.value(forKey: "DisplayName") as! String?
                            ServiceID = dict.value(forKey: "ID") as! String?
                            AcctType = dict.value(forKey: "Type") as! String?
                            //                            foundDefault = true
                        }
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
    
    func onlyAppVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let appVersion = dictionary[kVersion] as! String
        return appVersion
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
    
    @objc func showNetworks(){
        if networksShowing {
            hidesNetworks()
        }else{
            displayHiddenNetworks()
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        networksShowing = !networksShowing
    }
    
    func postPaidMenu(){
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
        scrollViewBase.contentSize.height = 900
        
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
        
        //Current spend icon
        let currentSpendIcon = UIImageView(image: #imageLiteral(resourceName: "current_spend"))
        scrollViewBase.addSubview(currentSpendIcon)
        currentSpendIcon.image = currentSpendIcon.image?.withRenderingMode(.alwaysTemplate)
        currentSpendIcon.tintColor = UIColor.white
        currentSpendIcon.translatesAutoresizingMaskIntoConstraints = false
        currentSpendIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        currentSpendIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        currentSpendIcon.topAnchor.constraint(equalTo: homeIcon.bottomAnchor, constant: 20).isActive = true
        currentSpendIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        //        btnHome.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
        //Current spend button
        let btnCurrentSpend = UIButton()
        scrollViewBase.addSubview(btnCurrentSpend)
        btnCurrentSpend.translatesAutoresizingMaskIntoConstraints = false
        btnCurrentSpend.setTitle("Current spend and bills", for: .normal)
        btnCurrentSpend.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnCurrentSpend.setTitleColor(UIColor.white, for: .normal)
        btnCurrentSpend.leadingAnchor.constraint(equalTo: homeIcon.trailingAnchor, constant: 16).isActive = true
        btnCurrentSpend.topAnchor.constraint(equalTo: btnHome.bottomAnchor, constant: 21).isActive = true
        btnCurrentSpend.addTarget(self, action: #selector(goToCurrentSpend), for: .touchUpInside)
        
        //Mobile icon
        let mobileIcon = UIButton()
        scrollViewBase.addSubview(mobileIcon)
        mobileIcon.translatesAutoresizingMaskIntoConstraints = false
        let mobileImage = UIImage(named: "ic_mobile")
        let mobileTintColor = mobileImage?.withRenderingMode(.alwaysTemplate)
        mobileIcon.setImage(mobileTintColor, for: .normal)
        mobileIcon.tintColor = UIColor.white
        mobileIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        pdtsImageTop = mobileIcon.topAnchor.constraint(equalTo: currentSpendIcon.bottomAnchor, constant: 20)
        pdtsImageTop.isActive = true
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
        btnProductsTop = btnPdt.topAnchor.constraint(equalTo: btnCurrentSpend.bottomAnchor, constant: 21)
        btnProductsTop.isActive = true
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
        btnTravel.setTitle("Smart Traveller", for: .normal)
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
        networkIcon.addTarget(self, action: #selector(showNetworks), for: .touchUpInside)
        //Network
        let btnNetwork = UIButton()
        scrollViewBase.addSubview(btnNetwork)
        btnNetwork.translatesAutoresizingMaskIntoConstraints = false
        btnNetwork.setTitle("Network", for: .normal)
        btnNetwork.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnNetwork.setTitleColor(UIColor.white, for: .normal)
        btnNetwork.leadingAnchor.constraint(equalTo: networkIcon.trailingAnchor, constant: 16).isActive = true
        btnNetwork.topAnchor.constraint(equalTo: btnLocator.bottomAnchor, constant: 24).isActive = true
        btnNetwork.addTarget(self, action: #selector(showNetworks), for: .touchUpInside)
        //Arrow down
        let chevron = UIButton()
        scrollViewBase.addSubview(chevron)
        chevron.translatesAutoresizingMaskIntoConstraints = false
        let chevImage = UIImage(named: "dropdown")
        let chevTint = chevImage?.withRenderingMode(.alwaysTemplate)
        chevron.setImage(chevTint, for: .normal)
        chevron.tintColor = UIColor.white
        chevron.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -20).isActive = true
        chevron.topAnchor.constraint(equalTo: btnLocator.bottomAnchor, constant: 26).isActive = true
        chevron.widthAnchor.constraint(equalToConstant: 30).isActive = true
        chevron.heightAnchor.constraint(equalToConstant: 20).isActive = true
        chevron.addTarget(self, action: #selector(showNetworks), for: .touchUpInside)
        
        //btn speed checker
        
        scrollViewBase.addSubview(btnSpeedChecker)
        btnSpeedChecker.translatesAutoresizingMaskIntoConstraints = false
        btnSpeedChecker.leadingAnchor.constraint(equalTo: locatorIcon.trailingAnchor, constant: 16).isActive = true
        btnSpeedChecker.topAnchor.constraint(equalTo: btnNetwork.bottomAnchor, constant: 13).isActive = true
        btnSpeedChecker.setTitle("Speed Checker", for: .normal)
        btnSpeedChecker.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnSpeedChecker.setTitleColor(UIColor.gray, for: .normal)
        btnSpeedChecker.isHidden = true
        btnSpeedChecker.addTarget(self, action: #selector(goToSpeedChecker), for: .touchUpInside)
        
        //btn network usage
        
        scrollViewBase.addSubview(btnNetworkUsage)
        btnNetworkUsage.translatesAutoresizingMaskIntoConstraints = false
        btnNetworkUsage.leadingAnchor.constraint(equalTo: locatorIcon.trailingAnchor, constant: 16).isActive = true
        btnNetworkUsage.topAnchor.constraint(equalTo: btnSpeedChecker.bottomAnchor, constant: 13).isActive = true
        btnNetworkUsage.setTitle("Network Usage", for: .normal)
        btnNetworkUsage.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnNetworkUsage.setTitleColor(UIColor.gray, for: .normal)
        btnNetworkUsage.isHidden = true
        
        //btn Broadband finder
        
        scrollViewBase.addSubview(btnBBFinder)
        btnBBFinder.translatesAutoresizingMaskIntoConstraints = false
        btnBBFinder.leadingAnchor.constraint(equalTo: locatorIcon.trailingAnchor, constant: 16).isActive = true
        btnBBFinder.topAnchor.constraint(equalTo: btnNetworkUsage.bottomAnchor, constant: 13).isActive = true
        btnBBFinder.setTitle("Broadband Finder", for: .normal)
        btnBBFinder.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnBBFinder.setTitleColor(UIColor.gray, for: .normal)
        btnBBFinder.isHidden = true
        
        //btn Network Coverage
        
        scrollViewBase.addSubview(btnNetworkCov)
        btnNetworkCov.translatesAutoresizingMaskIntoConstraints = false
        btnNetworkCov.leadingAnchor.constraint(equalTo: locatorIcon.trailingAnchor, constant: 16).isActive = true
        btnNetworkCov.topAnchor.constraint(equalTo: btnBBFinder.bottomAnchor, constant: 13).isActive = true
        btnNetworkCov.setTitle("Network Coverage", for: .normal)
        btnNetworkCov.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
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
        mssgIconTop2 = mssgIcon.topAnchor.constraint(equalTo: networkIcon.bottomAnchor, constant: 172)
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
        mssgTopConstraint2 = btnMessage.topAnchor.constraint(equalTo: btnNetwork.bottomAnchor, constant: 178)
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
        
        //Version
        let lblVersion = UILabel()
        scrollViewBase.addSubview(lblVersion)
        lblVersion.translatesAutoresizingMaskIntoConstraints = false
        lblVersion.text = "Version v. \(onlyAppVersion())"
        lblVersion.font = UIFont(name: String.defaultFontR, size: 19)
        lblVersion.textColor = UIColor.white
        lblVersion.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 63).isActive = true
        lblVersion.topAnchor.constraint(equalTo: btnLogout.bottomAnchor, constant: 30).isActive = true
        lblVersion.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -5).isActive = true
        lblVersion.numberOfLines = 0
        lblVersion.lineBreakMode = .byWordWrapping
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
        scrollViewBase.contentSize.height = 900
        
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
        pdtsImageTop = mobileIcon.topAnchor.constraint(equalTo: homeIcon.bottomAnchor, constant: 20)
        pdtsImageTop.isActive = true
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
        btnProductsTop = btnPdt.topAnchor.constraint(equalTo: btnHome.bottomAnchor, constant: 21)
        btnProductsTop.isActive = true
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
        btnTravel.setTitle("Smart Traveller", for: .normal)
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
        networkIcon.addTarget(self, action: #selector(showNetworks), for: .touchUpInside)
        //Network
        let btnNetwork = UIButton()
        scrollViewBase.addSubview(btnNetwork)
        btnNetwork.translatesAutoresizingMaskIntoConstraints = false
        btnNetwork.setTitle("Network", for: .normal)
        btnNetwork.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnNetwork.setTitleColor(UIColor.white, for: .normal)
        btnNetwork.leadingAnchor.constraint(equalTo: networkIcon.trailingAnchor, constant: 16).isActive = true
        btnNetwork.topAnchor.constraint(equalTo: btnLocator.bottomAnchor, constant: 24).isActive = true
        btnNetwork.addTarget(self, action: #selector(showNetworks), for: .touchUpInside)
        //Arrow down
        let chevron = UIButton()
        scrollViewBase.addSubview(chevron)
        chevron.translatesAutoresizingMaskIntoConstraints = false
        let chevImage = UIImage(named: "dropdown")
        let chevTint = chevImage?.withRenderingMode(.alwaysTemplate)
        chevron.setImage(chevTint, for: .normal)
        chevron.tintColor = UIColor.white
        chevron.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -20).isActive = true
        chevron.topAnchor.constraint(equalTo: btnLocator.bottomAnchor, constant: 26).isActive = true
        chevron.widthAnchor.constraint(equalToConstant: 30).isActive = true
        chevron.heightAnchor.constraint(equalToConstant: 20).isActive = true
        chevron.addTarget(self, action: #selector(showNetworks), for: .touchUpInside)
        
        //btn speed checker
        
        scrollViewBase.addSubview(btnSpeedChecker)
        btnSpeedChecker.translatesAutoresizingMaskIntoConstraints = false
        btnSpeedChecker.leadingAnchor.constraint(equalTo: locatorIcon.trailingAnchor, constant: 16).isActive = true
        btnSpeedChecker.topAnchor.constraint(equalTo: btnNetwork.bottomAnchor, constant: 13).isActive = true
        btnSpeedChecker.setTitle("Speed Checker", for: .normal)
        btnSpeedChecker.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnSpeedChecker.setTitleColor(UIColor.gray, for: .normal)
        btnSpeedChecker.isHidden = true
        btnSpeedChecker.addTarget(self, action: #selector(goToSpeedChecker), for: .touchUpInside)
        
        //btn network usage
        
        scrollViewBase.addSubview(btnNetworkUsage)
        btnNetworkUsage.translatesAutoresizingMaskIntoConstraints = false
        btnNetworkUsage.leadingAnchor.constraint(equalTo: locatorIcon.trailingAnchor, constant: 16).isActive = true
        btnNetworkUsage.topAnchor.constraint(equalTo: btnSpeedChecker.bottomAnchor, constant: 13).isActive = true
        btnNetworkUsage.setTitle("Network Usage", for: .normal)
        btnNetworkUsage.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnNetworkUsage.setTitleColor(UIColor.gray, for: .normal)
        btnNetworkUsage.isHidden = true
        
        //btn Broadband finder
        
        scrollViewBase.addSubview(btnBBFinder)
        btnBBFinder.translatesAutoresizingMaskIntoConstraints = false
        btnBBFinder.leadingAnchor.constraint(equalTo: locatorIcon.trailingAnchor, constant: 16).isActive = true
        btnBBFinder.topAnchor.constraint(equalTo: btnNetworkUsage.bottomAnchor, constant: 13).isActive = true
        btnBBFinder.setTitle("Broadband Finder", for: .normal)
        btnBBFinder.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnBBFinder.setTitleColor(UIColor.gray, for: .normal)
        btnBBFinder.isHidden = true
        
        //btn Network Coverage
        
        scrollViewBase.addSubview(btnNetworkCov)
        btnNetworkCov.translatesAutoresizingMaskIntoConstraints = false
        btnNetworkCov.leadingAnchor.constraint(equalTo: locatorIcon.trailingAnchor, constant: 16).isActive = true
        btnNetworkCov.topAnchor.constraint(equalTo: btnBBFinder.bottomAnchor, constant: 13).isActive = true
        btnNetworkCov.setTitle("Network Coverage", for: .normal)
        btnNetworkCov.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
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
        mssgIconTop2 = mssgIcon.topAnchor.constraint(equalTo: networkIcon.bottomAnchor, constant: 172)
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
        mssgTopConstraint2 = btnMessage.topAnchor.constraint(equalTo: btnNetwork.bottomAnchor, constant: 178)
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
        
        //Version
        let lblVersion = UILabel()
        scrollViewBase.addSubview(lblVersion)
        lblVersion.translatesAutoresizingMaskIntoConstraints = false
        lblVersion.text = "Version v. \(onlyAppVersion())"
        lblVersion.font = UIFont(name: String.defaultFontR, size: 19)
        lblVersion.textColor = UIColor.white
        lblVersion.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 63).isActive = true
        lblVersion.topAnchor.constraint(equalTo: btnLogout.bottomAnchor, constant: 30).isActive = true
        lblVersion.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -5).isActive = true
        lblVersion.numberOfLines = 0
        lblVersion.lineBreakMode = .byWordWrapping
    }
    
    func logout(){
        
        preference.removeObject(forKey: UserDefaultsKeys.loginStatus.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.responseData.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.staffNumber.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.staffCreditData.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.Plan.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.Data.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.defaultMSISDN.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.RESPONSEMESSAGE.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.FBBLINKEDNUMBER.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.FBBACTKEY.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.FBBUSERID.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.BBPACKAGES.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.FBBUSERACCOUNT.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.DefaultService.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.accountBalance.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.accBalanceLabel.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.balanceLabel.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.ROAMINGS.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.ServiceList.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.userSubscriberSummary.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.isGaugeVisible.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.lastUpdate.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.shakeBundles.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.shakeBundlesOther.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.userSession.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.userSecret.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.userKey.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.requestKey.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.defaultName.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.TOTALINITIAL.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.BB_LastUpdate.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.BB_HOME_PERCENTAGE.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.P_CURRENTVOL.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.adslBalance.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.P_ADVANCEPAYMENT.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.P_PLANNAME.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.BB_accountUsageDet.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.postPaidOutBill.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.postPaidBreakDown.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.isSensitiveDataAllowed.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.postPaidCurrentSpend.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.postPaidBillHistory.rawValue)
        let Services = preference.object(forKey: UserDefaultsKeys.ServiceList.rawValue)
        if let array = Services as? NSArray {
            for obj in array {
                if let dict = obj as? NSDictionary {
                    
                    let displayNumber = dict.value(forKey: "primaryID") as! String
                    let userNumber = displayNumber.dropFirst(3)
                    let firstPin = "0\(userNumber)"
                    preference.removeObject(forKey: "\(firstPin)_topUpHistory")
                    preference.removeObject(forKey: "\(firstPin)_serviceBreakDown")
                }
            }
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func closeMenu(){
        self.motherViewTrailing2?.isActive = false
        self.motherViewTrailing1?.isActive = true
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        menuShowing = !menuShowing
    }
    
    func convertMBTOKB(passed: Double) -> Double{
        let convertValue = passed * 1024
        return convertValue
    }
    
    func convertGBTOKB(passed: Double) -> Double{
        let convertValue = passed * 1024 * 1024
        return convertValue
    }
    
    func greetings() -> String{
        var time: String = "Unknown"
        let now = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: now as Date)
        let hourInt = Int(currentHour.description)!
        if hourInt >= 0 && hourInt <= 11 {
            time = "morning"
        }else if hourInt >= 12 && hourInt <= 15 {
            time = "afternoon"
        }else{
            time = "evening"
        }
        return time
    }
    
    // Get today date as String
    func getTodayString() -> String{
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EE"
        let dayInWeek = formatter.string(from: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLL"
        let strMonth = dateFormatter.string(from: date)
        let today_string = String(dayInWeek) + "," + String(day!) + " " + String(strMonth) + " " + String(year!)  + " " + String(hour!) + ":" +  String(minute!) + ":" + String(second!)
        
        return today_string
        
    }
    
    @objc func goToHome(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "homeVC")
        present(moveTo, animated: true, completion: nil)
//        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
//        let moveTo = storyboard.instantiateViewController(withIdentifier: "RateUs")
//        self.addChildViewController(moveTo)
//        moveTo.view.frame = self.view.frame
//        self.view.addSubview(moveTo.view)
//        moveTo.didMove(toParentViewController: self)
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
        let storyboard = UIStoryboard(name: "Roaming", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "SmartTraveller")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToTwoFour(){
        let storyboard = UIStoryboard(name: "Support", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "supportVC")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToLocator(){
        let storyboard = UIStoryboard(name: "StoreLocator", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "StoreLocatorVc")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToAbout(){
        let storyboard = UIStoryboard(name: "About", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "AboutViewController")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToMessages(){
        let storyboard = UIStoryboard(name: "Messages", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "Messages")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToProfile(){
        let storyboard = UIStoryboard(name: "ProductsServices", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "ProductsServicesViewController")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToSettings(){
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "SettingsVc")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToTipsB(){
        let storyboard = UIStoryboard(name: "Roaming", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "RoamingTips")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToTC(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "About", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "TermsConditionsViewController")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToPrivacyPolicy(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "About", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "PrivacyPolicyViewController")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToSpeedChecker(_sender: UITapGestureRecognizer){
//        let storyboard = UIStoryboard(name: "NetPerform", bundle: nil)
//        let moveTo = storyboard.instantiateViewController(withIdentifier: "speedChecker")
//        present(moveTo, animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "TopUp", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "FreeSHS")
        self.addChildViewController(moveTo)
        moveTo.view.frame = self.view.frame
        self.view.addSubview(moveTo.view)
        moveTo.didMove(toParentViewController: self)
    }
    
    @objc func goToLogin(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToFBBM(){
        let storyboard = UIStoryboard(name: "OffersExtras", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "displayChosenOfferVc") as? displayChosenOfferVc else { return }
        moveTo.selectedOffer = "FBB"
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func openRatings(){
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "RateUs")
        self.addChildViewController(moveTo)
        moveTo.view.frame = self.view.frame
        self.view.addSubview(moveTo.view)
        moveTo.didMove(toParentViewController: self)

    }
    
    @objc func goToCurrentSpend(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "PostPaid", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "currentSpendsBills")
        present(moveTo, animated: true, completion: nil)
    }
    
    func showRatings(){
        print("Showing ratings")
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "RateUs")
        self.addChildViewController(moveTo)
        moveTo.view.frame = self.view.frame
        self.view.addSubview(moveTo.view)
        moveTo.didMove(toParentViewController: self)

    }

    @objc func closeModalB(){
        self.view.removeFromSuperview()
    }
    
    @objc func openAppStore() {
        
        if let url = URL(string: "https://itunes.apple.com/us/app/my-vodafone-ghana/id1440915381?ls=1&mt=8"),
            UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:]) { (opened) in
                if(opened){
                    print("App Store Opened")
                    self.preference.set(true, forKey: UserDefaultsKeys.hasRated.rawValue)
                    self.closeModalB()
                }
            }
        } else {
            print("Can't Open URL on Simulator")
        }
    }
    
    func displayHiddenNetworks(){
        mssgIconTop1?.isActive = false
        mssgIconTop2?.isActive = true
        mssgTopConstraint1?.isActive = false
        mssgTopConstraint2?.isActive = true
        btnSpeedChecker.isHidden = false
        btnNetworkUsage.isHidden = false
        btnBBFinder.isHidden = false
        btnNetworkCov.isHidden = false
        scrollViewBase.contentSize.height = 900
    }
    func hidesNetworks(){
        mssgIconTop2?.isActive = false
        mssgIconTop1?.isActive = true
        mssgTopConstraint2?.isActive = false
        mssgTopConstraint1?.isActive = true
        btnSpeedChecker.isHidden = true
        btnNetworkUsage.isHidden = true
        btnBBFinder.isHidden = true
        btnNetworkCov.isHidden = true
        scrollViewBase.contentSize.height = 750
    }
    func displayNoInternet() {
        let storyboard = UIStoryboard(name: "Support", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "NointernetViewController") as! NointernetViewController
        
        self.addChildViewController(moveTo)
        moveTo.view.frame = self.view.frame
        self.view.addSubview(moveTo.view)
        moveTo.didMove(toParentViewController: self)
    }
    
    //Hashing of password
    //Hashing function
    func md5Base(_ string: String) -> String {
        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
        var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5_Init(context)
        CC_MD5_Update(context, string, CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8)))
        CC_MD5_Final(&digest, context)
        context.deallocate(capacity: 1)
        var hexString = ""
        for byte in digest {
            hexString += String(format:"%02x", byte)
        }
        return hexString
    }
    
    //key hardening
    func keyHardening(){
        let userSession = preference.object(forKey: UserDefaultsKeys.userSession.rawValue) as! String
        let userSecret = preference.object(forKey: UserDefaultsKeys.userSecret.rawValue) as! String
        let userKey = preference.object(forKey: UserDefaultsKeys.userKey.rawValue) as! String
        var secretKey =  userKey+userSession+userSecret
        secretKey = md5Base(secretKey)
        print("FirstKEY: \(secretKey)")
        secretKey = String(secretKey.prefix(16))
        print("secretKey: \(secretKey)")
        preference.set(secretKey, forKey: UserDefaultsKeys.requestKey.rawValue)
    }
    
    //Harden my request
    func encryptAsyncRequest(requestBody: String) -> String{
        guard let secretKey = preference.object(forKey: UserDefaultsKeys.requestKey.rawValue) as? String else{
            print("logging out")
//            logout()
            
            return ""
            
        }
        
        let cipher:String = CryptoHelper.encrypt(input:requestBody, userKey: secretKey)!;
        
        return cipher
    }
    
    func decryptAsyncRequest(requestBody: String) -> String{
        if let secretKey = preference.object(forKey: UserDefaultsKeys.requestKey.rawValue) as? String {
            guard let cipher:String = CryptoHelper.decrypt(input:requestBody, userKey: secretKey) else {
//                logout()
                return ""
            }
            return cipher
        }else{
//            logout()
            return ""
        }
        
        
        
        
    }
    
    
    
    //Function to convert String to NSDictionary
    func convertToNSDictionary(decrypt: String)-> NSDictionary{
        var dictonary:NSDictionary?
        
        if let data = decrypt.data(using: String.Encoding.utf8){
            
            do {
                dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] as! NSDictionary
                
                if let myDictionary = dictonary
                {
                    
                    return myDictionary
                }
            } catch let error as NSError {
                print(error)
            }
        }
        return [:]
    }
    
    func clearLogout(){
        preference.removeObject(forKey: "loginStatus")
        preference.removeObject(forKey: "responseData")
        preference.removeObject(forKey: "staffNumber")
        preference.removeObject(forKey: "staffCreditData")
        preference.removeObject(forKey: "Plan")
        preference.removeObject(forKey: "Data")
        preference.removeObject(forKey: "defaultMSISDN")
        preference.removeObject(forKey: "RESPONSEMESSAGE")
        preference.removeObject(forKey: "FBBLINKEDNUMBER")
        preference.removeObject(forKey: "FBBACTKEY")
        preference.removeObject(forKey: "FBBUSERID")
        preference.removeObject(forKey: "BBPACKAGES")
        preference.removeObject(forKey: "FBBUSERACCOUNT")
        preference.removeObject(forKey: "DefaultService")
        preference.removeObject(forKey: "accountBalance")
        preference.removeObject(forKey: "accBalanceLabel")
        preference.removeObject(forKey: "balanceLabel")
        preference.removeObject(forKey: "ROAMINGS")
        preference.removeObject(forKey: UserDefaultsKeys.userSubscriberSummary.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.isGaugeVisible.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.lastUpdate.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.shakeBundles.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.shakeBundlesOther.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.userSession.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.userSecret.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.userKey.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.requestKey.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.defaultName.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.adslBalance.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.BB_Plan.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.BB_accountUsageDet.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.postPaidOutBill.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.postPaidBreakDown.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.isSensitiveDataAllowed.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.postPaidCurrentSpend.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.postPaidBillHistory.rawValue)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        present(moveTo, animated: true, completion: nil)
    }
    
    func loginToAccount(url: URL, password: String, username: String){
        let request = NSMutableURLRequest(url: url)
        
        
        request.httpMethod = "POST"
        
        
        
        let postParameters:Dictionary<String, Any> = [
            "username":username,
            "password":password,
            "action":"loginToAccount",
            "os":getAppVersion()
        ]
        if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
            request.httpBody = postData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            //creating a task to send the post request
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                if error != nil{
                    print("error is \(error!.localizedDescription)")
                    DispatchQueue.main.async {
                        //Todo
                        //go to Login screen
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let moveTo = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                        self.present(moveTo, animated: true, completion: nil)
                    }
                    return;
                }
                //parsing the response
                do{
                    //converting response to NSDictionary
                    let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    //parsing the json
                    if let parseJSON = myJSON {
                        print("here")
                        //creating variables to hold response
                        var responseCode: Int!
                        var responseMessage: String!
                        var responseData: NSDictionary!
                        var responseSession: NSDictionary!
                        print(parseJSON)
                        //getting the json response
                        responseCode = parseJSON["RESPONSECODE"] as! Int?
                        responseMessage = parseJSON["RESPONSEMESSAGE"] as! String?
                        responseData = parseJSON["RESPONSEDATA"] as! NSDictionary?
                        responseSession = parseJSON["SESSION"] as! NSDictionary?
                        
                        if responseData != nil {
                            self.preference.set(responseData["ServiceList"] as! NSArray, forKey: UserDefaultsKeys.ServiceList.rawValue)
                            let obj = responseData["AccountStatus"] as! String
                            let Services = self.preference.object(forKey: UserDefaultsKeys.ServiceList.rawValue)
                            let default_service = responseData["DefaultService"] as! String
                            self.preference.set(default_service, forKey: "DefaultService")
                            let defaultService = self.preference.object(forKey: "DefaultService") as! String
                            if let array = Services as? NSArray {
                                var foundDefault = false
                                
                                for obj in array {
                                    if foundDefault == false{
                                        if let dict = obj as? NSDictionary {
                                            // Now reference the data you need using:
                                            self.ServiceID = dict.value(forKey: "ID") as! String?
                                            self.AcctType = dict.value(forKey: "Type") as! String?
                                            
                                            if(self.ServiceID == defaultService){
                                                self.defaultAccNameB = dict.value(forKey: "DisplayName") as! String?
                                                self.primaryIDB = dict.value(forKey: "primaryID") as! String?
                                                self.AcctType = dict.value(forKey: "Type") as! String?
                                                foundDefault = true
                                                print("Got it")
                                            }else{
                                                print("this happened")
                                                //Just pick one to display
                                                self.defaultAccNameB = dict.value(forKey: "DisplayName") as! String?
                                                self.ServiceID = dict.value(forKey: "ID") as! String?
                                                self.AcctType = dict.value(forKey: "Type") as! String?
                                                self.primaryIDB = dict.value(forKey: "primaryID") as! String?
                                                //                                                self.preference.set(self.ServiceID, forKey: "DefaultService")
                                                //                            foundDefault = true
                                            }
                                        }
                                    }
                                    
                                }
                            }
                            //                            print("Primary ID:: \(self.primaryID!)")
                            //                            print("Display Name:: \(self.defaultAccName!)")
                            let defaultNum = self.primaryIDB?.dropFirst(3)
                            self.primaryIDB = "0\(defaultNum!)"
                            self.preference.set(self.primaryIDB, forKey: "defaultMSISDN")
                            self.preference.set(self.defaultAccNameB, forKey: UserDefaultsKeys.defaultName.rawValue)
                            self.preference.set(self.ServiceID, forKey: UserDefaultsKeys.defaultName.rawValue)
                            print("Account stat: \(obj)")
                            
                            let session = responseSession["session"] as! String
                            let secret = responseSession["secret"] as! String
                            let key = responseSession["key"] as! String
                            
                            //Save secrets
                            self.preference.set(session, forKey: UserDefaultsKeys.userSession.rawValue)
                            self.preference.set(secret, forKey: UserDefaultsKeys.userSecret.rawValue)
                            self.preference.set(key, forKey: UserDefaultsKeys.userKey.rawValue)
                        }
                        
                        
                        print(responseCode)
                        print("-------------- response data -------------")
                        
                        //                        self.stopAsyncLoader()
                        DispatchQueue.main.async { // Correct
                            if responseCode == 0{
                                
//                                self.stop_activity_loader()
                                self.preference.set("Yes", forKey: "loginStatus")
                                self.preference.set(responseData, forKey: "responseData")
                                
                                self.keyChainB.set(password, forKey: keyChainKeys.secretPassword.rawValue)
                                self.keyChainB.set(username, forKey: keyChainKeys.secretUser.rawValue)
                                self.keyHardening()
                                
                                if(self.AcctType == "PHONE_MOBILE_PRE_P"){
                                    //go to home screen
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let moveTo = storyboard.instantiateViewController(withIdentifier: "homeVC")
                                    self.present(moveTo, animated: true, completion: nil)
                                }else if(self.AcctType == "PHONE_MOBILE_POST_P"){
                                    //go to home screen
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let moveTo = storyboard.instantiateViewController(withIdentifier: "homeVC")
                                    self.present(moveTo, animated: true, completion: nil)
                                }else if(self.AcctType == "PHONE_MOBILE_HYBRID"){
                                    //go to home screen
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let moveTo = storyboard.instantiateViewController(withIdentifier: "homeVC")
                                    self.present(moveTo, animated: true, completion: nil)
                                }else{
                                    print("fbb here")
                                    //go to home screen
                                    let storyboard = UIStoryboard(name: "Broadband", bundle: nil)
                                    let moveTo = storyboard.instantiateViewController(withIdentifier: "broadbandHome")
                                    self.present(moveTo, animated: true, completion: nil)
                                }
                                
                            }else{
                                print("Was zero \(responseCode)")
//                                self.stop_activity_loader()
                                //display error message
//                                self.errorDialog.isHidden = false
//                                self.lblErrorMessage.text = responseMessage
//                                self.lblUsernameTop?.constant = 90
//                                self.darkViewHeight?.constant = 660
//                                self.scrollView.contentSize.height = (self.lblHeader.frame.size.height + self.darkView.frame.size.height) + 90
                            }
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
//                        self.stop_activity_loader()
//                        //display error message
//                        self.errorDialog.isHidden = false
//                        self.lblErrorMessage.text = error.localizedDescription
//                        self.lblUsernameTop?.constant = 90
//                        self.darkViewHeight?.constant = 660
//                        self.scrollView.contentSize.height = (self.lblHeader.frame.size.height + self.darkView.frame.size.height) + 90
                    }
                    print(error)
                }
            }
            //executing the task
            task.resume()
        }
        
    }
}
