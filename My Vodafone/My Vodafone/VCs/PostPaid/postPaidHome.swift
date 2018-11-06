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
    
    let adslView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.70)
        view.isOpaque = false
        return view
    }()
    
    let updateIcon = UIButton()
    let lblLastUpdatedStatus = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let services = preference.object(forKey: UserDefaultsKeys.ServiceList.rawValue)
        //        print(services)
        dService = preference.object(forKey: UserDefaultsKeys.DefaultService.rawValue) as? String
        //        print(dService)
        let responseData = preference.object(forKey: "responseData") as! NSDictionary
        username = responseData["Username"] as? String
        lastUpdate = preference.object(forKey: UserDefaultsKeys.lastUpdate.rawValue) as! String?
        
        lastUpdate = preference.object(forKey: UserDefaultsKeys.BB_LastUpdate.rawValue) as? String
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
    }

    func setUpViewsPostPaid(){
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
        
        let lblOutBill = UILabel()
        creditView.addSubview(lblOutBill)
        lblOutBill.translatesAutoresizingMaskIntoConstraints = false
        lblOutBill.font = UIFont(name: String.defaultFontR, size: 20)
        lblOutBill.text = "Outstanding bill"
        lblOutBill.leadingAnchor.constraint(equalTo: creditView.leadingAnchor, constant: 30).isActive = true
        lblOutBill.topAnchor.constraint(equalTo: creditView.topAnchor, constant: 30).isActive = true
        lblOutBill.trailingAnchor.constraint(equalTo: btnTopUp.leadingAnchor, constant: 10).isActive = true
        lblOutBill.numberOfLines = 0
        lblOutBill.lineBreakMode = .byWordWrapping
        
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
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.contentSize.height = 1000
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
}
