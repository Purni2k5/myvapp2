//
//  broadbandHome.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 19/10/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit
import FSPagerView

class broadbandHome: baseViewControllerM, FSPagerViewDataSource, FSPagerViewDelegate {
    var defaultImageUrl: String?
    var defaultAccName: String?
    var msisdn: String?
    var username: String?
    var defaultMSISDN: String?
    var primaryID: String?
    var accountBalance: String?
    var balanceLabel: String?
    var accountBalanceLabel: String?
    var dService: String?
    
    var fontSizeForCredit: CGFloat = 30
    var fontSizeForCreditTitle: CGFloat = 19
    
    let defaultAccImage = UIImageView()
    let defaultCallCreditView = UIView()
    let lblCreditTitle = UILabel()
    let lblCreditRem = UILabel()
    let defaultAccDisName = UILabel()
    let yendiagoro = UIImageView()
    let twoFourSeven = UIImageView()
    let updateIcon = UIButton()
    let lblLastUpdatedStatus = UILabel()
    let lblShakeHeader = UILabel()
    let btnTopUp = UIButton()
    let shakeImage = UIImageView()
    let pagerView = FSPagerView()
    let lblShakeDesc = UILabel()
    let shakeButton = UIButton()
    
    let scrollView = UIScrollView()
    let greetingsRed = UIImageView()
    let lblGreetings = UILabel()
    let lblWelcome = UILabel()
    let keyChain = KeychainSwift()
    
    let gaugeViewHolder = UIView()
    let lblGaugeViewTitle = UILabel()
    let lblGaugeViewLeft = UILabel()
    let lblGaugeActualValue = UILabel()
    
    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    
    var isMade4MePresent: Bool = false
    var isGaugeVisible: Bool = false
    
    fileprivate var imageNames = ["bubble2"]
    fileprivate var defaultImageTopConstraint1: NSLayoutConstraint?
    fileprivate var defaultImageTopConstraint2: NSLayoutConstraint?
    
    fileprivate var defaultCallCreditViewTop1: NSLayoutConstraint?
    fileprivate var defaultCallCreditViewTop2: NSLayoutConstraint?
    
    fileprivate var defaultCallCreditViewLeading1: NSLayoutConstraint?
    fileprivate var defaultCallCreditViewLeading2: NSLayoutConstraint?
    
    fileprivate var defaultCallCreditViewTrailing1: NSLayoutConstraint?
    fileprivate var defaultCallCreditViewTrailing2: NSLayoutConstraint?
    fileprivate var btnTopWidth: NSLayoutConstraint?
    fileprivate var btnTopHeight: NSLayoutConstraint?
    fileprivate var btnTopUpTopConstraint1: NSLayoutConstraint?
    fileprivate var btnTopUpTopConstraint2: NSLayoutConstraint?
    fileprivate var btnTopUpTrailingConstraint1: NSLayoutConstraint?
    fileprivate var btnTopUpTrailingConstraint2: NSLayoutConstraint?
    
    fileprivate var defaultCallViewHeight: NSLayoutConstraint?
    
    fileprivate var yendiAgoroTop1: NSLayoutConstraint?
    fileprivate var yendiAgoroTop2: NSLayoutConstraint?
    fileprivate var supportTop1: NSLayoutConstraint?
    fileprivate var supportTop2: NSLayoutConstraint?
    
    //Variables for gauge
    var gloBucketType: String?
    
    var dataActualUnit: String?
    var dataActualValue: String?
    var dataBucketUnit: String?
    var dataBucketValue: String?
    var dataPercentUsed: String?
    var dataUnit: String?
    
    var smsActualUnit: String?
    var smsActualValue: String?
    var smsBucketUnit: String?
    var smsBucketValue: String?
    var smsPercentUsed: String?
    var smsUnit: String?
    
    var callsActualUnit: String?
    var callsActualValue: String?
    var callsBucketUnit: String?
    var callsBucketValue: String?
    var callsPercentUsed: String?
    var callsUnit: String?
    
    var callsActualValueSum: Int = 0
    var callsBucketValueSum: Double = 0
    var percentageCallsSum: Double = 0
    var dataActualValueSum: Double = 0
    var dataBucketValueSum: Double = 0
    
    var actualValueToKB: Double = 0
    var bucketValueToKB: Double = 0
    var dataActualInKB: Double = 0
    var dataBucketInKB: Double = 0
    
    var gaugeTracker = 0
    var gaugeViewPromotion: String?
    var gaugeViewExpirationDuration: String?
    var gaugeViewRawExpirationDuration: String?
    
    var lastUpdate: String?
    
    let btnOffers: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.white
        let btnImage = UIImage(named: "top_up")
        btn.setImage(btnImage, for: .normal)
        btn.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15)
        btn.addTarget(self, action: #selector(goToTopUp), for: .touchUpInside)
        return btn
    }()
    
    let btnGoFBB: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        let btnImage = UIImage(named: "fbb")
        btn.setImage(btnImage, for: .normal)
        //        btn.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15)
        btn.addTarget(self, action: #selector(goToFBBM), for: .touchUpInside)
        return btn
    }()
    
    let btnDataIcon: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.white
        let btnImage = UIImage(named: "data_icon")
        let tintImage = btnImage?.withRenderingMode(.alwaysTemplate)
        btn.setImage(tintImage, for: .normal)
        btn.tintColor = UIColor.gray
        
        return btn
    }()
    
    let btnSMSIcon: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        let btnImage = UIImage(named: "sms")
        let tintImage = btnImage?.withRenderingMode(.alwaysTemplate)
        btn.setImage(tintImage, for: .normal)
        btn.tintColor = UIColor.white
        
        return btn
    }()
    
    let btnCallDataIcon: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let btnImage = UIImage(named: "call_icon")
        let tintImage = btnImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintImage, for: .normal)
        button.tintColor = UIColor.white
        
        return button
    }()
    
    let lblPlan: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontB, size: 20)
        return view
    }()
    
    let lblPlanMessage: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.vodaRed
        view.text = ""
        view.font = UIFont(name: String.defaultFontB, size: 13)
        return view
    }()
    
    let lblPlanExpiration = UILabel()
    
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
    let pageControl = FSPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zeroAlpha()
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        print(UserData)
        
        
        if let defaultService = preference.object(forKey: UserDefaultsKeys.DefaultService.rawValue) as! String? {
            dService = defaultService
        }else{
            //logout
            print("Do this")
            logout()
        }
        username = UserData["Username"] as! String?
        msisdn = preference.object(forKey: "defaultMSISDN") as! String?
        balanceLabel = preference.object(forKey: "balanceLabel") as! String?
        accountBalanceLabel = preference.object(forKey: "accBalanceLabel") as! String?
        lastUpdate = preference.object(forKey: UserDefaultsKeys.lastUpdate.rawValue) as! String?
        
        
        let Services = preference.object(forKey: UserDefaultsKeys.ServiceList.rawValue)
        //        print(Services)
        if let array = Services as? NSArray {
            var foundDefault = false
            print(foundDefault)
            for obj in array {
                if foundDefault == false{
                    if let dict = obj as? NSDictionary {
                        // Now reference the data you need using:
                        ServiceID = dict.value(forKey: "ID") as! String?
                        AcctType = dict.value(forKey: "Type") as! String?
                        
                        if(ServiceID == defaultService){
                            defaultAccName = dict.value(forKey: "DisplayName") as! String?
                            primaryID = dict.value(forKey: "primaryID") as! String?
                            AcctType = dict.value(forKey: "Type") as! String?
                            foundDefault = true
                            print("Got it")
                            
                        }else{
                            //Just pick one to display
                            defaultAccName = dict.value(forKey: "DisplayName") as! String?
                            ServiceID = dict.value(forKey: "ID") as! String?
                            AcctType = dict.value(forKey: "Type") as! String?
                            primaryID = dict.value(forKey: "primaryID") as! String?
                            //                            foundDefault = true
                        }
                    }
                }
                
            }
        }
        
        setUpViews1()
//        backgroundCalls()
        
        
        // Check for internet connection
        checkConnection()
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
    }
    
    
    
    override func viewDidLayoutSubviews() {
        
        defaultAccImage.layer.cornerRadius = defaultAccImage.frame.size.width / 2
        defaultAccImage.clipsToBounds = true
        defaultAccImage.layer.borderColor = UIColor.white.cgColor
        defaultAccImage.layer.borderWidth = 2
        
        //topup button
        
    }
    
    func showSlider(){
        pagerView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.pagerView.transform = .identity
        }) { (success) in
            self.showCredit()
        }
        self.pagerView.alpha = 1
        self.lblShakeHeader.alpha = 1
        self.lblShakeDesc.alpha = 1
        self.shakeButton.alpha = 1
        
    }
    
    func showCredit(){
        defaultCallCreditView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.defaultCallCreditView.transform = .identity
        }) { (success) in
            self.showYendiAgoro()
        }
        self.defaultCallCreditView.alpha = 1
        self.lblCreditTitle.alpha = 1
        self.lblCreditRem.alpha = 1
        self.btnTopUp.alpha = 1
        
    }
    
    
    func showLastUpdate() {
        UIView.animate(withDuration: 1, animations: {
            self.lblLastUpdatedStatus.alpha = 1
            self.updateIcon.alpha = 1
        }) { (true) in
            self.showYendiAgoro()
            //            self.showTwoFourSeven()
        }
    }
    
    func showYendiAgoro(){
        yendiagoro.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        twoFourSeven.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 2, options: [], animations: {
            self.yendiagoro.transform = .identity
            self.twoFourSeven.transform = .identity
        }) { (success) in
            
        }
        self.yendiagoro.alpha = 1
        self.twoFourSeven.alpha = 1
        
    }
    
    
    func setUpViews1(){
        print("You are in bb")
        let bgImage = UIImageView()
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bgImage)
        let timeOfDay = greetings()
        if timeOfDay == "morning"{
            bgImage.image = UIImage(named: "morning_bg_")
        }else if timeOfDay == "afternoon" {
            bgImage.image = UIImage(named: "bg_afternoon")
        }else{
            bgImage.image = UIImage(named: "evening_bg_")
        }
        
        bgImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bgImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bgImage.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        bgImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        let motherView = UIView()
        motherView.translatesAutoresizingMaskIntoConstraints = false
        motherView.backgroundColor = UIColor.clear
        view.addSubview(motherView)
        motherView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        motherView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        motherView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        motherView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.clear
        motherView.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: motherView.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: motherView.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: motherView.safeTopAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: motherView.safeBottomAnchor).isActive = true
        
        //app logo
        let app_logo = UIImageView(image: #imageLiteral(resourceName: "voda_logo"))
        scrollView.addSubview(app_logo)
        app_logo.translatesAutoresizingMaskIntoConstraints = false
        app_logo.heightAnchor.constraint(equalToConstant: 48).isActive = true
        app_logo.widthAnchor.constraint(equalToConstant: 48).isActive = true
        app_logo.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10).isActive = true
        app_logo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        
        //Menu image
        let vcHamburger = UIButton()
        vcHamburger.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(vcHamburger)
        let hamburgerImage = UIImage(named: "menu")
        vcHamburger.setImage(hamburgerImage, for: .normal)
        vcHamburger.widthAnchor.constraint(equalToConstant: 40).isActive = true
        vcHamburger.heightAnchor.constraint(equalToConstant: 40).isActive = true
        vcHamburger.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        vcHamburger.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -10).isActive = true
        vcHamburger.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        
        //Menu label
        let lblMenu = UILabel()
        scrollView.addSubview(lblMenu)
        lblMenu.translatesAutoresizingMaskIntoConstraints = false
        lblMenu.textColor = UIColor.white
        lblMenu.text = "MENU"
        lblMenu.font = UIFont(name: String.defaultFontR, size: 13)
        lblMenu.topAnchor.constraint(equalTo: vcHamburger.bottomAnchor, constant: -3).isActive = true
        lblMenu.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -14).isActive = true
        
        
        
        //Pager view
        scrollView.addSubview(pagerView)
        pagerView.translatesAutoresizingMaskIntoConstraints = false
        pagerView.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 20).isActive = true
        pagerView.topAnchor.constraint(equalTo: app_logo.bottomAnchor, constant: 10).isActive = true
        pagerView.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -20).isActive = true
        pagerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        pagerView.contentMode = .scaleAspectFit
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerView.automaticSlidingInterval = 5.0
        pagerView.isInfinite = true
        pagerView.transformer = FSPagerViewTransformer(type: .zoomOut)
        
        // Create a page control
        scrollView.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.centerXAnchor.constraint(equalTo: motherView.centerXAnchor).isActive = true
        pageControl.topAnchor.constraint(equalTo: pagerView.bottomAnchor, constant: 20).isActive = true
        pageControl.numberOfPages = imageNames.count
        pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        
        scrollView.addSubview(defaultAccImage)
        
        
        
        if !isMade4MePresent {
            defaultAccImage.translatesAutoresizingMaskIntoConstraints = false
            defaultAccImage.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "default_profile"), options: [.continueInBackground, .progressiveDownload])
            
            defaultAccImage.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
            defaultImageTopConstraint1 = defaultAccImage.topAnchor.constraint(equalTo: pagerView.bottomAnchor, constant: 30)
            defaultImageTopConstraint1?.isActive = true
            
        }else{
            defaultImageTopConstraint2?.isActive = true
            print("Yes load local")
        }
        
        
        
        defaultAccImage.widthAnchor.constraint(equalToConstant: 90).isActive = true
        defaultAccImage.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        //account name
        scrollView.addSubview(defaultAccDisName)
        defaultAccDisName.translatesAutoresizingMaskIntoConstraints = false
        defaultAccDisName.textColor = UIColor.white
        defaultAccDisName.font = UIFont(name: String.defaultFontR, size: 20)
        let defaultAccNameArr = defaultAccName?.components(separatedBy: " ")
        
        defaultAccName = defaultAccNameArr?[0]
        let phoneTextIndex = defaultAccNameArr!.count - 1
        let phoneText = defaultAccNameArr?[phoneTextIndex]
        defaultAccDisName.text = "\(defaultAccName!) \n\(phoneText!)" //
        defaultAccDisName.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 40).isActive = true
        defaultAccDisName.topAnchor.constraint(equalTo: defaultAccImage.bottomAnchor, constant: 10).isActive = true
        defaultAccDisName.numberOfLines = 0
        defaultAccDisName.lineBreakMode = .byWordWrapping
        
        //Call credit view
        scrollView.addSubview(defaultCallCreditView)
        defaultCallCreditView.translatesAutoresizingMaskIntoConstraints = false
        defaultCallCreditView.backgroundColor = UIColor.white.withAlphaComponent(0.50)
        defaultCallCreditView.isOpaque = false
        defaultCallCreditViewLeading1 = defaultCallCreditView.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 45)
        defaultCallCreditViewLeading2 = defaultCallCreditView.widthAnchor.constraint(equalToConstant: 200)
        
        defaultCallCreditViewTrailing1 = defaultCallCreditView.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -45)
        defaultCallCreditViewTrailing2 = defaultCallCreditView.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -10)
        
        defaultCallViewHeight = defaultCallCreditView.heightAnchor.constraint(equalToConstant: 80)
        defaultCallViewHeight?.isActive = true
        defaultCallCreditViewTop1 = defaultCallCreditView.topAnchor.constraint(equalTo: defaultAccDisName.bottomAnchor, constant: 20)
        defaultCallCreditViewTop2 = defaultCallCreditView.topAnchor.constraint(equalTo: defaultAccImage.topAnchor, constant: 10)
        
        
        //        print("is gauge:: \(isGaugeVisible)")
        defaultCallCreditView.layer.cornerRadius = 40
        defaultCallCreditView.clipsToBounds = true
        
        //top up button in call credit view
        defaultCallCreditView.addSubview(btnTopUp)
        btnTopUp.translatesAutoresizingMaskIntoConstraints = false
        btnTopUp.backgroundColor = UIColor.white
        btnTopWidth = btnTopUp.widthAnchor.constraint(equalToConstant: 80)
        btnTopWidth?.isActive = true
        btnTopHeight = btnTopUp.heightAnchor.constraint(equalToConstant: 80)
        btnTopHeight?.isActive = true
        btnTopUpTopConstraint1 = btnTopUp.topAnchor.constraint(equalTo: defaultCallCreditView.topAnchor)
        btnTopUpTopConstraint2 = btnTopUp.topAnchor.constraint(equalTo: defaultCallCreditView.topAnchor)
        btnTopUpTopConstraint1?.isActive = true
        btnTopUpTrailingConstraint1 =  btnTopUp.trailingAnchor.constraint(equalTo: defaultCallCreditView.trailingAnchor)
        btnTopUpTrailingConstraint2 =  btnTopUp.trailingAnchor.constraint(equalTo: defaultCallCreditView.trailingAnchor)
        btnTopUpTrailingConstraint1?.isActive = true
        btnTopUp.layer.cornerRadius = 80 / 2
        btnTopUp.clipsToBounds = true
        let topupImage = UIImage(named: "top_up")
        btnTopUp.setImage(topupImage, for: .normal)
        btnTopUp.imageEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20)
        btnTopUp.addTarget(self, action: #selector(goToTopUp), for: .touchUpInside)
        
        //label for credit title
        defaultCallCreditView.addSubview(lblCreditTitle)
        lblCreditTitle.translatesAutoresizingMaskIntoConstraints = false
        if let creditTitle = balanceLabel {
            lblCreditTitle.text = creditTitle
        }else{
            lblCreditTitle.text = "Credit remaining"
        }
        
        lblCreditTitle.textColor = UIColor.black
        lblCreditTitle.font = UIFont(name: String.defaultFontR, size: fontSizeForCreditTitle)
        lblCreditTitle.leadingAnchor.constraint(equalTo: defaultCallCreditView.leadingAnchor, constant: 10).isActive = true
        lblCreditTitle.topAnchor.constraint(equalTo: defaultCallCreditView.topAnchor, constant: 20).isActive = true
        
        //label for actual credit
        defaultCallCreditView.addSubview(lblCreditRem)
        lblCreditRem.translatesAutoresizingMaskIntoConstraints = false
        if let creditRem = accountBalanceLabel {
            lblCreditRem.text = creditRem
        }else{
            lblCreditRem.text = "GHS -- --"
        }
        
        lblCreditRem.textColor = UIColor.black
        let credit = lblCreditRem.text?.count
        
        if credit! > 5 && isGaugeVisible == true {
            
            fontSizeForCredit = 20
            btnTopWidth?.constant = 70
            btnTopHeight?.constant = 70
            btnTopUp.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15)
            btnTopUp.layer.cornerRadius = 35
            btnTopUpTopConstraint2?.isActive = true
            btnTopUpTrailingConstraint2?.isActive = true
            defaultCallViewHeight?.constant = 70
            defaultCallCreditView.layer.cornerRadius = 35
            fontSizeForCreditTitle = 17
            lblCreditTitle.font = UIFont(name: String.defaultFontR, size: fontSizeForCreditTitle)
        }else{
            
        }
        lblCreditRem.font = UIFont(name: String.defaultFontB, size: fontSizeForCredit)
        lblCreditRem.leadingAnchor.constraint(equalTo: defaultCallCreditView.leadingAnchor, constant: 10).isActive = true
        lblCreditRem.topAnchor.constraint(equalTo: lblCreditTitle.bottomAnchor, constant: 8).isActive = true
        
        //Gauge View
        
        
        scrollView.addSubview(gaugeViewHolder)
        gaugeViewHolder.translatesAutoresizingMaskIntoConstraints = false
        gaugeViewHolder.backgroundColor = UIColor.clear
        gaugeViewHolder.leadingAnchor.constraint(equalTo: motherView.leadingAnchor).isActive = true
        gaugeViewHolder.topAnchor.constraint(equalTo: defaultAccImage.bottomAnchor, constant: 100).isActive = true
        gaugeViewHolder.trailingAnchor.constraint(equalTo: motherView.trailingAnchor).isActive = true
        gaugeViewHolder.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        scrollView.addSubview(btnOffers)
        btnOffers.leadingAnchor.constraint(equalTo: gaugeViewHolder.leadingAnchor, constant: 230).isActive = true
        btnOffers.widthAnchor.constraint(equalToConstant: 60).isActive = true
        btnOffers.heightAnchor.constraint(equalToConstant: 60).isActive = true
        btnOffers.bottomAnchor.constraint(equalTo: gaugeViewHolder.topAnchor, constant: 12).isActive = true
        btnOffers.layer.cornerRadius = 30
        btnOffers.clipsToBounds = true
        
        scrollView.addSubview(btnGoFBB)
        btnGoFBB.topAnchor.constraint(equalTo: btnOffers.bottomAnchor, constant: -2).isActive = true
        btnGoFBB.leadingAnchor.constraint(equalTo: btnOffers.trailingAnchor, constant: 1).isActive = true
        btnGoFBB.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnGoFBB.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnGoFBB.layer.cornerRadius = 20
        btnGoFBB.layer.borderColor = UIColor.white.cgColor
        btnGoFBB.layer.borderWidth = 1
        
        //data Icon
        gaugeViewHolder.addSubview(btnDataIcon)
        btnDataIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnDataIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnDataIcon.topAnchor.constraint(equalTo: gaugeViewHolder.topAnchor, constant: 100).isActive = true
        btnDataIcon.leadingAnchor.constraint(equalTo: gaugeViewHolder.leadingAnchor, constant: 30).isActive = true
        btnDataIcon.layer.cornerRadius = 20
        btnDataIcon.layer.borderWidth = 1
        btnDataIcon.layer.borderColor = UIColor.white.cgColor
        
        //sms Icon
        gaugeViewHolder.addSubview(btnSMSIcon)
        btnSMSIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnSMSIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnSMSIcon.topAnchor.constraint(equalTo: btnDataIcon.bottomAnchor, constant: 15).isActive = true
        btnSMSIcon.leadingAnchor.constraint(equalTo: gaugeViewHolder.leadingAnchor, constant: 55).isActive = true
        btnSMSIcon.layer.cornerRadius = 20
        btnSMSIcon.layer.borderWidth = 1
        btnSMSIcon.layer.borderColor = UIColor.white.cgColor
        
        //Call Icon
        scrollView.addSubview(btnCallDataIcon)
        btnCallDataIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnCallDataIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnCallDataIcon.topAnchor.constraint(equalTo: btnSMSIcon.bottomAnchor, constant: 10).isActive = true
        btnCallDataIcon.leadingAnchor.constraint(equalTo: btnSMSIcon.trailingAnchor, constant: 2).isActive = true
        btnCallDataIcon.layer.cornerRadius = 20
        btnCallDataIcon.layer.borderWidth = 1
        btnCallDataIcon.layer.borderColor = UIColor.white.cgColor
        
        //Plan label
        gaugeViewHolder.addSubview(lblPlan)
        lblPlan.leadingAnchor.constraint(equalTo: btnCallDataIcon.trailingAnchor, constant: 20).isActive = true
        lblPlan.topAnchor.constraint(equalTo: btnCallDataIcon.topAnchor, constant: 20).isActive = true
        lblPlan.trailingAnchor.constraint(equalTo: gaugeViewHolder.trailingAnchor, constant: -10).isActive = true
        lblPlan.numberOfLines = 0
        lblPlan.lineBreakMode = .byWordWrapping
        
        //Plan Warning Message
        gaugeViewHolder.addSubview(lblPlanMessage)
        lblPlanMessage.leadingAnchor.constraint(equalTo: btnCallDataIcon.trailingAnchor, constant: 40).isActive = true
        lblPlanMessage.topAnchor.constraint(equalTo: lblPlan.bottomAnchor, constant: 4).isActive = true
        lblPlanMessage.trailingAnchor.constraint(equalTo: gaugeViewHolder.trailingAnchor, constant: -10).isActive = true
        lblPlanMessage.numberOfLines = 0
        lblPlanMessage.lineBreakMode = .byWordWrapping
        
        
        
        //yendi agoro
        scrollView.addSubview(yendiagoro)
        yendiagoro.translatesAutoresizingMaskIntoConstraints = false
        yendiagoro.image = UIImage(named: "spinlogo")
        yendiagoro.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        yendiAgoroTop1 = yendiagoro.topAnchor.constraint(equalTo: defaultAccDisName.bottomAnchor, constant: 150)
        yendiAgoroTop2 = yendiagoro.topAnchor.constraint(equalTo: gaugeViewHolder.bottomAnchor, constant: 80)
        
        yendiagoro.heightAnchor.constraint(equalToConstant: 58).isActive = true
        yendiagoro.widthAnchor.constraint(equalToConstant: 110).isActive = true
        yendiagoro.isUserInteractionEnabled = true
        
        let yendiAgoroRec = UITapGestureRecognizer(target: self, action: #selector(goToYendiAgoro))
        yendiagoro.addGestureRecognizer(yendiAgoroRec)
        
        //24/7
        scrollView.addSubview(twoFourSeven)
        twoFourSeven.translatesAutoresizingMaskIntoConstraints = false
        twoFourSeven.image = UIImage(named: "support")
        supportTop1 = twoFourSeven.topAnchor.constraint(equalTo: defaultAccDisName.bottomAnchor, constant: 140)
        supportTop2 = twoFourSeven.topAnchor.constraint(equalTo: gaugeViewHolder.bottomAnchor, constant: 70)
        twoFourSeven.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -3).isActive = true
        twoFourSeven.widthAnchor.constraint(equalToConstant: 80).isActive = true
        twoFourSeven.heightAnchor.constraint(equalToConstant: 80).isActive = true
        twoFourSeven.isUserInteractionEnabled = true
        
        let twoFourSevenRec = UITapGestureRecognizer(target: self, action: #selector(goToSupport))
        twoFourSeven.addGestureRecognizer(twoFourSevenRec)
        
        //update icon
        scrollView.addSubview(updateIcon)
        updateIcon.translatesAutoresizingMaskIntoConstraints = false
        let progressArrow = UIImage(named: "progressarrow")
        
        updateIcon.setImage(progressArrow, for: .normal)
        updateIcon.topAnchor.constraint(equalTo: yendiagoro.bottomAnchor, constant: 100).isActive = true
        updateIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 60).isActive = true
        updateIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        updateIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        //        updateIcon.addTarget(self, action: #selector(updateHome), for: .touchUpInside)
        
        //Last updated label
        scrollView.addSubview(lblLastUpdatedStatus)
        lblLastUpdatedStatus.translatesAutoresizingMaskIntoConstraints = false
        if let lastUpdate = lastUpdate {
            lblLastUpdatedStatus.text = "Last updated on \(lastUpdate)"
        }else{
            lblLastUpdatedStatus.text = "Last updated on ........."
        }
        
        lblLastUpdatedStatus.font = UIFont(name: String.defaultFontR, size: 14)
        lblLastUpdatedStatus.textColor = UIColor.white
        lblLastUpdatedStatus.leadingAnchor.constraint(equalTo: updateIcon.trailingAnchor, constant: 10).isActive = true
        lblLastUpdatedStatus.topAnchor.constraint(equalTo: yendiagoro.bottomAnchor, constant: 105).isActive = true
        
        
        if isGaugeVisible {
            defaultCallCreditViewTop2?.isActive = true
            defaultCallCreditViewLeading2?.isActive = true
            defaultCallCreditViewTrailing2?.isActive = true
            yendiAgoroTop2?.isActive = true
            supportTop2?.isActive = true
            gaugeViewHolder.isHidden = false
        }else{
            defaultCallCreditViewTop1?.isActive = true
            defaultCallCreditViewLeading1?.isActive = true
            defaultCallCreditViewTrailing1?.isActive = true
            yendiAgoroTop1?.isActive = true
            supportTop1?.isActive = true
            gaugeViewHolder.isHidden = true
            btnGoFBB.isHidden = true
            btnCallDataIcon.isHidden = true
            btnOffers.isHidden = true
        }
        
        
        
        //        scrollView.contentSize.height = 2000
    }
    
    private func updateGauge(){
        print("Attempting to move progress bar")
        shapeLayer.strokeEnd = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showSlider()
        
        let circularPath = UIBezierPath(arcCenter: .zero
            , radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.white.withAlphaComponent(0.50).cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = kCALineCapRound
        trackLayer.position = CGPoint(x: gaugeViewHolder.frame.size.width/2, y: gaugeViewHolder.frame.size.height/2)
        gaugeViewHolder.layer.addSublayer(trackLayer)
        
        gaugeViewHolder.addSubview(lblGaugeViewTitle)
        lblGaugeViewTitle.translatesAutoresizingMaskIntoConstraints = false
        lblGaugeViewTitle.font = UIFont(name: String.defaultFontR, size: 20)
        lblGaugeViewTitle.textColor = UIColor.white
        lblGaugeViewTitle.text = "Total Data"
        lblGaugeViewTitle.topAnchor.constraint(equalTo: gaugeViewHolder.topAnchor, constant: 40).isActive = true
        lblGaugeViewTitle.centerXAnchor.constraint(equalTo: gaugeViewHolder.centerXAnchor).isActive = true
        
        gaugeViewHolder.addSubview(lblGaugeViewLeft)
        lblGaugeViewLeft.translatesAutoresizingMaskIntoConstraints = false
        lblGaugeViewLeft.textColor = UIColor.white
        lblGaugeViewLeft.font = UIFont(name: String.defaultFontB, size: 35)
        lblGaugeViewLeft.topAnchor.constraint(equalTo: lblGaugeViewTitle.bottomAnchor, constant: 30).isActive = true
        lblGaugeViewLeft.centerXAnchor.constraint(equalTo: gaugeViewHolder.centerXAnchor).isActive = true
        
        gaugeViewHolder.addSubview(lblGaugeActualValue)
        lblGaugeActualValue.translatesAutoresizingMaskIntoConstraints = false
        lblGaugeActualValue.textColor = UIColor.white
        lblGaugeActualValue.font = UIFont(name: String.defaultFontR, size: 21)
        lblGaugeActualValue.topAnchor.constraint(equalTo: lblGaugeViewLeft.bottomAnchor, constant: 20).isActive = true
        lblGaugeActualValue.centerXAnchor.constraint(equalTo: gaugeViewHolder.centerXAnchor).isActive = true
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.position = CGPoint(x: gaugeViewHolder.frame.size.width/2, y: gaugeViewHolder.frame.size.height/2)
        shapeLayer.strokeEnd = 0
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1   )
        updateGauge()
        //        basicAnimation.toValue = 1
        //        shapeLayer.add(basicAnimation, forKey: "basics")
        //        trackLayer.position = centerForGauge
        gaugeViewHolder.layer.addSublayer(shapeLayer)
        //        scrollView.resizeScrollViewContentSize()
        scrollView.contentSize.height = 1500
    }
    
    func backgroundCalls(){
//        checkStaff()
//        getMobileBalances()
        
    }
  
    
    fileprivate func activateCallGauge(){
        btnCallDataIcon.backgroundColor = UIColor.white
        var btnImage = UIImage(named: "call_icon")
        var tintImage = btnImage?.withRenderingMode(.alwaysTemplate)
        btnCallDataIcon.setImage(tintImage, for: .normal)
        btnCallDataIcon.tintColor = UIColor.gray
        
        btnSMSIcon.backgroundColor = UIColor.clear
        btnImage = UIImage(named: "sms")
        tintImage = btnImage?.withRenderingMode(.alwaysTemplate)
        btnSMSIcon.setImage(tintImage, for: .normal)
        btnSMSIcon.tintColor = UIColor.white
        
        btnDataIcon.backgroundColor = UIColor.clear
        btnImage = UIImage(named: "data_icon")
        tintImage = btnImage?.withRenderingMode(.alwaysTemplate)
        btnDataIcon.setImage(tintImage, for: .normal)
        btnDataIcon.tintColor = UIColor.white
        
        lblGaugeViewTitle.text = "Total Mins"
        lblGaugeViewLeft.text = "\(String(callsBucketValueSum))"
        lblGaugeActualValue.text = "of \(String(callsActualValueSum))\(callsActualUnit ?? "")"
        
        let intCallsActual = Double(callsActualValueSum)
        let intsCallsBucket = Double(callsBucketValueSum)
        var totalUsed = (intCallsActual - intsCallsBucket)
        totalUsed = (intsCallsBucket / intCallsActual) * 100
        totalUsed = totalUsed / 100
        print("total Calls: \(totalUsed)")
        shapeLayer.strokeEnd = CGFloat(totalUsed)
    }
    
    
    
    
    @objc func updateHome(){
        
    }
    
    
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNames.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        //        cell.imageView?.image = shakeImage
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        
        
        cell.imageView?.clipsToBounds = true
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        pageControl.currentPage = targetIndex
        
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
        
    }
    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
        
    }
    
    func pagerViewWillBeginDragging(_ pagerView: FSPagerView) {
        //
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        
        if pagerView.currentIndex == 0 {
            pagerView.addSubview(lblShakeHeader)
            lblGreetings.alpha = 0
            greetingsRed.alpha = 0
            lblWelcome.alpha = 0
            lblShakeHeader.translatesAutoresizingMaskIntoConstraints = false
            lblShakeHeader.textColor = UIColor.white
            lblShakeHeader.isHidden = false
            lblShakeHeader.text = "Shake on Vodafone X"
            lblShakeHeader.numberOfLines = 0
            lblShakeHeader.lineBreakMode = .byWordWrapping
            lblShakeHeader.font = UIFont(name: String.defaultFontB, size: 20)
            lblShakeHeader.textAlignment = .center
            lblShakeHeader.leadingAnchor.constraint(equalTo: pagerView.leadingAnchor, constant: 20).isActive = true
            lblShakeHeader.topAnchor.constraint(equalTo: pagerView.topAnchor, constant: 20).isActive = true
            lblShakeHeader.trailingAnchor.constraint(equalTo: pagerView.trailingAnchor, constant: -20).isActive = true
            lblShakeHeader.alpha = 1
            lblShakeDesc.alpha = 1
            shakeButton.alpha = 1
            
            //Shake Description
            pagerView.addSubview(lblShakeDesc)
            lblShakeDesc.translatesAutoresizingMaskIntoConstraints = false
            lblShakeDesc.textColor = UIColor.white
            lblShakeDesc.numberOfLines = 0
            lblShakeDesc.lineBreakMode = .byWordWrapping
            lblShakeDesc.font = UIFont(name: String.defaultFontR, size: 16)
            lblShakeDesc.isHidden = false
            lblShakeDesc.text = "Shake and get exciting bundles and rewards only on My Vodafone App"
            lblShakeDesc.leadingAnchor.constraint(equalTo: pagerView.leadingAnchor, constant: 20).isActive = true
            lblShakeDesc.topAnchor.constraint(equalTo: lblShakeHeader.bottomAnchor, constant: 10).isActive = true
            lblShakeDesc.trailingAnchor.constraint(equalTo: pagerView.trailingAnchor, constant: -40).isActive = true
            //shake button
            pagerView.addSubview(shakeButton)
            shakeButton.translatesAutoresizingMaskIntoConstraints = false
            shakeButton.backgroundColor = UIColor.white
            shakeButton.setTitleColor(UIColor.black, for: .normal)
            shakeButton.titleLabel?.font = UIFont(name: String.defaultFontR, size: 16)
            shakeButton.isHidden = false
            shakeButton.setTitle("1GB FREE ON SHAKE - CLICK HERE", for: .normal)
            shakeButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
            shakeButton.leadingAnchor.constraint(equalTo: pagerView.leadingAnchor, constant: 20).isActive = true
            shakeButton.trailingAnchor.constraint(equalTo: pagerView.trailingAnchor, constant: -20).isActive = true
            shakeButton.topAnchor.constraint(equalTo: lblShakeDesc.bottomAnchor, constant: 10).isActive = true
            shakeButton.addTarget(self, action: #selector(goToShake), for: .touchUpInside)
        }else{
            
            lblShakeHeader.alpha = 0
            lblShakeDesc.alpha = 0
            shakeButton.alpha = 0
            
            lblGreetings.alpha = 1
            greetingsRed.alpha = 1
            lblWelcome.alpha = 1
            pagerView.addSubview(greetingsRed)
            greetingsRed.translatesAutoresizingMaskIntoConstraints = false
            greetingsRed.backgroundColor = UIColor.vodaRed
            greetingsRed.widthAnchor.constraint(equalToConstant: 3).isActive = true
            greetingsRed.leadingAnchor.constraint(equalTo: pagerView.leadingAnchor, constant: 50).isActive = true
            greetingsRed.topAnchor.constraint(equalTo: pagerView.topAnchor, constant: 40).isActive = true
            greetingsRed.bottomAnchor.constraint(equalTo: pagerView.bottomAnchor, constant: -40).isActive = true
            
            pagerView.addSubview(lblGreetings)
            lblGreetings.translatesAutoresizingMaskIntoConstraints = false
            lblGreetings.textColor = UIColor.white
            lblGreetings.font = UIFont(name: String.defaultFontR, size: 23)
            lblGreetings.text = "Good \(greetings())"
            lblGreetings.leadingAnchor.constraint(equalTo: greetingsRed.trailingAnchor, constant: 20).isActive = true
            lblGreetings.topAnchor.constraint(equalTo: pagerView.topAnchor, constant: 80).isActive = true
            lblGreetings.trailingAnchor.constraint(equalTo: pagerView.trailingAnchor, constant: -10).isActive = true
            lblGreetings.numberOfLines = 0
            lblGreetings.lineBreakMode = .byWordWrapping
            
            pagerView.addSubview(lblWelcome)
            lblWelcome.translatesAutoresizingMaskIntoConstraints = false
            lblWelcome.textColor = UIColor.white
            lblWelcome.font = UIFont(name: String.defaultFontR, size: 13)
            lblWelcome.leadingAnchor.constraint(equalTo: greetingsRed.leadingAnchor, constant: 20).isActive = true
            lblWelcome.topAnchor.constraint(equalTo: lblGreetings.bottomAnchor, constant: 5).isActive = true
            lblWelcome.trailingAnchor.constraint(equalTo: pagerView.trailingAnchor, constant: -10).isActive = true
            lblWelcome.numberOfLines = 0
            lblWelcome.lineBreakMode = .byWordWrapping
            
            lblWelcome.text = "Welcome to My Vodafone"
        }
    }
    
    @objc func goToSupport(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Support", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "supportVC")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToYendiAgoro(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Games", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "yendiAgoroVc")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToTopUp(){
        let storyboard = UIStoryboard(name: "TopUp", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "toppingUpViewController")
        self.addChildViewController(moveTo)
        moveTo.view.frame = self.view.frame
        self.view.addSubview(moveTo.view)
        moveTo.didMove(toParentViewController: self)
    }
    
    @objc func showMenuh(){
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
    @objc func goToShake(){
        let storyboard = UIStoryboard(name: "Shake", bundle: nil)
        //        let moveTo = storyboard.instantiateViewController(withIdentifier: "ShakeScreen")
        let moveTo = storyboard.instantiateViewController(withIdentifier: "ShakeScreen")
        present(moveTo, animated: true, completion: nil)
    }
    func zeroAlpha(){
        //        shakeImage.alpha = 0
        pagerView.alpha = 0
        //        lblShakeHeader.alpha = 0
        //        lblShakeDesc.alpha = 0
        //        shakeButton.alpha = 0
        defaultCallCreditView.alpha = 0
        btnTopUp.alpha = 0
        lblCreditTitle.alpha = 0
        lblCreditRem.alpha = 0
        //        defaultAccImage.alpha = 0
        //        defaultAccDisName.alpha = 0
        twoFourSeven.alpha = 0
        //        updateIcon.alpha = 0
        //        lblLastUpdatedStatus.alpha = 0
        yendiagoro.alpha = 0
    }


}
