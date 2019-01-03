//
//  Messages.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 26/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class Messages: baseViewControllerM {

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
        view.heightAnchor.constraint(equalToConstant: 380).isActive = true
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
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        
    }
    
    //Function to startIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        
    }
    
    var msisdn: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.grayBackground
        SetUpViewMessages()
        if let defaultMSISDN = preference.object(forKey: "defaultMSISDN") as! String?{
            msisdn = defaultMSISDN
            
        }
        let responseData = preference.object(forKey: "responseData") as! NSDictionary
        username = responseData["Username"] as? String
        
        if CheckInternet.Connection(){
            start_activity_loader()
            fetchMessages()
        }else{
            
        }
        
        if AcctType == "PHONE_MOBILE_PRE_P" || AcctType == "BB_FIXED_PRE_P"{
            prePaidMenu()
        }else{
            prePaidMenu()
        }
    }

    func SetUpViewMessages(){
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
        backButton.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
        
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
        lblSelectedOffer.text = "Messages"
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
        
        //activity loader
        scrollView.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30).isActive = true
    }
    
    func fetchMessages(){
        let postParameters:Dictionary<String, Any> = [
            "username":username!,
            "action":"getNotifications",
            "os":getAppVersion()
        ]
        
        let async_call = URL(string: String.offers)
        let request = NSMutableURLRequest(url: async_call!)
        request.httpMethod = "POST"
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
                            self.stop_activity_loader()
                            self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not proccess your request try again later...")
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
                            
                            responseBody = parseJSON["responseBody"] as! String?
                            if responseBody != nil {
                                //cache data
                                
                                DispatchQueue.main.async {
                                    let resBody = responseBody
                                    let decrypt = self.decryptAsyncRequest(requestBody: resBody!)
                                    let decryptedResponseBody = self.convertToNSDictionary(decrypt: decrypt)
                                    print(decryptedResponseBody)
                                    responseCode = decryptedResponseBody["RESPONSECODE"] as! Int?
                                    if responseCode == 0 {
                                        
                                    }else{
                                        
                                        self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not update your bill. Try later")
                                    }
                                    self.stop_activity_loader()
                                }
                            }
                            
                        }
                    }catch{
                        print("postPaid Balance error \(error.localizedDescription)")
                        DispatchQueue.main.async {
                            
                        }
                    }
                }
                task.resume()
            }
        }
    }
}
