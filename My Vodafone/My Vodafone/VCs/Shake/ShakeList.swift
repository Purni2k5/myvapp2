//
//  ShakeList.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 16/10/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class ShakeList: baseViewControllerM {

    var username: String?
    
    let scrollView = UIScrollView()
    
    // back button
    let backButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //create a closure for activity loader
    let activity_loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        view.hidesWhenStopped = true
        return view
    }()
    
    let lblShakeHeader: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Shake on Vodafone X"
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 31)
        return view
    }()
    
    let lblShakeDesc: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Super Vodafone X Bundles"
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 25)
        return view
    }()
    let separator = UIView()
    
    fileprivate func getSharedXBundles() {
        if let shakeXBundles = preference.object(forKey: UserDefaultsKeys.shakeBundles.rawValue) as! NSArray? {
            
            let totalArray = shakeXBundles.count
            var counter = 0
            
            var cardTop: CGFloat = 15
            for obj in shakeXBundles {
                print("objs \(obj)")
                if let dict = obj as? NSDictionary {
                    
                    let name = dict.value(forKey: "NAME") as! String?
                    let price = dict.value(forKey: "PRICE") as! String?
                    let pid = dict.value(forKey: "PID") as! String?
                    let sub_desc = dict.value(forKey: "SUB_DESCR") as! String
                    let desc = dict.value(forKey: "DESCRIPTION") as! String?
                    
                    //Draw card to hold bundles
                    let cardView = UIView()
                    self.scrollView.addSubview(cardView)
                    cardView.backgroundColor = UIColor.white.withAlphaComponent(0.60)
                    cardView.translatesAutoresizingMaskIntoConstraints = false
                    cardView.heightAnchor.constraint(equalToConstant: 150).isActive = true
                    cardView.topAnchor.constraint(equalTo: self.separator.bottomAnchor, constant: cardTop).isActive = true
                    cardView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
                    cardView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
                    cardView.layer.cornerRadius = 3
                    
                    //shake icon
                    let miniShakeIcon = UIImageView(image: #imageLiteral(resourceName: "shake_hand"))
                    cardView.addSubview(miniShakeIcon)
                    miniShakeIcon.translatesAutoresizingMaskIntoConstraints = false
                    miniShakeIcon.widthAnchor.constraint(equalToConstant: 50).isActive = true
                    miniShakeIcon.heightAnchor.constraint(equalToConstant: 50).isActive = true
                    miniShakeIcon.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20).isActive = true
                    miniShakeIcon.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
                    
                    let lblShakeName = UILabel()
                    cardView.addSubview(lblShakeName)
                    lblShakeName.translatesAutoresizingMaskIntoConstraints = false
                    lblShakeName.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20).isActive = true
                    lblShakeName.leadingAnchor.constraint(equalTo: miniShakeIcon.trailingAnchor, constant: 10).isActive = true
                    lblShakeName.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -80).isActive = true
                    lblShakeName.font = UIFont(name: String.defaultFontB, size: 21)
                    lblShakeName.textColor = UIColor.black
                    lblShakeName.text = name
                    lblShakeName.numberOfLines = 0
                    lblShakeName.lineBreakMode = .byWordWrapping
                    cardTop = cardTop + 165
                    //                                                    self.scrollView.contentSize.height = 1200
                    
                    let lblPrice = UILabel()
                    cardView.addSubview(lblPrice)
                    lblPrice.translatesAutoresizingMaskIntoConstraints = false
                    lblPrice.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 19).isActive = true
                    lblPrice.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
                    lblPrice.numberOfLines = 0
                    lblPrice.lineBreakMode = .byWordWrapping
                    lblPrice.font = UIFont(name: String.defaultFontB, size: 25)
                    lblPrice.textColor = UIColor.black
                    lblPrice.text = "GHS \(price ?? "")"
                    
                    let lblSub_desc = UILabel()
                    cardView.addSubview(lblSub_desc)
                    lblSub_desc.translatesAutoresizingMaskIntoConstraints = false
                    lblSub_desc.topAnchor.constraint(equalTo: miniShakeIcon.bottomAnchor, constant: 20).isActive = true
                    lblSub_desc.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
                    lblSub_desc.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
                    lblSub_desc.numberOfLines = 0
                    lblSub_desc.lineBreakMode = .byWordWrapping
                    lblSub_desc.font = UIFont(name: String.defaultFontB, size: 18)
                    lblSub_desc.textColor = UIColor.black
                    let htmlString = sub_desc
                    let data = htmlString.data(using: String.Encoding.unicode)! // mind "!"
                    let attrStr = try? NSAttributedString( // do catch
                        data: data,
                        options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                        documentAttributes: nil)
                    // suppose we have an UILabel, but any element with NSAttributedString will do
                    lblSub_desc.attributedText = attrStr
                    
                    let btnPurchase = ConfirmXShake()
                    cardView.addSubview(btnPurchase)
                    btnPurchase.translatesAutoresizingMaskIntoConstraints = false
                    btnPurchase.backgroundColor = UIColor.vodaRed
                    btnPurchase.setTitle("CLICK", for: .normal)
                    btnPurchase.titleLabel?.font = UIFont(name: String.defaultFontR, size: 20)
                    btnPurchase.setTitleColor(UIColor.white, for: .normal)
                    btnPurchase.heightAnchor.constraint(equalToConstant: 55).isActive = true
                    btnPurchase.widthAnchor.constraint(equalToConstant: 120).isActive = true
                    btnPurchase.topAnchor.constraint(equalTo: lblPrice.bottomAnchor, constant: 20).isActive = true
                    btnPurchase.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
                    
                    counter = counter + 1
                    if counter == shakeXBundles.count {
                        let lblOtherOffers = UILabel()
                        self.scrollView.addSubview(lblOtherOffers)
                        lblOtherOffers.translatesAutoresizingMaskIntoConstraints = false
                        lblOtherOffers.font = UIFont(name: String.defaultFontB, size: 23)
                        lblOtherOffers.textColor = UIColor.white
                        lblOtherOffers.text = "Other Offers"
                        lblOtherOffers.numberOfLines = 0
                        lblOtherOffers.lineBreakMode = .byWordWrapping
                        lblOtherOffers.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                        lblOtherOffers.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 30).isActive = true
                        
                        let separator2 = UIView()
                        self.scrollView.addSubview(separator2)
                        separator2.translatesAutoresizingMaskIntoConstraints = false
                        separator2.backgroundColor = UIColor.gray
                        separator2.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
                        separator2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
                        separator2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
                        separator2.topAnchor.constraint(equalTo: lblOtherOffers.bottomAnchor, constant: 20).isActive = true
                        
                        //Draw card to hold bundles
                        let cardView = UIView()
                        self.scrollView.addSubview(cardView)
                        cardView.backgroundColor = UIColor.white.withAlphaComponent(0.60)
                        cardView.translatesAutoresizingMaskIntoConstraints = false
                        cardView.heightAnchor.constraint(equalToConstant: 150).isActive = true
                        cardView.topAnchor.constraint(equalTo: separator2.bottomAnchor, constant: 10).isActive = true
                        cardView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
                        cardView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
                        cardView.layer.cornerRadius = 3
                        
                        //shake icon
                        let miniShakeIcon = UIImageView(image: #imageLiteral(resourceName: "shake_hand"))
                        cardView.addSubview(miniShakeIcon)
                        miniShakeIcon.translatesAutoresizingMaskIntoConstraints = false
                        miniShakeIcon.widthAnchor.constraint(equalToConstant: 50).isActive = true
                        miniShakeIcon.heightAnchor.constraint(equalToConstant: 50).isActive = true
                        miniShakeIcon.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20).isActive = true
                        miniShakeIcon.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
                        
                        let lblShakeName = UILabel()
                        cardView.addSubview(lblShakeName)
                        lblShakeName.translatesAutoresizingMaskIntoConstraints = false
                        lblShakeName.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20).isActive = true
                        lblShakeName.leadingAnchor.constraint(equalTo: miniShakeIcon.trailingAnchor, constant: 10).isActive = true
                        lblShakeName.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -80).isActive = true
                        lblShakeName.font = UIFont(name: String.defaultFontB, size: 21)
                        lblShakeName.textColor = UIColor.black
                        lblShakeName.text = "Other Vodafone X Bundles"
                        lblShakeName.numberOfLines = 0
                        lblShakeName.lineBreakMode = .byWordWrapping
                        
                        
                        
                        let lblSub_desc = UILabel()
                        cardView.addSubview(lblSub_desc)
                        lblSub_desc.translatesAutoresizingMaskIntoConstraints = false
                        lblSub_desc.topAnchor.constraint(equalTo: miniShakeIcon.bottomAnchor, constant: 20).isActive = true
                        lblSub_desc.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
                        lblSub_desc.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -30).isActive = true
                        lblSub_desc.numberOfLines = 0
                        lblSub_desc.lineBreakMode = .byWordWrapping
                        lblSub_desc.font = UIFont(name: String.defaultFontR, size: 16)
                        lblSub_desc.textColor = UIColor.black
                        lblSub_desc.text = "Get all other Vodafone X bundles"
                        
                        let btnPurchase = ConfirmXShake()
                        cardView.addSubview(btnPurchase)
                        btnPurchase.translatesAutoresizingMaskIntoConstraints = false
                        btnPurchase.backgroundColor = UIColor.support_yellow
                        btnPurchase.setTitle("CLICK", for: .normal)
                        btnPurchase.titleLabel?.font = UIFont(name: String.defaultFontR, size: 20)
                        btnPurchase.setTitleColor(UIColor.white, for: .normal)
                        btnPurchase.heightAnchor.constraint(equalToConstant: 55).isActive = true
                        btnPurchase.widthAnchor.constraint(equalToConstant: 120).isActive = true
                        btnPurchase.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 80).isActive = true
                        btnPurchase.name = name
                        btnPurchase.desc = desc
                        btnPurchase.pid = pid
                        btnPurchase.price = price
                        btnPurchase.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
                    }
                    //                                                    var totalHeight = (totalArray * 165) + 125
                    self.scrollView.contentSize.height = 1200 + 125 + 210
                    
                    
                }
                
                
            }
            
        }else{
            print("No dey")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpVeiwsShakeList()
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        username = UserData["Username"] as? String
        
        getSharedXBundles()
        
        getShakeBundles()
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
    }


    func setUpVeiwsShakeList(){
        let bgImage = UIImageView()
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bgImage)
        /*let timeOfDay = greetings()
        if timeOfDay == "morning"{
            bgImage.image = UIImage(named: "shake__bg")
        }else if timeOfDay == "afternoon" {
            bgImage.image = UIImage(named: "bg_afternoon")
        }else{
            bgImage.image = UIImage(named: "bg_afternoon")
        }*/
        bgImage.image = UIImage(named: "shake__bg")
        
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
        
        scrollView.addSubview(backButton)
        let backImage = UIImage(named: "leftArrow")
        let backTint = backImage?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(backTint, for: .normal)
        backButton.tintColor = UIColor.white
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 10).isActive = true
        backButton.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
        
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
        
        //Header
        scrollView.addSubview(lblShakeHeader)
        lblShakeHeader.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 70).isActive = true
        lblShakeHeader.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        lblShakeHeader.numberOfLines = 0
        lblShakeHeader.lineBreakMode = .byWordWrapping
        
        //Description
        scrollView.addSubview(lblShakeDesc)
        lblShakeDesc.topAnchor.constraint(equalTo: lblShakeHeader.bottomAnchor, constant: 30).isActive = true
        lblShakeDesc.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        lblShakeDesc.numberOfLines = 0
        lblShakeDesc.lineBreakMode = .byWordWrapping
        
        //Separator
        
        scrollView.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor.gray
        separator.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        separator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        separator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        separator.topAnchor.constraint(equalTo: lblShakeDesc.bottomAnchor, constant: 20).isActive = true
        
        scrollView.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: motherView.centerXAnchor).isActive = true
        activity_loader.centerYAnchor.constraint(equalTo: motherView.centerYAnchor).isActive = true
        
        
    }
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
    }
    
    //Function to stopIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
    }
    
    // getShakeBundles
    func getShakeBundles(){
        let async_call = URL(string: String.offers)
        let request = NSMutableURLRequest(url: async_call!)
        request.httpMethod = "POST"
        
        //Check Internet
        if !CheckInternet.Connection(){
            displayNoInternet()
        }else{
            start_activity_loader()
            let postParameters: Dictionary<String, Any> = [
                "action":"getCustomData",
                "sql":"select * from VF_SHAKE_BUNDLES WHERE STATUS= ?",
                "authentication":"dd05e670a96e8f587c626ccfa101ddd013906d3d",
                "condition":"0",
                "username":username!,
                "os":getAppVersion()
            ]
            
            if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
                request.httpBody = postData
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                
                let task = URLSession.shared.dataTask(with: request as URLRequest){
                    data, response, error in
                    if error != nil {
                        DispatchQueue.main.async {
                            self.stop_activity_loader()
                            print("error is:: \(error!.localizedDescription)")
                        }
                        return
                    }
                    
                    do {
                        let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        if let parseJSON = myJSON {
                            var responseCode: Int?
                            
                            responseCode = parseJSON["RESPONSECODE"] as! Int?
//                            print("Shake X \(parseJSON)")
                            DispatchQueue.main.async {
                                if responseCode == 0 {
                                    self.stop_activity_loader()
                                    if let responseMessage = parseJSON["RESPONSEMESSAGE"] as! NSArray? {
                                        let resMssge = responseMessage
//                                        print("Shakes X \(resMssge)")
                                        self.preference.set(resMssge, forKey: UserDefaultsKeys.shakeBundles.rawValue)
                                        if let array = resMssge as NSArray? {
                                            let totalArray = array.count
                                            var counter = 0
                                            
                                            var cardTop: CGFloat = 15
                                            for obj in array {
                                                print("objs \(obj)")
                                                if let dict = obj as? NSDictionary {
                                                    
                                                    let name = dict.value(forKey: "NAME") as! String?
                                                    let price = dict.value(forKey: "PRICE") as! String?
                                                    let pid = dict.value(forKey: "PID") as! String?
                                                    let sub_desc = dict.value(forKey: "SUB_DESCR") as! String
                                                    let desc = dict.value(forKey: "DESCRIPTION") as! String?
                                                    
                                                    //Draw card to hold bundles
                                                    let cardView = UIView()
                                                    self.scrollView.addSubview(cardView)
                                                    cardView.backgroundColor = UIColor.white.withAlphaComponent(0.60)
                                                    cardView.translatesAutoresizingMaskIntoConstraints = false
                                                    cardView.heightAnchor.constraint(equalToConstant: 150).isActive = true
                                                    cardView.topAnchor.constraint(equalTo: self.separator.bottomAnchor, constant: cardTop).isActive = true
                                                    cardView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
                                                    cardView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
                                                    cardView.layer.cornerRadius = 3
                                                    
                                                    
                                                    //shake icon
                                                    let miniShakeIcon = UIImageView(image: #imageLiteral(resourceName: "shake_hand"))
                                                    cardView.addSubview(miniShakeIcon)
                                                    miniShakeIcon.translatesAutoresizingMaskIntoConstraints = false
                                                    miniShakeIcon.widthAnchor.constraint(equalToConstant: 50).isActive = true
                                                    miniShakeIcon.heightAnchor.constraint(equalToConstant: 50).isActive = true
                                                    miniShakeIcon.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20).isActive = true
                                                    miniShakeIcon.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
                                                    
                                                    let lblShakeName = UILabel()
                                                    cardView.addSubview(lblShakeName)
                                                    lblShakeName.translatesAutoresizingMaskIntoConstraints = false
                                                    lblShakeName.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20).isActive = true
                                                    lblShakeName.leadingAnchor.constraint(equalTo: miniShakeIcon.trailingAnchor, constant: 10).isActive = true
                                                    lblShakeName.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -80).isActive = true
                                                    lblShakeName.font = UIFont(name: String.defaultFontB, size: 21)
                                                    lblShakeName.textColor = UIColor.black
                                                    lblShakeName.text = name
                                                    lblShakeName.numberOfLines = 0
                                                    lblShakeName.lineBreakMode = .byWordWrapping
                                                    cardTop = cardTop + 165
//                                                    self.scrollView.contentSize.height = 1200
                                                    
                                                    let lblPrice = UILabel()
                                                    cardView.addSubview(lblPrice)
                                                    lblPrice.translatesAutoresizingMaskIntoConstraints = false
                                                    lblPrice.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 19).isActive = true
                                                    lblPrice.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
                                                    lblPrice.numberOfLines = 0
                                                    lblPrice.lineBreakMode = .byWordWrapping
                                                    lblPrice.font = UIFont(name: String.defaultFontB, size: 25)
                                                    lblPrice.textColor = UIColor.black
                                                    lblPrice.text = "GHS \(price ?? "")"
                                                    
                                                    let lblSub_desc = UILabel()
                                                    cardView.addSubview(lblSub_desc)
                                                    lblSub_desc.translatesAutoresizingMaskIntoConstraints = false
                                                    lblSub_desc.topAnchor.constraint(equalTo: miniShakeIcon.bottomAnchor, constant: 20).isActive = true
                                                    lblSub_desc.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
                                                    lblSub_desc.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
                                                    lblSub_desc.numberOfLines = 0
                                                    lblSub_desc.lineBreakMode = .byWordWrapping
                                                    lblSub_desc.font = UIFont(name: String.defaultFontB, size: 18)
                                                    lblSub_desc.textColor = UIColor.black
                                                    let htmlString = sub_desc
                                                    let data = htmlString.data(using: String.Encoding.unicode)! // mind "!"
                                                    let attrStr = try? NSAttributedString( // do catch
                                                        data: data,
                                                        options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                                                        documentAttributes: nil)
                                                    // suppose we have an UILabel, but any element with NSAttributedString will do
                                                    lblSub_desc.attributedText = attrStr
                                                    
                                                    let btnPurchase = ConfirmXShake()
                                                    cardView.addSubview(btnPurchase)
                                                    btnPurchase.translatesAutoresizingMaskIntoConstraints = false
                                                    btnPurchase.backgroundColor = UIColor.vodaRed
                                                    btnPurchase.setTitle("CLICK", for: .normal)
                                                    btnPurchase.titleLabel?.font = UIFont(name: String.defaultFontR, size: 20)
                                                    btnPurchase.setTitleColor(UIColor.white, for: .normal)
                                                    btnPurchase.heightAnchor.constraint(equalToConstant: 55).isActive = true
                                                    btnPurchase.widthAnchor.constraint(equalToConstant: 120).isActive = true
                                                    btnPurchase.topAnchor.constraint(equalTo: lblPrice.bottomAnchor, constant: 20).isActive = true
                                                    btnPurchase.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
                                                    btnPurchase.name = name
                                                    btnPurchase.desc = desc
                                                    btnPurchase.pid = pid
                                                    btnPurchase.price = price
                                                    btnPurchase.addTarget(self, action: #selector(self.goToConfirmShakeX(_btn:)), for: .touchUpInside)
                                                    
                                                    counter = counter + 1
                                                    if counter == array.count {
                                                        let lblOtherOffers = UILabel()
                                                        self.scrollView.addSubview(lblOtherOffers)
                                                        lblOtherOffers.translatesAutoresizingMaskIntoConstraints = false
                                                        lblOtherOffers.font = UIFont(name: String.defaultFontB, size: 23)
                                                        lblOtherOffers.textColor = UIColor.white
                                                        lblOtherOffers.text = "Other Offers"
                                                        lblOtherOffers.numberOfLines = 0
                                                        lblOtherOffers.lineBreakMode = .byWordWrapping
                                                        lblOtherOffers.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                                                        lblOtherOffers.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 30).isActive = true
                                                        
                                                        let separator2 = UIView()
                                                        self.scrollView.addSubview(separator2)
                                                        separator2.translatesAutoresizingMaskIntoConstraints = false
                                                        separator2.backgroundColor = UIColor.gray
                                                        separator2.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
                                                        separator2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
                                                        separator2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
                                                        separator2.topAnchor.constraint(equalTo: lblOtherOffers.bottomAnchor, constant: 20).isActive = true
                                                        
                                                        //Draw card to hold bundles
                                                        let cardView = UIView()
                                                        self.scrollView.addSubview(cardView)
                                                        cardView.backgroundColor = UIColor.white.withAlphaComponent(0.60)
                                                        cardView.translatesAutoresizingMaskIntoConstraints = false
                                                        cardView.heightAnchor.constraint(equalToConstant: 150).isActive = true
                                                        cardView.topAnchor.constraint(equalTo: separator2.bottomAnchor, constant: 10).isActive = true
                                                        cardView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
                                                        cardView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
                                                        cardView.layer.cornerRadius = 3
                                                        
                                                        //shake icon
                                                        let miniShakeIcon = UIImageView(image: #imageLiteral(resourceName: "shake_hand"))
                                                        cardView.addSubview(miniShakeIcon)
                                                        miniShakeIcon.translatesAutoresizingMaskIntoConstraints = false
                                                        miniShakeIcon.widthAnchor.constraint(equalToConstant: 50).isActive = true
                                                        miniShakeIcon.heightAnchor.constraint(equalToConstant: 50).isActive = true
                                                        miniShakeIcon.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20).isActive = true
                                                        miniShakeIcon.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
                                                        
                                                        let lblShakeName = UILabel()
                                                        cardView.addSubview(lblShakeName)
                                                        lblShakeName.translatesAutoresizingMaskIntoConstraints = false
                                                        lblShakeName.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20).isActive = true
                                                        lblShakeName.leadingAnchor.constraint(equalTo: miniShakeIcon.trailingAnchor, constant: 10).isActive = true
                                                        lblShakeName.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -80).isActive = true
                                                        lblShakeName.font = UIFont(name: String.defaultFontB, size: 21)
                                                        lblShakeName.textColor = UIColor.black
                                                        lblShakeName.text = "Other Vodafone X Bundles"
                                                        lblShakeName.numberOfLines = 0
                                                        lblShakeName.lineBreakMode = .byWordWrapping
                                                        
                                                        
                                                        
                                                        let lblSub_desc = UILabel()
                                                        cardView.addSubview(lblSub_desc)
                                                        lblSub_desc.translatesAutoresizingMaskIntoConstraints = false
                                                        lblSub_desc.topAnchor.constraint(equalTo: miniShakeIcon.bottomAnchor, constant: 20).isActive = true
                                                        lblSub_desc.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
                                                        lblSub_desc.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -30).isActive = true
                                                        lblSub_desc.numberOfLines = 0
                                                        lblSub_desc.lineBreakMode = .byWordWrapping
                                                        lblSub_desc.font = UIFont(name: String.defaultFontR, size: 16)
                                                        lblSub_desc.textColor = UIColor.black
                                                        lblSub_desc.text = "Get all other Vodafone X bundles"
                                                        
                                                        let btnPurchase = UIButton()
                                                        cardView.addSubview(btnPurchase)
                                                        btnPurchase.translatesAutoresizingMaskIntoConstraints = false
                                                        btnPurchase.backgroundColor = UIColor.support_yellow
                                                        btnPurchase.setTitle("CLICK", for: .normal)
                                                        btnPurchase.titleLabel?.font = UIFont(name: String.defaultFontR, size: 20)
                                                        btnPurchase.setTitleColor(UIColor.white, for: .normal)
                                                        btnPurchase.heightAnchor.constraint(equalToConstant: 55).isActive = true
                                                        btnPurchase.widthAnchor.constraint(equalToConstant: 120).isActive = true
                                                        btnPurchase.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 80).isActive = true
                                                        btnPurchase.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
                                                        btnPurchase.addTarget(self, action: #selector(self.goToConfirmShakeX(_btn:)), for: .touchUpInside)
                                                    }
//                                                    var totalHeight = (totalArray * 165) + 125
                                                    self.scrollView.contentSize.height = 1200 + 125 + 210
                                                    
                                                  
                                                }
                                                
                                                
                                            }
                                            
                                            
                                        }
                                        
                                    }
                                }
                            }
                        }
                    }catch{
                        DispatchQueue.main.async {
                            self.stop_activity_loader()
                            print(error.localizedDescription)
                            self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process your request at this time")
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    @objc func goToConfirmShakeX(_btn: UIButton){
        let storyboard = UIStoryboard(name: "Shake", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "confirmShake") as? confirmShake else {return}
        guard let variables = _btn as? ConfirmXShake else { return }
        moveTo.price = variables.price
        moveTo.name = variables.name
        moveTo.desc = variables.desc
        moveTo.pid = variables.pid
        present(moveTo, animated: true, completion: nil)
    }
}
