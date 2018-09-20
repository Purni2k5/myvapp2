//
//  RoamingBundles.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 20/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class RoamingBundles: baseViewControllerM {

    var msisdn: String?
    var offerName: String?
    var offerPrice: String?
    var offerDescription: String?
    var offerPID: String?
    var offerUSSD: String?
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground
        msisdn = preference.object(forKey: "defaultMSISDN") as! String?
        setUpViewsRoamingBundles()
        
        let roamingBundles = self.preference.object(forKey: "ROAMINGS")
        if roamingBundles != nil {
            stop_activity_loader()
            displayOffers()
        }else{
            getRoamingBundles()
        }
//        getRoamingBundles()
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
    }

    func setUpViewsRoamingBundles(){
        view.addSubview(scrollView)
        
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
        backButton.addTarget(self, action: #selector(goToTravelling), for: .touchUpInside)
        
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
        lblSelectedOffer.text = "Roaming Bundles"
        lblSelectedOffer.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        lblSelectedOffer.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 70).isActive = true
        lblSelectedOffer.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        lblSelectedOffer.numberOfLines = 0
        lblSelectedOffer.lineBreakMode = .byWordWrapping
        
        scrollView.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        start_activity_loader()
    }
    
    func displayOffers(){
        let getBundles = self.preference.object(forKey: "ROAMINGS")
        if let array = getBundles as! NSArray?{
            let totalOffers = array.count
            
            var topAnchorConstraint: CGFloat = 170
            
            for obj in array {
                if let dict = obj as? NSDictionary{
                    self.offerName = dict.value(forKey: "NAME") as! String?
                    self.offerPrice = dict.value(forKey: "PRICE") as! String?
                    self.offerDescription = dict.value(forKey: "DESCRIPTION") as! String?
                    self.offerPID = dict.value(forKey: "PID") as! String?
                    self.offerUSSD = dict.value(forKey: "USSD") as! String?
                    
                    //creating the uiview
                    let offerView = GesturesView()
                    offerView.offerVariable = self.offerName
                    offerView.offerPrice = self.offerPrice
                    offerView.offerDescription = self.offerDescription
                    offerView.offerPID = self.offerPID
                    offerView.offerUSSD = self.offerUSSD
                    self.scrollView.addSubview(offerView)
                    offerView.translatesAutoresizingMaskIntoConstraints = false
                    offerView.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: topAnchorConstraint).isActive = true
                    offerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
                    offerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
                    offerView.backgroundColor = UIColor.white
                    offerView.heightAnchor.constraint(equalToConstant: 130).isActive = true
                    //transforming to cards
                    offerView.layer.cornerRadius = 2
                    offerView.layer.shadowOffset = CGSize(width: 0, height: 5)
                    offerView.layer.shadowColor = UIColor.black.cgColor
                    offerView.layer.shadowOpacity = 0.2
                    
                    //add left image view
                    let cardImage = UIImageView()
                    offerView.addSubview(cardImage)
                    cardImage.backgroundColor = UIColor.cardImageColour
                    cardImage.translatesAutoresizingMaskIntoConstraints = false
                    cardImage.leadingAnchor.constraint(equalTo: offerView.leadingAnchor, constant: 0).isActive = true
                    cardImage.widthAnchor.constraint(equalToConstant: 12).isActive = true
                    cardImage.topAnchor.constraint(equalTo: offerView.topAnchor, constant: 0).isActive = true
                    cardImage.bottomAnchor.constraint(equalTo: offerView.bottomAnchor, constant: 0).isActive = true
                    
                    //Adding display images
                    let offerIcon = UIImageView(image: #imageLiteral(resourceName: "call_icon"))
                    offerIcon.translatesAutoresizingMaskIntoConstraints = false
                    offerView.addSubview(offerIcon)
                    offerIcon.backgroundColor = UIColor.vodaIconColour
                    offerIcon.widthAnchor.constraint(equalToConstant: 60).isActive = true
                    offerIcon.heightAnchor.constraint(equalToConstant: 60).isActive = true
                    offerIcon.topAnchor.constraint(equalTo: offerView.topAnchor, constant: 30).isActive = true
                    offerIcon.leadingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: 19).isActive = true
                    //make image round
                    offerIcon.layer.cornerRadius = offerIcon.frame.size.width / 2
                    offerIcon.clipsToBounds = true
                    
                    //add Name of offer
                    let offerNameLbl = UILabel()
                    self.scrollView.addSubview(offerNameLbl)
                    offerNameLbl.translatesAutoresizingMaskIntoConstraints = false
                    offerNameLbl.text = self.offerName
                    offerNameLbl.font = UIFont(name: String.defaultFontB, size: 20)
                    offerNameLbl.topAnchor.constraint(equalTo: offerView.topAnchor, constant: 38).isActive = true
                    offerNameLbl.leadingAnchor.constraint(equalTo: offerIcon.trailingAnchor, constant: 8).isActive = true
                    offerNameLbl.trailingAnchor.constraint(equalTo: offerView.trailingAnchor, constant: -10).isActive = true
                    offerNameLbl.numberOfLines = 0
                    offerNameLbl.lineBreakMode = .byWordWrapping
                    
                    //add price of offer
                    let offerPriceLbl = UILabel()
                    self.scrollView.addSubview(offerPriceLbl)
                    offerPriceLbl.translatesAutoresizingMaskIntoConstraints = false
                    offerPriceLbl.text = "Price GHS \(self.offerPrice!)"
                    offerPriceLbl.font = UIFont(name: String.defaultFontR, size: 16)
                    offerPriceLbl.topAnchor.constraint(equalTo: offerNameLbl.bottomAnchor, constant: 10).isActive = true
                    offerPriceLbl.leadingAnchor.constraint(equalTo: offerIcon.trailingAnchor, constant: 8).isActive = true
                    offerPriceLbl.trailingAnchor.constraint(equalTo: offerView.trailingAnchor, constant: -10).isActive = true
                    
                    //Adding right arrow
                    let rightArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
                    self.scrollView.addSubview(rightArrow)
                    rightArrow.translatesAutoresizingMaskIntoConstraints = false
                    rightArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
                    rightArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
                    rightArrow.topAnchor.constraint(equalTo: offerView.topAnchor, constant: 57).isActive = true
                    rightArrow.trailingAnchor.constraint(equalTo: offerView.trailingAnchor, constant: -9).isActive = true
                    
                    topAnchorConstraint = topAnchorConstraint + 165
                    
                    self.scrollView.contentSize.height = CGFloat(totalOffers) + topAnchorConstraint + 70
                    
                    //Adding gesture
                    let touchRec = UITapGestureRecognizer(target: self, action: #selector(self.goToBuyBundle))
                    offerView.addGestureRecognizer(touchRec)
                    
                }
            }
        }
        getRoamingBundles()
    }
    
    func getRoamingBundles(){
        let request_api = URL(string: String.offers)
        let request = NSMutableURLRequest(url: request_api!)
        request.httpMethod = "POST"
        
        let postParameters:Dictionary<String, Any> = [
            "action":"products",
            "option":"byType",
            "msisdn":msisdn!,
            "productType":"ROAMINGS",
            "os":getAppVersion()
        ]
        
        if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
            request.httpBody = postData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            //creating a task to send request
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                if error != nil {
                    print("error is:: \(error!)")
                    return;
                }
                //parsing the response
                do {
                    //converting the response to NSDictionary
                    let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    //parsing the json
                    if let parseJSON = myJSON{
                        var responseCode: Int!
                        var responseMessage: NSArray!
                        
                        responseCode = parseJSON["RESPONSECODE"] as! Int
                        responseMessage = parseJSON["RESPONSEMESSAGE"] as! NSArray?
                        
                        let newTotalOffers = responseMessage.count
                        print("new count \(newTotalOffers)")
                        
                        DispatchQueue.main.async {
                            if responseCode == 0 {
                                self.stop_activity_loader()
                                //Populate again
                                //Clean existing particular userdefaults
                                self.preference.removeObject(forKey: "ROAMINGS")
                                //now add to user defaults new offers
                                self.preference.set(responseMessage, forKey: "ROAMINGS")
                                let getBundles = self.preference.object(forKey: "ROAMINGS")
                                if let array = getBundles as! NSArray?{
                                    let totalOffers = array.count
                                    
                                    var topAnchorConstraint: CGFloat = 170
                                    
                                    for obj in array {
                                        if let dict = obj as? NSDictionary{
                                            self.offerName = dict.value(forKey: "NAME") as! String?
                                            self.offerPrice = dict.value(forKey: "PRICE") as! String?
                                            self.offerDescription = dict.value(forKey: "DESCRIPTION") as! String?
                                            self.offerPID = dict.value(forKey: "PID") as! String?
                                            self.offerUSSD = dict.value(forKey: "USSD") as! String?
                                            
                                            //creating the uiview
                                            let offerView = GesturesView()
                                            offerView.offerVariable = self.offerName
                                            offerView.offerPrice = self.offerPrice
                                            offerView.offerDescription = self.offerDescription
                                            offerView.offerPID = self.offerPID
                                            offerView.offerUSSD = self.offerUSSD
                                            self.scrollView.addSubview(offerView)
                                            offerView.translatesAutoresizingMaskIntoConstraints = false
                                            offerView.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: topAnchorConstraint).isActive = true
                                            offerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
                                            offerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
                                            offerView.backgroundColor = UIColor.white
                                            offerView.heightAnchor.constraint(equalToConstant: 130).isActive = true
                                            //transforming to cards
                                            offerView.layer.cornerRadius = 2
                                            offerView.layer.shadowOffset = CGSize(width: 0, height: 5)
                                            offerView.layer.shadowColor = UIColor.black.cgColor
                                            offerView.layer.shadowOpacity = 0.2
                                            
                                            //add left image view
                                            let cardImage = UIImageView()
                                            offerView.addSubview(cardImage)
                                            cardImage.backgroundColor = UIColor.cardImageColour
                                            cardImage.translatesAutoresizingMaskIntoConstraints = false
                                            cardImage.leadingAnchor.constraint(equalTo: offerView.leadingAnchor, constant: 0).isActive = true
                                            cardImage.widthAnchor.constraint(equalToConstant: 12).isActive = true
                                            cardImage.topAnchor.constraint(equalTo: offerView.topAnchor, constant: 0).isActive = true
                                            cardImage.bottomAnchor.constraint(equalTo: offerView.bottomAnchor, constant: 0).isActive = true
                                            
                                            //Adding display images
                                            let offerIcon = UIImageView(image: #imageLiteral(resourceName: "call_icon"))
                                            offerIcon.translatesAutoresizingMaskIntoConstraints = false
                                            offerView.addSubview(offerIcon)
                                            offerIcon.backgroundColor = UIColor.vodaIconColour
                                            offerIcon.widthAnchor.constraint(equalToConstant: 60).isActive = true
                                            offerIcon.heightAnchor.constraint(equalToConstant: 60).isActive = true
                                            offerIcon.topAnchor.constraint(equalTo: offerView.topAnchor, constant: 30).isActive = true
                                            offerIcon.leadingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: 19).isActive = true
                                            //make image round
                                            offerIcon.layer.cornerRadius = offerIcon.frame.size.width / 2
                                            offerIcon.clipsToBounds = true
                                            
                                            //add Name of offer
                                            let offerNameLbl = UILabel()
                                            self.scrollView.addSubview(offerNameLbl)
                                            offerNameLbl.translatesAutoresizingMaskIntoConstraints = false
                                            offerNameLbl.text = self.offerName
                                            offerNameLbl.font = UIFont(name: String.defaultFontB, size: 20)
                                            offerNameLbl.topAnchor.constraint(equalTo: offerView.topAnchor, constant: 38).isActive = true
                                            offerNameLbl.leadingAnchor.constraint(equalTo: offerIcon.trailingAnchor, constant: 8).isActive = true
                                            offerNameLbl.trailingAnchor.constraint(equalTo: offerView.trailingAnchor, constant: -10).isActive = true
                                            offerNameLbl.numberOfLines = 0
                                            offerNameLbl.lineBreakMode = .byWordWrapping
                                            
                                            //add price of offer
                                            let offerPriceLbl = UILabel()
                                            self.scrollView.addSubview(offerPriceLbl)
                                            offerPriceLbl.translatesAutoresizingMaskIntoConstraints = false
                                            offerPriceLbl.text = "Price GHS \(self.offerPrice!)"
                                            offerPriceLbl.font = UIFont(name: String.defaultFontR, size: 16)
                                            offerPriceLbl.topAnchor.constraint(equalTo: offerNameLbl.bottomAnchor, constant: 10).isActive = true
                                            offerPriceLbl.leadingAnchor.constraint(equalTo: offerIcon.trailingAnchor, constant: 8).isActive = true
                                            offerPriceLbl.trailingAnchor.constraint(equalTo: offerView.trailingAnchor, constant: -10).isActive = true
                                            
                                            //Adding right arrow
                                            let rightArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
                                            self.scrollView.addSubview(rightArrow)
                                            rightArrow.translatesAutoresizingMaskIntoConstraints = false
                                            rightArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
                                            rightArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
                                            rightArrow.topAnchor.constraint(equalTo: offerView.topAnchor, constant: 57).isActive = true
                                            rightArrow.trailingAnchor.constraint(equalTo: offerView.trailingAnchor, constant: -9).isActive = true
                                            
                                            topAnchorConstraint = topAnchorConstraint + 165
                                            
                                            self.scrollView.contentSize.height = CGFloat(totalOffers) + topAnchorConstraint + 70
                                            
                                            //Adding gesture
                                            let touchRec = UITapGestureRecognizer(target: self, action: #selector(self.goToBuyBundle))
                                             offerView.addGestureRecognizer(touchRec)
                                            
                                        }
                                    }
                                }
                                
                            }else{
                                self.stop_activity_loader()
                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry try again")
                            }
                        }
                    }
                    
                }catch {
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        self.stop_activity_loader()
                        self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry try again")
                    }
                }
            }
            // executing task
            task.resume()
        }
        
    }
    
    @objc func goToBuyBundle(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "OffersExtras", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "BuyOfferViewController") as? BuyOfferViewController else {return}
        guard let gestureVariables = _sender.view as? GesturesView else {return}
        moveTo.selectedOffer = gestureVariables.offerVariable!
        moveTo.selectedOfferPrice = gestureVariables.offerPrice!
        moveTo.selectedOfferDesc = gestureVariables.offerDescription!
        moveTo.selectedOfferPID = gestureVariables.offerPID!
        moveTo.selectedUSSD = gestureVariables.offerUSSD!
        self.addChildViewController(moveTo)
        moveTo.view.frame = self.view.frame
        self.view.addSubview(moveTo.view)
        moveTo.didMove(toParentViewController: self)
    }
    
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
}
