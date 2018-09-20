//
//  homeVC.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 19/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class homeVC: baseViewControllerM {
    
    var defaultImageUrl: String?
    var defaultAccName: String?
    var msisdn: String?
    var username: String?
    var defaultMSISDN: String?
    var primaryID: String?
    var accountBalance: String?
    var balanceLabel: String?
    var accountBalanceLabel: String?
//    let preference = UserDefaults.standard
//    var altDisplayName: String?
//    var altServiceID: String?
//    var altAcctType: String?
//    var ServiceID: String?
//    var AcctType: String?
    var fontSizeForCredit: CGFloat = 30
    
    let defaultAccImage = UIImageView()
    let defaultCallCreditView = UIView()
    let lblCreditTitle = UILabel()
    let lblCreditRem = UILabel()
    let defaultAccDisName = UILabel()
    let yendiagoro = UIImageView()
    let twoFourSeven = UIImageView()
    let updateIcon = UIImageView()
    let lblLastUpdatedStatus = UILabel()
    let lblShakeHeader = UILabel()
    let btnTopUp = UIButton()
    let shakeImage = UIImageView(image: #imageLiteral(resourceName: "shake_bubble"))
    let lblShakeDesc = UILabel()
    let shakeButton = UIButton()
    let lblPromotion = UILabel()
    let lblPromotionExpire = UILabel()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        zeroAlpha()
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        print(UserData)
        let defaultService = UserData["DefaultService"] as! String
        username = UserData["Username"] as! String?
        msisdn = preference.object(forKey: "defaultMSISDN") as! String?
        balanceLabel = preference.object(forKey: "balanceLabel") as! String?
        accountBalanceLabel = preference.object(forKey: "accBalanceLabel") as! String?
        
//        print("yos:: \(defaultService)")
        let Services = preference.object(forKey: "ServiceList")
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
        backgroundCalls()
        // Check for internet connection
        checkConnection()
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showSlider()
    }
    
    override func viewDidLayoutSubviews() {
        
        defaultAccImage.layer.cornerRadius = defaultAccImage.frame.size.width / 2
        defaultAccImage.clipsToBounds = true
        defaultAccImage.layer.borderColor = UIColor.white.cgColor
        defaultAccImage.layer.borderWidth = 2
        
        //topup button
        btnTopUp.layer.cornerRadius = btnTopUp.frame.size.width / 2
        btnTopUp.clipsToBounds = true
    }
    
    func showSlider(){
        UIView.animate(withDuration: 1, animations: {
            self.shakeImage.alpha = 1
            self.lblShakeHeader.alpha = 1
            self.lblShakeDesc.alpha = 1
            self.shakeButton.alpha = 1
        }) { (true) in
            self.showCredit()
        }
    }
    
    func showCredit(){
        UIView.animate(withDuration: 1, animations: {
            self.defaultCallCreditView.alpha = 1
            self.lblCreditTitle.alpha = 1
            self.lblCreditRem.alpha = 1
            self.btnTopUp.alpha = 1
        }) { (true) in
            self.showDefaultImage()
        }
    }
    
    func showDefaultImage(){
        UIView.animate(withDuration: 0.5, animations: {
            self.defaultAccImage.alpha = 1
            self.defaultAccDisName.alpha = 1
        }) { (true) in
            self.showTwoFourSeven()
        }
    }
    func showTwoFourSeven(){
        UIView.animate(withDuration: 1, animations: {
            self.twoFourSeven.alpha = 1
        }) { (true) in
            self.showLastUpdate()
        }
    }
    
    func showLastUpdate() {
        UIView.animate(withDuration: 1, animations: {
            self.lblLastUpdatedStatus.alpha = 1
            self.updateIcon.alpha = 1
        }) { (true) in
            self.showYendiAgoro()
        }
    }
    
    func showYendiAgoro(){
        UIView.animate(withDuration: 1, animations: {
            self.yendiagoro.alpha = 1
        }) { (true) in
            UIView.animate(withDuration: 1, animations: {
                self.yendiagoro.alpha = 0
            }, completion: { (true) in
                self.yendiagoro.alpha = 1
            })
        }
    }
    func setUpViews1(){
        
        let bgImage = UIImageView()
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bgImage)
        bgImage.image = UIImage(named: "morning_bg_")
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
        
        let scrollView = UIScrollView()
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
        scrollView.addSubview(shakeImage)
        shakeImage.translatesAutoresizingMaskIntoConstraints = false
        shakeImage.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 20).isActive = true
        shakeImage.topAnchor.constraint(equalTo: app_logo.bottomAnchor, constant: 20).isActive = true
        shakeImage.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -20).isActive = true
        shakeImage.heightAnchor.constraint(equalToConstant: 170).isActive = true
//        shakeImage.contentMode = .scaleAspectFit
        
        //shake header
        scrollView.addSubview(lblShakeHeader)
        lblShakeHeader.translatesAutoresizingMaskIntoConstraints = false
        lblShakeHeader.textColor = UIColor.white
        lblShakeHeader.text = "Shake on Vodafone X"
        lblShakeHeader.numberOfLines = 0
        lblShakeHeader.lineBreakMode = .byWordWrapping
        lblShakeHeader.font = UIFont(name: String.defaultFontB, size: 20)
        lblShakeHeader.textAlignment = .center
        lblShakeHeader.leadingAnchor.constraint(equalTo: shakeImage.leadingAnchor, constant: 20).isActive = true
        lblShakeHeader.topAnchor.constraint(equalTo: shakeImage.topAnchor, constant: 20).isActive = true
        lblShakeHeader.trailingAnchor.constraint(equalTo: shakeImage.trailingAnchor, constant: -20).isActive = true
        
        //Shake Description
        scrollView.addSubview(lblShakeDesc)
        lblShakeDesc.translatesAutoresizingMaskIntoConstraints = false
        lblShakeDesc.textColor = UIColor.white
//        lblShakeDesc.textAlignment = .center
        lblShakeDesc.numberOfLines = 0
        lblShakeDesc.lineBreakMode = .byWordWrapping
        lblShakeDesc.font = UIFont(name: String.defaultFontR, size: 16)
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
        shakeButton.setTitle("1GB FREE ON SHAKE - CLICK HERE", for: .normal)
        shakeButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        shakeButton.leadingAnchor.constraint(equalTo: shakeImage.leadingAnchor, constant: 20).isActive = true
        shakeButton.trailingAnchor.constraint(equalTo: shakeImage.trailingAnchor, constant: -20).isActive = true
        shakeButton.topAnchor.constraint(equalTo: lblShakeDesc.bottomAnchor, constant: 10).isActive = true
        
        //Default account image
        scrollView.addSubview(defaultAccImage)
        defaultAccImage.translatesAutoresizingMaskIntoConstraints = false
        defaultAccImage.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "default_profile"), options: [.continueInBackground, .progressiveDownload])
        
        defaultAccImage.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        defaultAccImage.topAnchor.constraint(equalTo: shakeImage.bottomAnchor, constant: 20).isActive = true
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
        defaultCallCreditView.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 45).isActive = true
        defaultCallCreditView.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -45).isActive = true
        defaultCallCreditView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        defaultCallCreditView.topAnchor.constraint(equalTo: defaultAccDisName.bottomAnchor, constant: 20).isActive = true
        defaultCallCreditView.layer.cornerRadius = 40
        defaultCallCreditView.clipsToBounds = true
        
        //top up button in call credit view
        scrollView.addSubview(btnTopUp)
        btnTopUp.translatesAutoresizingMaskIntoConstraints = false
        btnTopUp.backgroundColor = UIColor.white
        btnTopUp.widthAnchor.constraint(equalToConstant: 80).isActive = true
        btnTopUp.heightAnchor.constraint(equalToConstant: 80).isActive = true
        btnTopUp.topAnchor.constraint(equalTo: defaultAccDisName.bottomAnchor, constant: 20).isActive = true
//        btnTopUp.bottomAnchor.constraint(equalTo: defaultCallCreditView.bottomAnchor).isActive = true
        btnTopUp.trailingAnchor.constraint(equalTo: defaultCallCreditView.trailingAnchor).isActive = true
        let topupImage = UIImage(named: "top_up")
        btnTopUp.setImage(topupImage, for: .normal)
        btnTopUp.imageEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20)
        btnTopUp.addTarget(self, action: #selector(goToTopUp), for: .touchUpInside)
        
        //label for credit title
        scrollView.addSubview(lblCreditTitle)
        lblCreditTitle.translatesAutoresizingMaskIntoConstraints = false
        if let creditTitle = balanceLabel {
            lblCreditTitle.text = creditTitle
        }else{
            lblCreditTitle.text = "Credit remaining"
        }
        
        lblCreditTitle.textColor = UIColor.black
        lblCreditTitle.font = UIFont(name: String.defaultFontR, size: 19)
        lblCreditTitle.leadingAnchor.constraint(equalTo: defaultCallCreditView.leadingAnchor, constant: 25).isActive = true
        lblCreditTitle.topAnchor.constraint(equalTo: defaultCallCreditView.topAnchor, constant: 20).isActive = true
        
        //label for actual credit
        scrollView.addSubview(lblCreditRem)
        lblCreditRem.translatesAutoresizingMaskIntoConstraints = false
        if let creditRem = accountBalanceLabel {
            lblCreditRem.text = creditRem
        }else{
            lblCreditRem.text = "GHS -- --"
        }
        
        lblCreditRem.textColor = UIColor.black
        let credit = lblCreditRem.text?.count
        if credit! > 5 {
            fontSizeForCredit = 20
        }
        lblCreditRem.font = UIFont(name: String.defaultFontB, size: fontSizeForCredit)
        lblCreditRem.leadingAnchor.constraint(equalTo: defaultCallCreditView.leadingAnchor, constant: 25).isActive = true
        lblCreditRem.topAnchor.constraint(equalTo: lblCreditTitle.bottomAnchor, constant: 8).isActive = true
        
        //yendi agoro
        scrollView.addSubview(yendiagoro)
        yendiagoro.translatesAutoresizingMaskIntoConstraints = false
        yendiagoro.image = UIImage(named: "spinlogo")
        yendiagoro.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        yendiagoro.topAnchor.constraint(equalTo: defaultAccDisName.bottomAnchor, constant: 150).isActive = true
        yendiagoro.heightAnchor.constraint(equalToConstant: 80).isActive = true
        yendiagoro.widthAnchor.constraint(equalToConstant: 140).isActive = true
        yendiagoro.isUserInteractionEnabled = true
        
        let yendiAgoroRec = UITapGestureRecognizer(target: self, action: #selector(goToYendiAgoro))
        yendiagoro.addGestureRecognizer(yendiAgoroRec)
        
        //24/7
        scrollView.addSubview(twoFourSeven)
        twoFourSeven.translatesAutoresizingMaskIntoConstraints = false
        twoFourSeven.image = UIImage(named: "support")
        twoFourSeven.topAnchor.constraint(equalTo: defaultAccDisName.bottomAnchor, constant: 140).isActive = true
        twoFourSeven.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -3).isActive = true
        twoFourSeven.widthAnchor.constraint(equalToConstant: 80).isActive = true
        twoFourSeven.heightAnchor.constraint(equalToConstant: 80).isActive = true
        twoFourSeven.isUserInteractionEnabled = true
        
        let twoFourSevenRec = UITapGestureRecognizer(target: self, action: #selector(goToSupport))
        twoFourSeven.addGestureRecognizer(twoFourSevenRec)
        
        //update icon
        scrollView.addSubview(updateIcon)
        updateIcon.translatesAutoresizingMaskIntoConstraints = false
        updateIcon.image = UIImage(named: "progressarrow")
        updateIcon.topAnchor.constraint(equalTo: yendiagoro.bottomAnchor, constant: 100).isActive = true
        updateIcon.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 60).isActive = true
        updateIcon.widthAnchor.constraint(equalToConstant: 15).isActive = true
        updateIcon.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        //Last updated label
        scrollView.addSubview(lblLastUpdatedStatus)
        lblLastUpdatedStatus.translatesAutoresizingMaskIntoConstraints = false
        lblLastUpdatedStatus.text = "Last updated on ........."
        lblLastUpdatedStatus.font = UIFont(name: String.defaultFontR, size: 13)
        lblLastUpdatedStatus.textColor = UIColor.white
        lblLastUpdatedStatus.leadingAnchor.constraint(equalTo: updateIcon.trailingAnchor, constant: 10).isActive = true
        lblLastUpdatedStatus.topAnchor.constraint(equalTo: yendiagoro.bottomAnchor, constant: 105).isActive = true
        
        
        //Bottom view to show data offer
        let bottomDarkView = UIView()
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
        lblPromotionExpire.lineBreakMode = .byWordWrapping
        
        scrollView.contentSize.height = 950
    }
    
    func backgroundCalls(){
        checkStaff()
        getMobileBalances()
    }
    
    //Function to check for staff Number
    func checkStaff(){
        let postParameters: Dictionary<String, Any> = [
            "action":"checkStaffNumber",
            "msisdn":msisdn!,
            "username":username!,
            "os":getAppVersion()
        ]
        let async_call = URL(string: String.offers)
        let request = NSMutableURLRequest(url: async_call!)
        request.httpMethod = "POST"
        
        if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
            request.httpBody = postData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                if error != nil {
                    print("check staff error:: \(error!.localizedDescription)")
                    return;
                }
                
                do {
                    let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    if let parseJSON = myJSON {
                        var responseCode: Int?
                        responseCode = parseJSON["RESPONSECODE"] as! Int?
                        if responseCode == 0 {
                            let staffCreditData = parseJSON["RESPONSEDATA"] as! NSDictionary?
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
                    
                }catch{
                    print("check staff catch error:: \(error.localizedDescription)")
                }
            }
            task.resume()
        }
    }
    
    //Function to call balances
    func getMobileBalances() {
        let postParameters: Dictionary<String, Any> = [
            "action":"subscriberSummary",
            "msisdn":msisdn!,
            "username":username!,
            "os":getAppVersion()
        ]
        let async_call = URL(string: String.userURL)
        let request = NSMutableURLRequest(url: async_call!)
        request.httpMethod = "POST"
        
        if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
            request.httpBody = postData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                if error != nil {
                    print("Balance retriving error:: \(error!.localizedDescription)")
                    return;
                }
                
                do {
                    let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    if let parseJSON = myJSON {
                        var responseCode: Int?
                        responseCode = parseJSON["RESPONSECODE"] as! Int?
                        DispatchQueue.main.async {
                            if responseCode == 0 {
                                let promotions = parseJSON["PROMOTIONS"] as! NSArray?
                                let balance = parseJSON["BALANCE"] as! NSDictionary?
                                print("promos \(promotions!)")
                                print("balance \(balance!)")
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
                                    self.lblCreditTitle.text = self.balanceLabel!
                                }
                                
                                
                                
                                
                            }
                        }
                    }
                }catch{
                    print("Balance retriving error:: \(error.localizedDescription)")
                }
            }
            task.resume()
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
    func zeroAlpha(){
        shakeImage.alpha = 0
        lblShakeHeader.alpha = 0
        lblShakeDesc.alpha = 0
        shakeButton.alpha = 0
        defaultCallCreditView.alpha = 0
        btnTopUp.alpha = 0
        lblCreditTitle.alpha = 0
        lblCreditRem.alpha = 0
        defaultAccImage.alpha = 0
        defaultAccDisName.alpha = 0
        twoFourSeven.alpha = 0
        updateIcon.alpha = 0
        lblLastUpdatedStatus.alpha = 0
        yendiagoro.alpha = 0
    }
}