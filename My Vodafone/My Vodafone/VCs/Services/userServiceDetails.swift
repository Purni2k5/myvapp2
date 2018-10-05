//
//  userServiceDetails.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 19/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class userServiceDetails: baseViewControllerM {

    var msisdn: String?
    var displayName: String?
    var username: String?
    
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
    
    //create a closure for activity loader
    let activity_loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        view.hidesWhenStopped = true
        view.color = UIColor.vodaRed
        return view
    }()
    
    // Dark View
    let darkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground
        setUpViewsServiceeDet()
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        username = UserData["Username"] as? String
        
        if CheckInternet.Connection(){
            getAccountBalance()
        }else{
            
        }
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
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
    
    func setUpViewsServiceeDet(){
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        scrollView.contentSize.height = 1500
        
        scrollView.addSubview(topImage)
        topImage.image = UIImage(named: "bg2")
        topImage.heightAnchor.constraint(equalToConstant: 330).isActive = true
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
        backButton.addTarget(self, action: #selector(goToProducts), for: .touchUpInside)
        
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
        lblSelectedOffer.text = "Your Products and services"
        lblSelectedOffer.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        lblSelectedOffer.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 70).isActive = true
        lblSelectedOffer.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        lblSelectedOffer.numberOfLines = 0
        lblSelectedOffer.lineBreakMode = .byWordWrapping
        
        topImage.addSubview(darkView)
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.70)
        darkView.isOpaque = false
        darkView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        darkView.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        darkView.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        darkView.bottomAnchor.constraint(equalTo: topImage.bottomAnchor, constant: -20).isActive = true
        
        let displayImage = UIImageView()
        darkView.addSubview(displayImage)
        displayImage.translatesAutoresizingMaskIntoConstraints = false
        displayImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        displayImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        displayImage.centerXAnchor.constraint(equalTo: darkView.centerXAnchor).isActive = true
        displayImage.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 20).isActive = true
        displayImage.image = UIImage(named: "default_profile")
        displayImage.layer.cornerRadius = 50
        displayImage.layer.borderColor = UIColor.white.cgColor
        displayImage.clipsToBounds = true
        displayImage.layer.borderWidth = 2
        
        darkView.addSubview(activity_loader)
        activity_loader.centerYAnchor.constraint(equalTo: darkView.centerYAnchor).isActive = true
        activity_loader.centerXAnchor.constraint(equalTo: darkView.centerXAnchor).isActive = true
        start_activity_loader()
        
        let lblDisplayName = UILabel()
        darkView.addSubview(lblDisplayName)
        lblDisplayName.translatesAutoresizingMaskIntoConstraints = false
        lblDisplayName.text = displayName!
        lblDisplayName.textColor = UIColor.white
        lblDisplayName.font = UIFont(name: String.defaultFontR, size: 20)
        lblDisplayName.textAlignment = .center
        lblDisplayName.topAnchor.constraint(equalTo: displayImage.bottomAnchor, constant: 20).isActive = true
        lblDisplayName.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 30).isActive = true
        lblDisplayName.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -30).isActive = true
        lblDisplayName.numberOfLines = 0
        lblDisplayName.lineBreakMode = .byWordWrapping
        
        let lblMSISDN = UILabel()
        darkView.addSubview(lblMSISDN)
        lblMSISDN.translatesAutoresizingMaskIntoConstraints = false
        lblMSISDN.textAlignment = .center
        lblMSISDN.textColor = UIColor.white
        lblMSISDN.text = msisdn!
        lblMSISDN.font = UIFont(name: String.defaultFontR, size: 15)
        lblMSISDN.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 30).isActive = true
        lblMSISDN.topAnchor.constraint(equalTo: lblDisplayName.bottomAnchor, constant: 5).isActive = true
        lblMSISDN.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -30).isActive = true
    }
    
    func createCard(){
        let cardView = UIView()
        scrollView.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = UIColor.white
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cardView.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 20).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        cardView.layer.cornerRadius = 2
        cardView.layer.shadowOffset = CGSize(width: 0, height: 5)
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.2
    }
    
    func getAccountBalance(){
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
                    print("error is:: \(error!.localizedDescription)")
                    DispatchQueue.main.async {
                        self.stop_activity_loader()
                    }
                    return;
                }
                do {
                    let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    if let parseJSON = myJSON {
                        var responseCode: Int?
                        responseCode = parseJSON["RESPONSECODE"] as! Int?
                        DispatchQueue.main.async {
                            if responseCode == 0 {
                                self.stop_activity_loader()
//                                print(parseJSON)
                                if let bundleDetails = parseJSON["PROMOTIONS"] as! NSArray? {
                                    var cardViewTop:CGFloat = 30
                                    for bundleDetail in bundleDetails {
//                                        print("Bundle Detail \(bundleDetail)")
                                        
                                        if let dict = bundleDetail as? NSDictionary {
                                            let promotion = dict.value(forKey: "Promotion") as! String?
                                            let expirationDuration = dict.value(forKey: "ExpirationDuration") as! String?
//                                            self.createCard()
                                            
                                            let cardView = UIView()
                                            self.scrollView.addSubview(cardView)
                                            cardView.translatesAutoresizingMaskIntoConstraints = false
                                            cardView.backgroundColor = UIColor.white
                                            cardView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
                                            cardView.topAnchor.constraint(equalTo: self.topImage.bottomAnchor, constant: cardViewTop).isActive = true
                                            cardView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
//                                            cardView.heightAnchor.constraint(equalToConstant: 500).isActive = true
                                            cardView.layer.cornerRadius = 2
                                            cardView.layer.shadowOffset = CGSize(width: 0, height: 5)
                                            cardView.layer.shadowColor = UIColor.black.cgColor
                                            cardView.layer.shadowOpacity = 0.2
                                            
                                            let lblPromotion = UILabel()
                                            cardView.addSubview(lblPromotion)
                                            lblPromotion.translatesAutoresizingMaskIntoConstraints = false
                                            lblPromotion.text = promotion
                                            lblPromotion.textColor = UIColor.black
                                            lblPromotion.font = UIFont(name: String.defaultFontR, size: 25)
                                            lblPromotion.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
                                            lblPromotion.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20).isActive = true
                                            lblPromotion.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
                                            lblPromotion.numberOfLines = 0
                                            lblPromotion.lineBreakMode = .byWordWrapping
                                            
                                            let lblExpire = UILabel()
                                            cardView.addSubview(lblExpire)
                                            lblExpire.translatesAutoresizingMaskIntoConstraints = false
                                            lblExpire.text = expirationDuration
                                            lblExpire.textColor = UIColor.black
                                            lblExpire.font = UIFont(name: String.defaultFontR, size: 15)
                                            lblExpire.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
                                            lblExpire.topAnchor.constraint(equalTo: lblPromotion.bottomAnchor, constant: 5).isActive = true
                                            lblExpire.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
                                            lblExpire.numberOfLines = 0
                                            lblExpire.lineBreakMode = .byWordWrapping
                                            
                                            let lblHeaderSep = UIView()
                                            cardView.addSubview(lblHeaderSep)
                                            lblHeaderSep.translatesAutoresizingMaskIntoConstraints = false
                                            lblHeaderSep.backgroundColor = UIColor.gray
                                            lblHeaderSep.heightAnchor.constraint(equalToConstant: 0.2).isActive = true
                                            lblHeaderSep.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
                                            lblHeaderSep.topAnchor.constraint(equalTo: lblExpire.bottomAnchor, constant: 15).isActive = true
                                            lblHeaderSep.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
                                            
                                            let myNextArray = dict.value(forKey: "BundleDetails") as? NSArray
                                            
                                            if let array = myNextArray {
                                                for obj in array {
                                                    
                                                    if let dict = obj as? NSDictionary{ 
                                                       
                                                        let actualValue = dict.value(forKey: "ActualValue") as! String
                                                        let actualUnit = dict.value(forKey: "ActualUnit") as! String
                                                        
                                                        let lblActualValue = UILabel()
                                                        cardView.addSubview(lblActualValue)
                                                        lblActualValue.translatesAutoresizingMaskIntoConstraints = false
                                                        lblActualValue.text = actualValue
                                                        lblActualValue.textColor = UIColor.black
                                                        lblActualValue.font = UIFont(name: String.defaultFontR, size: 16)
                                                        lblActualValue.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
                                                        lblActualValue.topAnchor.constraint(equalTo: lblHeaderSep.bottomAnchor, constant: 40).isActive = true
                                                        lblActualValue.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
                                                        lblActualValue.numberOfLines = 0
                                                        lblActualValue.lineBreakMode = .byWordWrapping
                                                    }
                                                }
                                                if array.count >= 5 {
                                                    cardView.heightAnchor.constraint(equalToConstant: 550).isActive = true
                                                    cardViewTop = cardViewTop + 570
                                                }else{
                                                    cardView.heightAnchor.constraint(equalToConstant: 320).isActive = true
                                                    cardViewTop = cardViewTop + 350
                                                }
                                            }
                                            
                                        }
                                        
                                    }
                                }
                                
                            }else{
                                self.stop_activity_loader()
                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry try again..")
                            }
                        }
                    }
                }catch{
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        self.stop_activity_loader()
                    }
                }
            }
            task.resume()
        }
    }

}
