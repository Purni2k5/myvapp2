//
//  FBBPackages.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 06/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class FBBPackages: baseViewControllerM {

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
    
    //create card view
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.heightAnchor.constraint(equalToConstant: 400).isActive = true
        var offerVariable: String?
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.grayBackground
        setUpViewsFBBPackages()
        populatePackages()
        
        
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
        
    }
    
    func setUpViewsFBBPackages(){
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
        
        scrollView.addSubview(topImage)
        let timeOfDay = greetings()
        if timeOfDay == "morning"{
            topImage.image = UIImage(named: "bg2")
        }else if timeOfDay == "afternoon" {
            topImage.image = UIImage(named: "afternoon_bg")
        }else{
            topImage.image = UIImage(named: "evening_bg2")
        }
        topImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
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
        backButton.addTarget(self, action: #selector(goToFBB), for: .touchUpInside)
        
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
        lblSelectedOffer.text = "Fixed Broadband Packages"
        lblSelectedOffer.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        lblSelectedOffer.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 70).isActive = true
        lblSelectedOffer.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        lblSelectedOffer.numberOfLines = 0
        lblSelectedOffer.lineBreakMode = .byWordWrapping
        
        //activity loader
        scrollView.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        scrollView.contentSize.height = 5000
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
    
    func populatePackages(){
        let bbPackages = preference.object(forKey: "BBPACKAGES")
        if !CheckInternet.Connection(){
            toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "You're offline")
        }else{
            if bbPackages != nil {
                
                if let array = bbPackages as! NSArray?{
                    let totalPackages = array.count
                    var topAnchorConstraint: CGFloat = 30
                    print(totalPackages)
                    for obj in array {
                        if let dict = obj as? NSDictionary{
                            let price = dict.value(forKey: "PRICE") as! String
                            let USSDURL = dict.value(forKey: "USSDURL") as! String
                            let pid = dict.value(forKey: "PID") as! String
                            let packageName = dict.value(forKey: "NAME") as! String
                            let packageDesc = dict.value(forKey: "DESCRIPTION") as! String
                            
                            //creating the uiview
                            let packageCard = ChangeFBBPlan()
                            packageCard.planName = packageName
                            packageCard.planPrice = price
                            packageCard.planPID = pid
                            packageCard.planUSSDURL = USSDURL
                            self.scrollView.addSubview(packageCard)
                            packageCard.translatesAutoresizingMaskIntoConstraints = false
                            packageCard.topAnchor.constraint(equalTo: self.topImage.bottomAnchor, constant: topAnchorConstraint).isActive = true
                            packageCard.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25.0).isActive = true
                            packageCard.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25.0).isActive = true
                            packageCard.backgroundColor = UIColor.white
                            if packageName.contains("Vodafone One"){
                                packageCard.heightAnchor.constraint(equalToConstant: 430).isActive = true
                                topAnchorConstraint += 465
                            }else{
                                packageCard.heightAnchor.constraint(equalToConstant: 230).isActive = true
                                topAnchorConstraint += 265
                            }
                            
                            //transforming to cards
                            packageCard.layer.cornerRadius = 2
                            packageCard.layer.shadowOffset = CGSize(width: 0, height: 5)
                            packageCard.layer.shadowColor = UIColor.black.cgColor
                            packageCard.layer.shadowOpacity = 0.2
                            
                            //View with price
                            let viewPrice = UIView()
                            packageCard.addSubview(viewPrice)
                            viewPrice.translatesAutoresizingMaskIntoConstraints = false
                            viewPrice.backgroundColor = UIColor.support_dark_voilet.withAlphaComponent(0.80)
                            viewPrice.widthAnchor.constraint(equalToConstant: 70).isActive = true
                            viewPrice.heightAnchor.constraint(equalToConstant: 70).isActive = true
                            viewPrice.topAnchor.constraint(equalTo: packageCard.topAnchor, constant: 20).isActive = true
                            viewPrice.trailingAnchor.constraint(equalTo: packageCard.trailingAnchor, constant: -20).isActive = true
                            viewPrice.layer.cornerRadius = 70 / 2
                            //label for price
                            let lblPrice = UILabel()
                            viewPrice.addSubview(lblPrice)
                            lblPrice.translatesAutoresizingMaskIntoConstraints = false
                            lblPrice.text = price
                            lblPrice.textColor = UIColor.white
                            lblPrice.font = UIFont(name: String.defaultFontB, size: 20)
                            /*lblPrice.centerXAnchor.constraint(equalTo: viewPrice.centerXAnchor).isActive = true
                            lblPrice.centerYAnchor.constraint(equalTo: viewPrice.centerYAnchor).isActive = true*/
                            lblPrice.leadingAnchor.constraint(equalTo: viewPrice.leadingAnchor, constant: 10).isActive = true
                            lblPrice.topAnchor.constraint(equalTo: viewPrice.topAnchor, constant: 20).isActive = true
                            lblPrice.trailingAnchor.constraint(equalTo: viewPrice.trailingAnchor, constant: -10).isActive = true
                            lblPrice.numberOfLines = 0
                            lblPrice.lineBreakMode = .byWordWrapping
                            lblPrice.textAlignment = .center
                            
                            //Package Name
                            let lblPackName = UILabel()
                            self.scrollView.addSubview(lblPackName)
                            lblPackName.translatesAutoresizingMaskIntoConstraints = false
                            lblPackName.text = packageName
                            lblPackName.textColor = UIColor.support_dark_gray2
                            lblPackName.font = UIFont(name: String.defaultFontR, size: 35)
                            lblPackName.leadingAnchor.constraint(equalTo: packageCard.leadingAnchor, constant: 30).isActive = true
                            lblPackName.topAnchor.constraint(equalTo: packageCard.topAnchor, constant: 30).isActive = true
                            lblPackName.trailingAnchor.constraint(equalTo: viewPrice.leadingAnchor, constant: -60).isActive = true
                            lblPackName.lineBreakMode = .byWordWrapping
                            lblPackName.numberOfLines = 0
                            
                            let lblPID = UILabel()
                            self.scrollView.addSubview(lblPID)
                            lblPID.translatesAutoresizingMaskIntoConstraints = false
                            lblPID.textColor = UIColor.support_dark_gray2
                            lblPID.text = pid
                            lblPID.font = UIFont(name: String.defaultFontB, size: 16)
                            lblPID.leadingAnchor.constraint(equalTo: packageCard.leadingAnchor, constant: 30).isActive = true
                            lblPID.topAnchor.constraint(equalTo: lblPackName.bottomAnchor, constant: 7).isActive = true
                            lblPID.trailingAnchor.constraint(equalTo: packageCard.trailingAnchor, constant: -10).isActive = true
                            lblPID.numberOfLines = 0
                            lblPID.lineBreakMode = .byWordWrapping
                            
                            //line
                            let separator1 = UIView()
                            packageCard.addSubview(separator1)
                            separator1.translatesAutoresizingMaskIntoConstraints = false
//                            separator1.layer.borderColor = UIColor.black.cgColor
                            separator1.leadingAnchor.constraint(equalTo: packageCard.leadingAnchor, constant: 30).isActive = true
                            separator1.trailingAnchor.constraint(equalTo: packageCard.trailingAnchor, constant: -60).isActive = true
                            separator1.topAnchor.constraint(equalTo: lblPID.bottomAnchor, constant: 2).isActive = true
                            separator1.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
                            separator1.backgroundColor = UIColor.black.withAlphaComponent(0.50)
                            
                            //Description
                            let lblDesc = UILabel()
                            packageCard.addSubview(lblDesc)
                            lblDesc.translatesAutoresizingMaskIntoConstraints = false
                            lblDesc.text = packageDesc
                            lblDesc.font = UIFont(name: String.defaultFontR, size: 17)
                            lblDesc.textColor = UIColor.black
                            lblDesc.leadingAnchor.constraint(equalTo: packageCard.leadingAnchor, constant: 30).isActive = true
                            lblDesc.topAnchor.constraint(equalTo: separator1.bottomAnchor, constant: 10).isActive = true
                            lblDesc.trailingAnchor.constraint(equalTo: packageCard.trailingAnchor, constant: -30).isActive = true
                            lblDesc.numberOfLines = 0
                            lblDesc.lineBreakMode = .byWordWrapping
                            
                            //Button
                            let btnChange = UIView()
                            packageCard.addSubview(btnChange)
                            btnChange.translatesAutoresizingMaskIntoConstraints = false
                            btnChange.backgroundColor = UIColor.vodaRed
                            btnChange.heightAnchor.constraint(equalToConstant: 55).isActive = true
                            btnChange.leadingAnchor.constraint(equalTo: packageCard.leadingAnchor, constant: 30).isActive = true
                            btnChange.topAnchor.constraint(equalTo: lblDesc.bottomAnchor, constant: 10).isActive = true
                            btnChange.trailingAnchor.constraint(equalTo: packageCard.trailingAnchor, constant: -30).isActive = true
                            
                            //Button label
                            let lblButton = UILabel()
                            btnChange.addSubview(lblButton)
                            lblButton.translatesAutoresizingMaskIntoConstraints = false
                            lblButton.font = UIFont(name: String.defaultFontR, size: 22)
                            lblButton.textColor = UIColor.white
                            lblButton.text = "Change to this plan"
                            lblButton.centerXAnchor.constraint(equalTo: btnChange.centerXAnchor).isActive = true
                            lblButton.centerYAnchor.constraint(equalTo: btnChange.centerYAnchor).isActive = true
                            
                            //Adding gesture recognizer
                            let gesRec = UITapGestureRecognizer(target: self, action: #selector(goToConfirm(_sender:)))
                            packageCard.addGestureRecognizer(gesRec)
                            self.scrollView.contentSize.height = 4000
                            
                        }
                    }
                }
                let async_call = URL(string: String.oldOffers)
                let request = NSMutableURLRequest(url: async_call!)
                
                let postParameters: Dictionary<String, Any> = [
                    "action":"products",
                    "option":"byType",
                    "productType":"FBB",
                    "os":getAppVersion()
                ]
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
//                                self.stop_activity_loader()
//                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: error!.localizedDescription)
                            }
                            return;
                        }
                        do {
                            let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            if let parseJSON = myJSON {
                                var responseCode: Int?
                                
                                print(parseJSON)
                                responseCode = parseJSON["RESPONSECODE"] as! Int?
                                DispatchQueue.main.async {
                                    self.stop_activity_loader()
                                    if responseCode == 0 {
                                        var responseMessage: NSArray?
                                        responseMessage = parseJSON["RESPONSEMESSAGE"] as! NSArray?
                                        //Now cache results
                                        self.preference.removeObject(forKey: "BBPACKAGES")
                                        self.preference.set(responseMessage, forKey: "BBPACKAGES")
                                        print("***************************************************")
                                        let cachedPackages = self.preference.object(forKey: "BBPACKAGES")
                                        if let array = cachedPackages as! NSArray?{
                                            let totalPackages = array.count
                                            var topAnchorConstraint: CGFloat = 30
                                            print(totalPackages)
                                            for obj in array {
                                                if let dict = obj as? NSDictionary{
                                                    let price = dict.value(forKey: "PRICE") as! String
                                                    let USSDURL = dict.value(forKey: "USSDURL") as! String
                                                    let pid = dict.value(forKey: "PID") as! String
                                                    let packageName = dict.value(forKey: "NAME") as! String
                                                    let packageDesc = dict.value(forKey: "DESCRIPTION") as! String
                                                    
                                                    //creating the uiview
                                                    let packageCard = ChangeFBBPlan()
                                                    packageCard.planName = packageName
                                                    packageCard.planPrice = price
                                                    packageCard.planPID = pid
                                                    packageCard.planUSSDURL = USSDURL
                                                    self.scrollView.addSubview(packageCard)
                                                    packageCard.translatesAutoresizingMaskIntoConstraints = false
                                                    packageCard.topAnchor.constraint(equalTo: self.topImage.bottomAnchor, constant: topAnchorConstraint).isActive = true
                                                    packageCard.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25.0).isActive = true
                                                    packageCard.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25.0).isActive = true
                                                    packageCard.backgroundColor = UIColor.white
                                                    if packageName.contains("Vodafone One"){
                                                        packageCard.heightAnchor.constraint(equalToConstant: 430).isActive = true
                                                        topAnchorConstraint += 465
                                                    }else{
                                                        packageCard.heightAnchor.constraint(equalToConstant: 230).isActive = true
                                                        topAnchorConstraint += 265
                                                    }
                                                    
                                                    //transforming to cards
                                                    packageCard.layer.cornerRadius = 2
                                                    packageCard.layer.shadowOffset = CGSize(width: 0, height: 5)
                                                    packageCard.layer.shadowColor = UIColor.black.cgColor
                                                    packageCard.layer.shadowOpacity = 0.2
                                                    
                                                    //View with price
                                                    let viewPrice = UIView()
                                                    packageCard.addSubview(viewPrice)
                                                    viewPrice.translatesAutoresizingMaskIntoConstraints = false
                                                    viewPrice.backgroundColor = UIColor.support_dark_voilet.withAlphaComponent(0.80)
                                                    viewPrice.widthAnchor.constraint(equalToConstant: 70).isActive = true
                                                    viewPrice.heightAnchor.constraint(equalToConstant: 70).isActive = true
                                                    viewPrice.topAnchor.constraint(equalTo: packageCard.topAnchor, constant: 20).isActive = true
                                                    viewPrice.trailingAnchor.constraint(equalTo: packageCard.trailingAnchor, constant: -20).isActive = true
                                                    viewPrice.layer.cornerRadius = 70 / 2
                                                    //label for price
                                                    let lblPrice = UILabel()
                                                    viewPrice.addSubview(lblPrice)
                                                    lblPrice.translatesAutoresizingMaskIntoConstraints = false
                                                    lblPrice.text = price
                                                    lblPrice.textColor = UIColor.white
                                                    lblPrice.font = UIFont(name: String.defaultFontB, size: 20)
                                                    /*lblPrice.centerXAnchor.constraint(equalTo: viewPrice.centerXAnchor).isActive = true
                                                     lblPrice.centerYAnchor.constraint(equalTo: viewPrice.centerYAnchor).isActive = true*/
                                                    lblPrice.leadingAnchor.constraint(equalTo: viewPrice.leadingAnchor, constant: 10).isActive = true
                                                    lblPrice.topAnchor.constraint(equalTo: viewPrice.topAnchor, constant: 20).isActive = true
                                                    lblPrice.trailingAnchor.constraint(equalTo: viewPrice.trailingAnchor, constant: -10).isActive = true
                                                    lblPrice.numberOfLines = 0
                                                    lblPrice.lineBreakMode = .byWordWrapping
                                                    lblPrice.textAlignment = .center
                                                    
                                                    //Package Name
                                                    let lblPackName = UILabel()
                                                    self.scrollView.addSubview(lblPackName)
                                                    lblPackName.translatesAutoresizingMaskIntoConstraints = false
                                                    lblPackName.text = packageName
                                                    lblPackName.textColor = UIColor.support_dark_gray2
                                                    lblPackName.font = UIFont(name: String.defaultFontR, size: 35)
                                                    lblPackName.leadingAnchor.constraint(equalTo: packageCard.leadingAnchor, constant: 30).isActive = true
                                                    lblPackName.topAnchor.constraint(equalTo: packageCard.topAnchor, constant: 30).isActive = true
                                                    lblPackName.trailingAnchor.constraint(equalTo: viewPrice.leadingAnchor, constant: -60).isActive = true
                                                    lblPackName.lineBreakMode = .byWordWrapping
                                                    lblPackName.numberOfLines = 0
                                                    
                                                    let lblPID = UILabel()
                                                    self.scrollView.addSubview(lblPID)
                                                    lblPID.translatesAutoresizingMaskIntoConstraints = false
                                                    lblPID.textColor = UIColor.support_dark_gray2
                                                    lblPID.text = pid
                                                    lblPID.font = UIFont(name: String.defaultFontB, size: 16)
                                                    lblPID.leadingAnchor.constraint(equalTo: packageCard.leadingAnchor, constant: 30).isActive = true
                                                    lblPID.topAnchor.constraint(equalTo: lblPackName.bottomAnchor, constant: 7).isActive = true
                                                    lblPID.trailingAnchor.constraint(equalTo: packageCard.trailingAnchor, constant: -10).isActive = true
                                                    lblPID.numberOfLines = 0
                                                    lblPID.lineBreakMode = .byWordWrapping
                                                    
                                                    //line
                                                    let separator1 = UIView()
                                                    packageCard.addSubview(separator1)
                                                    separator1.translatesAutoresizingMaskIntoConstraints = false
                                                    //                            separator1.layer.borderColor = UIColor.black.cgColor
                                                    separator1.leadingAnchor.constraint(equalTo: packageCard.leadingAnchor, constant: 30).isActive = true
                                                    separator1.trailingAnchor.constraint(equalTo: packageCard.trailingAnchor, constant: -60).isActive = true
                                                    separator1.topAnchor.constraint(equalTo: lblPID.bottomAnchor, constant: 2).isActive = true
                                                    separator1.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
                                                    separator1.backgroundColor = UIColor.black.withAlphaComponent(0.50)
                                                    
                                                    //Description
                                                    let lblDesc = UILabel()
                                                    packageCard.addSubview(lblDesc)
                                                    lblDesc.translatesAutoresizingMaskIntoConstraints = false
                                                    lblDesc.text = packageDesc
                                                    lblDesc.font = UIFont(name: String.defaultFontR, size: 17)
                                                    lblDesc.textColor = UIColor.black
                                                    lblDesc.leadingAnchor.constraint(equalTo: packageCard.leadingAnchor, constant: 30).isActive = true
                                                    lblDesc.topAnchor.constraint(equalTo: separator1.bottomAnchor, constant: 10).isActive = true
                                                    lblDesc.trailingAnchor.constraint(equalTo: packageCard.trailingAnchor, constant: -30).isActive = true
                                                    lblDesc.numberOfLines = 0
                                                    lblDesc.lineBreakMode = .byWordWrapping
                                                    
                                                    //Button
                                                    let btnChange = UIView()
                                                    packageCard.addSubview(btnChange)
                                                    btnChange.translatesAutoresizingMaskIntoConstraints = false
                                                    btnChange.backgroundColor = UIColor.vodaRed
                                                    btnChange.heightAnchor.constraint(equalToConstant: 55).isActive = true
                                                    btnChange.leadingAnchor.constraint(equalTo: packageCard.leadingAnchor, constant: 30).isActive = true
                                                    btnChange.topAnchor.constraint(equalTo: lblDesc.bottomAnchor, constant: 10).isActive = true
                                                    btnChange.trailingAnchor.constraint(equalTo: packageCard.trailingAnchor, constant: -30).isActive = true
                                                    
                                                    //Button label
                                                    let lblButton = UILabel()
                                                    btnChange.addSubview(lblButton)
                                                    lblButton.translatesAutoresizingMaskIntoConstraints = false
                                                    lblButton.font = UIFont(name: String.defaultFontR, size: 22)
                                                    lblButton.textColor = UIColor.white
                                                    lblButton.text = "Change to this plan"
                                                    lblButton.centerXAnchor.constraint(equalTo: btnChange.centerXAnchor).isActive = true
                                                    lblButton.centerYAnchor.constraint(equalTo: btnChange.centerYAnchor).isActive = true
                                                    
                                                    //Adding gesture recognizer
                                                    let gesRec = UITapGestureRecognizer(target: self, action: #selector(self.goToConfirm(_sender:)))
                                                    packageCard.addGestureRecognizer(gesRec)
                                                    self.scrollView.contentSize.height = 4000
                                                    
                                                }
                                            }
                                        }
                                    }else{
//                                        self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry try again later..")
                                    }
                                }
                            }
                        }catch{
                            print(error.localizedDescription)
                            DispatchQueue.main.async {
//                                self.stop_activity_loader()
//                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: error.localizedDescription)
                            }
                        }
                    }
                    task.resume()
                }
            }else{
                start_activity_loader()
                let async_call = URL(string: String.oldOffers)
                let request = NSMutableURLRequest(url: async_call!)
                
                let postParameters: Dictionary<String, Any> = [
                    "action":"products",
                    "option":"byType",
                    "productType":"FBB",
                    "os":getAppVersion()
                ]
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
                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: error!.localizedDescription)
                            }
                            return;
                        }
                        do {
                            let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            if let parseJSON = myJSON {
                                var responseCode: Int?
                                
                                print(parseJSON)
                                responseCode = parseJSON["RESPONSECODE"] as! Int?
                                DispatchQueue.main.async {
                                    self.stop_activity_loader()
                                    if responseCode == 0 {
                                        var responseMessage: NSArray?
                                        responseMessage = parseJSON["RESPONSEMESSAGE"] as! NSArray?
                                        //Now cache results
                                        self.preference.set(responseMessage, forKey: "BBPACKAGES")
                                        print("***************************************************")
                                        let cachedPackages = self.preference.object(forKey: "BBPACKAGES")
                                        if let array = cachedPackages as! NSArray?{
                                            let totalPackages = array.count
                                            var topAnchorConstraint: CGFloat = 30
                                            print(totalPackages)
                                            for obj in array {
                                                if let dict = obj as? NSDictionary{
                                                    let price = dict.value(forKey: "PRICE") as! String
                                                    let USSDURL = dict.value(forKey: "USSDURL") as! String
                                                    let pid = dict.value(forKey: "PID") as! String
                                                    let packageName = dict.value(forKey: "NAME") as! String
                                                    let packageDesc = dict.value(forKey: "DESCRIPTION") as! String
                                                    
                                                    //creating the uiview
                                                    let packageCard = ChangeFBBPlan()
                                                    packageCard.planName = packageName
                                                    packageCard.planPrice = price
                                                    packageCard.planPID = pid
                                                    packageCard.planUSSDURL = USSDURL
                                                    self.scrollView.addSubview(packageCard)
                                                    packageCard.translatesAutoresizingMaskIntoConstraints = false
                                                    packageCard.topAnchor.constraint(equalTo: self.topImage.bottomAnchor, constant: topAnchorConstraint).isActive = true
                                                    packageCard.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25.0).isActive = true
                                                    packageCard.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25.0).isActive = true
                                                    packageCard.backgroundColor = UIColor.white
                                                    if packageName.contains("Vodafone One"){
                                                        packageCard.heightAnchor.constraint(equalToConstant: 430).isActive = true
                                                        topAnchorConstraint += 465
                                                    }else{
                                                        packageCard.heightAnchor.constraint(equalToConstant: 230).isActive = true
                                                        topAnchorConstraint += 265
                                                    }
                                                    
                                                    //transforming to cards
                                                    packageCard.layer.cornerRadius = 2
                                                    packageCard.layer.shadowOffset = CGSize(width: 0, height: 5)
                                                    packageCard.layer.shadowColor = UIColor.black.cgColor
                                                    packageCard.layer.shadowOpacity = 0.2
                                                    
                                                    //View with price
                                                    let viewPrice = UIView()
                                                    packageCard.addSubview(viewPrice)
                                                    viewPrice.translatesAutoresizingMaskIntoConstraints = false
                                                    viewPrice.backgroundColor = UIColor.support_dark_voilet.withAlphaComponent(0.80)
                                                    viewPrice.widthAnchor.constraint(equalToConstant: 70).isActive = true
                                                    viewPrice.heightAnchor.constraint(equalToConstant: 70).isActive = true
                                                    viewPrice.topAnchor.constraint(equalTo: packageCard.topAnchor, constant: 20).isActive = true
                                                    viewPrice.trailingAnchor.constraint(equalTo: packageCard.trailingAnchor, constant: -20).isActive = true
                                                    viewPrice.layer.cornerRadius = 70 / 2
                                                    //label for price
                                                    let lblPrice = UILabel()
                                                    viewPrice.addSubview(lblPrice)
                                                    lblPrice.translatesAutoresizingMaskIntoConstraints = false
                                                    lblPrice.text = price
                                                    lblPrice.textColor = UIColor.white
                                                    lblPrice.font = UIFont(name: String.defaultFontB, size: 20)
                                                    /*lblPrice.centerXAnchor.constraint(equalTo: viewPrice.centerXAnchor).isActive = true
                                                     lblPrice.centerYAnchor.constraint(equalTo: viewPrice.centerYAnchor).isActive = true*/
                                                    lblPrice.leadingAnchor.constraint(equalTo: viewPrice.leadingAnchor, constant: 10).isActive = true
                                                    lblPrice.topAnchor.constraint(equalTo: viewPrice.topAnchor, constant: 20).isActive = true
                                                    lblPrice.trailingAnchor.constraint(equalTo: viewPrice.trailingAnchor, constant: -10).isActive = true
                                                    lblPrice.numberOfLines = 0
                                                    lblPrice.lineBreakMode = .byWordWrapping
                                                    lblPrice.textAlignment = .center
                                                    
                                                    //Package Name
                                                    let lblPackName = UILabel()
                                                    self.scrollView.addSubview(lblPackName)
                                                    lblPackName.translatesAutoresizingMaskIntoConstraints = false
                                                    lblPackName.text = packageName
                                                    lblPackName.textColor = UIColor.support_dark_gray2
                                                    lblPackName.font = UIFont(name: String.defaultFontR, size: 35)
                                                    lblPackName.leadingAnchor.constraint(equalTo: packageCard.leadingAnchor, constant: 30).isActive = true
                                                    lblPackName.topAnchor.constraint(equalTo: packageCard.topAnchor, constant: 30).isActive = true
                                                    lblPackName.trailingAnchor.constraint(equalTo: viewPrice.leadingAnchor, constant: -60).isActive = true
                                                    lblPackName.lineBreakMode = .byWordWrapping
                                                    lblPackName.numberOfLines = 0
                                                    
                                                    let lblPID = UILabel()
                                                    self.scrollView.addSubview(lblPID)
                                                    lblPID.translatesAutoresizingMaskIntoConstraints = false
                                                    lblPID.textColor = UIColor.support_dark_gray2
                                                    lblPID.text = pid
                                                    lblPID.font = UIFont(name: String.defaultFontB, size: 16)
                                                    lblPID.leadingAnchor.constraint(equalTo: packageCard.leadingAnchor, constant: 30).isActive = true
                                                    lblPID.topAnchor.constraint(equalTo: lblPackName.bottomAnchor, constant: 7).isActive = true
                                                    lblPID.trailingAnchor.constraint(equalTo: packageCard.trailingAnchor, constant: -10).isActive = true
                                                    lblPID.numberOfLines = 0
                                                    lblPID.lineBreakMode = .byWordWrapping
                                                    
                                                    //line
                                                    let separator1 = UIView()
                                                    packageCard.addSubview(separator1)
                                                    separator1.translatesAutoresizingMaskIntoConstraints = false
                                                    //                            separator1.layer.borderColor = UIColor.black.cgColor
                                                    separator1.leadingAnchor.constraint(equalTo: packageCard.leadingAnchor, constant: 30).isActive = true
                                                    separator1.trailingAnchor.constraint(equalTo: packageCard.trailingAnchor, constant: -60).isActive = true
                                                    separator1.topAnchor.constraint(equalTo: lblPID.bottomAnchor, constant: 2).isActive = true
                                                    separator1.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
                                                    separator1.backgroundColor = UIColor.black.withAlphaComponent(0.50)
                                                    
                                                    //Description
                                                    let lblDesc = UILabel()
                                                    packageCard.addSubview(lblDesc)
                                                    lblDesc.translatesAutoresizingMaskIntoConstraints = false
                                                    lblDesc.text = packageDesc
                                                    lblDesc.font = UIFont(name: String.defaultFontR, size: 17)
                                                    lblDesc.textColor = UIColor.black
                                                    lblDesc.leadingAnchor.constraint(equalTo: packageCard.leadingAnchor, constant: 30).isActive = true
                                                    lblDesc.topAnchor.constraint(equalTo: separator1.bottomAnchor, constant: 10).isActive = true
                                                    lblDesc.trailingAnchor.constraint(equalTo: packageCard.trailingAnchor, constant: -30).isActive = true
                                                    lblDesc.numberOfLines = 0
                                                    lblDesc.lineBreakMode = .byWordWrapping
                                                    
                                                    //Button
                                                    let btnChange = UIView()
                                                    packageCard.addSubview(btnChange)
                                                    btnChange.translatesAutoresizingMaskIntoConstraints = false
                                                    btnChange.backgroundColor = UIColor.vodaRed
                                                    btnChange.heightAnchor.constraint(equalToConstant: 55).isActive = true
                                                    btnChange.leadingAnchor.constraint(equalTo: packageCard.leadingAnchor, constant: 30).isActive = true
                                                    btnChange.topAnchor.constraint(equalTo: lblDesc.bottomAnchor, constant: 10).isActive = true
                                                    btnChange.trailingAnchor.constraint(equalTo: packageCard.trailingAnchor, constant: -30).isActive = true
                                                    
                                                    //Button label
                                                    let lblButton = UILabel()
                                                    btnChange.addSubview(lblButton)
                                                    lblButton.translatesAutoresizingMaskIntoConstraints = false
                                                    lblButton.font = UIFont(name: String.defaultFontR, size: 22)
                                                    lblButton.textColor = UIColor.white
                                                    lblButton.text = "Change to this plan"
                                                    lblButton.centerXAnchor.constraint(equalTo: btnChange.centerXAnchor).isActive = true
                                                    lblButton.centerYAnchor.constraint(equalTo: btnChange.centerYAnchor).isActive = true
                                                    
                                                    //Adding gesture recognizer
                                                    let gesRec = UITapGestureRecognizer(target: self, action: #selector(self.goToConfirm(_sender:)))
                                                    packageCard.addGestureRecognizer(gesRec)
                                                    self.scrollView.contentSize.height = 4000
                                                    
                                                }
                                            }
                                        }
                                    }else{
                                        self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry try again later..")
                                    }
                                }
                            }
                        }catch{
                            print(error.localizedDescription)
                            DispatchQueue.main.async {
                                self.stop_activity_loader()
                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: error.localizedDescription)
                            }
                        }
                    }
                    task.resume()
                }
            }
        }
    }
    
    @objc func goToConfirm(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "FBB", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "confirmChangePlan") as? confirmChangePlan else {return}
        guard let moveVariables = _sender.view as? ChangeFBBPlan else {return}
        moveTo.planName = moveVariables.planName
        moveTo.planPID = moveVariables.planID
        moveTo.planPrice = moveVariables.planPrice
        moveTo.USSDURL = moveVariables.planUSSDURL
        
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToFBB(){
        let storyboard = UIStoryboard(name: "OffersExtras", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "displayChosenOfferVc") as? displayChosenOfferVc else {return}
        moveTo.selectedOffer = "FBB"
        present(moveTo, animated: true, completion: nil)
    }

}
