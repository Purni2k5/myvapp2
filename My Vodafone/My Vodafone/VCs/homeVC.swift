//
//  homeVC.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 19/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit
import FSPagerView


class homeVC: baseViewControllerM, FSPagerViewDataSource, FSPagerViewDelegate {
    
    
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
    var deviceWidth: CGFloat?
//    let preference = UserDefaults.standard
//    var altDisplayName: String?
//    var altServiceID: String?
//    var altAcctType: String?
//    var ServiceID: String?
//    var AcctType: String?
    var fontSizeForCredit: CGFloat = 30
    var fontSizeForCreditTitle: CGFloat = 19
    
    let defaultAccImage = UIImageView()
    let defaultCallCreditView = UIView()
    let lblCreditTitle = UILabel()
    let lblCreditRem = UILabel()
    let defaultAccDisName = UILabel()
    let yendiagoro = UIImageView()
    let twoFourSeven = UIImageView()
    let freeshsImage = UIImageView()
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
//    let made4MeOffer1 = UIButton()
//    let made4MeOffer2 = UIButton()
//    let made4MeOffer3 = UIButton()
    let gaugeViewHolder = UIView()
    let lblGaugeViewTitle = UILabel()
    let lblGaugeViewLeft = UILabel()
    let lblGaugeActualValue = UILabel()
    
    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    
    var isMade4MePresent: Bool = false
    var isGaugeVisible: Bool = false
    
    fileprivate var imageNames = ["shake_bubble", "bubble2"]
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
    
    fileprivate var freeshsTop1: NSLayoutConstraint?
    fileprivate var freeshsTop2: NSLayoutConstraint?
    
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
    var hasRated: Bool?
    
    let btnOffers: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.white
        let btnImage = UIImage(named: "top_up")
        btn.setImage(btnImage, for: .normal)
        btn.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15)
        btn.addTarget(self, action: #selector(goToOffers), for: .touchUpInside)
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
        btn.addTarget(self, action: #selector(showDataGauge), for: .touchUpInside)
        return btn
    }()
    
    let btnSMSIcon: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        let btnImage = UIImage(named: "sms")
        let tintImage = btnImage?.withRenderingMode(.alwaysTemplate)
        btn.setImage(tintImage, for: .normal)
        btn.tintColor = UIColor.white
        btn.addTarget(self, action: #selector(showSMSGauge), for: .touchUpInside)
        return btn
    }()
    
    let btnCallDataIcon: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let btnImage = UIImage(named: "call_icon")
        let tintImage = btnImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintImage, for: .normal)
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(showCallsGauge), for: .touchUpInside)
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
            print("dService:: \(dService)")
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
        defaultAccName = preference.object(forKey: UserDefaultsKeys.defaultName.rawValue) as! String?
        print("begin defName \(defaultAccName)")
        hasRated = preference.object(forKey: UserDefaultsKeys.hasRated.rawValue) as! Bool?
        print("Has rated:: \(hasRated)")
        
        
        
//        print("yos:: \(defaultService)")
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
                        
                        if(ServiceID == dService){
//                            print("checked against \(defaultService)")
                            defaultAccName = dict.value(forKey: "DisplayName") as! String?
                            primaryID = dict.value(forKey: "primaryID") as! String?
                            AcctType = dict.value(forKey: "Type") as! String?
                            foundDefault = true
                            print("Got it")
//                            print("found defName \(defaultAccName)")
                            
                        }else{
                            //Just pick one to display
//                            defaultAccName = dict.value(forKey: "DisplayName") as! String?
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
        
        backgroundCalls()
        
        
        // Check for internet connection
        checkConnection()
        
        
        if AcctType == "PHONE_MOBILE_PRE_P" || AcctType == "BB_FIXED_PRE_P"{
            prePaidMenu()
        }else{
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
        /*UIView.animate(withDuration: 1, animations: {
//            self.shakeImage.alpha = 1
            self.pagerView.alpha = 1
            self.lblShakeHeader.alpha = 1
            self.lblShakeDesc.alpha = 1
            self.shakeButton.alpha = 1
        }) { (true) in
            self.showCredit()
        }*/
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
    fileprivate func loadMade4Me() {
        //Make async call to retrieve made4me offers
        let async_call = URL(string: String.MVA_SHAKE_PROMOS)
        let request = NSMutableURLRequest(url: async_call!)
        request.httpMethod = "POST"
        let postParameters = ["action":"Made4MeBundles", "msisdn":msisdn!, "username":username!]
        if let jsonParameters = try? JSONSerialization.data(withJSONObject: postParameters, options: .prettyPrinted){
            let theJSONText = String(data: jsonParameters,encoding: String.Encoding.utf8)
            let requestBody: Dictionary<String, Any> = [
                "requestBody":encryptAsyncRequest(requestBody: theJSONText!.description)
            ]
            
            if let postData = (try? JSONSerialization.data(withJSONObject: requestBody, options: JSONSerialization.WritingOptions.prettyPrinted)){
                
                request.httpBody = postData
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                var session = preference.object(forKey: UserDefaultsKeys.userSession.rawValue) as! String
                session = session.replacingOccurrences(of: "-", with: "")
                request.addValue(session, forHTTPHeaderField: "session")
                request.addValue(username!, forHTTPHeaderField: "username")
                
                let task = URLSession.shared.dataTask(with: request as URLRequest){
                    data, response, error in
                    if error != nil {
                        if error != nil {
                            print("error is:: \(error!.localizedDescription)")
                            return;
                        }
                    }
                    do {
                        let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        if let parseJSON = myJSON{
                            var sessionAuth: String!
                            sessionAuth = parseJSON["SessionAuth"] as! String?
                            if sessionAuth == "true" {
                                DispatchQueue.main.async {
                                    self.logout()
                                }
                                
                            }
                            var responseBody: String?
                            responseBody = parseJSON["responseBody"] as! String?
                            print("Made4Me:: \(responseBody ?? "")")
                            if let resBody = responseBody {
                                let decrypt = self.decryptAsyncRequest(requestBody: resBody)
                                print("Decrypted:: \(decrypt)")
                                let decryptedResponseBody = self.convertToNSDictionary(decrypt: decrypt)
                                print(decryptedResponseBody)
                                
                                var responseCode: Int?
                                var responseMessage: NSArray?
                                responseCode = decryptedResponseBody["RESPONSECODE"] as! Int?
                                print("Device width:: \(self.deviceWidth)")
                                DispatchQueue.main.async {
                                    if responseCode == 0 {
                                        responseMessage = decryptedResponseBody["RESPONSEMESSAGE"] as! NSArray?
                                        if let ressMessage = responseMessage {
                                            self.isMade4MePresent = true
                                            //                                                //cache
                                            self.preference.set(responseMessage, forKey: UserDefaultsKeys.Made4MeBundles.rawValue)
                                            var viewLeading: CGFloat = 40
                                            for obj in ressMessage{
                                                if let dict = obj as? NSDictionary{
                                                    let made4MeName = dict.value(forKey: "name") as! String
                                                    let made4MeBundleID = dict.value(forKey: "bundleid") as! String
                                                    let currency = dict.value(forKey: "currency") as! String
                                                    let price = dict.value(forKey: "price") as! String
                                                    let short = dict.value(forKey: "short") as! String
                                                    let validity = dict.value(forKey: "validity") as! String
                                                    let volume = dict.value(forKey: "volume") as! String
                                                    let long = dict.value(forKey: "long") as! String
                                                    
                                                    let made4MeView = made4MeVariables()
                                                    self.scrollView.addSubview(made4MeView)
                                                    made4MeView.translatesAutoresizingMaskIntoConstraints = false
                                                    made4MeView.backgroundColor = UIColor.black
                                                    if Int(self.deviceWidth!) <= 320{
                                                        made4MeView.heightAnchor.constraint(equalToConstant: 80).isActive = true
                                                        made4MeView.widthAnchor.constraint(equalToConstant: 80).isActive = true
                                                        made4MeView.layer.cornerRadius = 40
                                                    }else{
                                                        made4MeView.heightAnchor.constraint(equalToConstant: 80).isActive = true
                                                        made4MeView.widthAnchor.constraint(equalToConstant: 80).isActive = true
                                                        made4MeView.layer.cornerRadius = 40
                                                    }
                                                    
                                                    made4MeView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: viewLeading).isActive = true
                                                    made4MeView.topAnchor.constraint(equalTo: self.pagerView.bottomAnchor, constant: 40).isActive = true
                                                    
                                                    made4MeView.layer.borderColor = UIColor.white.cgColor
                                                    made4MeView.layer.borderWidth = 1
                                                    made4MeView.name = made4MeName
                                                    made4MeView.price = price
                                                    made4MeView.long = long
                                                    made4MeView.currency = currency
                                                    made4MeView.validity = validity
                                                    made4MeView.short = short
                                                    made4MeView.bundleid = made4MeBundleID
                                                    made4MeView.volume = volume
                                                    self.defaultImageTopConstraint2 = self.defaultAccImage.topAnchor.constraint(equalTo: made4MeView.bottomAnchor, constant: 60)
                                                    self.defaultImageTopConstraint1?.isActive = false
                                                    self.defaultImageTopConstraint2?.isActive = true
                                                    made4MeView.alpha = 0
                                                    made4MeView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
                                                    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 2, options: [], animations: {
                                                        made4MeView.transform = .identity
                                                    }) { (success) in
                                                        
                                                    }
                                                    made4MeView.alpha = 1
                                                    let made4MeRec = UITapGestureRecognizer(target: self, action: #selector(self.goToMade4Me(_sender:)))
                                                    made4MeView.addGestureRecognizer(made4MeRec)
                                                    
                                                    let lblPrice = UILabel()
                                                    self.scrollView.addSubview(lblPrice)
                                                    lblPrice.translatesAutoresizingMaskIntoConstraints = false
                                                    lblPrice.textColor = UIColor.white
                                                    lblPrice.text = "\(volume)"
                                                    lblPrice.font = UIFont(name: String.defaultFontB, size: 18)
                                                    lblPrice.centerXAnchor.constraint(equalTo: made4MeView.centerXAnchor).isActive = true
                                                    lblPrice.centerYAnchor.constraint(equalTo: made4MeView.centerYAnchor).isActive = true
                                                    
                                                    let lblDescripion = UILabel()
                                                    self.scrollView.addSubview(lblDescripion)
                                                    lblDescripion.translatesAutoresizingMaskIntoConstraints = false
                                                    lblDescripion.textColor = UIColor.white
                                                    lblDescripion.text = "\(currency.uppercased()) \(price) \(validity)"
                                                    lblDescripion.font = UIFont(name: String.defaultFontB, size: 16)
                                                    lblDescripion.topAnchor.constraint(equalTo: made4MeView.bottomAnchor, constant: 10).isActive = true
                                                    lblDescripion.leadingAnchor.constraint(equalTo: made4MeView.leadingAnchor, constant: 2).isActive = true
                                                    lblDescripion.trailingAnchor.constraint(equalTo: made4MeView.trailingAnchor, constant: 2).isActive = true
                                                    lblDescripion.numberOfLines = 0
                                                    lblDescripion.lineBreakMode = .byWordWrapping
                                                    
                                                    if Int(self.deviceWidth!) <= 320 {
                                                        viewLeading = viewLeading + 100
                                                    }else{
                                                       viewLeading = viewLeading + 120
                                                    }
                                                    
                                                }
                                            }
                                            
                                        }else{
                                            print("No made4me")
                                        }
                                    }
                                }
                            }
                        }
                    }catch{
                        print("back error:: \(error.localizedDescription)")
                    }
                }
                task.resume()
            }
        }
    }
    
    func setUpViews1(){
        deviceWidth = view.frame.width
        
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
        bgImage.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
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
        
        //sake image
        /*scrollView.addSubview(shakeImage)
        shakeImage.translatesAutoresizingMaskIntoConstraints = false
        shakeImage.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 20).isActive = true
        shakeImage.topAnchor.constraint(equalTo: app_logo.bottomAnchor, constant: 20).isActive = true
        shakeImage.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -20).isActive = true
        shakeImage.heightAnchor.constraint(equalToConstant: 170).isActive = true
        shakeImage.image = UIImage(named: imageNames[0])
        
        shakeImage.addSubview(lblShakeHeader)
        lblShakeHeader.translatesAutoresizingMaskIntoConstraints = false
        lblShakeHeader.textColor = UIColor.white
        lblShakeHeader.isHidden = false
        lblShakeHeader.text = "Shake on Vodafone X"
        lblShakeHeader.numberOfLines = 0
        lblShakeHeader.lineBreakMode = .byWordWrapping
        lblShakeHeader.font = UIFont(name: String.defaultFontB, size: 20)
        lblShakeHeader.textAlignment = .center
        lblShakeHeader.leadingAnchor.constraint(equalTo: shakeImage.leadingAnchor, constant: 20).isActive = true
        lblShakeHeader.topAnchor.constraint(equalTo: shakeImage.topAnchor, constant: 20).isActive = true
        lblShakeHeader.trailingAnchor.constraint(equalTo: shakeImage.trailingAnchor, constant: -20).isActive = true
        
        //Shake Description
        shakeImage.addSubview(lblShakeDesc)
        lblShakeDesc.translatesAutoresizingMaskIntoConstraints = false
        lblShakeDesc.textColor = UIColor.white
        lblShakeDesc.numberOfLines = 0
        lblShakeDesc.lineBreakMode = .byWordWrapping
        lblShakeDesc.font = UIFont(name: String.defaultFontR, size: 16)
        lblShakeDesc.isHidden = false
        lblShakeDesc.text = "Shake and get exciting bundles and rewards only on My Vodafone App"
        lblShakeDesc.leadingAnchor.constraint(equalTo: shakeImage.leadingAnchor, constant: 20).isActive = true
        lblShakeDesc.topAnchor.constraint(equalTo: lblShakeHeader.bottomAnchor, constant: 10).isActive = true
        lblShakeDesc.trailingAnchor.constraint(equalTo: shakeImage.trailingAnchor, constant: -40).isActive = true
        //shake button
        scrollView.addSubview(shakeButton)
        shakeButton.translatesAutoresizingMaskIntoConstraints = false
        shakeButton.backgroundColor = UIColor.white
        shakeButton.setTitleColor(UIColor.black, for: .normal)
        shakeButton.titleLabel?.font = UIFont(name: String.defaultFontR, size: 16)
        shakeButton.isHidden = false
        shakeButton.setTitle("1GB FREE ON SHAKE - CLICK HERE", for: .normal)
        shakeButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        shakeButton.leadingAnchor.constraint(equalTo: shakeImage.leadingAnchor, constant: 20).isActive = true
        shakeButton.trailingAnchor.constraint(equalTo: shakeImage.trailingAnchor, constant: -20).isActive = true
        shakeButton.topAnchor.constraint(equalTo: lblShakeDesc.bottomAnchor, constant: 10).isActive = true*/
        
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
        
//        scrollView.addSubview(made4MeOffer1)
//        scrollView.addSubview(made4MeOffer2)
//        scrollView.addSubview(made4MeOffer3)
        
        
        //Default account image
        scrollView.addSubview(defaultAccImage)
        
        
        
        if !isMade4MePresent {
            defaultAccImage.translatesAutoresizingMaskIntoConstraints = false
            defaultAccImage.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "default_profile"), options: [.continueInBackground, .progressiveDownload])
            
            defaultAccImage.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
            defaultImageTopConstraint1 = defaultAccImage.topAnchor.constraint(equalTo: pagerView.bottomAnchor, constant: 30)
            defaultImageTopConstraint1?.isActive = true
            loadMade4Me()
        }else{
            defaultImageTopConstraint2?.isActive = true
            print("Yes load local")
        }
        
        
        if Int(deviceWidth!) <= 320 {
            defaultAccImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
            defaultAccImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        }else{
            defaultAccImage.widthAnchor.constraint(equalToConstant: 90).isActive = true
            defaultAccImage.heightAnchor.constraint(equalToConstant: 90).isActive = true
        }
        
        
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
        if Int(deviceWidth!) <= 320 {
            defaultCallCreditViewLeading2 = defaultCallCreditView.widthAnchor.constraint(equalToConstant: 180)
        }else{
            defaultCallCreditViewLeading2 = defaultCallCreditView.widthAnchor.constraint(equalToConstant: 200)
        }
        
        
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
        if Int(deviceWidth!) <= 320 {
            btnTopWidth = btnTopUp.widthAnchor.constraint(equalToConstant: 70)
            btnTopHeight = btnTopUp.heightAnchor.constraint(equalToConstant: 70)
            
            btnTopUp.layer.cornerRadius = 35
        }else{
            btnTopWidth = btnTopUp.widthAnchor.constraint(equalToConstant: 80)
            btnTopHeight = btnTopUp.heightAnchor.constraint(equalToConstant: 80)
            btnTopUp.layer.cornerRadius = 40
        }
        
        btnTopWidth?.isActive = true
        
        btnTopHeight?.isActive = true
        btnTopUpTopConstraint1 = btnTopUp.topAnchor.constraint(equalTo: defaultCallCreditView.topAnchor)
        btnTopUpTopConstraint2 = btnTopUp.topAnchor.constraint(equalTo: defaultCallCreditView.topAnchor)
        btnTopUpTopConstraint1?.isActive = true
        btnTopUpTrailingConstraint1 =  btnTopUp.trailingAnchor.constraint(equalTo: defaultCallCreditView.trailingAnchor)
        btnTopUpTrailingConstraint2 =  btnTopUp.trailingAnchor.constraint(equalTo: defaultCallCreditView.trailingAnchor)
        btnTopUpTrailingConstraint1?.isActive = true
        
        
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
        if Int(deviceWidth!) <= 320 {
            lblCreditTitle.text = "Credit \nremaining"
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
        if Int(deviceWidth!) <= 320 {
            btnOffers.leadingAnchor.constraint(equalTo: gaugeViewHolder.leadingAnchor, constant: 210).isActive = true
        }else{
            btnOffers.leadingAnchor.constraint(equalTo: gaugeViewHolder.leadingAnchor, constant: 230).isActive = true
        }
        
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
        if Int(deviceWidth!) <= 320 {
           btnDataIcon.leadingAnchor.constraint(equalTo: gaugeViewHolder.leadingAnchor, constant: 10).isActive = true
        }else{
            btnDataIcon.leadingAnchor.constraint(equalTo: gaugeViewHolder.leadingAnchor, constant: 30).isActive = true
        }
        
        btnDataIcon.layer.cornerRadius = 20
        btnDataIcon.layer.borderWidth = 1
        btnDataIcon.layer.borderColor = UIColor.white.cgColor
        
        //sms Icon
        gaugeViewHolder.addSubview(btnSMSIcon)
        btnSMSIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnSMSIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnSMSIcon.topAnchor.constraint(equalTo: btnDataIcon.bottomAnchor, constant: 15).isActive = true
        if Int(deviceWidth!) <= 320 {
            btnSMSIcon.leadingAnchor.constraint(equalTo: gaugeViewHolder.leadingAnchor, constant: 30).isActive = true
        }else{
            btnSMSIcon.leadingAnchor.constraint(equalTo: gaugeViewHolder.leadingAnchor, constant: 55).isActive = true
        }
        
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
        yendiAgoroTop1 = yendiagoro.topAnchor.constraint(equalTo: defaultAccDisName.bottomAnchor, constant: 190)
        yendiAgoroTop2 = yendiagoro.topAnchor.constraint(equalTo: gaugeViewHolder.bottomAnchor, constant: 80)
        
        yendiagoro.heightAnchor.constraint(equalToConstant: 58).isActive = true
        yendiagoro.widthAnchor.constraint(equalToConstant: 110).isActive = true
        yendiagoro.isUserInteractionEnabled = true
        
        let yendiAgoroRec = UITapGestureRecognizer(target: self, action: #selector(goToYendiAgoro))
        yendiagoro.addGestureRecognizer(yendiAgoroRec)
        
        //Free shs
        scrollView.addSubview(freeshsImage)
        freeshsImage.translatesAutoresizingMaskIntoConstraints = false
        freeshsImage.image = UIImage(named: "freeshs")
        freeshsTop1 = freeshsImage.topAnchor.constraint(equalTo: defaultAccDisName.bottomAnchor, constant: 110)
        freeshsTop2 = freeshsImage.topAnchor.constraint(equalTo: gaugeViewHolder.bottomAnchor, constant: -5)
        freeshsImage.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -20).isActive = true
        freeshsImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
        freeshsImage.heightAnchor.constraint(equalToConstant: 70).isActive = true
        freeshsImage.backgroundColor = UIColor.white
        freeshsImage.isUserInteractionEnabled = true
        freeshsImage.layer.cornerRadius = 35
        
        let freeshsRec = UITapGestureRecognizer(target: self, action: #selector(goToFreeSHS))
        freeshsImage.addGestureRecognizer(freeshsRec)
        
        //24/7
        scrollView.addSubview(twoFourSeven)
        twoFourSeven.translatesAutoresizingMaskIntoConstraints = false
        twoFourSeven.image = UIImage(named: "support")
        supportTop1 = twoFourSeven.topAnchor.constraint(equalTo: defaultAccDisName.bottomAnchor, constant: 190)
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
        
        
        //Bottom view to show data offer
        /*let bottomDarkView = UIView()
        bottomDarkView.translatesAutoresizingMaskIntoConstraints = false
        bottomDarkView.backgroundColor = UIColor.black.withAlphaComponent(0.60)
        bottomDarkView.isOpaque = false
        scrollView.addSubview(bottomDarkView)
        bottomDarkView.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 10).isActive = true
        bottomDarkView.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -10).isActive = true
        bottomDarkView.topAnchor.constraint(equalTo: updateIcon.bottomAnchor, constant: 40).isActive = true
        bottomDarkView.heightAnchor.constraint(equalToConstant: 130).isActive = true
//        bottomDarkView.isHidden = true
        
        //Red image on offer view
        let redImageView = UIImageView()
        bottomDarkView.addSubview(redImageView)
        redImageView.translatesAutoresizingMaskIntoConstraints = false
        redImageView.backgroundColor = UIColor.vodaRed
        redImageView.widthAnchor.constraint(equalToConstant: 5).isActive = true
        redImageView.topAnchor.constraint(equalTo: bottomDarkView.topAnchor, constant: 8).isActive = true
        redImageView.bottomAnchor.constraint(equalTo: bottomDarkView.bottomAnchor, constant: -8).isActive = true
        redImageView.leadingAnchor.constraint(equalTo: bottomDarkView.leadingAnchor, constant: 10).isActive = true
        
        // Promotion label
        bottomDarkView.addSubview(lblPromotion)
        lblPromotion.translatesAutoresizingMaskIntoConstraints = false
        lblPromotion.text = "Promotion"
        lblPromotion.textColor = UIColor.white
        lblPromotion.font = UIFont(name: String.defaultFontR, size: 17)
        lblPromotion.leadingAnchor.constraint(equalTo: redImageView.trailingAnchor, constant: 20).isActive = true
        lblPromotion.topAnchor.constraint(equalTo: bottomDarkView.topAnchor, constant: 20).isActive = true
        lblPromotion.trailingAnchor.constraint(equalTo: bottomDarkView.trailingAnchor, constant: -10).isActive = true
        lblPromotion.numberOfLines = 0
        lblPromotion.lineBreakMode = .byWordWrapping
        
        //Promotion expiration date
        bottomDarkView.addSubview(lblPromotionExpire)
        lblPromotionExpire.translatesAutoresizingMaskIntoConstraints = false
        lblPromotionExpire.textColor = UIColor.white
        lblPromotionExpire.text = "Expires on ............"
        lblPromotionExpire.font = UIFont(name: String.defaultFontR, size: 17)
        lblPromotionExpire.leadingAnchor.constraint(equalTo: redImageView.leadingAnchor, constant: 20).isActive = true
        lblPromotionExpire.bottomAnchor.constraint(equalTo: bottomDarkView.bottomAnchor, constant: -20).isActive = true
        lblPromotionExpire.trailingAnchor.constraint(equalTo: bottomDarkView.trailingAnchor, constant: -10).isActive = true
        lblPromotionExpire.numberOfLines = 0
        lblPromotionExpire.lineBreakMode = .byWordWrapping*/
        
        if isGaugeVisible {
            defaultCallCreditViewTop2?.isActive = true
            defaultCallCreditViewLeading2?.isActive = true
            defaultCallCreditViewTrailing2?.isActive = true
            yendiAgoroTop2?.isActive = true
            supportTop2?.isActive = true
            freeshsTop2?.isActive = true
            gaugeViewHolder.isHidden = false
        }else{
            defaultCallCreditViewTop1?.isActive = true
            defaultCallCreditViewLeading1?.isActive = true
            defaultCallCreditViewTrailing1?.isActive = true
            yendiAgoroTop1?.isActive = true
            supportTop1?.isActive = true
            freeshsTop1?.isActive = true
            gaugeViewHolder.isHidden = true
            btnGoFBB.isHidden = true
            btnCallDataIcon.isHidden = true
            btnOffers.isHidden = true
        }
        
        gaugeViewHolder.addSubview(lblPlanExpiration)
        lblPlanExpiration.translatesAutoresizingMaskIntoConstraints = false
        lblPlanExpiration.textColor = UIColor.white
        lblPlanExpiration.font = UIFont(name: String.defaultFontR, size: 21)
        lblPlanExpiration.topAnchor.constraint(equalTo: yendiagoro.bottomAnchor, constant: 40).isActive = true
        lblPlanExpiration.centerXAnchor.constraint(equalTo: gaugeViewHolder.centerXAnchor).isActive = true
        
//        scrollView.contentSize.height = 2000
    }
    
    private func updateGauge(){
        print("Attempting to move progress bar")
        shapeLayer.strokeEnd = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if AcctType == "BB_FIXED_PRE_P" {
            let storyboard = UIStoryboard(name: "Broadband", bundle: nil)
            let moveTo = storyboard.instantiateViewController(withIdentifier: "broadbandHome")
            present(moveTo, animated: true, completion: nil)
        }else if AcctType == "PHONE_MOBILE_POST_P"{
            let storyboard = UIStoryboard(name: "PostPaid", bundle: nil)
            let moveTo = storyboard.instantiateViewController(withIdentifier: "postPaidHome")
            present(moveTo, animated: true, completion: nil)
        }

        
        
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
        checkStaff()
        getMobileBalances()
        
    }
    @objc func goToMade4Me(_sender: UITapGestureRecognizer){
        print("Clicked")
        let storyboard = UIStoryboard(name: "OffersExtras", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "BuyOfferViewController") as? BuyOfferViewController else { return }
        guard let gestureVariables = _sender.view as? made4MeVariables else {return}
        moveTo.selectedOffer = gestureVariables.name!
        moveTo.selectedOfferPrice = gestureVariables.price!
        moveTo.selectedOfferDesc = gestureVariables.short!
        moveTo.selectedOfferPID = gestureVariables.bundleid!
        moveTo.selectedUSSD = "*530#"
        self.addChildViewController(moveTo)
        moveTo.view.frame = self.view.frame
        self.view.addSubview(moveTo.view)
        moveTo.didMove(toParentViewController: self)
        
    }
    
    //Function to check for staff Number
    func checkStaff(){
        let postParameters = ["action":"checkStaffNumber","msisdn":msisdn!,"username":username!,"os":getAppVersion()]
        
        
        if let jsonParameters = try? JSONSerialization.data(withJSONObject: postParameters, options: .prettyPrinted) {
            
            let theJSONText = String(data: jsonParameters,encoding: String.Encoding.utf8)
            
        
        
        let requestBody: Dictionary<String, Any> = [
            "requestBody":encryptAsyncRequest(requestBody: theJSONText!.description)
        ]
        
        
        let async_call = URL(string: String.offers)
        let request = NSMutableURLRequest(url: async_call!)
        request.httpMethod = "POST"
        
        if let postData = (try? JSONSerialization.data(withJSONObject: requestBody, options: JSONSerialization.WritingOptions.prettyPrinted)){
            request.httpBody = postData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            if let sess = preference.object(forKey: UserDefaultsKeys.userSession.rawValue) as? String{
                var session = preference.object(forKey: UserDefaultsKeys.userSession.rawValue) as! String
                session = session.replacingOccurrences(of: "-", with: "")
                
                request.addValue(session, forHTTPHeaderField: "session")
                request.addValue(username!, forHTTPHeaderField: "username")
                
                print("My requestss:: \(requestBody)")
                let task = URLSession.shared.dataTask(with: request as URLRequest){
                    data, response, error in
                    if error != nil {
                        print("check staff error:: \(error!.localizedDescription)")
                        return;
                    }
                    
                    do {
                        let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        print("myJSONCheck:: \(myJSON)")
                        if let parseJSON = myJSON {
                            var responseBody: String?
                            responseBody = parseJSON["responseBody"] as? String
                            print("responseBodys:: \(responseBody ?? "")")
                            if let resBody = responseBody{
                                let decrypt = self.decryptAsyncRequest(requestBody: resBody)
                                
                                let decryptedResponseBody = self.convertToNSDictionary(decrypt: decrypt)
                                print(decryptedResponseBody)
                                
                                
                                var responseCode: Int?
                                responseCode = decryptedResponseBody["RESPONSECODE"] as! Int
                                print("responseCode:: \(responseCode)")
                                if responseCode == 0 {
                                    let staffCreditData = decryptedResponseBody["RESPONSEDATA"] as! NSDictionary?
                                    let checkIfStaff = self.preference.object(forKey: "staffNumber")
                                    if (checkIfStaff != nil) {
                                        
                                        self.preference.removeObject(forKey: "staffNumber")
                                        self.preference.removeObject(forKey: "staffCreditData")
                                        // populate with fresh values
                                        self.preference.set(true, forKey: "staffNumber")
                                        self.preference.set(staffCreditData, forKey: "staffCreditData")
                                    }else{
                                        self.preference.set(true, forKey: "staffNumber")
                                        self.preference.set(staffCreditData, forKey: "staffCreditData")
                                        
                                    }
                                    
                                }else{
                                    
                                }
                            }
                        }
                        
                    }catch{
                        print("check staff catch error:: \(error.localizedDescription)")
                    }
                }
                task.resume()
            }else{
                //logout
                print("Logging out")
                logout()
            }
            
        }
        }
    }
    
    //Fuction to display data in gaugeView
    fileprivate func activateDataGauge() {
        shapeLayer.strokeEnd = 0
        btnDataIcon.backgroundColor = UIColor.white
        var btnImage = UIImage(named: "data_icon")
        var tintImage = btnImage?.withRenderingMode(.alwaysTemplate)
        btnDataIcon.setImage(tintImage, for: .normal)
        btnDataIcon.tintColor = UIColor.gray
        
        btnSMSIcon.backgroundColor = UIColor.clear
        btnImage = UIImage(named: "sms")
        tintImage = btnImage?.withRenderingMode(.alwaysTemplate)
        btnSMSIcon.setImage(tintImage, for: .normal)
        btnSMSIcon.tintColor = UIColor.white
        
        btnCallDataIcon.backgroundColor = UIColor.clear
        btnImage = UIImage(named: "call_icon")
        tintImage = btnImage?.withRenderingMode(.alwaysTemplate)
        btnCallDataIcon.setImage(tintImage, for: .normal)
        btnCallDataIcon.tintColor = UIColor.white
        
        lblGaugeViewTitle.text = "Total Data"
        lblGaugeViewLeft.text = "\(dataBucketValueSum)\(dataBucketUnit ?? "")"
        lblGaugeActualValue.text = "of \(dataActualValue ?? "")\(dataActualUnit ?? "")"
        
        var dataUsed = (dataActualInKB - dataBucketInKB)
        dataUsed = (dataBucketInKB / dataActualInKB) * 100
        dataUsed = dataUsed / 100
        print("total Data: \(dataUsed)")
        shapeLayer.strokeEnd = CGFloat(dataUsed)
    }
    
    @objc func showDataGauge(){
        
        activateDataGauge()
    }
    
    //Fuction to display sms in gaugeView
    fileprivate func activateSMSGauge() {
        btnSMSIcon.backgroundColor = UIColor.white
        var btnImage = UIImage(named: "sms")
        var tintImage = btnImage?.withRenderingMode(.alwaysTemplate)
        btnSMSIcon.setImage(tintImage, for: .normal)
        btnSMSIcon.tintColor = UIColor.gray
        
        btnDataIcon.backgroundColor = UIColor.clear
        btnImage = UIImage(named: "data_icon")
        tintImage = btnImage?.withRenderingMode(.alwaysTemplate)
        btnDataIcon.setImage(tintImage, for: .normal)
        btnDataIcon.tintColor = UIColor.white
        
        btnCallDataIcon.backgroundColor = UIColor.clear
        btnImage = UIImage(named: "call_icon")
        tintImage = btnImage?.withRenderingMode(.alwaysTemplate)
        btnCallDataIcon.setImage(tintImage, for: .normal)
        btnCallDataIcon.tintColor = UIColor.white
        
        lblGaugeViewTitle.text = "Sms"
        lblGaugeViewLeft.text = "\(smsBucketValue ?? "")"
        lblGaugeActualValue.text = "of \(smsActualValue ?? "")\(smsActualUnit ?? "")"
        
        let intsmsActual = Double(smsActualValue!)!
        let intsmsBucket = Double(smsBucketValue!)!
        var totalUsed = (intsmsActual - intsmsBucket)
        totalUsed = (intsmsBucket / intsmsActual) * 100
        totalUsed = totalUsed / 100
        print("total Sms: \(totalUsed)")
        shapeLayer.strokeEnd = CGFloat(totalUsed)
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
    
    @objc func showSMSGauge(){
        activateSMSGauge()
    }
    
    //Fuction to display call in gaugeView
    @objc func showCallsGauge(){
        activateCallGauge()
        
    }
    
    //Function to call balances
    func getMobileBalances() {
        
        if AcctType == "PHONE_MOBILE_POST_P"{
            
        }else{
            let postParameters = ["action":"subscriberSummary", "msisdn":msisdn!,"username":username!,"os":getAppVersion()]
            let async_call = URL(string: String.userURL)
            let request = NSMutableURLRequest(url: async_call!)
            request.httpMethod = "POST"
            
            if let jsonParameters = try? JSONSerialization.data(withJSONObject: postParameters, options: .prettyPrinted) {
                
                let theJSONText = String(data: jsonParameters,encoding: String.Encoding.utf8)
                
                let requestBody: Dictionary<String, Any> = [
                    "requestBody":encryptAsyncRequest(requestBody: theJSONText!.description)
                ]
                print("printJJ:: \(requestBody)")
                
                if let postData = (try? JSONSerialization.data(withJSONObject: requestBody, options: JSONSerialization.WritingOptions.prettyPrinted)){
                    request.httpBody = postData
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                    if let sess = preference.object(forKey: UserDefaultsKeys.userSession.rawValue) as? String{
                        var session = preference.object(forKey: UserDefaultsKeys.userSession.rawValue) as! String
                        session = session.replacingOccurrences(of: "-", with: "")
                        request.addValue(session, forHTTPHeaderField: "session")
                        request.addValue(username!, forHTTPHeaderField: "username")
                        
                        let task = URLSession.shared.dataTask(with: request as URLRequest){
                            data, response, error in
                            if error != nil {
                                print("Balance retriving error:: \(error!.localizedDescription)")
                                return;
                            }
                            
                            do {
                                let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                                if let parseJSON = myJSON {
                                    var responseBody: String?
                                    responseBody = parseJSON["responseBody"] as! String?
                                    
                                    print("BalresponseBody:: \(responseBody)")
                                    if let resBody = responseBody {
                                        let decrypt = self.decryptAsyncRequest(requestBody: resBody)
                                        print("Decrypted:: \(decrypt)")
                                        let decryptedResponseBody = self.convertToNSDictionary(decrypt: decrypt)
                                        print(decryptedResponseBody)
                                        var responseCode: Int!
                                        
                                        responseCode = decryptedResponseBody["RESPONSECODE"] as! Int?
                                        
                                        DispatchQueue.main.async {
                                            if responseCode == 0 {
                                                let today = self.getTodayString()
                                                print("Time: \(today)")
                                                self.updateIcon.layer.removeAnimation(forKey: "rotate")
                                                self.preference.set(today, forKey: UserDefaultsKeys.lastUpdate.rawValue)
                                                self.lblLastUpdatedStatus.text = "Last updated \(today)"
                                                let promotions = decryptedResponseBody["PROMOTIONS"] as! NSArray?
                                                print("Promotions : \(promotions)")
                                                
                                                if let promotionsRip = promotions {
                                                    var extraPromoCardTop: CGFloat = 10
                                                    self.preference.set(promotionsRip, forKey: UserDefaultsKeys.userSubscriberSummary.rawValue)
                                                    for obj in promotionsRip{
                                                        if let dict = obj as? NSDictionary{
                                                            let planExpireDuration = dict.value(forKey: "ExpirationDuration") as! String
                                                            let plan = dict.value(forKey: "Promotion") as! String
                                                            
                                                            let rawExpireDuration = dict.value(forKey: "RawExpirationDuration") as! String?
                                                            
                                                            self.lblPlanExpiration.text = planExpireDuration
                                                            
                                                            if let rawExpiree = rawExpireDuration as String? {
                                                                if Int(rawExpiree)! < 7 {
                                                                    self.lblPlanMessage.textColor = UIColor.vodaRed
                                                                }
                                                                
                                                            }
                                                            
                                                            let bundleDict = dict.value(forKey: "BundleDetails") as? NSArray
                                                            if let array = bundleDict {
                                                                let totalBuckets = array.count
                                                                print("Total bucket:: \(totalBuckets)")
                                                                for arrayObject in array {
                                                                    
                                                                    print("bundle arrays \(arrayObject)")
                                                                    if let bundleDict = arrayObject as? NSDictionary{
                                                                        let bucketType = bundleDict.value(forKey: "Type") as! String
                                                                        let actualValue = bundleDict.value(forKey: "ActualValue") as! String
                                                                        let bucketUnit = bundleDict.value(forKey: "BucketUnit") as! String
                                                                        let percentageUsed = bundleDict.value(forKey: "PercentageUsed") as! String
                                                                        let bucketValue = bundleDict.value(forKey: "BucketValue") as! String
                                                                        let unit = bundleDict.value(forKey: "Unit") as! String
                                                                        let actualUnit = bundleDict.value(forKey: "ActualUnit") as! String
                                                                        let rolledOver = bundleDict.value(forKey: "RolledOver") as! Int?
                                                                        print("Bucket Types: \(bucketType)")
                                                                        
                                                                        if totalBuckets >= 3 {
                                                                            print("show gauge")
                                                                            // set isGauge to true
                                                                            // TODO set preference for gaugevisible
                                                                            self.isGaugeVisible = true
                                                                            self.gaugeViewExpirationDuration = dict.value(forKey: "ExpirationDuration") as! String
                                                                            self.gaugeViewPromotion = dict.value(forKey: "Promotion") as! String
                                                                            self.gaugeViewRawExpirationDuration = dict.value(forKey: "RawExpirationDuration") as! String
                                                                            
                                                                            if bucketType == "data"{
                                                                                self.gloBucketType = bucketType
                                                                                self.dataUnit = unit
                                                                                self.dataActualUnit = actualUnit
                                                                                self.dataBucketUnit = bucketUnit
                                                                                self.dataActualValue = actualValue
                                                                                self.dataPercentUsed = percentageUsed
                                                                                self.dataBucketValue = bucketValue
                                                                                let convertActualValue = Double(actualValue)
                                                                                let convBucketValue = Double(bucketValue)
                                                                                self.dataActualValueSum += convertActualValue!
                                                                                self.dataBucketValueSum += convBucketValue!
                                                                                if bucketValue.contains("."){
                                                                                    //                                                                let removeDeci = bucketValue.dropLast(3)
                                                                                    self.lblGaugeViewLeft.text = "\(self.dataBucketValueSum)\(bucketUnit)"
                                                                                }else{
                                                                                    self.lblGaugeViewLeft.text = "\(self.dataBucketValueSum)\(bucketUnit)"
                                                                                }
                                                                                self.lblGaugeActualValue.text = "of \(self.dataActualValueSum)\(actualUnit)"
                                                                                
                                                                                if bucketUnit != "KB"{
                                                                                    self.bucketValueToKB = self.convertGBTOKB(passed: Double(bucketValue)!)
                                                                                    self.dataBucketInKB += self.bucketValueToKB
                                                                                    
                                                                                }else{
                                                                                    self.dataBucketInKB += Double(bucketValue)!
                                                                                }
                                                                                
                                                                                if actualUnit != "KB" {
                                                                                    self.actualValueToKB = self.convertGBTOKB(passed: Double(actualValue)!)
                                                                                    
                                                                                    self.dataActualInKB += self.actualValueToKB
                                                                                }else{
                                                                                    self.dataActualInKB += Double(actualValue)!
                                                                                }
                                                                            }else if bucketType == "sms" {
                                                                                print("Seen sms")
                                                                                self.gloBucketType = "Sms"
                                                                                self.smsUnit = unit
                                                                                self.smsActualUnit = actualUnit
                                                                                self.smsBucketUnit = bucketUnit
                                                                                self.smsActualValue = actualValue
                                                                                self.smsPercentUsed = percentageUsed
                                                                                self.smsBucketValue = bucketValue
                                                                            }else if bucketType == "offnet"{
                                                                                print("Seen offnet")
                                                                                self.gloBucketType = "Total Mins"
                                                                                self.callsUnit = unit
                                                                                self.callsActualUnit = actualUnit
                                                                                self.callsBucketUnit = bucketUnit
                                                                                self.callsActualValue = actualValue
                                                                                self.callsPercentUsed = percentageUsed
                                                                                self.callsBucketValue = bucketValue
                                                                                let convertActualValue = Int(actualValue)
                                                                                print("Actual valu \(actualValue)")
                                                                                let convBucketValue = Double(bucketValue)
                                                                                let convPercentValue = Double(percentageUsed)
                                                                                self.callsActualValueSum += convertActualValue!
                                                                                self.callsBucketValueSum += convBucketValue!
                                                                                self.percentageCallsSum += convPercentValue!
                                                                            }else if bucketType == "onnet"{
                                                                                print("Seen onnet")
                                                                                self.gloBucketType = "Total Mins"
                                                                                self.callsUnit = unit
                                                                                self.callsActualUnit = actualUnit
                                                                                self.callsBucketUnit = bucketUnit
                                                                                self.callsActualValue = actualValue
                                                                                self.callsPercentUsed = percentageUsed
                                                                                self.callsBucketValue = bucketValue
                                                                                let convertActualValue = Int(actualValue)
                                                                                let convBucketValue = Double(bucketValue)
                                                                                let convPercentValue = Double(percentageUsed)
                                                                                self.callsActualValueSum += convertActualValue!
                                                                                self.callsBucketValueSum += convBucketValue!
                                                                                self.percentageCallsSum += convPercentValue!
                                                                            }else if bucketType == "idd"{
                                                                                self.gloBucketType = "Total Mins"
                                                                                self.callsUnit = unit
                                                                                self.callsActualUnit = actualUnit
                                                                                self.callsBucketUnit = bucketUnit
                                                                                self.callsActualValue = actualValue
                                                                                self.callsPercentUsed = percentageUsed
                                                                                self.callsBucketValue = bucketValue
                                                                                let convertActualValue = Int(actualValue)
                                                                                let convBucketValue = Double(bucketValue)
                                                                                let convPercentValue = Double(percentageUsed)
                                                                                self.callsActualValueSum += convertActualValue!
                                                                                self.callsBucketValueSum += convBucketValue!
                                                                                self.percentageCallsSum += convPercentValue!
                                                                            }else{
                                                                                self.gloBucketType = "Total Mins"
                                                                                self.callsUnit = unit
                                                                                self.callsActualUnit = actualUnit
                                                                                self.callsBucketUnit = bucketUnit
                                                                                self.callsActualValue = actualValue
                                                                                self.callsPercentUsed = percentageUsed
                                                                                self.callsBucketValue = bucketValue
                                                                                let convertActualValue = Int(actualValue)
                                                                                let convBucketValue = Double(bucketValue)
                                                                                let convPercentValue = Double(percentageUsed)
                                                                                self.callsActualValueSum += convertActualValue!
                                                                                self.callsBucketValueSum += convBucketValue!
                                                                                self.percentageCallsSum += convPercentValue!
                                                                            }
                                                                        }else{
                                                                            print("Didn't count")
                                                                            
                                                                            let extraPromoCard = UIView()
                                                                            self.scrollView.addSubview(extraPromoCard)
                                                                            extraPromoCard.translatesAutoresizingMaskIntoConstraints = false
                                                                            extraPromoCard.backgroundColor = UIColor.black.withAlphaComponent(0.60)
                                                                            extraPromoCard.heightAnchor.constraint(equalToConstant: 150).isActive = true
                                                                            extraPromoCard.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
                                                                            extraPromoCard.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive  = true
                                                                            extraPromoCard.topAnchor.constraint(equalTo: self.updateIcon.bottomAnchor, constant: extraPromoCardTop).isActive = true
                                                                            
                                                                            //Red image on offer view
                                                                            let redImageView = UIImageView()
                                                                            extraPromoCard.addSubview(redImageView)
                                                                            redImageView.translatesAutoresizingMaskIntoConstraints = false
                                                                            redImageView.backgroundColor = UIColor.vodaRed
                                                                            redImageView.widthAnchor.constraint(equalToConstant: 5).isActive = true
                                                                            redImageView.topAnchor.constraint(equalTo: extraPromoCard.topAnchor, constant: 8).isActive = true
                                                                            redImageView.bottomAnchor.constraint(equalTo: extraPromoCard.bottomAnchor, constant: -8).isActive = true
                                                                            redImageView.leadingAnchor.constraint(equalTo: extraPromoCard.leadingAnchor, constant: 10).isActive = true
                                                                            
                                                                            // Promotion label
                                                                            let lblPromotion = UILabel()
                                                                            
                                                                            extraPromoCard.addSubview(lblPromotion)
                                                                            lblPromotion.translatesAutoresizingMaskIntoConstraints = false
                                                                            lblPromotion.text = plan
                                                                            lblPromotion.textColor = UIColor.white
                                                                            lblPromotion.font = UIFont(name: String.defaultFontR, size: 20)
                                                                            lblPromotion.leadingAnchor.constraint(equalTo: redImageView.trailingAnchor, constant: 20).isActive = true
                                                                            lblPromotion.topAnchor.constraint(equalTo: extraPromoCard.topAnchor, constant: 20).isActive = true
                                                                            lblPromotion.trailingAnchor.constraint(equalTo: extraPromoCard.trailingAnchor, constant: -10).isActive = true
                                                                            lblPromotion.numberOfLines = 0
                                                                            lblPromotion.lineBreakMode = .byWordWrapping
                                                                            
                                                                            let promoBucketDetails = UILabel()
                                                                            extraPromoCard.addSubview(promoBucketDetails)
                                                                            promoBucketDetails.translatesAutoresizingMaskIntoConstraints = false
                                                                            promoBucketDetails.font = UIFont(name: String.defaultFontB, size: 22)
                                                                            promoBucketDetails.textColor = UIColor.white
                                                                            if let rollOver = rolledOver {
                                                                                if rollOver == 1 {
                                                                                    promoBucketDetails.text = "\(bucketValue)\(bucketUnit) left"
                                                                                }else{
                                                                                    promoBucketDetails.text = "\(bucketValue)\(bucketUnit) left of \(actualValue)\(actualUnit)"
                                                                                }
                                                                            }
                                                                            
                                                                            promoBucketDetails.leadingAnchor.constraint(equalTo: redImageView.trailingAnchor, constant: 20).isActive = true
                                                                            promoBucketDetails.topAnchor.constraint(equalTo: lblPromotion.bottomAnchor, constant: 30).isActive = true
                                                                            promoBucketDetails.trailingAnchor.constraint(equalTo: extraPromoCard.trailingAnchor, constant: -20).isActive = true
                                                                            promoBucketDetails.numberOfLines = 0
                                                                            promoBucketDetails.lineBreakMode = .byWordWrapping
                                                                            
                                                                            //Promotion expiration date
                                                                            let lblPromotionExpire = UILabel()
                                                                            extraPromoCard.addSubview(lblPromotionExpire)
                                                                            lblPromotionExpire.translatesAutoresizingMaskIntoConstraints = false
                                                                            if let rawExpireWrap = rawExpireDuration {
                                                                                if Int(rawExpireWrap)! < 7 {
                                                                                    lblPromotionExpire.textColor = UIColor.vodaRed
                                                                                }else{
                                                                                    lblPromotionExpire.textColor = UIColor.white
                                                                                }
                                                                            }
                                                                            
                                                                            lblPromotionExpire.text = planExpireDuration
                                                                            lblPromotionExpire.font = UIFont(name: String.defaultFontR, size: 17)
                                                                            lblPromotionExpire.leadingAnchor.constraint(equalTo: redImageView.leadingAnchor, constant: 20).isActive = true
                                                                            lblPromotionExpire.bottomAnchor.constraint(equalTo: extraPromoCard.bottomAnchor, constant: -20).isActive = true
                                                                            lblPromotionExpire.trailingAnchor.constraint(equalTo: extraPromoCard.trailingAnchor, constant: -10).isActive = true
                                                                            lblPromotionExpire.numberOfLines = 0
                                                                            lblPromotionExpire.lineBreakMode = .byWordWrapping
                                                                            
                                                                            extraPromoCardTop = extraPromoCardTop + 160
                                                                        }
                                                                    }
                                                                }
                                                            } //The lasst
                                                        }
                                                    }
                                                    print("total calls given \(self.callsActualValueSum)")
                                                    print("total calls left \(self.callsBucketValueSum)")
                                                    print("total calls percentage \(self.percentageCallsSum)")
                                                    print("GaugeView Promo \(self.gaugeViewPromotion)")
                                                    print("Sum actual in KB \(self.dataActualInKB)")
                                                    print("Sum bucket in KB \(self.dataBucketInKB)")
                                                    var dataUsed = (self.dataActualInKB - self.dataBucketInKB)
                                                    dataUsed = (self.dataBucketInKB / self.dataActualInKB) * 100
                                                    dataUsed = dataUsed / 100
                                                    //Calls
                                                    let intCallsActual = Double(self.callsActualValueSum)
                                                    let intsCallsBucket = Double(self.callsBucketValueSum)
                                                    var callsUsed = (intCallsActual - intsCallsBucket)
                                                    callsUsed = (intsCallsBucket / intCallsActual) * 100
                                                    callsUsed = callsUsed / 100
                                                    //SMS
                                                    if let intsmsActualOptional = self.smsActualValue{
                                                        let intsmsActual = Double(intsmsActualOptional)!
                                                        let intsmsBucket = Double(self.smsBucketValue!)!
                                                        var SMSUsed = (intsmsActual - intsmsBucket)
                                                        
                                                        SMSUsed = (intsmsBucket / intsmsActual) * 100
                                                        SMSUsed = SMSUsed / 100
                                                        
                                                        if dataUsed < 0.25 && callsUsed < 0.25 && SMSUsed < 0.25 {
                                                            self.lblPlanMessage.text = "You are running out of DATA, VOICE, SMS"
                                                        }else if dataUsed < 0.25 && callsUsed < 0.25{
                                                            self.lblPlanMessage.text = "You are running out of DATA, VOICE"
                                                        }else if dataUsed < 0.25 && SMSUsed < 0.25 {
                                                            self.lblPlanMessage.text = "You are running out of DATA, SMS"
                                                        }else if callsUsed < 0.25 && SMSUsed < 0.25 {
                                                            self.lblPlanMessage.text = "You are running out of VOICE, SMS"
                                                        }else if dataUsed < 0.25 {
                                                            self.lblPlanMessage.text = "You are running out of DATA"
                                                        }else if callsUsed < 0.25 {
                                                            self.lblPlanMessage.text = "You are running out of VOICE"
                                                        }else if SMSUsed < 0.25 {
                                                            self.lblPlanMessage.text = "You are running out of SMS"
                                                        }
                                                    }
                                                    if self.gaugeViewPromotion == nil {
                                                        print("Dont show gauge again")
                                                        self.isGaugeVisible = false
                                                        
                                                    }
                                                    if !self.isGaugeVisible {
                                                        self.gaugeViewHolder.isHidden = true
                                                        self.btnGoFBB.isHidden = true
                                                        self.btnCallDataIcon.isHidden = true
                                                        self.btnOffers.isHidden = true
                                                        
                                                    }else{
                                                        self.defaultCallCreditViewTop1?.isActive = false
                                                        self.defaultCallCreditViewTop2?.isActive = true
                                                        self.defaultCallCreditViewLeading1?.isActive = false
                                                        self.defaultCallCreditViewLeading2?.isActive = true
                                                        self.defaultCallCreditViewTrailing1?.isActive = false
                                                        self.defaultCallCreditViewTrailing2?.isActive = true
                                                        self.yendiAgoroTop1?.isActive = false
                                                        self.yendiAgoroTop2?.isActive = true
                                                        self.supportTop1?.isActive = false
                                                        self.supportTop2?.isActive = true
                                                        self.freeshsTop1?.isActive = false
                                                        self.freeshsTop2?.isActive = true
                                                        self.gaugeViewHolder.isHidden = false
                                                        self.lblPlan.text = self.gaugeViewPromotion
                                                        self.lblPlanExpiration.text = self.gaugeViewExpirationDuration
                                                        if Int(self.gaugeViewRawExpirationDuration!)! < 7 {
                                                            self.lblPlanExpiration.textColor = UIColor.vodaRed
                                                        }
                                                        
                                                        self.lblCreditTitle.font = UIFont(name: String.defaultFontR, size: 17)
                                                        self.lblCreditRem.font = UIFont(name: String.defaultFontB, size: 17)
                                                        self.btnCallDataIcon.isHidden = false
                                                        self.btnGoFBB.isHidden = false
                                                        self.btnOffers.isHidden = false
                                                        self.activateDataGauge()
                                                        self.shapeLayer.strokeEnd = CGFloat(dataUsed)
                                                    }
                                                }
                                                let balance = decryptedResponseBody["BALANCE"] as! NSDictionary?
                                                
                                                if let accBalance = balance!["AccountBalance"] as! String? {
                                                    self.accountBalance = accBalance
                                                    self.preference.set(self.accountBalance!, forKey: "accountBalance")
                                                }
                                                if let accBalanceLabel = balance!["AccountBalanceLabel"] as! String? {
                                                    self.accountBalanceLabel = accBalanceLabel
                                                    self.preference.set(self.accountBalanceLabel!, forKey: "accBalanceLabel")
                                                    self.lblCreditRem.text = self.accountBalanceLabel!
                                                }
                                                if let balLabel = balance!["BalanceLabel"] as! String? {
                                                    self.balanceLabel = balLabel
                                                    self.preference.set(self.balanceLabel!, forKey: "balanceLabel")
                                                    if Int(self.deviceWidth!) <= 320 {
                                                        self.lblCreditTitle.font = UIFont(name: String.defaultFontR, size: 15)
                                                    }
                                                    self.lblCreditTitle.text = self.balanceLabel!
                                                }
                                                
                                            }
                                            
                                        }
                                    }
                                }
                            }catch{
                                print("Balance retriving error:: \(error.localizedDescription)")
                            }
                        }
                        task.resume()
                    }else{
                        logout()
                    }
                    
                }
                
            }
        }
    }
    
    @objc func updateHome(){
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = 1.0
        rotateAnimation.repeatCount = Float.greatestFiniteMagnitude;
        
        updateIcon.layer.add(rotateAnimation, forKey: "rotate")
        getMobileBalances()
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
    
    @objc func goToFreeSHS(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "TopUp", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "FreeSHS")
        self.addChildViewController(moveTo)
        moveTo.view.frame = self.view.frame
        self.view.addSubview(moveTo.view)
        moveTo.didMove(toParentViewController: self)
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
