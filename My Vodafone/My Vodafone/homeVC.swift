//
//  homeVC.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 19/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class homeVC: UIViewController {
    
    var defaultImageUrl: String?
    var defaultAccName: String?
    let preference = UserDefaults.standard
    
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
    let scrollView: UIScrollView = {
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

    override func viewDidLoad() {
        super.viewDidLoad()

        zeroAlpha()
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        let defaultService = UserData["DefaultService"] as! String
        print("yo:: \(defaultService)")
        let Services = preference.object(forKey: "ServiceList")
        print(Services)
        if let array = Services as? NSArray {
            for obj in array {
                if let dict = obj as? NSDictionary {
                    // Now reference the data you need using:
                    let id = dict.value(forKey: "DisplayName")
                    let ServiceID = dict.value(forKey: "ID") as! String
                    let AcctType = dict.value(forKey: "Type") as! String
                    
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
                        defaultAccName = dict.value(forKey: "DisplayName") as! String?
                    }
                }
            }
        }
        setUpViews()
        // Check for internet connection
        checkConnection()
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
    func setUpViews(){
        let bgImage = vcHomeImage
        view.addSubview(bgImage)
        bgImage.image = UIImage(named: "morning_bg_")
        bgImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bgImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bgImage.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        bgImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        view.addSubview(motherView)
        motherView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        motherView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        motherView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        motherView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        motherView.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: motherView.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: motherView.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: motherView.safeTopAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: motherView.bottomAnchor).isActive = true
        
        //app logo
        let app_logo = UIImageView(image: #imageLiteral(resourceName: "voda_logo"))
        scrollView.addSubview(app_logo)
        app_logo.translatesAutoresizingMaskIntoConstraints = false
        app_logo.heightAnchor.constraint(equalToConstant: 48).isActive = true
        app_logo.widthAnchor.constraint(equalToConstant: 48).isActive = true
        app_logo.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10).isActive = true
        app_logo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        
        //Menu image
        scrollView.addSubview(vcHamburger)
        vcHamburger.image = UIImage(named: "hamburger")
        vcHamburger.image = vcHamburger.image?.withRenderingMode(.alwaysTemplate)
        vcHamburger.tintColor = UIColor.white
        vcHamburger.widthAnchor.constraint(equalToConstant: 30).isActive = true
        vcHamburger.heightAnchor.constraint(equalToConstant: 30).isActive = true
        vcHamburger.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        vcHamburger.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -10).isActive = true
        
        //Menu label
        let lblMenu = UILabel()
        scrollView.addSubview(lblMenu)
        lblMenu.translatesAutoresizingMaskIntoConstraints = false
        lblMenu.textColor = UIColor.white
        lblMenu.text = "MENU"
        lblMenu.font = UIFont(name: String.defaultFontR, size: 13)
        lblMenu.topAnchor.constraint(equalTo: vcHamburger.bottomAnchor, constant: 1).isActive = true
        lblMenu.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -8).isActive = true
        
        //sake image
        scrollView.addSubview(shakeImage)
        shakeImage.translatesAutoresizingMaskIntoConstraints = false
        shakeImage.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 20).isActive = true
        shakeImage.topAnchor.constraint(equalTo: app_logo.bottomAnchor, constant: 12).isActive = true
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
        defaultAccImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        defaultAccImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        //account name
        scrollView.addSubview(defaultAccDisName)
        defaultAccDisName.translatesAutoresizingMaskIntoConstraints = false
        defaultAccDisName.textColor = UIColor.white
        defaultAccDisName.font = UIFont(name: String.defaultFontR, size: 20)
        let defaultAccNameArr = defaultAccName?.components(separatedBy: " ")
        defaultAccName = defaultAccNameArr?[0]
        let phoneTextIndex = defaultAccNameArr!.count - 1
        let phoneText = defaultAccNameArr?[phoneTextIndex]
        defaultAccDisName.text = "\(defaultAccName!) \n\(phoneText!)"
        defaultAccDisName.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        defaultAccDisName.topAnchor.constraint(equalTo: defaultAccImage.bottomAnchor, constant: 10).isActive = true
        defaultAccDisName.numberOfLines = 0
        defaultAccDisName.lineBreakMode = .byWordWrapping
        
        //Call credit view
        scrollView.addSubview(defaultCallCreditView)
        defaultCallCreditView.translatesAutoresizingMaskIntoConstraints = false
        defaultCallCreditView.backgroundColor = UIColor.white.withAlphaComponent(0.50)
        defaultCallCreditView.isOpaque = false
        defaultCallCreditView.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        defaultCallCreditView.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -30).isActive = true
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
        
        //label for credit title
        scrollView.addSubview(lblCreditTitle)
        lblCreditTitle.translatesAutoresizingMaskIntoConstraints = false
        lblCreditTitle.text = "Credit remaining"
        lblCreditTitle.textColor = UIColor.black
        lblCreditTitle.font = UIFont(name: String.defaultFontR, size: 16)
        lblCreditTitle.leadingAnchor.constraint(equalTo: defaultCallCreditView.leadingAnchor, constant: 30).isActive = true
        lblCreditTitle.topAnchor.constraint(equalTo: defaultCallCreditView.topAnchor, constant: 20).isActive = true
        
        //label for actual credit
        scrollView.addSubview(lblCreditRem)
        lblCreditRem.translatesAutoresizingMaskIntoConstraints = false
        lblCreditRem.text = "GHS 2,000"
        lblCreditRem.textColor = UIColor.black
        lblCreditRem.font = UIFont(name: String.defaultFontB, size: 19)
        lblCreditRem.leadingAnchor.constraint(equalTo: defaultCallCreditView.leadingAnchor, constant: 30).isActive = true
        lblCreditRem.topAnchor.constraint(equalTo: lblCreditTitle.bottomAnchor, constant: 8).isActive = true
        
        //yendi agoro
        scrollView.addSubview(yendiagoro)
        yendiagoro.translatesAutoresizingMaskIntoConstraints = false
        yendiagoro.image = UIImage(named: "spinlogo")
        yendiagoro.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        yendiagoro.topAnchor.constraint(equalTo: defaultAccDisName.bottomAnchor, constant: 150).isActive = true
        yendiagoro.heightAnchor.constraint(equalToConstant: 60).isActive = true
        yendiagoro.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
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
        updateIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        updateIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //Last updated label
        scrollView.addSubview(lblLastUpdatedStatus)
        lblLastUpdatedStatus.translatesAutoresizingMaskIntoConstraints = false
        lblLastUpdatedStatus.text = "Last updated on ........."
        lblLastUpdatedStatus.font = UIFont(name: String.defaultFontR, size: 13)
        lblLastUpdatedStatus.textColor = UIColor.white
        lblLastUpdatedStatus.leadingAnchor.constraint(equalTo: updateIcon.trailingAnchor, constant: 10).isActive = true
        lblLastUpdatedStatus.topAnchor.constraint(equalTo: yendiagoro.bottomAnchor, constant: 105).isActive = true
        
        scrollView.contentSize.height = 900
    }
    
    @objc func goToSupport(_sender: UITapGestureRecognizer){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "supportVC")
        present(moveTo!, animated: true, completion: nil)
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
