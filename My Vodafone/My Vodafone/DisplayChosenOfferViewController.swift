//
//  DisplayChosenOfferViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 25/07/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class DisplayChosenOfferViewController: UIViewController {

    @IBOutlet var superView: UIView!
    
    var selectedOffer: String = ""
    let preferences = UserDefaults.standard
    var totalOffers:Int!
    
    //create closure for top Image
    let appBackImage: UIImageView = {
        let topImage = UIImageView(image: #imageLiteral(resourceName: "bg2"))
        topImage.translatesAutoresizingMaskIntoConstraints = false
        topImage.contentMode = .scaleAspectFill
        return topImage
    }()
    
    //create closure for back button
    let viewButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(switchToController), for: .touchUpInside)
        return button
    }()
    
    //create closure for hamburger
    let hamburgerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //create closure for menu label
    let menuLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Menu"
        label.textColor = UIColor.white
        label.font = UIFont(name: String.defaultFontR, size: 12)
        return label
    }()
    
    //create closure for selected offer type
    let selectedOfferLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = UIFont(name: String.defaultFontR, size: 31)
        return label
    }()
    
    //create activity loader
    let activity_loader: UIActivityIndicatorView = {
        let activity_loader = UIActivityIndicatorView()
        activity_loader.translatesAutoresizingMaskIntoConstraints = false
        activity_loader.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activity_loader.color = UIColor.vodaRed
//        activity_loader.backgroundColor = UIColor.cardImageColour
        activity_loader.startAnimating()
        activity_loader.hidesWhenStopped = true
        activity_loader.isHidden = false
        return activity_loader
        
    }()
    
    //create scroll view
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.grayBackground
//        view.contentSize.height = 2000
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Change view's background colour
        view.backgroundColor = UIColor.grayBackground
        setUpViews()
        print("transfered:: \(selectedOffer)")
        
       
        let vodafonePdts = preferences.object(forKey: selectedOffer)
        let UserData = preferences.object(forKey: "responseData") as! NSDictionary
        let defaultNumber = UserData["Contact"] as! String
        print("voda:: \(selectedOffer)")
        
        if vodafonePdts == nil {
            print("Was empty")
            scrollView.addSubview(activity_loader)
            let horizontalConstraint = NSLayoutConstraint(item: activity_loader, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
            let verticalConstraint = NSLayoutConstraint(item: activity_loader, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
            NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
            
            //Now make async call to fetch data
            let asyncAPI = URL(string: String.offers)
            let request = NSMutableURLRequest(url: asyncAPI!)
            request.httpMethod = "POST"
//            selectedOffer = selectedOffer.uppercased()
            //declare parameters
            let postParameters: Dictionary<String, Any> = [
                "action":"products",
                "option":"byType",
                "msisdn":defaultNumber,
                "productType":selectedOffer.uppercased()
            ]
            if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
                request.httpBody = postData
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                
                //creating a task to send post request
                let task = URLSession.shared.dataTask(with: request as URLRequest){
                    data, response, error in
                    if error != nil {
                        print("error is: \(error)")
                        return;
                    }
                    //passing the response
                    do {
                        //converting response to NSDictionary
                        let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        //parsing the json
                        if let parseJSON = myJSON {
                            var responseCode: Int!
                            var responseMessage: NSArray!
                            responseCode = parseJSON["RESPONSECODE"] as! Int
                            responseMessage = parseJSON["RESPONSEMESSAGE"] as! NSArray?
                            
                            //Now store in user defaults for quick retrieval next time
                            self.preferences.set(responseMessage, forKey: self.selectedOffer)
                            print(responseCode)
                            print(responseMessage)
                            print("****************************************************")
                            let getOffers = self.preferences.object(forKey: self.selectedOffer)
                            DispatchQueue.main.async {
                                self.activity_loader.stopAnimating()
                                if let array = getOffers as! NSArray?{
                                    let totalOffers = array.count
                                    let castTotalOffers = CGFloat(totalOffers)
                                    var topAnchorConstraint: CGFloat = 170
                                    var cardHeight: CGFloat = 145
                                    for obj in array {
                                        if let dict = obj as? NSDictionary{
                                            let offerName = dict.value(forKey: "NAME") as! String
                                            let offerPrice = dict.value(forKey: "PRICE") as! String
                                            
                                            //creating the uiview
                                            let offerView = UIView()
                                            self.scrollView.addSubview(offerView)
                                            offerView.translatesAutoresizingMaskIntoConstraints = false
                                            offerView.topAnchor.constraint(equalTo: self.appBackImage.bottomAnchor, constant: topAnchorConstraint).isActive = true
                                            offerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
                                            offerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
                                            offerView.backgroundColor = UIColor.white
                                            offerView.heightAnchor.constraint(equalToConstant: 130).isActive = true
                                            //transforming to cards
                                            offerView.layer.cornerRadius = 2
                                            offerView.layer.shadowOffset = CGSize(width: 0, height: 5)
                                            offerView.layer.shadowColor = UIColor.black.cgColor
                                            offerView.layer.shadowOpacity = 0.1
                                            
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
                                            offerNameLbl.text = offerName
                                            offerNameLbl.font = UIFont(name: String.defaultFontB, size: 20)
                                            offerNameLbl.topAnchor.constraint(equalTo: offerView.topAnchor, constant: 38).isActive = true
                                            offerNameLbl.leadingAnchor.constraint(equalTo: offerIcon.trailingAnchor, constant: 8).isActive = true
                                            offerNameLbl.trailingAnchor.constraint(equalTo: offerView.trailingAnchor, constant: -10).isActive = true
                                            
                                            //add price of offer
                                            let offerPriceLbl = UILabel()
                                            self.scrollView.addSubview(offerPriceLbl)
                                            offerPriceLbl.translatesAutoresizingMaskIntoConstraints = false
                                            offerPriceLbl.text = "Price GHS \(offerPrice)"
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
                                            //(cardHeight * castTotalOffers) + 620
                                            self.scrollView.contentSize.height = CGFloat(totalOffers) + topAnchorConstraint + 70
                                            
                                        }
                                    }
                                }
                            }
                            
                            
                        }
                    } catch {
                        print(error)
                    }
                }
                task.resume()
            }
        }else{
            print("Now here was not empty \(vodafonePdts!)")
            if let array = vodafonePdts as! NSArray?{
                totalOffers = array.count
                let castTotalOffers = CGFloat(totalOffers)
                var topAnchorConstraint: CGFloat = 170
                var cardHeight: CGFloat = 145
                for obj in array {
                    if let dict = obj as? NSDictionary{
                        let offerName = dict.value(forKey: "NAME") as! String
                        let offerPrice = dict.value(forKey: "PRICE") as! String
                        
                        //creating the uiview
                        let offerView = UIView()
                        self.scrollView.addSubview(offerView)
                        offerView.translatesAutoresizingMaskIntoConstraints = false
                        offerView.topAnchor.constraint(equalTo: self.appBackImage.bottomAnchor, constant: topAnchorConstraint).isActive = true
                        offerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
                        offerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
                        offerView.backgroundColor = UIColor.white
                        offerView.heightAnchor.constraint(equalToConstant: 130).isActive = true
                        //transforming to cards
                        offerView.layer.cornerRadius = 2
                        offerView.layer.shadowOffset = CGSize(width: 0, height: 5)
                        offerView.layer.shadowColor = UIColor.black.cgColor
                        offerView.layer.shadowOpacity = 0.1
                        
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
                        offerNameLbl.text = offerName
                        offerNameLbl.font = UIFont(name: String.defaultFontB, size: 20)
                        offerNameLbl.topAnchor.constraint(equalTo: offerView.topAnchor, constant: 38).isActive = true
                        offerNameLbl.leadingAnchor.constraint(equalTo: offerIcon.trailingAnchor, constant: 8).isActive = true
                        offerNameLbl.trailingAnchor.constraint(equalTo: offerView.trailingAnchor, constant: -10).isActive = true
                        
                        //add price of offer
                        let offerPriceLbl = UILabel()
                        self.scrollView.addSubview(offerPriceLbl)
                        offerPriceLbl.translatesAutoresizingMaskIntoConstraints = false
                        offerPriceLbl.text = "Price GHS \(offerPrice)"
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
                        //(cardHeight * castTotalOffers) + 620
                        self.scrollView.contentSize.height = CGFloat(totalOffers) + topAnchorConstraint + 70
                    }
                }
            }
            //No do some background check again
            makeAsync(offer: selectedOffer, msisdn: defaultNumber)
            
        }
        
    }
    
    func makeAsync(offer:String, msisdn:String){
        let request_api = URL(string: String.offers)
        let request = NSMutableURLRequest(url: request_api!)
        request.httpMethod = "POST"
        
        let postParameters:Dictionary<String, Any> = [
            "action":"products",
            "option":"byType",
            "msisdn":msisdn,
            "productType":offer.uppercased()
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
                        
                        if newTotalOffers != self.totalOffers {
                            DispatchQueue.main.async {
                                //Populate again
                                //Clean existing particular userdefaults
                                self.preferences.removeObject(forKey: self.selectedOffer)
                                //now add to user defaults new offers
                                self.preferences.set(responseMessage, forKey: self.selectedOffer)
                                let getOffers = self.preferences.object(forKey: self.selectedOffer)
                                if let array = getOffers as! NSArray?{
                                    let totalOffers = array.count
                                    let castTotalOffers = CGFloat(totalOffers)
                                    var topAnchorConstraint: CGFloat = 170
                                    var cardHeight: CGFloat = 145
                                    for obj in array {
                                        if let dict = obj as? NSDictionary{
                                            let offerName = dict.value(forKey: "NAME") as! String
                                            let offerPrice = dict.value(forKey: "PRICE") as! String
                                            
                                            //creating the uiview
                                            let offerView = UIView()
                                            self.scrollView.addSubview(offerView)
                                            offerView.translatesAutoresizingMaskIntoConstraints = false
                                            offerView.topAnchor.constraint(equalTo: self.appBackImage.bottomAnchor, constant: topAnchorConstraint).isActive = true
                                            offerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
                                            offerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
                                            offerView.backgroundColor = UIColor.white
                                            offerView.heightAnchor.constraint(equalToConstant: 130).isActive = true
                                            //transforming to cards
                                            offerView.layer.cornerRadius = 2
                                            offerView.layer.shadowOffset = CGSize(width: 0, height: 5)
                                            offerView.layer.shadowColor = UIColor.black.cgColor
                                            offerView.layer.shadowOpacity = 0.1
                                            
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
                                            offerNameLbl.text = offerName
                                            offerNameLbl.font = UIFont(name: String.defaultFontB, size: 20)
                                            offerNameLbl.topAnchor.constraint(equalTo: offerView.topAnchor, constant: 38).isActive = true
                                            offerNameLbl.leadingAnchor.constraint(equalTo: offerIcon.trailingAnchor, constant: 8).isActive = true
                                            offerNameLbl.trailingAnchor.constraint(equalTo: offerView.trailingAnchor, constant: -10).isActive = true
                                            
                                            //add price of offer
                                            let offerPriceLbl = UILabel()
                                            self.scrollView.addSubview(offerPriceLbl)
                                            offerPriceLbl.translatesAutoresizingMaskIntoConstraints = false
                                            offerPriceLbl.text = "Price GHS \(offerPrice)"
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
                                            //(cardHeight * castTotalOffers) + 620
                                            self.scrollView.contentSize.height = CGFloat(totalOffers) + topAnchorConstraint + 70
                                            
                                        }
                                    }
                                }
                            }
                        }else{
                            print("Don't populate")
                        }
                    }
                    
                }catch {
                    print(error)
                }
            }
            // executing task
            task.resume()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setUpViews(){
        //Scroll view
        view.addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        scrollView.addSubview(appBackImage)
        scrollView.addSubview(viewButton)
        scrollView.addSubview(hamburgerButton)
        scrollView.addSubview(menuLabel)
        scrollView.addSubview(selectedOfferLabel)
        
        
        //top Image
//        superView.addSubview(appBackImage)
        
        appBackImage.PinTopImage(view: self.view)
        
        
        //back button
        
        let back_image = UIImage(named: "leftArrow")
        let tintedBackImage = back_image?.withRenderingMode(.alwaysTemplate)
        viewButton.setImage(tintedBackImage, for: .normal)
        viewButton.tintColor = UIColor.white
        viewButton.setImage(#imageLiteral(resourceName: "leftArrow"), for: .normal)
        viewButton.topAnchor.constraint(equalTo: appBackImage.topAnchor, constant: 20).isActive = true
        viewButton.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 8).isActive = true
        viewButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        viewButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        //hamburger
        
        let hamburger_image = UIImage(named: "hamburger")
        let tintHamImage = hamburger_image?.withRenderingMode(.alwaysTemplate)
        hamburgerButton.setImage(tintHamImage, for: .normal)
        hamburgerButton.tintColor = UIColor.white
        
        hamburgerButton.topAnchor.constraint(equalTo: appBackImage.topAnchor, constant: 20).isActive = true
        hamburgerButton.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -8).isActive = true
        hamburgerButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        hamburgerButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        //Menu Label
        
        menuLabel.topAnchor.constraint(equalTo: hamburgerButton.bottomAnchor, constant: -6).isActive = true
//        menuLabel.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 100).isActive = true
        menuLabel.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -15).isActive = true
        
        
        //Selected Offer type Label
        
        selectedOfferLabel.textAlignment = .center
        selectedOfferLabel.leadingAnchor.constraint(equalTo: appBackImage.leadingAnchor, constant: 20).isActive = true
        selectedOfferLabel.trailingAnchor.constraint(equalTo: appBackImage.trailingAnchor, constant: -20).isActive = true
        selectedOfferLabel.topAnchor.constraint(equalTo: appBackImage.topAnchor, constant: 120).isActive = true
        if selectedOffer == "FBB"{
            selectedOfferLabel.text = "Fixed Broadband"
        }else if selectedOffer == "Data" {
            selectedOfferLabel.text = "Data Bundles"
        }
        else{
            selectedOfferLabel.text = selectedOffer
        }
        
        
        //Activity loader
//        superView.addSubview(activity_loader)
//        let horizontalConstraint = NSLayoutConstraint(item: activity_loader, attribute: .centerX, relatedBy: .equal, toItem: superView, attribute: .centerX, multiplier: 1, constant: 0)
//        let verticalConstraint = NSLayoutConstraint(item: activity_loader, attribute: .centerY, relatedBy: .equal, toItem: superView, attribute: .centerY, multiplier: 1, constant: 0)
//        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
    }
    
    //Function to move back to offers view controller
    @objc func switchToController(){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "OffersExtrasViewController")
        present(moveTo!, animated: true, completion: nil)
    }

}

extension UIView {
    //for top image
    func PinTopImage(view: UIView){
        self.topAnchor.constraint(equalTo: (superview?.topAnchor)!, constant: 20).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *){
            print("yes 11")
        return safeAreaLayoutGuide.topAnchor
        }
        return topAnchor
    }
    
}
