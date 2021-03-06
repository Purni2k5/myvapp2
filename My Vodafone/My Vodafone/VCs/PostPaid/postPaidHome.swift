//
//  postPaidHome.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 01/11/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class postPaidHome: baseViewControllerM {

    var dService: String?
    var displayName: String?
    var lastUpdate: String?
    var username: String?
    var userID: String?
    var accountNumber: String?
    var currentSpend: String?
    var currSpendDesc: String?
    var currSpendCircle: String?
    var outBill: String!
    var outPlan: String?
    var balanceLabel: String!
    var roamingAmt: String?
    var callsAmt: String?
    var internetAmt: String?
    var smsAmt: String?
    var msisdn: String?
    var lblOutBill = UILabel()
    let lblExclude = UILabel()
    let lblOutPlan = UILabel()
    let lblRoamingDesc = UILabel()
    let lblInternetDesc = UILabel()
    let lblCallsDesc = UILabel()
    let lblSMSDesc = UILabel()
    var roamingDesc: String?
    var callsDesc: String?
    var internetDesc: String?
    var smsDesc: String?
    
    var allowSensitiveData: Bool?
    var isBreakDownShowing: Bool = false
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let bgImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let motherViewBBHome: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let greetingsImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblBill: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.black
        return view
    }()
    
    let darkView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.70)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblCurrSpend: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: String.defaultFontR, size: 30)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        return view
    }()
    
    let btnDropDown: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postPaidDetailsCard: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    let updateIcon = UIButton()
    let lblLastUpdatedStatus = UILabel()
    let lblCurrSpendCircle = UILabel()
    let lblRoaming = UILabel()
    let lblCalls = UILabel()
    let lblInternet = UILabel()
    let lblSMS = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let services = preference.object(forKey: UserDefaultsKeys.ServiceList.rawValue)
        //        print(services)
        dService = preference.object(forKey: UserDefaultsKeys.DefaultService.rawValue) as? String
        //        print(dService)
        let responseData = preference.object(forKey: "responseData") as! NSDictionary
        username = responseData["Username"] as? String
        lastUpdate = preference.object(forKey: UserDefaultsKeys.lastUpdate.rawValue) as! String?
        
        msisdn = preference.object(forKey: "defaultMSISDN") as! String?
        allowSensitiveData = preference.object(forKey: UserDefaultsKeys.isSensitiveDataAllowed.rawValue) as? Bool
        
        
        let outBillData = preference.object(forKey: UserDefaultsKeys.postPaidOutBill.rawValue) as? String
        print(outBillData)
        if outBillData != nil {
            if outBillData == "" {
                
            }else{
                let resBody = outBillData
                let decrypt = decryptAsyncRequest(requestBody: resBody!)
                
                var postBalance: NSDictionary!
                let decryptedResponseBody = self.convertToNSDictionary(decrypt: decrypt)
                postBalance = decryptedResponseBody["BALANCE"] as! NSDictionary?
                balanceLabel = postBalance["BalanceLabel"] as! String?
                outBill = postBalance["AccountBalanceLabel"] as! String?
            }
            
        }else{
            
        }
        let postBillBreakData = preference.object(forKey: UserDefaultsKeys.postPaidBreakDown.rawValue) as? String
        if postBillBreakData != nil {
            if postBillBreakData == "" {
                
            }else{
                let resBody = postBillBreakData
                let decrypt = decryptAsyncRequest(requestBody: resBody!)
                var postBreakDown: NSDictionary!
                let decryptedResponseBody = self.convertToNSDictionary(decrypt: decrypt)
                print("Decry \(decryptedResponseBody)")
                postBreakDown = decryptedResponseBody["RESPONSEMESSAGE"] as! NSDictionary?
                //                                        print(responseMessage)
                let currentSpendData = postBreakDown["CurrentSpend"] as! NSDictionary?
                let outOfPlanSpend = postBreakDown["OutOfPlanSpend"] as! NSDictionary?
                
                if let currSpendData = currentSpendData {
                    currentSpend = currSpendData["Amount"] as! String?
                    currSpendDesc = currSpendData["Desc"] as! String?
                    lblCurrSpend.text = currentSpend
                    lblExclude.text = currSpendDesc
                }
                if let currOutOfPlanSpend = outOfPlanSpend {
                    
                    currSpendCircle = currOutOfPlanSpend["Total"] as! String?
                    
                    outPlan = currOutOfPlanSpend["Desc"] as! String?
                    let components = currOutOfPlanSpend["Components"] as! NSArray?
                    if let array = components {
                        //                                                let totalArray = array.count
                        var counter = 0
                        for obj in array {
                            if let dict = obj as? NSDictionary{
                                counter = counter + 1
                                let description = dict.value(forKey: "Desc") as? String
                                let planType = dict.value(forKey: "Type") as? String
                                let planAmt = dict.value(forKey: "Amount") as? String
                                if counter == 1 {
                                    if let desc = description {
                                        roamingDesc = desc
                                        roamingAmt = planAmt
                                        lblRoamingDesc.text = roamingDesc
                                        lblRoaming.text = roamingAmt
                                    }
                                }else if counter == 2 {
                                    if let desc = description {
                                        callsDesc = desc
                                        callsAmt = planAmt
                                        lblCallsDesc.text = callsDesc
                                        lblCalls.text = callsAmt
                                    }
                                }else if counter == 3 {
                                    if let desc = description {
                                        internetDesc = desc
                                        internetAmt = planAmt
                                        lblInternetDesc.text = internetDesc
                                        lblInternet.text = internetAmt
                                    }
                                }else if counter == 4 {
                                    if let desc = description {
                                        smsDesc = desc
                                        smsAmt = planAmt
                                        lblSMSDesc.text = smsDesc
                                        lblSMS.text = smsAmt
                                    }
                                }
                            }
                        }
                    }
                    
                }
            }
            
        }else{
            
        }
        if let serviceArray = services as? NSArray{
            var foundDefault = false
            for obj in serviceArray{
                print(foundDefault)
                if foundDefault == false{
                    if let dict = obj as? NSDictionary {
                        displayName = dict.value(forKey: "DisplayName") as? String
                        let id = dict.value(forKey: "ID") as! String?
                        print("ID: \(id)")
                        if id == dService{
                            displayName = dict.value(forKey: "DisplayName") as? String
                            userID = dict.value(forKey: "primaryID") as? String
                            accountNumber = dict.value(forKey: "SecondaryID") as? String
                            AcctType = dict.value(forKey: "Type") as! String?
                            foundDefault = true
                            print("dName \(displayName)")
                        }
                    }
                }
                
            }
        }
        print("account type \(AcctType)")
        
        setUpViewsPostPaid()
        if AcctType == "PHONE_MOBILE_PRE_P" || AcctType == "BB_FIXED_PRE_P"{
            prePaidMenu()
        }else if AcctType == "PHONE_MOBILE_POST_P" {
            postPaidMenu()
        }
        else{
            prePaidMenu()
        }
        checkConnection()
        if CheckInternet.Connection(){
            loadPostPaidDetails()
            
        }
        
        checkConnection()
    }

    func setUpViewsPostPaid(){
        let viewWidth = view.frame.width
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
        
        view.addSubview(motherView)
        motherView.backgroundColor = UIColor.clear
        motherView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        motherView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        motherView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        motherView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        motherView.addSubview(scrollView)
        scrollView.backgroundColor = UIColor.clear
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
        
        scrollView.addSubview(greetingsImage)
        greetingsImage.image = UIImage(named: "bubble2")
        greetingsImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        greetingsImage.topAnchor.constraint(equalTo: lblMenu.bottomAnchor, constant: 20).isActive = true
        greetingsImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        greetingsImage.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        let greetingsRed = UIImageView()
        greetingsImage.addSubview(greetingsRed)
        greetingsRed.translatesAutoresizingMaskIntoConstraints = false
        greetingsRed.backgroundColor = UIColor.vodaRed
        greetingsRed.widthAnchor.constraint(equalToConstant: 3).isActive = true
        greetingsRed.leadingAnchor.constraint(equalTo: greetingsImage.leadingAnchor, constant: 50).isActive = true
        greetingsRed.topAnchor.constraint(equalTo: greetingsImage.topAnchor, constant: 40).isActive = true
        greetingsRed.bottomAnchor.constraint(equalTo: greetingsImage.bottomAnchor, constant: -40).isActive = true
        
        let lblGreetings = UILabel()
        greetingsImage.addSubview(lblGreetings)
        lblGreetings.translatesAutoresizingMaskIntoConstraints = false
        lblGreetings.textColor = UIColor.white
        lblGreetings.font = UIFont(name: String.defaultFontR, size: 23)
        lblGreetings.text = "Good \(greetings())"
        lblGreetings.leadingAnchor.constraint(equalTo: greetingsRed.trailingAnchor, constant: 20).isActive = true
        lblGreetings.topAnchor.constraint(equalTo: greetingsImage.topAnchor, constant: 50).isActive = true
        lblGreetings.trailingAnchor.constraint(equalTo: greetingsImage.trailingAnchor, constant: -10).isActive = true
        lblGreetings.numberOfLines = 0
        lblGreetings.lineBreakMode = .byWordWrapping
        
        let lblWelcome = UILabel()
        greetingsImage.addSubview(lblWelcome)
        lblWelcome.translatesAutoresizingMaskIntoConstraints = false
        lblWelcome.textColor = UIColor.white
        lblWelcome.font = UIFont(name: String.defaultFontR, size: 13)
        lblWelcome.leadingAnchor.constraint(equalTo: greetingsRed.leadingAnchor, constant: 20).isActive = true
        lblWelcome.topAnchor.constraint(equalTo: lblGreetings.bottomAnchor, constant: 5).isActive = true
        lblWelcome.trailingAnchor.constraint(equalTo: greetingsImage.trailingAnchor, constant: -10).isActive = true
        lblWelcome.numberOfLines = 0
        lblWelcome.lineBreakMode = .byWordWrapping
        
        let normalText = "Welcome to "
        let boldText = "My Vodafone"
        let attributedString = NSMutableAttributedString(string:normalText)
        let attrs = [NSAttributedStringKey.font : UIFont(name: String.defaultFontB, size: 13)]
        let boldString = NSMutableAttributedString(string: boldText, attributes:attrs)
        attributedString.append(boldString)
        lblWelcome.attributedText = attributedString
        
        let displayImage = UIImageView(image: #imageLiteral(resourceName: "default_profile"))
        scrollView.addSubview(displayImage)
        displayImage.translatesAutoresizingMaskIntoConstraints = false
        displayImage.heightAnchor.constraint(equalToConstant: 90).isActive = true
        displayImage.widthAnchor.constraint(equalToConstant: 90).isActive = true
        displayImage.topAnchor.constraint(equalTo: greetingsImage.bottomAnchor, constant: 30).isActive = true
        displayImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        displayImage.layer.cornerRadius = 45
        displayImage.layer.borderColor = UIColor.white.cgColor
        displayImage.layer.borderWidth = 2
        
        let lblDisplayName = UILabel()
        scrollView.addSubview(lblDisplayName)
        lblDisplayName.translatesAutoresizingMaskIntoConstraints = false
        lblDisplayName.textColor = UIColor.white
        lblDisplayName.font = UIFont(name: String.defaultFontB, size: 21)
        lblDisplayName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        lblDisplayName.topAnchor.constraint(equalTo: displayImage.bottomAnchor, constant: 15).isActive = true
        lblDisplayName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 500).isActive = true
        lblDisplayName.numberOfLines = 0
        lblDisplayName.lineBreakMode = .byWordWrapping
        let defaultAccNameArr = displayName?.components(separatedBy: " ")
        
        displayName = defaultAccNameArr?[0]
        let phoneTextIndex = defaultAccNameArr!.count - 1
        let phoneText = defaultAccNameArr?[phoneTextIndex]
        lblDisplayName.text = "\(displayName!)\n\(phoneText!)"
        
        let creditView = UIView()
        scrollView.addSubview(creditView)
        creditView.translatesAutoresizingMaskIntoConstraints = false
        creditView.backgroundColor = UIColor.white.withAlphaComponent(0.60)
        creditView.isOpaque = false
        creditView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        creditView.topAnchor.constraint(equalTo: lblDisplayName.bottomAnchor, constant: 30).isActive = true
        creditView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        creditView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        creditView.layer.cornerRadius = 50
        
        let btnTopUp = UIButton()
        creditView.addSubview(btnTopUp)
        btnTopUp.translatesAutoresizingMaskIntoConstraints = false
        btnTopUp.backgroundColor = UIColor.white
        btnTopUp.widthAnchor.constraint(equalToConstant: 100).isActive = true
        btnTopUp.topAnchor.constraint(equalTo: creditView.topAnchor).isActive = true
        btnTopUp.trailingAnchor.constraint(equalTo: creditView.trailingAnchor).isActive = true
        btnTopUp.bottomAnchor.constraint(equalTo: creditView.bottomAnchor).isActive = true
        btnTopUp.layer.cornerRadius = 50
        let btnTopUpImage = UIImage(named: "top_up")
        btnTopUp.setImage(btnTopUpImage, for: .normal)
        btnTopUp.imageEdgeInsets = UIEdgeInsetsMake(25, 25, 25, 25)
        btnTopUp.addTarget(self, action: #selector(goToTopUp), for: .touchUpInside)
        
        
        creditView.addSubview(lblOutBill)
        lblOutBill.translatesAutoresizingMaskIntoConstraints = false
        lblOutBill.font = UIFont(name: String.defaultFontR, size: 20)
        if let balanceLabel = balanceLabel {
            lblOutBill.text = balanceLabel
        }else{
            lblOutBill.text = "Outstanding bill"
        }
        
        lblOutBill.leadingAnchor.constraint(equalTo: creditView.leadingAnchor, constant: 30).isActive = true
        lblOutBill.topAnchor.constraint(equalTo: creditView.topAnchor, constant: 20).isActive = true
        lblOutBill.trailingAnchor.constraint(equalTo: btnTopUp.leadingAnchor, constant: 10).isActive = true
        lblOutBill.numberOfLines = 0
        lblOutBill.lineBreakMode = .byWordWrapping
        
        creditView.addSubview(lblBill)
        if let outBill = outBill{
            lblBill.text = outBill
        }else{
            lblBill.text = "GHS --- -- --"
        }
        
        lblBill.leadingAnchor.constraint(equalTo: creditView.leadingAnchor, constant: 30).isActive = true
        lblBill.topAnchor.constraint(equalTo: lblOutBill.bottomAnchor, constant: 10).isActive = true
        lblBill.trailingAnchor.constraint(equalTo: btnTopUp.leadingAnchor, constant: -2).isActive = true
        if Int(viewWidth) <= 320 {
            lblBill.font = UIFont(name: String.defaultFontB, size: 18)
            
        }else{
            lblBill.font = UIFont(name: String.defaultFontB, size: 29)
        }
        
        lblBill.numberOfLines = 0
        lblBill.lineBreakMode = .byWordWrapping
        
        //24/7
        let twoFourSeven = UIImageView()
        scrollView.addSubview(twoFourSeven)
        twoFourSeven.translatesAutoresizingMaskIntoConstraints = false
        twoFourSeven.image = UIImage(named: "support")
        twoFourSeven.topAnchor.constraint(equalTo: creditView.bottomAnchor, constant: 40).isActive = true
        twoFourSeven.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -3).isActive = true
        twoFourSeven.widthAnchor.constraint(equalToConstant: 80).isActive = true
        twoFourSeven.heightAnchor.constraint(equalToConstant: 80).isActive = true
        twoFourSeven.isUserInteractionEnabled = true
        let twoFourSevenRec = UITapGestureRecognizer(target: self, action: #selector(goToSupport))
        twoFourSeven.addGestureRecognizer(twoFourSevenRec)
        
        scrollView.addSubview(updateIcon)
        updateIcon.translatesAutoresizingMaskIntoConstraints = false
        let update_image = UIImage(named: "progressarrow")
        updateIcon.setImage(update_image, for: .normal)
        updateIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true
        updateIcon.topAnchor.constraint(equalTo: twoFourSeven.bottomAnchor, constant: 20).isActive = true
        updateIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        updateIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        updateIcon.addTarget(self, action: #selector(updateDetails), for: .touchUpInside)
        
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
        lblLastUpdatedStatus.topAnchor.constraint(equalTo: twoFourSeven.bottomAnchor, constant: 25).isActive = true
        
        scrollView.addSubview(darkView)
        darkView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        darkView.topAnchor.constraint(equalTo: updateIcon.bottomAnchor, constant: 20).isActive = true
        darkView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        darkView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        let redView = UIView()
        redView.translatesAutoresizingMaskIntoConstraints = false
        darkView.addSubview(redView)
        redView.backgroundColor = UIColor.red
        redView.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 10).isActive = true
        redView.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 10).isActive = true
        redView.widthAnchor.constraint(equalToConstant: 4).isActive = true
        redView.bottomAnchor.constraint(equalTo: darkView.bottomAnchor, constant: -10).isActive = true
        
        let lblCurr = UILabel()
        lblCurr.translatesAutoresizingMaskIntoConstraints = false
        darkView.addSubview(lblCurr)
        lblCurr.text = "All current spends since last bill"
        lblCurr.textColor = UIColor.white
        lblCurr.font = UIFont(name: String.defaultFontR, size: 15)
        lblCurr.numberOfLines = 0
        lblCurr.lineBreakMode = .byWordWrapping
        lblCurr.leadingAnchor.constraint(equalTo: redView.trailingAnchor, constant: 20).isActive = true
        lblCurr.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 20).isActive = true
        lblCurr.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -10).isActive = true
        
        darkView.addSubview(lblCurrSpend)
        lblCurrSpend.leadingAnchor.constraint(equalTo: redView.trailingAnchor, constant: 20).isActive = true
        lblCurrSpend.topAnchor.constraint(equalTo: lblCurr.bottomAnchor, constant: 20).isActive = true
        lblCurrSpend.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -10).isActive = true
        if let currentSpend = currentSpend{
            lblCurrSpend.text = currentSpend
        }else{
            lblCurrSpend.text = "GHS -- --- --"
        }
        
        
        
        darkView.addSubview(lblExclude)
        lblExclude.translatesAutoresizingMaskIntoConstraints = false
        if let currSpendDesc = currSpendDesc {
            lblExclude.text = currSpendDesc
        }else{
            lblExclude.text = "-- -- --"
        }
        
        lblExclude.textColor = UIColor.white
        lblExclude.font = UIFont(name: String.defaultFontR, size: 16)
        lblExclude.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        lblExclude.topAnchor.constraint(equalTo: lblCurrSpend.bottomAnchor, constant: 20).isActive = true
        lblExclude.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -10).isActive = true
        lblExclude.numberOfLines = 0
        lblExclude.lineBreakMode = .byWordWrapping
        
        darkView.addSubview(btnDropDown)
        let arrowImage = UIImage(named: "dropdown")
        btnDropDown.setImage(arrowImage, for: .normal)
        btnDropDown.widthAnchor.constraint(equalToConstant: 25).isActive = true
        btnDropDown.heightAnchor.constraint(equalToConstant: 18).isActive = true
        btnDropDown.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 50).isActive = true
        btnDropDown.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        btnDropDown.addTarget(self, action: #selector(showBreakDown), for: .touchUpInside)
        
        let viewHeight = view.frame.height
        scrollView.addSubview(postPaidDetailsCard)
        postPaidDetailsCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        postPaidDetailsCard.topAnchor.constraint(equalTo: darkView.bottomAnchor).isActive = true
        postPaidDetailsCard.trailingAnchor.constraint(equalTo: darkView.trailingAnchor).isActive = true
        postPaidDetailsCard.heightAnchor.constraint(equalToConstant: 780).isActive = true
        postPaidDetailsCard.isHidden = true
        
        
        postPaidDetailsCard.addSubview(lblOutPlan)
        lblOutPlan.translatesAutoresizingMaskIntoConstraints = false
        if let outPlan = outPlan {
            lblOutPlan.text = outPlan
        }else{
            lblOutPlan.text = "----------"
        }
        
        lblOutPlan.textColor = UIColor.support_dark_voilet
        lblOutPlan.font = UIFont(name: String.defaultFontR, size: 15)
        lblOutPlan.topAnchor.constraint(equalTo: postPaidDetailsCard.topAnchor, constant: 20).isActive = true
        lblOutPlan.centerXAnchor.constraint(equalTo: postPaidDetailsCard.centerXAnchor).isActive = true
        
        let totalSpendView = UIView()
        postPaidDetailsCard.addSubview(totalSpendView)
        totalSpendView.translatesAutoresizingMaskIntoConstraints = false
        totalSpendView.topAnchor.constraint(equalTo: lblOutPlan.bottomAnchor, constant: 10).isActive = true
        totalSpendView.centerXAnchor.constraint(equalTo: postPaidDetailsCard.centerXAnchor).isActive = true
        totalSpendView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        totalSpendView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        totalSpendView.backgroundColor = UIColor.support_dark_voilet
        totalSpendView.layer.cornerRadius = 60
        
        totalSpendView.addSubview(lblCurrSpendCircle)
        lblCurrSpendCircle.translatesAutoresizingMaskIntoConstraints = false
        lblCurrSpendCircle.font = UIFont(name: String.defaultFontR, size: 22)
        lblCurrSpendCircle.centerXAnchor.constraint(equalTo: totalSpendView.centerXAnchor).isActive = true
        lblCurrSpendCircle.centerYAnchor.constraint(equalTo: totalSpendView.centerYAnchor).isActive = true
        if let currSpendCircle = currSpendCircle {
            lblCurrSpendCircle.text = currSpendCircle
        }else{
            lblCurrSpendCircle.text = "GHS -- -- --"
        }
        
        lblCurrSpendCircle.textColor = UIColor.white
        
        let roamingLinker = UIView()
        roamingLinker.translatesAutoresizingMaskIntoConstraints = false
        postPaidDetailsCard.addSubview(roamingLinker)
        roamingLinker.backgroundColor = UIColor.support_dark_voilet
        roamingLinker.topAnchor.constraint(equalTo: totalSpendView.bottomAnchor).isActive = true
        roamingLinker.widthAnchor.constraint(equalToConstant: 3).isActive = true
        roamingLinker.heightAnchor.constraint(equalToConstant: 40).isActive = true
        roamingLinker.centerXAnchor.constraint(equalTo: postPaidDetailsCard.centerXAnchor).isActive = true
        
        let roamingView = UIView()
        postPaidDetailsCard.addSubview(roamingView)
        roamingView.translatesAutoresizingMaskIntoConstraints = false
        roamingView.topAnchor.constraint(equalTo: roamingLinker.bottomAnchor).isActive = true
        roamingView.centerXAnchor.constraint(equalTo: postPaidDetailsCard.centerXAnchor).isActive = true
        roamingView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        roamingView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        roamingView.backgroundColor = UIColor.support_dark_voilet
        roamingView.layer.cornerRadius = 35
        
        
        postPaidDetailsCard.addSubview(lblRoamingDesc)
        lblRoamingDesc.translatesAutoresizingMaskIntoConstraints = false
        if let roamingDesc = roamingDesc {
            lblRoamingDesc.text = roamingDesc
        }else{
            lblRoamingDesc.text = ""
        }
        
        lblRoamingDesc.font = UIFont(name: String.defaultFontR, size: 16)
        lblRoamingDesc.textColor = UIColor.black
        lblRoamingDesc.numberOfLines = 0
        lblRoamingDesc.lineBreakMode = .byWordWrapping
        lblRoamingDesc.leadingAnchor.constraint(equalTo: postPaidDetailsCard.leadingAnchor, constant: 30).isActive = true
        lblRoamingDesc.topAnchor.constraint(equalTo: roamingLinker.bottomAnchor, constant: 5).isActive = true
        lblRoamingDesc.trailingAnchor.constraint(equalTo: roamingView.leadingAnchor, constant: -30).isActive = true
        
        postPaidDetailsCard.addSubview(lblRoaming)
        lblRoaming.translatesAutoresizingMaskIntoConstraints = false
        lblRoaming.textColor = UIColor.black
        if let roamingAmt = roamingAmt {
           lblRoaming.text = roamingAmt
        }else{
            lblRoaming.text = "GHS 0"
        }
        
        lblRoaming.leadingAnchor.constraint(equalTo: roamingView.trailingAnchor, constant: 20).isActive = true
        lblRoaming.topAnchor.constraint(equalTo: roamingLinker.bottomAnchor, constant: 25).isActive = true
        lblRoaming.trailingAnchor.constraint(equalTo: postPaidDetailsCard.trailingAnchor, constant: -10).isActive = true
        lblRoaming.numberOfLines = 0
        lblRoaming.lineBreakMode = .byWordWrapping
        lblRoaming.font = UIFont(name: String.defaultFontB, size: 20)
        
        let roamingImage = UIImageView()
        roamingView.addSubview(roamingImage)
        roamingImage.translatesAutoresizingMaskIntoConstraints = false
        let roaming_image = UIImage(named: "ic_roaming")
        let roamingTint = roaming_image?.withRenderingMode(.alwaysTemplate)
        roamingImage.image = roamingTint
        roamingImage.tintColor = UIColor.white
        roamingImage.centerXAnchor.constraint(equalTo: roamingView.centerXAnchor).isActive = true
        roamingImage.centerYAnchor.constraint(equalTo: roamingView.centerYAnchor).isActive = true
        roamingImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        roamingImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let callsLinker = UIView()
        callsLinker.translatesAutoresizingMaskIntoConstraints = false
        postPaidDetailsCard.addSubview(callsLinker)
        callsLinker.backgroundColor = UIColor.support_dark_voilet
        callsLinker.topAnchor.constraint(equalTo: roamingView.bottomAnchor).isActive = true
        callsLinker.widthAnchor.constraint(equalToConstant: 3).isActive = true
        callsLinker.heightAnchor.constraint(equalToConstant: 40).isActive = true
        callsLinker.centerXAnchor.constraint(equalTo: postPaidDetailsCard.centerXAnchor).isActive = true

        let callsView = UIView()
        postPaidDetailsCard.addSubview(callsView)
        callsView.translatesAutoresizingMaskIntoConstraints = false
        callsView.topAnchor.constraint(equalTo: callsLinker.bottomAnchor).isActive = true
        callsView.centerXAnchor.constraint(equalTo: postPaidDetailsCard.centerXAnchor).isActive = true
        callsView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        callsView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        callsView.backgroundColor = UIColor.support_dark_voilet
        callsView.layer.cornerRadius = 35
        
        
        postPaidDetailsCard.addSubview(lblCallsDesc)
        lblCallsDesc.translatesAutoresizingMaskIntoConstraints = false
        if let callsDesc = callsDesc {
            lblCallsDesc.text = callsDesc
        }else{
            lblCallsDesc.text = ""
        }
        
        lblCallsDesc.font = UIFont(name: String.defaultFontR, size: 16)
        lblCallsDesc.textColor = UIColor.black
        lblCallsDesc.numberOfLines = 0
        lblCallsDesc.lineBreakMode = .byWordWrapping
        lblCallsDesc.leadingAnchor.constraint(equalTo: postPaidDetailsCard.leadingAnchor, constant: 30).isActive = true
        lblCallsDesc.topAnchor.constraint(equalTo: callsLinker.bottomAnchor, constant: 5).isActive = true
        lblCallsDesc.trailingAnchor.constraint(equalTo: callsView.leadingAnchor, constant: -30).isActive = true
        
        postPaidDetailsCard.addSubview(lblCalls)
        lblCalls.translatesAutoresizingMaskIntoConstraints = false
        lblCalls.textColor = UIColor.black
        if let callsAmt = callsAmt {
            lblCalls.text = callsAmt
        }else {
            lblCalls.text = "GHS 0"
        }
        
        lblCalls.leadingAnchor.constraint(equalTo: callsView.trailingAnchor, constant: 20).isActive = true
        lblCalls.topAnchor.constraint(equalTo: callsLinker.bottomAnchor, constant: 25).isActive = true
        lblCalls.trailingAnchor.constraint(equalTo: postPaidDetailsCard.trailingAnchor, constant: -10).isActive = true
        lblCalls.numberOfLines = 0
        lblCalls.lineBreakMode = .byWordWrapping
        lblCalls.font = UIFont(name: String.defaultFontB, size: 20)
        
        let callsImage = UIImageView(image: #imageLiteral(resourceName: "call_icon"))
        callsView.addSubview(callsImage)
        callsImage.translatesAutoresizingMaskIntoConstraints = false
        callsImage.centerXAnchor.constraint(equalTo: callsView.centerXAnchor).isActive = true
        callsImage.centerYAnchor.constraint(equalTo: callsView.centerYAnchor).isActive = true
        callsImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        callsImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let internetLinker = UIView()
        internetLinker.translatesAutoresizingMaskIntoConstraints = false
        postPaidDetailsCard.addSubview(internetLinker)
        internetLinker.backgroundColor = UIColor.support_dark_voilet
        internetLinker.topAnchor.constraint(equalTo: callsView.bottomAnchor).isActive = true
        internetLinker.widthAnchor.constraint(equalToConstant: 3).isActive = true
        internetLinker.heightAnchor.constraint(equalToConstant: 40).isActive = true
        internetLinker.centerXAnchor.constraint(equalTo: postPaidDetailsCard.centerXAnchor).isActive = true
        
        let internetView = UIView()
        postPaidDetailsCard.addSubview(internetView)
        internetView.translatesAutoresizingMaskIntoConstraints = false
        internetView.topAnchor.constraint(equalTo: internetLinker.bottomAnchor).isActive = true
        internetView.centerXAnchor.constraint(equalTo: postPaidDetailsCard.centerXAnchor).isActive = true
        internetView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        internetView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        internetView.backgroundColor = UIColor.support_dark_voilet
        internetView.layer.cornerRadius = 35
        
        
        postPaidDetailsCard.addSubview(lblInternetDesc)
        lblInternetDesc.translatesAutoresizingMaskIntoConstraints = false
        if let internetDesc = internetDesc {
            lblInternetDesc.text = internetDesc
        }else{
            lblInternetDesc.text = ""
        }
        
        lblInternetDesc.font = UIFont(name: String.defaultFontR, size: 16)
        lblInternetDesc.textColor = UIColor.black
        lblInternetDesc.numberOfLines = 0
        lblInternetDesc.lineBreakMode = .byWordWrapping
        lblInternetDesc.leadingAnchor.constraint(equalTo: postPaidDetailsCard.leadingAnchor, constant: 30).isActive = true
        lblInternetDesc.topAnchor.constraint(equalTo: internetLinker.bottomAnchor, constant: 25).isActive = true
        lblInternetDesc.trailingAnchor.constraint(equalTo: internetView.leadingAnchor, constant: -30).isActive = true
        
        postPaidDetailsCard.addSubview(lblInternet)
        lblInternet.translatesAutoresizingMaskIntoConstraints = false
        lblInternet.textColor = UIColor.black
        if let internetAmt = internetAmt {
            lblInternet.text = internetAmt
        }else{
            lblInternet.text = "GHS 0"
        }
        
        lblInternet.leadingAnchor.constraint(equalTo: internetView.trailingAnchor, constant: 20).isActive = true
        lblInternet.topAnchor.constraint(equalTo: internetLinker.bottomAnchor, constant: 25).isActive = true
        lblInternet.trailingAnchor.constraint(equalTo: postPaidDetailsCard.trailingAnchor, constant: -10).isActive = true
        lblInternet.numberOfLines = 0
        lblInternet.lineBreakMode = .byWordWrapping
        lblInternet.font = UIFont(name: String.defaultFontB, size: 20)
        
        let dataImage = UIImageView(image: #imageLiteral(resourceName: "data_icon"))
        internetView.addSubview(dataImage)
        dataImage.translatesAutoresizingMaskIntoConstraints = false
        dataImage.centerXAnchor.constraint(equalTo: internetView.centerXAnchor).isActive = true
        dataImage.centerYAnchor.constraint(equalTo: internetView.centerYAnchor).isActive = true
        dataImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        dataImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let smsLinker = UIView()
        smsLinker.translatesAutoresizingMaskIntoConstraints = false
        postPaidDetailsCard.addSubview(smsLinker)
        smsLinker.backgroundColor = UIColor.support_dark_voilet
        smsLinker.topAnchor.constraint(equalTo: internetView.bottomAnchor).isActive = true
        smsLinker.widthAnchor.constraint(equalToConstant: 3).isActive = true
        smsLinker.heightAnchor.constraint(equalToConstant: 40).isActive = true
        smsLinker.centerXAnchor.constraint(equalTo: postPaidDetailsCard.centerXAnchor).isActive = true
        
        let smsView = UIView()
        postPaidDetailsCard.addSubview(smsView)
        smsView.translatesAutoresizingMaskIntoConstraints = false
        smsView.topAnchor.constraint(equalTo: smsLinker.bottomAnchor).isActive = true
        smsView.centerXAnchor.constraint(equalTo: postPaidDetailsCard.centerXAnchor).isActive = true
        smsView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        smsView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        smsView.backgroundColor = UIColor.support_dark_voilet
        smsView.layer.cornerRadius = 35
        
        
        postPaidDetailsCard.addSubview(lblSMSDesc)
        lblSMSDesc.translatesAutoresizingMaskIntoConstraints = false
        if let smsDesc = smsDesc {
            lblSMSDesc.text = smsDesc
        }else{
            lblSMSDesc.text = ""
        }
        
        lblSMSDesc.font = UIFont(name: String.defaultFontR, size: 16)
        lblSMSDesc.textColor = UIColor.black
        lblSMSDesc.numberOfLines = 0
        lblSMSDesc.lineBreakMode = .byWordWrapping
        lblSMSDesc.leadingAnchor.constraint(equalTo: postPaidDetailsCard.leadingAnchor, constant: 30).isActive = true
        lblSMSDesc.topAnchor.constraint(equalTo: smsLinker.bottomAnchor, constant: 25).isActive = true
        lblSMSDesc.trailingAnchor.constraint(equalTo: smsView.leadingAnchor, constant: -30).isActive = true
        
        postPaidDetailsCard.addSubview(lblSMS)
        lblSMS.translatesAutoresizingMaskIntoConstraints = false
        lblSMS.textColor = UIColor.black
        if let smsAmt = smsAmt {
            lblSMS.text = smsAmt
        }else{
            lblSMS.text = "GHS 0"
        }
        
        lblSMS.leadingAnchor.constraint(equalTo: smsView.trailingAnchor, constant: 20).isActive = true
        lblSMS.topAnchor.constraint(equalTo: smsLinker.bottomAnchor, constant: 25).isActive = true
        lblSMS.trailingAnchor.constraint(equalTo: postPaidDetailsCard.trailingAnchor, constant: -10).isActive = true
        lblSMS.numberOfLines = 0
        lblSMS.lineBreakMode = .byWordWrapping
        lblSMS.font = UIFont(name: String.defaultFontB, size: 20)
        
        let smsImage = UIImageView()
        smsView.addSubview(smsImage)
        let sms_image = UIImage(named: "sms")
        let smsTint = sms_image?.withRenderingMode(.alwaysTemplate)
        smsImage.image = smsTint
        smsImage.tintColor = UIColor.white
        smsImage.translatesAutoresizingMaskIntoConstraints = false
        smsImage.centerXAnchor.constraint(equalTo: smsView.centerXAnchor).isActive = true
        smsImage.centerYAnchor.constraint(equalTo: smsView.centerYAnchor).isActive = true
        smsImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        smsImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let btnItemisedSpend = UIButton()
        postPaidDetailsCard.addSubview(btnItemisedSpend)
        btnItemisedSpend.translatesAutoresizingMaskIntoConstraints = false
        btnItemisedSpend.backgroundColor = UIColor.grayButton
        btnItemisedSpend.setTitle("See itemised spend", for: .normal)
        btnItemisedSpend.setTitleColor(UIColor.white, for: .normal)
        btnItemisedSpend.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnItemisedSpend.leadingAnchor.constraint(equalTo: postPaidDetailsCard.leadingAnchor, constant: 20).isActive = true
        btnItemisedSpend.trailingAnchor.constraint(equalTo: postPaidDetailsCard.trailingAnchor, constant: -20).isActive = true
        btnItemisedSpend.topAnchor.constraint(equalTo: smsView.bottomAnchor, constant: 20).isActive = true
        btnItemisedSpend.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnItemisedSpend.addTarget(self, action: #selector(showItemised), for: .touchUpInside)
        
        let btnBillHistory = UIButton()
        postPaidDetailsCard.addSubview(btnBillHistory)
        btnBillHistory.translatesAutoresizingMaskIntoConstraints = false
        btnBillHistory.backgroundColor = UIColor.support_light_gray
        btnBillHistory.setTitle("See bill history", for: .normal)
        btnBillHistory.setTitleColor(UIColor.black, for: .normal)
        btnBillHistory.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnBillHistory.leadingAnchor.constraint(equalTo: postPaidDetailsCard.leadingAnchor, constant: 20).isActive = true
        btnBillHistory.trailingAnchor.constraint(equalTo: postPaidDetailsCard.trailingAnchor, constant: -20).isActive = true
        btnBillHistory.topAnchor.constraint(equalTo: btnItemisedSpend.bottomAnchor, constant: 20).isActive = true
        btnBillHistory.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnBillHistory.addTarget(self, action: #selector(showItemised), for: .touchUpInside)
        
        if Int(viewWidth) <= 320 {
            scrollView.contentSize.height = viewHeight + 150
        }else if Int(viewWidth) == 375 {
            scrollView.contentSize.height = viewHeight + 210
        }
        else{
            scrollView.contentSize.height = viewHeight + 150
//            780 820
        }
        
        
        
        
        
        
        
    }
    
    // Function to load post paid details
    fileprivate func outstandingBill() {
        let async_call = URL(string: String.userURL)
        let request = NSMutableURLRequest(url: async_call!)
        request.httpMethod = "POST"
        
        let postParameters = ["action":"subscriberSummary", "username":username!, "msisdn": msisdn!, "os":getAppVersion()]
        
        if let jsonParameters = try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted){
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
                        print("error is: \(error!.localizedDescription)")
                        DispatchQueue.main.async {
                            self.updateIcon.layer.removeAnimation(forKey: "rotate")
                        }
                        return;
                    }
                    do {
                        let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        if let parseJSON = myJSON {
                            print("responseBody: \(parseJSON)")
                            var sessionAuth: String!
                            sessionAuth = parseJSON["SessionAuth"] as! String?
                            if sessionAuth == "true" {
                                DispatchQueue.main.async {
                                    self.logout()
                                }
                                
                            }
                            var responseBody: String?
                            var responseCode: Int!
                            var balance: NSDictionary!
                            responseBody = parseJSON["responseBody"] as! String?
                            if responseBody != nil {
                                //cache data
                                self.preference.removeObject(forKey: UserDefaultsKeys.postPaidOutBill.rawValue)
                                self.preference.set(responseBody, forKey: UserDefaultsKeys.postPaidOutBill.rawValue)
                                DispatchQueue.main.async {
                                    let resBody = responseBody
                                    let decrypt = self.decryptAsyncRequest(requestBody: resBody!)
                                    let decryptedResponseBody = self.convertToNSDictionary(decrypt: decrypt)
                                    print(decryptedResponseBody)
                                    responseCode = decryptedResponseBody["RESPONSECODE"] as! Int?
                                    if responseCode == 0 {
                                        self.updateIcon.layer.removeAnimation(forKey: "rotate")
                                        let today = self.getTodayString()
                                        self.preference.set(today, forKey: UserDefaultsKeys.lastUpdate.rawValue)
                                        balance = decryptedResponseBody["BALANCE"] as! NSDictionary?
                                        self.balanceLabel = balance["BalanceLabel"] as! String?
                                        self.outBill = balance["AccountBalanceLabel"] as! String?
                                        self.lblOutBill.text = self.balanceLabel
                                        self.lblBill.text = self.outBill
                                        self.lblLastUpdatedStatus.text = "Last updated on \(today)"
                                    }else{
                                        self.updateIcon.layer.removeAnimation(forKey: "rotate")
                                        self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not update your bill. Try later")
                                    }
                                }
                            }
                            
                        }
                    }catch{
                        print("postPaid Balance error \(error.localizedDescription)")
                        DispatchQueue.main.async {
                            self.updateIcon.layer.removeAnimation(forKey: "rotate")
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    fileprivate func billBreakDown(){
        let async_call = URL(string: String.userURL)
        let request = NSMutableURLRequest(url: async_call!)
        request.httpMethod = "POST"
        
        let postParameters = ["action":"getUnbilled", "username":username!, "msisdn": msisdn!, "os":getAppVersion()]
        if let jsonParameters = try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted){
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
                        print("error is: \(error!.localizedDescription)")
                        DispatchQueue.main.async {
                            self.updateIcon.layer.removeAnimation(forKey: "rotate")
                        }
                        return
                    }
                    do {
                        let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        if let parseJSON = myJSON {
                            print("responseBody: \(parseJSON)")
                            
                            var responseBody: String?
                            var responseCode: Int!
                            var responseMessage: NSDictionary!
                            responseBody = parseJSON["responseBody"] as! String?
                            if responseBody != nil {
                                //cache data
                                self.preference.removeObject(forKey: UserDefaultsKeys.postPaidBreakDown.rawValue)
                                self.preference.set(responseBody, forKey: UserDefaultsKeys.postPaidBreakDown.rawValue)
                                DispatchQueue.main.async {
                                    let resBody = responseBody
                                    let decrypt = self.decryptAsyncRequest(requestBody: resBody!)
                                    let decryptedResponseBody = self.convertToNSDictionary(decrypt: decrypt)
//                                    print("breakDown \(decryptedResponseBody)")
                                    responseCode = decryptedResponseBody["RESPONSECODE"] as! Int?
                                    if responseCode == 0 {
                                        
                                        responseMessage = decryptedResponseBody["RESPONSEMESSAGE"] as! NSDictionary?
//                                        print(responseMessage)
                                        let currentSpendData = responseMessage["CurrentSpend"] as! NSDictionary?
                                        let outOfPlanSpend = responseMessage["OutOfPlanSpend"] as! NSDictionary?
                                        
                                        if let currSpendData = currentSpendData {
                                            self.currentSpend = currSpendData["Amount"] as! String?
                                            self.currSpendDesc = currSpendData["Desc"] as! String?
                                            self.lblCurrSpend.text = self.currentSpend
                                            self.lblExclude.text = self.currSpendDesc
                                        }
                                        
                                        if let currOutOfPlanSpend = outOfPlanSpend {
                                            self.currSpendCircle = currOutOfPlanSpend["Total"] as! String?
                                            self.outPlan = currOutOfPlanSpend["Desc"] as! String?
                                            self.lblCurrSpendCircle.text = self.currSpendCircle
                                            self.lblOutPlan.text = self.outPlan
                                            let components = currOutOfPlanSpend["Components"] as! NSArray?
                                            if let array = components {
//                                                let totalArray = array.count
                                                var counter = 0
                                                for obj in array {
                                                    if let dict = obj as? NSDictionary{
                                                        counter = counter + 1
                                                        let description = dict.value(forKey: "Desc") as? String
                                                        let planType = dict.value(forKey: "Type") as? String
                                                        let planAmt = dict.value(forKey: "Amount") as? String
                                                        if counter == 1 {
                                                            if let desc = description {
                                                                self.lblRoamingDesc.text = desc
                                                                self.lblRoaming.text = planAmt
                                                            }
                                                        }else if counter == 2 {
                                                            if let desc = description {
                                                                self.lblCallsDesc.text = desc
                                                                self.lblCalls.text = planAmt
                                                            }
                                                        }else if counter == 3 {
                                                            if let desc = description {
                                                                self.lblInternetDesc.text = desc
                                                                self.lblInternet.text = planAmt
                                                            }
                                                        }else if counter == 4 {
                                                            if let desc = description {
                                                                self.lblSMSDesc.text = desc
                                                                self.lblSMS.text = planAmt
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            
                                        }
                                        
                                    }else{
                                        
                                    }
                                }
                            }
                            
                        }
                    }catch{
                        print("postPaid break down error \(error.localizedDescription)")
                        DispatchQueue.main.async {
                            self.updateIcon.layer.removeAnimation(forKey: "rotate")
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    func loadPostPaidDetails(){
        outstandingBill()
        billBreakDown()
    }
    
    @objc func showBreakDown(){
        let viewWidth = view.frame.width
        let viewHeight = view.frame.height
        if isBreakDownShowing {
            UIView.animate(withDuration: 0.5, animations: {
                self.btnDropDown.transform = self.btnDropDown.transform.rotated(by: CGFloat(Double.pi / -1))
            })
            postPaidDetailsCard.isHidden = true
            if Int(viewWidth) <= 320 {
                scrollView.contentSize.height = viewHeight + 150
            }else{
                scrollView.contentSize.height = viewHeight + 150
            }
        }else{
            UIView.animate(withDuration: 0.5, animations: {
                self.btnDropDown.transform = self.btnDropDown.transform.rotated(by: CGFloat(Double.pi / -1))
                self.scrollView.setContentOffset(CGPoint(x: 0, y: 900), animated: true)
            })
            
            postPaidDetailsCard.isHidden = false
            if Int(viewWidth) <= 320 {
                scrollView.contentSize.height = viewHeight + 150 + 820
            }else if Int(viewWidth) == 375 {
                scrollView.contentSize.height = viewHeight + 150 + 850
            }
            else{
                scrollView.contentSize.height = viewHeight + 150 + 780
            }
        }
        
        isBreakDownShowing = !isBreakDownShowing
    }
    
    func animateRefreshBtn(){
        if CheckInternet.Connection(){
            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotateAnimation.fromValue = 0.0
            rotateAnimation.toValue = CGFloat(.pi * 2.0)
            rotateAnimation.duration = 1.0
            rotateAnimation.repeatCount = Float.greatestFiniteMagnitude;
            
            updateIcon.layer.add(rotateAnimation, forKey: "rotate")
        }else{
            displayNoInternet()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateRefreshBtn()
        
    }
    @objc func goToTopUp(){
        let storyboard = UIStoryboard(name: "TopUp", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "toppingUpViewController")
        self.addChildViewController(moveTo)
        moveTo.view.frame = self.view.frame
        self.view.addSubview(moveTo.view)
        moveTo.didMove(toParentViewController: self)
    }
    
    @objc func goToSupport(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Support", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "supportVC")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func updateDetails(){
        if !CheckInternet.Connection(){
            displayNoInternet()
        }else{
            animateRefreshBtn()
            loadPostPaidDetails()
        }
        
    }
    
    @objc func showItemised(){
        if allowSensitiveData != nil {
            if allowSensitiveData == true {
                let storyboard = UIStoryboard(name: "PostPaid", bundle: nil)
                guard let moveTo = storyboard.instantiateViewController(withIdentifier: "currentSpendsBills") as? currentSpendsBills else {return}
                moveTo.currSpend = currentSpend
                moveTo.excludeValue = currSpendDesc
                present(moveTo, animated: true, completion: nil)
            }else{
                
                let storyboard = UIStoryboard(name: "PostPaid", bundle: nil)
                guard let moveTo = storyboard.instantiateViewController(withIdentifier: "postPaidLogin") as? postPaidLogin else {return}
                moveTo.currentSpend = currentSpend
                moveTo.excludeValue = currSpendDesc
                self.addChildViewController(moveTo)
                moveTo.view.frame = self.view.frame
                view.addSubview(moveTo.view)
                moveTo.didMove(toParentViewController: self)
            }
        }else{
            
            let storyboard = UIStoryboard(name: "PostPaid", bundle: nil)
            guard let moveTo = storyboard.instantiateViewController(withIdentifier: "postPaidLogin") as? postPaidLogin else {return}
            moveTo.currentSpend = currentSpend
            moveTo.excludeValue = currSpendDesc
            self.addChildViewController(moveTo)
            moveTo.view.frame = self.view.frame
            view.addSubview(moveTo.view)
            moveTo.didMove(toParentViewController: self)
        }
        
    }
    
    @objc func showBillHistory(){
        let storyboard = UIStoryboard(name: "PostPaid", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "currentSpendsBills") as? currentSpendsBills else {return}
        moveTo.currSpend = currentSpend
        moveTo.excludeValue = currSpendDesc
        present(moveTo, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
