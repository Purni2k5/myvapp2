//
//  chooseDefaultService.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 01/10/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class chooseDefaultService: baseViewControllerM {

    fileprivate var cardHeight: NSLayoutConstraint?
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
    
    //create card view
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        
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
    
    let lblSelectHeader = UILabel()
    let separator1 = UIView()
    let desc = UILabel()
    var tagger: Int?
    let btnSave:  UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor.vodaRed
        view.setTitle("Save", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let txtSelectedService = UITextField()
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        btnSave.isHidden = true
    }
    
    //Function to stopIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        btnSave.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkConnection()
        view.backgroundColor = UIColor.grayBackground
        setUpViewsChooseDefaults()
        
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        username = UserData["Username"] as? String
        loadServices()
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
    }

    func setUpViewsChooseDefaults(){
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
        
        scrollView.addSubview(topImage)
        topImage.image = UIImage(named: "bg2")
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
        backButton.addTarget(self, action: #selector(goToPersonlised), for: .touchUpInside)
        
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
        lblSelectedOffer.text = "Select your home screen service"
        lblSelectedOffer.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        lblSelectedOffer.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 70).isActive = true
        lblSelectedOffer.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        lblSelectedOffer.numberOfLines = 0
        lblSelectedOffer.lineBreakMode = .byWordWrapping
        
        scrollView.addSubview(cardView)
        cardView.layer.cornerRadius = 2
        cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.2
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cardView.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 20).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        cardHeight = cardView.heightAnchor.constraint(equalToConstant: 480)
        cardHeight?.isActive = true
        
        cardView.addSubview(lblSelectHeader)
        lblSelectHeader.translatesAutoresizingMaskIntoConstraints = false
        lblSelectHeader.text = "Select from your services below"
        lblSelectHeader.font = UIFont(name: String.defaultFontR, size: 22)
        lblSelectHeader.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblSelectHeader.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20).isActive = true
        lblSelectHeader.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        lblSelectHeader.numberOfLines = 0
        lblSelectHeader.lineBreakMode = .byWordWrapping
        
        cardView.addSubview(desc)
        desc.translatesAutoresizingMaskIntoConstraints = false
        desc.text = "Select the service that you want to see first on the home"
        desc.font = UIFont(name: String.defaultFontR, size: 17)
        desc.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        desc.topAnchor.constraint(equalTo: lblSelectHeader.bottomAnchor, constant: 5).isActive = true
        desc.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        desc.numberOfLines = 0
        desc.lineBreakMode = .byWordWrapping
        
        cardView.addSubview(separator1)
        separator1.translatesAutoresizingMaskIntoConstraints = false
        separator1.backgroundColor = UIColor.black
        separator1.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        separator1.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        separator1.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: 30).isActive = true
        separator1.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        
        cardView.addSubview(txtSelectedService)
        txtSelectedService.translatesAutoresizingMaskIntoConstraints = false
        txtSelectedService.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 2).isActive = true
        txtSelectedService.topAnchor.constraint(equalTo: separator1.bottomAnchor, constant: 4).isActive = true
        txtSelectedService.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -2).isActive = true
        txtSelectedService.heightAnchor.constraint(equalToConstant: 40).isActive = true
        txtSelectedService.isHidden = true
        
        
    }
    
    @objc func goToPersonlised(){
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "personliseApp")
        present(moveTo, animated: true, completion: nil)
    }
    
    func loadServices(){
        let services = preference.object(forKey: UserDefaultsKeys.ServiceList.rawValue)
        let defaultService = preference.object(forKey: UserDefaultsKeys.DefaultService.rawValue) as! String
        txtSelectedService.text = defaultService
        print(defaultService)
        if let array = services as? NSArray {
            let arrayCount = array.count
            print("arrayCount:: \(arrayCount)")
            var counter = 0
            var topAnchorConstraint: CGFloat = 40
            var displayNameTopConstraint: CGFloat = 70
            var dynamicCardHeight: CGFloat = 100
            var separator2TopConstraint: CGFloat = 30
            var displayNumberTop: CGFloat = 5
            
            for obj in array {
                if let dict = obj as? NSDictionary {
                    let displayName = dict.value(forKey: "DisplayName") as! String
                    let primaryID = dict.value(forKey: "primaryID") as! String
                    let displayImage = dict.value(forKey: "DisplayImageUrl") as! String
                    let serviceID = dict.value(forKey: "ID") as! String
                    if displayName.contains("fbb"){
                        continue
                    }
                    
                    let displayImageView = UIImageView()
                    scrollView.addSubview(displayImageView)
                    displayImageView.translatesAutoresizingMaskIntoConstraints = false
                    displayImageView.sd_setImage(with: URL(string: displayImage), placeholderImage: UIImage(named: "default_profile"), options: [.continueInBackground, .progressiveDownload])
                    displayImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
                    displayImageView.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: topAnchorConstraint).isActive = true
                    displayImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
                    displayImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
                    
                    let lblDisplayName = UILabel()
                    scrollView.addSubview(lblDisplayName)
                    lblDisplayName.translatesAutoresizingMaskIntoConstraints = false
                    lblDisplayName.text = displayName
                    lblDisplayName.font = UIFont(name: String.defaultFontR, size: 22)
                    lblDisplayName.numberOfLines = 0
                    lblDisplayName.lineBreakMode = .byWordWrapping
                    lblDisplayName.leadingAnchor.constraint(equalTo: displayImageView.trailingAnchor, constant: 5).isActive = true
                    lblDisplayName.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: displayNameTopConstraint).isActive = true
                    
                    let lblDisplayNum = UILabel()
                    scrollView.addSubview(lblDisplayNum)
                    lblDisplayNum.translatesAutoresizingMaskIntoConstraints = false
                    lblDisplayNum.text = primaryID
                    lblDisplayNum.font = UIFont(name: String.defaultFontR, size: 19)
                    lblDisplayNum.numberOfLines = 0
                    lblDisplayNum.lineBreakMode = .byWordWrapping
                    lblDisplayNum.leadingAnchor.constraint(equalTo: displayImageView.trailingAnchor, constant: 5).isActive = true
                    lblDisplayNum.topAnchor.constraint(equalTo: lblDisplayName.bottomAnchor, constant: displayNumberTop).isActive = true
                    lblDisplayNum.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -5).isActive = true
                    
                    let separator2 = UIView()
                    scrollView.addSubview(separator2)
                    separator2.translatesAutoresizingMaskIntoConstraints = false
                    separator2.backgroundColor = UIColor.black
                    separator2.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
                    separator2.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
                    separator2.topAnchor.constraint(equalTo: lblDisplayNum.bottomAnchor, constant: separator2TopConstraint).isActive = true
                    separator2.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
                    
                    let radioButton = UIButton()
                    scrollView.addSubview(radioButton)
                    radioButton.translatesAutoresizingMaskIntoConstraints = false
                    var checkBoxImage: UIImage?
                    if serviceID == defaultService {
                         checkBoxImage = UIImage(named: "Checkbox")
                    }else{
                         checkBoxImage = UIImage(named: "UnCheckbox")
                    }
                    
                    radioButton.setImage(checkBoxImage, for: .normal)
                    radioButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
                    radioButton.topAnchor.constraint(equalTo: lblDisplayName.bottomAnchor).isActive = true
                    radioButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
                    radioButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
                    radioButton.addTarget(self, action: #selector(changeService(_:)), for: .touchUpInside)
                    radioButton.tag = Int(serviceID)!
                    
                    counter = counter + 1
                    topAnchorConstraint = topAnchorConstraint + 100
                    displayNameTopConstraint = displayNameTopConstraint + 100
                    dynamicCardHeight = dynamicCardHeight + 127
                    cardHeight?.constant = dynamicCardHeight
                    scrollView.contentSize.height = dynamicCardHeight + 500
                }
            }
            if counter == arrayCount {
                
                view.addSubview(btnSave)
                btnSave.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
                btnSave.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 30).isActive = true
                btnSave.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
                btnSave.heightAnchor.constraint(equalToConstant: 55).isActive = true
                btnSave.addTarget(self, action: #selector(setDefaultService), for: .touchUpInside)
                
                //activity loader
                cardView.addSubview(activity_loader)
                activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                activity_loader.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 30).isActive = true
            }else{
                print("not up to \(counter)")
                view.addSubview(btnSave)
                btnSave.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
                btnSave.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 30).isActive = true
                btnSave.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
                btnSave.heightAnchor.constraint(equalToConstant: 55).isActive = true
                btnSave.addTarget(self, action: #selector(setDefaultService), for: .touchUpInside)
                
                //activity loader
                cardView.addSubview(activity_loader)
                activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                activity_loader.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 30).isActive = true
            }
        }
    }
    
    @objc func setDefaultService(){
        if !CheckInternet.Connection(){
            let storyboard = UIStoryboard(name: "Support", bundle: nil)
            let moveTo = storyboard.instantiateViewController(withIdentifier: "NointernetViewController")
            self.addChildViewController(moveTo)
            moveTo.view.frame = self.view.frame
            self.view.addSubview(moveTo.view)
            moveTo.didMove(toParentViewController: self)
        }else{
            start_activity_loader()
            let selService = txtSelectedService.text!
            let async_call = URL(string: String.userSVC)
            let request = NSMutableURLRequest(url: async_call!)
            request.httpMethod = "POST"
            let postParameters: Dictionary<String, Any> = [
                "action":"setDefaultService",
                "username":username!,
                "serviceID":selService,
                "os":getDeviceOS()
            ]
            if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
                request.httpBody = postData
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                
                let task = URLSession.shared.dataTask(with: request as URLRequest){
                    data, response, error in
                    if error != nil {
                        DispatchQueue.main.async {
                            print("error is:: \(error!.localizedDescription)")
                            self.stop_activity_loader()
                            self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: error!.localizedDescription)
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
                                    let responseData = parseJSON["RESPONSEDATA"] as? NSDictionary
                                    if let resMssg = responseData {
                                        let dService = resMssg["DefaultService"] as? NSDictionary
                                        if let selServiceDet = dService {
                                            let ID = selServiceDet["ID"] as! String
                                            var primaryID = selServiceDet["primaryID"] as! String
                                            self.preference.removeObject(forKey: UserDefaultsKeys.DefaultService.rawValue)
                                            self.preference.set(ID, forKey: UserDefaultsKeys.DefaultService.rawValue)
                                            
                                            let defaultNum = primaryID.dropFirst(3)
                                            primaryID = "0\(defaultNum)"
                                            self.preference.set(primaryID, forKey: UserDefaultsKeys.defaultMSISDN.rawValue)
                                            
                                            //go to home screen
                                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                            let moveTo = storyboard.instantiateViewController(withIdentifier: "homeVC")
                                            self.present(moveTo, animated: true, completion: nil)
                                        }
                                    }
                                    
                                    
                                }else{
                                    let responseMessage = parseJSON["RESPONSEMESSAGE"] as? String
                                    if let mssg = responseMessage {
                                        self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: mssg)
                                    }
                                    
                                }
                                self.stop_activity_loader()
                            }
                        }
                    }catch{
                        DispatchQueue.main.async {
                            print("catch is:: \(error.localizedDescription)")
                            self.stop_activity_loader()
                            self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: error.localizedDescription)
                        }
                    }
                }
                task.resume()
            }
        }
        
    }
    
    @objc func changeService(_ btn: UIButton){
        print(btn.tag)
        txtSelectedService.text = String(btn.tag)
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            btn.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (success) in
            btn.isSelected = !btn.isSelected
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                btn.transform = .identity
                let checkImage = UIImage(named: "Checkbox")
                btn.setImage(checkImage, for: .normal)
                let defautIDString = String(btn.tag)
                self.preference.removeObject(forKey: UserDefaultsKeys.DefaultService.rawValue)
                self.preference.set(defautIDString, forKey: UserDefaultsKeys.DefaultService.rawValue)
                let storyboard = UIStoryboard(name: "Settings", bundle: nil)
                let moveTo = storyboard.instantiateViewController(withIdentifier: "chooseDefaultService")
                self.present(moveTo, animated: true, completion: nil)
            }, completion: nil)
        }
    }
}
