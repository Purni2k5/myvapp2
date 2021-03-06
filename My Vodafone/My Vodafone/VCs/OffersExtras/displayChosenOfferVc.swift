//
//  displayChosenOfferVc.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 29/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class displayChosenOfferVc: baseViewControllerM {

    var selectedOffer = ""
    let preferences = UserDefaults.standard
    var totalOffers:Int?
    var offerName: String?
    var offerPrice: String?
    var offerDescription: String?
    var offerPID: String?
    var offerUSSD: String?
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
        view.heightAnchor.constraint(equalToConstant: 120).isActive = true
        var offerVariable: String?
        return view
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
    
    //Function to startIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground
        setUpViewDisp()
        checkConnection()
        let vodafonePdts = preferences.object(forKey: selectedOffer)
        
        let UserData = preferences.object(forKey: "responseData") as! NSDictionary
        let defaultNumber = preferences.object(forKey: "defaultMSISDN") as! String
        username = UserData["Username"] as? String
        
        //check if products is dynamic
        if selectedOffer == "Vodafone Cash"{
            let vodaCashMenu = cardView
            scrollView.addSubview(vodaCashMenu)
            vodaCashMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            vodaCashMenu.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 60).isActive = true
            vodaCashMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            vodaCashMenu.layer.cornerRadius = 2
            vodaCashMenu.layer.shadowOffset = CGSize(width: 0, height: 5)
            vodaCashMenu.layer.shadowColor = UIColor.black.cgColor
            vodaCashMenu.layer.shadowOpacity = 0.2
            
            //left image with colour
            let leftImageColour = UIImageView()
            vodaCashMenu.addSubview(leftImageColour)
            leftImageColour.translatesAutoresizingMaskIntoConstraints = false
            leftImageColour.backgroundColor = UIColor.cardImageColour
            leftImageColour.leadingAnchor.constraint(equalTo: vodaCashMenu.leadingAnchor).isActive = true
            leftImageColour.topAnchor.constraint(equalTo: vodaCashMenu.topAnchor).isActive = true
            leftImageColour.widthAnchor.constraint(equalToConstant: 12).isActive = true
            leftImageColour.bottomAnchor.constraint(equalTo: vodaCashMenu.bottomAnchor).isActive = true
            
            //round image with icon
            let roundImage = UIImageView(image: #imageLiteral(resourceName: "ic_mobile"))
            roundImage.image = roundImage.image!.withRenderingMode(.alwaysTemplate)
            vodaCashMenu.addSubview(roundImage)
            roundImage.tintColor = UIColor.white
            roundImage.backgroundColor = UIColor.vodaIconColour
            roundImage.translatesAutoresizingMaskIntoConstraints = false
            roundImage.topAnchor.constraint(equalTo: vodaCashMenu.topAnchor, constant: 30).isActive = true
            roundImage.leadingAnchor.constraint(equalTo: leftImageColour.trailingAnchor, constant: 19).isActive = true
            roundImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
            roundImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
            roundImage.layer.cornerRadius = roundImage.frame.size.width / 2
            roundImage.clipsToBounds = true
            
            //adding cash menu label
            let vodaCashLabel = UILabel()
            vodaCashMenu.addSubview(vodaCashLabel)
            vodaCashLabel.translatesAutoresizingMaskIntoConstraints = false
            vodaCashLabel.text = "Vodafone Cash menu"
            vodaCashLabel.font = UIFont(name: String.defaultFontB, size: 20)
            vodaCashLabel.leadingAnchor.constraint(equalTo: roundImage.trailingAnchor, constant: 8).isActive = true
            vodaCashLabel.topAnchor.constraint(equalTo: vodaCashMenu.topAnchor, constant: 40).isActive = true
            vodaCashLabel.trailingAnchor.constraint(equalTo: vodaCashMenu.trailingAnchor, constant: 0).isActive = true
            
            //adding menu description
            let vodaCashLabelDesc = UILabel()
            vodaCashMenu.addSubview(vodaCashLabelDesc)
            vodaCashLabelDesc.translatesAutoresizingMaskIntoConstraints = false
            vodaCashLabelDesc.text = "Vodafone Menu"
            vodaCashLabelDesc.font = UIFont(name: String.defaultFontR, size: 15)
            vodaCashLabelDesc.leadingAnchor.constraint(equalTo: roundImage.trailingAnchor, constant: 12).isActive = true
            vodaCashLabelDesc.topAnchor.constraint(equalTo: vodaCashLabel.bottomAnchor, constant: 5).isActive = true
            vodaCashLabelDesc.trailingAnchor.constraint(equalTo: vodaCashMenu.trailingAnchor, constant: -10).isActive = true
            
            //adding right arrow
            let cashRightArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
            vodaCashMenu.addSubview(cashRightArrow)
            cashRightArrow.translatesAutoresizingMaskIntoConstraints = false
            cashRightArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
            cashRightArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
            cashRightArrow.topAnchor.constraint(equalTo: vodaCashMenu.topAnchor, constant: 57).isActive = true
            cashRightArrow.trailingAnchor.constraint(equalTo: vodaCashMenu.trailingAnchor, constant: -9).isActive = true
            //Adding gestures
            let vodaCashMenuRec = UITapGestureRecognizer(target: self, action: #selector(displayVodafoneCashDialler))
            vodaCashMenu.addGestureRecognizer(vodaCashMenuRec)
            
            //Vodafone cash Agent
            let vodaCashAgent = UIView()
            scrollView.addSubview(vodaCashAgent)
            vodaCashAgent.translatesAutoresizingMaskIntoConstraints = false
            vodaCashAgent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            vodaCashAgent.topAnchor.constraint(equalTo: vodaCashMenu.bottomAnchor, constant: 50).isActive = true
            vodaCashAgent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            vodaCashAgent.heightAnchor.constraint(equalToConstant: 130).isActive = true
            vodaCashAgent.backgroundColor = UIColor.white
            //transforming it a card
            vodaCashAgent.layer.cornerRadius = 2
            vodaCashAgent.layer.shadowOffset = CGSize(width: 0, height: 5)
            vodaCashAgent.layer.shadowColor = UIColor.black.cgColor
            vodaCashAgent.layer.shadowOpacity = 0.1
            
            //left image with colour
            let leftImageColourAgent = UIImageView()
            vodaCashAgent.addSubview(leftImageColourAgent)
            leftImageColourAgent.translatesAutoresizingMaskIntoConstraints = false
            leftImageColourAgent.backgroundColor = UIColor.cardImageColour
            leftImageColourAgent.leadingAnchor.constraint(equalTo: vodaCashAgent.leadingAnchor).isActive = true
            leftImageColourAgent.topAnchor.constraint(equalTo: vodaCashAgent.topAnchor).isActive = true
            leftImageColourAgent.widthAnchor.constraint(equalToConstant: 12).isActive = true
            leftImageColourAgent.bottomAnchor.constraint(equalTo: vodaCashAgent.bottomAnchor).isActive = true
            
            //round image with icon
            let roundImageAgent = UIImageView(image: #imageLiteral(resourceName: "ic_mobile"))
            roundImageAgent.image = roundImageAgent.image!.withRenderingMode(.alwaysTemplate)
            vodaCashAgent.addSubview(roundImageAgent)
            roundImageAgent.tintColor = UIColor.white
            roundImageAgent.backgroundColor = UIColor.vodaIconColour
            roundImageAgent.translatesAutoresizingMaskIntoConstraints = false
            roundImageAgent.topAnchor.constraint(equalTo: vodaCashAgent.topAnchor, constant: 30).isActive = true
            roundImageAgent.leadingAnchor.constraint(equalTo: leftImageColourAgent.trailingAnchor, constant: 19).isActive = true
            roundImageAgent.widthAnchor.constraint(equalToConstant: 60).isActive = true
            roundImageAgent.heightAnchor.constraint(equalToConstant: 60).isActive = true
            roundImageAgent.layer.cornerRadius = roundImageAgent.frame.size.width / 2
            roundImageAgent.clipsToBounds = true
            
            //adding cash menu label
            let vodaCashLabelAgent = UILabel()
            vodaCashAgent.addSubview(vodaCashLabelAgent)
            vodaCashLabelAgent.translatesAutoresizingMaskIntoConstraints = false
            vodaCashLabelAgent.text = "Vodafone Cash Agent"
            vodaCashLabelAgent.font = UIFont(name: String.defaultFontB, size: 20)
            vodaCashLabelAgent.leadingAnchor.constraint(equalTo: roundImageAgent.trailingAnchor, constant: 8).isActive = true
            vodaCashLabelAgent.topAnchor.constraint(equalTo: vodaCashAgent.topAnchor, constant: 40).isActive = true
            vodaCashLabelAgent.trailingAnchor.constraint(equalTo: vodaCashAgent.trailingAnchor, constant: 1).isActive = true
            
            //adding menu description
            let vodaCashLabelDescAgent = UILabel()
            vodaCashAgent.addSubview(vodaCashLabelDescAgent)
            vodaCashLabelDescAgent.translatesAutoresizingMaskIntoConstraints = false
            vodaCashLabelDescAgent.text = "Find Vodafone cash agents"
            vodaCashLabelDescAgent.font = UIFont(name: String.defaultFontR, size: 15)
            vodaCashLabelDescAgent.leadingAnchor.constraint(equalTo: roundImageAgent.trailingAnchor, constant: 12).isActive = true
            vodaCashLabelDescAgent.topAnchor.constraint(equalTo: vodaCashLabelAgent.bottomAnchor, constant: 5).isActive = true
            vodaCashLabelDescAgent.trailingAnchor.constraint(equalTo: vodaCashAgent.trailingAnchor, constant: -10).isActive = true
            
            //adding right arrow
            let cashRightArrowAgent = UIImageView(image: #imageLiteral(resourceName: "arrow"))
            vodaCashAgent.addSubview(cashRightArrowAgent)
            cashRightArrowAgent.translatesAutoresizingMaskIntoConstraints = false
            cashRightArrowAgent.widthAnchor.constraint(equalToConstant: 10).isActive = true
            cashRightArrowAgent.heightAnchor.constraint(equalToConstant: 25).isActive = true
            cashRightArrowAgent.topAnchor.constraint(equalTo: vodaCashAgent.topAnchor, constant: 57).isActive = true
            cashRightArrowAgent.trailingAnchor.constraint(equalTo: vodaCashAgent.trailingAnchor, constant: -9).isActive = true
            
            let vodaCashAgentRec = UITapGestureRecognizer(target: self, action: #selector(displayVodafoneCashAgentLocator))
            vodaCashAgent.addGestureRecognizer(vodaCashAgentRec)
            
            scrollView.contentSize.height = view.frame.size.height + vodaCashMenu.frame.size.height + vodaCashAgent.frame.size.height
            
        }else if selectedOffer == "Services" {
            let creditTransferCard = cardView
            scrollView.addSubview(creditTransferCard)
            creditTransferCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            creditTransferCard.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 60).isActive = true
            creditTransferCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            creditTransferCard.layer.cornerRadius = 2
            creditTransferCard.layer.shadowOffset = CGSize(width: 0, height: 5)
            creditTransferCard.layer.shadowColor = UIColor.black.cgColor
            creditTransferCard.layer.shadowOpacity = 0.2
            
            let servicesRec = UITapGestureRecognizer(target: self, action: #selector(goToCreditTrans))
            creditTransferCard.addGestureRecognizer(servicesRec)
            
            //left image with colour
            let leftImageColour = UIImageView()
            creditTransferCard.addSubview(leftImageColour)
            leftImageColour.translatesAutoresizingMaskIntoConstraints = false
            leftImageColour.backgroundColor = UIColor.cardImageColour
            leftImageColour.leadingAnchor.constraint(equalTo: creditTransferCard.leadingAnchor).isActive = true
            leftImageColour.topAnchor.constraint(equalTo: creditTransferCard.topAnchor).isActive = true
            leftImageColour.widthAnchor.constraint(equalToConstant: 12).isActive = true
            leftImageColour.bottomAnchor.constraint(equalTo: creditTransferCard.bottomAnchor).isActive = true
            
            //round image with icon
            let roundImage = UIImageView(image: #imageLiteral(resourceName: "ic_mobile"))
            roundImage.image = roundImage.image!.withRenderingMode(.alwaysTemplate)
            creditTransferCard.addSubview(roundImage)
            roundImage.tintColor = UIColor.white
            roundImage.backgroundColor = UIColor.vodaIconColour
            roundImage.translatesAutoresizingMaskIntoConstraints = false
            roundImage.topAnchor.constraint(equalTo: creditTransferCard.topAnchor, constant: 30).isActive = true
            roundImage.leadingAnchor.constraint(equalTo: leftImageColour.trailingAnchor, constant: 19).isActive = true
            roundImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
            roundImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
            roundImage.layer.cornerRadius = roundImage.frame.size.width / 2
            roundImage.clipsToBounds = true
            
            //adding credit transfer label
            let creditTransferLabel = UILabel()
            creditTransferCard.addSubview(creditTransferLabel)
            creditTransferLabel.translatesAutoresizingMaskIntoConstraints = false
            creditTransferLabel.text = "Credit Transfer"
            creditTransferLabel.font = UIFont(name: String.defaultFontB, size: 20)
            creditTransferLabel.leadingAnchor.constraint(equalTo: roundImage.trailingAnchor, constant: 8).isActive = true
            creditTransferLabel.topAnchor.constraint(equalTo: creditTransferCard.topAnchor, constant: 40).isActive = true
            creditTransferLabel.trailingAnchor.constraint(equalTo: creditTransferCard.trailingAnchor, constant: 0).isActive = true
            
            //adding description
            let creditTransferLabelDesc = UILabel()
            creditTransferCard.addSubview(creditTransferLabelDesc)
            creditTransferLabelDesc.translatesAutoresizingMaskIntoConstraints = false
            creditTransferLabelDesc.text = "Transfer credit to other numbers"
            creditTransferLabelDesc.font = UIFont(name: String.defaultFontR, size: 13)
            creditTransferLabelDesc.leadingAnchor.constraint(equalTo: roundImage.trailingAnchor, constant: 8).isActive = true
            creditTransferLabelDesc.topAnchor.constraint(equalTo: creditTransferLabel.bottomAnchor, constant: 5).isActive = true
            creditTransferLabelDesc.trailingAnchor.constraint(equalTo: creditTransferCard.trailingAnchor, constant: -10).isActive = true
            
            //adding right arrow
            let cashRightArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
            creditTransferCard.addSubview(cashRightArrow)
            cashRightArrow.translatesAutoresizingMaskIntoConstraints = false
            cashRightArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
            cashRightArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
            cashRightArrow.topAnchor.constraint(equalTo: creditTransferCard.topAnchor, constant: 57).isActive = true
            cashRightArrow.trailingAnchor.constraint(equalTo: creditTransferCard.trailingAnchor, constant: -9).isActive = true
            
            /*Swap Sim*/
            let simSwapCard = UIView()
            scrollView.addSubview(simSwapCard)
            simSwapCard.translatesAutoresizingMaskIntoConstraints = false
            simSwapCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            simSwapCard.topAnchor.constraint(equalTo: creditTransferCard.bottomAnchor, constant: 20).isActive = true
            simSwapCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            simSwapCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
            simSwapCard.backgroundColor = UIColor.white
            //transforming it a card
            simSwapCard.layer.cornerRadius = 2
            simSwapCard.layer.shadowOffset = CGSize(width: 0, height: 5)
            simSwapCard.layer.shadowColor = UIColor.black.cgColor
            simSwapCard.layer.shadowOpacity = 0.2
            
            let simSwapRec = UITapGestureRecognizer(target: self, action: #selector(showSimSwapModal))
            simSwapCard.addGestureRecognizer(simSwapRec)
            
            //left image with colour
            let leftImageColourAgent = UIImageView()
            simSwapCard.addSubview(leftImageColourAgent)
            leftImageColourAgent.translatesAutoresizingMaskIntoConstraints = false
            leftImageColourAgent.backgroundColor = UIColor.cardImageColour
            leftImageColourAgent.leadingAnchor.constraint(equalTo: simSwapCard.leadingAnchor).isActive = true
            leftImageColourAgent.topAnchor.constraint(equalTo: simSwapCard.topAnchor).isActive = true
            leftImageColourAgent.widthAnchor.constraint(equalToConstant: 12).isActive = true
            leftImageColourAgent.bottomAnchor.constraint(equalTo: simSwapCard.bottomAnchor).isActive = true
            
            //round image with icon
            let roundImageAgent = UIImageView(image: #imageLiteral(resourceName: "ic_mobile"))
            roundImageAgent.image = roundImageAgent.image!.withRenderingMode(.alwaysTemplate)
            simSwapCard.addSubview(roundImageAgent)
            roundImageAgent.tintColor = UIColor.white
            roundImageAgent.backgroundColor = UIColor.vodaIconColour
            roundImageAgent.translatesAutoresizingMaskIntoConstraints = false
            roundImageAgent.topAnchor.constraint(equalTo: simSwapCard.topAnchor, constant: 30).isActive = true
            roundImageAgent.leadingAnchor.constraint(equalTo: leftImageColourAgent.trailingAnchor, constant: 19).isActive = true
            roundImageAgent.widthAnchor.constraint(equalToConstant: 60).isActive = true
            roundImageAgent.heightAnchor.constraint(equalToConstant: 60).isActive = true
            roundImageAgent.layer.cornerRadius = roundImageAgent.frame.size.width / 2
            roundImageAgent.clipsToBounds = true
            
            //adding request label
            let requestLabel = UILabel()
            simSwapCard.addSubview(requestLabel)
            requestLabel.translatesAutoresizingMaskIntoConstraints = false
            requestLabel.text = "Request for a SIM Swap"
            requestLabel.numberOfLines = 0
            requestLabel.font = UIFont(name: String.defaultFontB, size: 20)
            requestLabel.leadingAnchor.constraint(equalTo: roundImageAgent.trailingAnchor, constant: 8).isActive = true
            requestLabel.topAnchor.constraint(equalTo: simSwapCard.topAnchor, constant: 40).isActive = true
            requestLabel.trailingAnchor.constraint(equalTo: simSwapCard.trailingAnchor, constant: 1).isActive = true
            
            //adding menu description
            let swapLabelDesc = UILabel()
            simSwapCard.addSubview(swapLabelDesc)
            swapLabelDesc.translatesAutoresizingMaskIntoConstraints = false
            swapLabelDesc.text = "SIM Swap"
            swapLabelDesc.font = UIFont(name: String.defaultFontR, size: 13)
            swapLabelDesc.leadingAnchor.constraint(equalTo: roundImageAgent.trailingAnchor, constant: 12).isActive = true
            swapLabelDesc.topAnchor.constraint(equalTo: requestLabel.bottomAnchor, constant: 5).isActive = true
            swapLabelDesc.trailingAnchor.constraint(equalTo: simSwapCard.trailingAnchor, constant: -10).isActive = true
            
            //adding right arrow
            let cashRightArrowAgent = UIImageView(image: #imageLiteral(resourceName: "arrow"))
            simSwapCard.addSubview(cashRightArrowAgent)
            cashRightArrowAgent.translatesAutoresizingMaskIntoConstraints = false
            cashRightArrowAgent.widthAnchor.constraint(equalToConstant: 10).isActive = true
            cashRightArrowAgent.heightAnchor.constraint(equalToConstant: 25).isActive = true
            cashRightArrowAgent.topAnchor.constraint(equalTo: simSwapCard.topAnchor, constant: 57).isActive = true
            cashRightArrowAgent.trailingAnchor.constraint(equalTo: simSwapCard.trailingAnchor, constant: -9).isActive = true
            
            /* Book Appointment */
            let bookAppoimentCard = UIView()
            scrollView.addSubview(bookAppoimentCard)
            bookAppoimentCard.translatesAutoresizingMaskIntoConstraints = false
            bookAppoimentCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            bookAppoimentCard.topAnchor.constraint(equalTo: simSwapCard.bottomAnchor, constant: 20).isActive = true
            bookAppoimentCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            bookAppoimentCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
            bookAppoimentCard.backgroundColor = UIColor.white
            //transforming it a card
            bookAppoimentCard.layer.cornerRadius = 2
            bookAppoimentCard.layer.shadowOffset = CGSize(width: 0, height: 5)
            bookAppoimentCard.layer.shadowColor = UIColor.black.cgColor
            bookAppoimentCard.layer.shadowOpacity = 0.2
            
            let bookAppoimentRec = UITapGestureRecognizer(target: self, action: #selector(goToAppointment(_sender:)))
            bookAppoimentCard.addGestureRecognizer(bookAppoimentRec)
            
            //left image with colour
            let leftImageApp = UIImageView()
            bookAppoimentCard.addSubview(leftImageApp)
            leftImageApp.translatesAutoresizingMaskIntoConstraints = false
            leftImageApp.backgroundColor = UIColor.cardImageColour
            leftImageApp.leadingAnchor.constraint(equalTo: bookAppoimentCard.leadingAnchor).isActive = true
            leftImageApp.topAnchor.constraint(equalTo: bookAppoimentCard.topAnchor).isActive = true
            leftImageApp.widthAnchor.constraint(equalToConstant: 12).isActive = true
            leftImageApp.bottomAnchor.constraint(equalTo: bookAppoimentCard.bottomAnchor).isActive = true
            
            //round image with icon
            let roundImageApp = UIImageView(image: #imageLiteral(resourceName: "ic_mobile"))
            roundImageApp.image = roundImageApp.image!.withRenderingMode(.alwaysTemplate)
            bookAppoimentCard.addSubview(roundImageApp)
            roundImageApp.tintColor = UIColor.white
            roundImageApp.backgroundColor = UIColor.vodaIconColour
            roundImageApp.translatesAutoresizingMaskIntoConstraints = false
            roundImageApp.topAnchor.constraint(equalTo: bookAppoimentCard.topAnchor, constant: 30).isActive = true
            roundImageApp.leadingAnchor.constraint(equalTo: leftImageApp.trailingAnchor, constant: 19).isActive = true
            roundImageApp.widthAnchor.constraint(equalToConstant: 60).isActive = true
            roundImageApp.heightAnchor.constraint(equalToConstant: 60).isActive = true
            roundImageApp.layer.cornerRadius = roundImageApp.frame.size.width / 2
            roundImageApp.clipsToBounds = true
            
            //adding label
            let bookingLabel = UILabel()
            bookAppoimentCard.addSubview(bookingLabel)
            bookingLabel.translatesAutoresizingMaskIntoConstraints = false
            bookingLabel.text = "Appoinment Booking"
            bookingLabel.font = UIFont(name: String.defaultFontB, size: 20)
            bookingLabel.leadingAnchor.constraint(equalTo: roundImageApp.trailingAnchor, constant: 8).isActive = true
            bookingLabel.topAnchor.constraint(equalTo: bookAppoimentCard.topAnchor, constant: 40).isActive = true
            bookingLabel.trailingAnchor.constraint(equalTo: bookAppoimentCard.trailingAnchor, constant: 1).isActive = true
            
            //adding menu description
            let bookLabelDesc = UILabel()
            bookAppoimentCard.addSubview(bookLabelDesc)
            bookLabelDesc.translatesAutoresizingMaskIntoConstraints = false
            bookLabelDesc.text = "Book an appointment with us"
            bookLabelDesc.font = UIFont(name: String.defaultFontR, size: 13)
            bookLabelDesc.leadingAnchor.constraint(equalTo: roundImageApp.trailingAnchor, constant: 8).isActive = true
            bookLabelDesc.topAnchor.constraint(equalTo: bookingLabel.bottomAnchor, constant: 5).isActive = true
            bookLabelDesc.trailingAnchor.constraint(equalTo: bookAppoimentCard.trailingAnchor, constant: -10).isActive = true
            
            //adding right arrow
            let bookArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
            bookAppoimentCard.addSubview(bookArrow)
            bookArrow.translatesAutoresizingMaskIntoConstraints = false
            bookArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
            bookArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
            bookArrow.topAnchor.constraint(equalTo: bookAppoimentCard.topAnchor, constant: 57).isActive = true
            bookArrow.trailingAnchor.constraint(equalTo: bookAppoimentCard.trailingAnchor, constant: -9).isActive = true
            
            scrollView.contentSize.height = view.frame.size.height + creditTransferCard.frame.size.height + simSwapCard.frame.size.height + bookAppoimentCard.frame.size.height
        }else if selectedOffer == "Internet Of Things" {
            /* Fleet Tracking */
            let fleetTrackingCard = UIView()
            scrollView.addSubview(fleetTrackingCard)
            fleetTrackingCard.translatesAutoresizingMaskIntoConstraints = false
            fleetTrackingCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            fleetTrackingCard.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 20).isActive = true
            fleetTrackingCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            fleetTrackingCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
            fleetTrackingCard.backgroundColor = UIColor.white
            //transforming it a card
            fleetTrackingCard.layer.cornerRadius = 2
            fleetTrackingCard.layer.shadowOffset = CGSize(width: 0, height: 5)
            fleetTrackingCard.layer.shadowColor = UIColor.black.cgColor
            fleetTrackingCard.layer.shadowOpacity = 0.2
            
            let fleetTrackingCardRec = UITapGestureRecognizer(target: self, action: #selector(goToFleetTracking(_sender:)))
            fleetTrackingCard.addGestureRecognizer(fleetTrackingCardRec)
            
            //left image with colour
            let fleetLeftImageApp = UIImageView()
            fleetTrackingCard.addSubview(fleetLeftImageApp)
            fleetLeftImageApp.translatesAutoresizingMaskIntoConstraints = false
            fleetLeftImageApp.backgroundColor = UIColor.cardImageColour
            fleetLeftImageApp.leadingAnchor.constraint(equalTo: fleetTrackingCard.leadingAnchor).isActive = true
            fleetLeftImageApp.topAnchor.constraint(equalTo: fleetTrackingCard.topAnchor).isActive = true
            fleetLeftImageApp.widthAnchor.constraint(equalToConstant: 12).isActive = true
            fleetLeftImageApp.bottomAnchor.constraint(equalTo: fleetTrackingCard.bottomAnchor).isActive = true
            
            //round image with icon
            let fleetRoundImageApp = UIImageView(image: #imageLiteral(resourceName: "ic_headset"))
            fleetRoundImageApp.image = fleetRoundImageApp.image!.withRenderingMode(.alwaysTemplate)
            fleetTrackingCard.addSubview(fleetRoundImageApp)
            fleetRoundImageApp.tintColor = UIColor.white
            fleetRoundImageApp.backgroundColor = UIColor.vodaIconColour
            fleetRoundImageApp.translatesAutoresizingMaskIntoConstraints = false
            fleetRoundImageApp.topAnchor.constraint(equalTo: fleetTrackingCard.topAnchor, constant: 30).isActive = true
            fleetRoundImageApp.leadingAnchor.constraint(equalTo: fleetLeftImageApp.trailingAnchor, constant: 19).isActive = true
            fleetRoundImageApp.widthAnchor.constraint(equalToConstant: 60).isActive = true
            fleetRoundImageApp.heightAnchor.constraint(equalToConstant: 60).isActive = true
            fleetRoundImageApp.layer.cornerRadius = fleetRoundImageApp.frame.size.width / 2
            fleetRoundImageApp.clipsToBounds = true
            
            //adding label
            let fleetLabel = UILabel()
            fleetTrackingCard.addSubview(fleetLabel)
            fleetLabel.translatesAutoresizingMaskIntoConstraints = false
            fleetLabel.text = "Fleet Tracking"
            fleetLabel.font = UIFont(name: String.defaultFontB, size: 20)
            fleetLabel.leadingAnchor.constraint(equalTo: fleetRoundImageApp.trailingAnchor, constant: 8).isActive = true
            fleetLabel.topAnchor.constraint(equalTo: fleetTrackingCard.topAnchor, constant: 40).isActive = true
            fleetLabel.trailingAnchor.constraint(equalTo: fleetTrackingCard.trailingAnchor, constant: 1).isActive = true
            
            
            //adding right arrow
            let bookArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
            fleetTrackingCard.addSubview(bookArrow)
            bookArrow.translatesAutoresizingMaskIntoConstraints = false
            bookArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
            bookArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
            bookArrow.topAnchor.constraint(equalTo: fleetTrackingCard.topAnchor, constant: 57).isActive = true
            bookArrow.trailingAnchor.constraint(equalTo: fleetTrackingCard.trailingAnchor, constant: -9).isActive = true
            
            /* Packages and Details */
            let fleetPackagesCard = UIView()
            scrollView.addSubview(fleetPackagesCard)
            fleetPackagesCard.translatesAutoresizingMaskIntoConstraints = false
            fleetPackagesCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            fleetPackagesCard.topAnchor.constraint(equalTo: fleetTrackingCard.bottomAnchor, constant: 20).isActive = true
            fleetPackagesCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            fleetPackagesCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
            fleetPackagesCard.backgroundColor = UIColor.white
            //transforming it a card
            fleetPackagesCard.layer.cornerRadius = 2
            fleetPackagesCard.layer.shadowOffset = CGSize(width: 0, height: 5)
            fleetPackagesCard.layer.shadowColor = UIColor.black.cgColor
            fleetPackagesCard.layer.shadowOpacity = 0.2
            
            let fleetPackagesCardRec = UITapGestureRecognizer(target: self, action: #selector(goToFleetPackages(_sender:)))
            fleetPackagesCard.addGestureRecognizer(fleetPackagesCardRec)
            
            //left image with colour
            let packagesLeftImageApp = UIImageView()
            fleetPackagesCard.addSubview(packagesLeftImageApp)
            packagesLeftImageApp.translatesAutoresizingMaskIntoConstraints = false
            packagesLeftImageApp.backgroundColor = UIColor.cardImageColour
            packagesLeftImageApp.leadingAnchor.constraint(equalTo: fleetPackagesCard.leadingAnchor).isActive = true
            packagesLeftImageApp.topAnchor.constraint(equalTo: fleetPackagesCard.topAnchor).isActive = true
            packagesLeftImageApp.widthAnchor.constraint(equalToConstant: 12).isActive = true
            packagesLeftImageApp.bottomAnchor.constraint(equalTo: fleetPackagesCard.bottomAnchor).isActive = true
            
            //round image with icon
            let packagesRoundImageApp = UIImageView(image: #imageLiteral(resourceName: "data_icon"))
            packagesRoundImageApp.image = packagesRoundImageApp.image!.withRenderingMode(.alwaysTemplate)
            fleetPackagesCard.addSubview(packagesRoundImageApp)
            packagesRoundImageApp.tintColor = UIColor.white
            packagesRoundImageApp.backgroundColor = UIColor.vodaIconColour
            packagesRoundImageApp.translatesAutoresizingMaskIntoConstraints = false
            packagesRoundImageApp.topAnchor.constraint(equalTo: fleetPackagesCard.topAnchor, constant: 30).isActive = true
            packagesRoundImageApp.leadingAnchor.constraint(equalTo: fleetLeftImageApp.trailingAnchor, constant: 19).isActive = true
            packagesRoundImageApp.widthAnchor.constraint(equalToConstant: 60).isActive = true
            packagesRoundImageApp.heightAnchor.constraint(equalToConstant: 60).isActive = true
            packagesRoundImageApp.layer.cornerRadius = fleetRoundImageApp.frame.size.width / 2
            packagesRoundImageApp.clipsToBounds = true
            
            //adding label
            let packagesLabel = UILabel()
            fleetPackagesCard.addSubview(packagesLabel)
            packagesLabel.translatesAutoresizingMaskIntoConstraints = false
            packagesLabel.text = "Packages and Details"
            packagesLabel.font = UIFont(name: String.defaultFontB, size: 20)
            packagesLabel.leadingAnchor.constraint(equalTo: packagesRoundImageApp.trailingAnchor, constant: 8).isActive = true
            packagesLabel.topAnchor.constraint(equalTo: fleetPackagesCard.topAnchor, constant: 40).isActive = true
            packagesLabel.trailingAnchor.constraint(equalTo: fleetPackagesCard.trailingAnchor, constant: 1).isActive = true
            
            
            //adding right arrow
            let packagesArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
            fleetPackagesCard.addSubview(packagesArrow)
            packagesArrow.translatesAutoresizingMaskIntoConstraints = false
            packagesArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
            packagesArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
            packagesArrow.topAnchor.constraint(equalTo: fleetPackagesCard.topAnchor, constant: 57).isActive = true
            packagesArrow.trailingAnchor.constraint(equalTo: fleetPackagesCard.trailingAnchor, constant: -9).isActive = true
            
//            scrollView.contentSize.height = view.frame.size.height + creditTransferCard.frame.size.height + simSwapCard.frame.size.height + bookAppoimentCard.frame.size.height
        }
        else if selectedOffer == "FBB" {
            //Browse lable
            let lblBrowse = UILabel()
            scrollView.addSubview(lblBrowse)
            lblBrowse.translatesAutoresizingMaskIntoConstraints = false
            lblBrowse.textAlignment = .center
            lblBrowse.font = UIFont(name: String.defaultFontR, size: 31)
            lblBrowse.textColor = UIColor.support_voilet
            lblBrowse.text = "Browse"
            lblBrowse.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            lblBrowse.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 40).isActive = true
            lblBrowse.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            
            let creditTransferCard = cardView
            scrollView.addSubview(creditTransferCard)
            creditTransferCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            creditTransferCard.topAnchor.constraint(equalTo: lblBrowse.bottomAnchor, constant: 20).isActive = true
            creditTransferCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            creditTransferCard.layer.cornerRadius = 2
            creditTransferCard.layer.shadowOffset = CGSize(width: 0, height: 5)
            creditTransferCard.layer.shadowColor = UIColor.black.cgColor
            creditTransferCard.layer.shadowOpacity = 0.2
            
            let fbbBalance = UITapGestureRecognizer(target: self, action: #selector(goToCheckFBB(_sender:)))
            creditTransferCard.addGestureRecognizer(fbbBalance)
            
            //left image with colour
            let leftImageColour = UIImageView()
            creditTransferCard.addSubview(leftImageColour)
            leftImageColour.translatesAutoresizingMaskIntoConstraints = false
            leftImageColour.backgroundColor = UIColor.cardImageColour
            leftImageColour.leadingAnchor.constraint(equalTo: creditTransferCard.leadingAnchor).isActive = true
            leftImageColour.topAnchor.constraint(equalTo: creditTransferCard.topAnchor).isActive = true
            leftImageColour.widthAnchor.constraint(equalToConstant: 12).isActive = true
            leftImageColour.bottomAnchor.constraint(equalTo: creditTransferCard.bottomAnchor).isActive = true
            
            //round image with icon
            let roundImage = UIImageView(image: #imageLiteral(resourceName: "ic_wifi"))
            roundImage.image = roundImage.image!.withRenderingMode(.alwaysTemplate)
            creditTransferCard.addSubview(roundImage)
            roundImage.tintColor = UIColor.white
            roundImage.backgroundColor = UIColor.vodaIconColour
            roundImage.translatesAutoresizingMaskIntoConstraints = false
            roundImage.topAnchor.constraint(equalTo: creditTransferCard.topAnchor, constant: 30).isActive = true
            roundImage.leadingAnchor.constraint(equalTo: leftImageColour.trailingAnchor, constant: 19).isActive = true
            roundImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
            roundImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
            roundImage.layer.cornerRadius = roundImage.frame.size.width / 2
            roundImage.clipsToBounds = true
            
            //adding credit transfer label
            let creditTransferLabel = UILabel()
            creditTransferCard.addSubview(creditTransferLabel)
            creditTransferLabel.translatesAutoresizingMaskIntoConstraints = false
            creditTransferLabel.text = "Broadband Balance"
            creditTransferLabel.font = UIFont(name: String.defaultFontB, size: 20)
            creditTransferLabel.leadingAnchor.constraint(equalTo: roundImage.trailingAnchor, constant: 8).isActive = true
            creditTransferLabel.topAnchor.constraint(equalTo: creditTransferCard.topAnchor, constant: 40).isActive = true
            creditTransferLabel.trailingAnchor.constraint(equalTo: creditTransferCard.trailingAnchor, constant: 0).isActive = true
            
            //adding description
            let creditTransferLabelDesc = UILabel()
            creditTransferCard.addSubview(creditTransferLabelDesc)
            creditTransferLabelDesc.translatesAutoresizingMaskIntoConstraints = false
            creditTransferLabelDesc.text = "Check your broadband balance"
            creditTransferLabelDesc.font = UIFont(name: String.defaultFontR, size: 13)
            creditTransferLabelDesc.leadingAnchor.constraint(equalTo: roundImage.trailingAnchor, constant: 8).isActive = true
            creditTransferLabelDesc.topAnchor.constraint(equalTo: creditTransferLabel.bottomAnchor, constant: 5).isActive = true
            creditTransferLabelDesc.trailingAnchor.constraint(equalTo: creditTransferCard.trailingAnchor, constant: -10).isActive = true
            
            //adding right arrow
            let cashRightArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
            creditTransferCard.addSubview(cashRightArrow)
            cashRightArrow.translatesAutoresizingMaskIntoConstraints = false
            cashRightArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
            cashRightArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
            cashRightArrow.topAnchor.constraint(equalTo: creditTransferCard.topAnchor, constant: 57).isActive = true
            cashRightArrow.trailingAnchor.constraint(equalTo: creditTransferCard.trailingAnchor, constant: -9).isActive = true
            
            /*Broadband Packages*/
            let BBPackagesCard = UIView()
            scrollView.addSubview(BBPackagesCard)
            BBPackagesCard.translatesAutoresizingMaskIntoConstraints = false
            BBPackagesCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            BBPackagesCard.topAnchor.constraint(equalTo: creditTransferCard.bottomAnchor, constant: 20).isActive = true
            BBPackagesCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            BBPackagesCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
            BBPackagesCard.backgroundColor = UIColor.white
            //transforming it a card
            BBPackagesCard.layer.cornerRadius = 2
            BBPackagesCard.layer.shadowOffset = CGSize(width: 0, height: 5)
            BBPackagesCard.layer.shadowColor = UIColor.black.cgColor
            BBPackagesCard.layer.shadowOpacity = 0.2
            
            let bBBPackagestCardRec = UITapGestureRecognizer(target: self, action: #selector(goToBBPackages))
            BBPackagesCard.addGestureRecognizer(bBBPackagestCardRec)
            
            //left image with colour
            let leftImageColourAgent = UIImageView()
            BBPackagesCard.addSubview(leftImageColourAgent)
            leftImageColourAgent.translatesAutoresizingMaskIntoConstraints = false
            leftImageColourAgent.backgroundColor = UIColor.cardImageColour
            leftImageColourAgent.leadingAnchor.constraint(equalTo: BBPackagesCard.leadingAnchor).isActive = true
            leftImageColourAgent.topAnchor.constraint(equalTo: BBPackagesCard.topAnchor).isActive = true
            leftImageColourAgent.widthAnchor.constraint(equalToConstant: 12).isActive = true
            leftImageColourAgent.bottomAnchor.constraint(equalTo: BBPackagesCard.bottomAnchor).isActive = true
            
            //round image with icon
            let roundImageAgent = UIImageView(image: #imageLiteral(resourceName: "ic_wifi"))
            roundImageAgent.image = roundImageAgent.image!.withRenderingMode(.alwaysTemplate)
            BBPackagesCard.addSubview(roundImageAgent)
            roundImageAgent.tintColor = UIColor.white
            roundImageAgent.backgroundColor = UIColor.vodaIconColour
            roundImageAgent.translatesAutoresizingMaskIntoConstraints = false
            roundImageAgent.topAnchor.constraint(equalTo: BBPackagesCard.topAnchor, constant: 30).isActive = true
            roundImageAgent.leadingAnchor.constraint(equalTo: leftImageColourAgent.trailingAnchor, constant: 19).isActive = true
            roundImageAgent.widthAnchor.constraint(equalToConstant: 60).isActive = true
            roundImageAgent.heightAnchor.constraint(equalToConstant: 60).isActive = true
            roundImageAgent.layer.cornerRadius = roundImageAgent.frame.size.width / 2
            roundImageAgent.clipsToBounds = true
            
            //adding request label
            let requestLabel = UILabel()
            BBPackagesCard.addSubview(requestLabel)
            requestLabel.translatesAutoresizingMaskIntoConstraints = false
            requestLabel.text = "Broadband Packages"
            requestLabel.numberOfLines = 0
            requestLabel.font = UIFont(name: String.defaultFontB, size: 20)
            requestLabel.leadingAnchor.constraint(equalTo: roundImageAgent.trailingAnchor, constant: 8).isActive = true
            requestLabel.topAnchor.constraint(equalTo: BBPackagesCard.topAnchor, constant: 40).isActive = true
            requestLabel.trailingAnchor.constraint(equalTo: BBPackagesCard.trailingAnchor, constant: 1).isActive = true
            
            //adding menu description
            let swapLabelDesc = UILabel()
            BBPackagesCard.addSubview(swapLabelDesc)
            swapLabelDesc.translatesAutoresizingMaskIntoConstraints = false
            swapLabelDesc.text = "Broadband Packages"
            swapLabelDesc.font = UIFont(name: String.defaultFontR, size: 13)
            swapLabelDesc.leadingAnchor.constraint(equalTo: roundImageAgent.trailingAnchor, constant: 12).isActive = true
            swapLabelDesc.topAnchor.constraint(equalTo: requestLabel.bottomAnchor, constant: 5).isActive = true
            swapLabelDesc.trailingAnchor.constraint(equalTo: BBPackagesCard.trailingAnchor, constant: -10).isActive = true
            
            //adding right arrow
            let cashRightArrowAgent = UIImageView(image: #imageLiteral(resourceName: "arrow"))
            BBPackagesCard.addSubview(cashRightArrowAgent)
            cashRightArrowAgent.translatesAutoresizingMaskIntoConstraints = false
            cashRightArrowAgent.widthAnchor.constraint(equalToConstant: 10).isActive = true
            cashRightArrowAgent.heightAnchor.constraint(equalToConstant: 25).isActive = true
            cashRightArrowAgent.topAnchor.constraint(equalTo: BBPackagesCard.topAnchor, constant: 57).isActive = true
            cashRightArrowAgent.trailingAnchor.constraint(equalTo: BBPackagesCard.trailingAnchor, constant: -9).isActive = true
            
            /* Book Appointment */
            let bookAppoimentCard = UIView()
            scrollView.addSubview(bookAppoimentCard)
            bookAppoimentCard.translatesAutoresizingMaskIntoConstraints = false
            bookAppoimentCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            bookAppoimentCard.topAnchor.constraint(equalTo: BBPackagesCard.bottomAnchor, constant: 20).isActive = true
            bookAppoimentCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            bookAppoimentCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
            bookAppoimentCard.backgroundColor = UIColor.white
            //transforming it a card
            bookAppoimentCard.layer.cornerRadius = 2
            bookAppoimentCard.layer.shadowOffset = CGSize(width: 0, height: 5)
            bookAppoimentCard.layer.shadowColor = UIColor.black.cgColor
            bookAppoimentCard.layer.shadowOpacity = 0.2
            
            let bookAppoimentCardRec = UITapGestureRecognizer(target: self, action: #selector(goToFBBMove))
            bookAppoimentCard.addGestureRecognizer(bookAppoimentCardRec)
            
            //left image with colour
            let leftImageApp = UIImageView()
            bookAppoimentCard.addSubview(leftImageApp)
            leftImageApp.translatesAutoresizingMaskIntoConstraints = false
            leftImageApp.backgroundColor = UIColor.cardImageColour
            leftImageApp.leadingAnchor.constraint(equalTo: bookAppoimentCard.leadingAnchor).isActive = true
            leftImageApp.topAnchor.constraint(equalTo: bookAppoimentCard.topAnchor).isActive = true
            leftImageApp.widthAnchor.constraint(equalToConstant: 12).isActive = true
            leftImageApp.bottomAnchor.constraint(equalTo: bookAppoimentCard.bottomAnchor).isActive = true
            
            //round image with icon
            let roundImageApp = UIImageView(image: #imageLiteral(resourceName: "ic_wifi"))
            roundImageApp.image = roundImageApp.image!.withRenderingMode(.alwaysTemplate)
            bookAppoimentCard.addSubview(roundImageApp)
            roundImageApp.tintColor = UIColor.white
            roundImageApp.backgroundColor = UIColor.vodaIconColour
            roundImageApp.translatesAutoresizingMaskIntoConstraints = false
            roundImageApp.topAnchor.constraint(equalTo: bookAppoimentCard.topAnchor, constant: 30).isActive = true
            roundImageApp.leadingAnchor.constraint(equalTo: leftImageApp.trailingAnchor, constant: 19).isActive = true
            roundImageApp.widthAnchor.constraint(equalToConstant: 60).isActive = true
            roundImageApp.heightAnchor.constraint(equalToConstant: 60).isActive = true
            roundImageApp.layer.cornerRadius = roundImageApp.frame.size.width / 2
            roundImageApp.clipsToBounds = true
            
            //adding label
            let bookingLabel = UILabel()
            bookAppoimentCard.addSubview(bookingLabel)
            bookingLabel.translatesAutoresizingMaskIntoConstraints = false
            bookingLabel.text = "Broadband Move Data"
            bookingLabel.font = UIFont(name: String.defaultFontB, size: 20)
            bookingLabel.leadingAnchor.constraint(equalTo: roundImageApp.trailingAnchor, constant: 8).isActive = true
            bookingLabel.topAnchor.constraint(equalTo: bookAppoimentCard.topAnchor, constant: 40).isActive = true
            bookingLabel.trailingAnchor.constraint(equalTo: bookAppoimentCard.trailingAnchor, constant: 1).isActive = true
            bookingLabel.numberOfLines = 0
            bookingLabel.lineBreakMode = .byWordWrapping
            
            //adding menu description
            let bookLabelDesc = UILabel()
            bookAppoimentCard.addSubview(bookLabelDesc)
            bookLabelDesc.translatesAutoresizingMaskIntoConstraints = false
            bookLabelDesc.text = "Broadband Move Data"
            bookLabelDesc.font = UIFont(name: String.defaultFontR, size: 13)
            bookLabelDesc.leadingAnchor.constraint(equalTo: roundImageApp.trailingAnchor, constant: 8).isActive = true
            bookLabelDesc.topAnchor.constraint(equalTo: bookingLabel.bottomAnchor, constant: 5).isActive = true
            bookLabelDesc.trailingAnchor.constraint(equalTo: bookAppoimentCard.trailingAnchor, constant: -10).isActive = true
            bookLabelDesc.numberOfLines = 0
            bookLabelDesc.lineBreakMode = .byWordWrapping
            
            //adding right arrow
            let bookArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
            bookAppoimentCard.addSubview(bookArrow)
            bookArrow.translatesAutoresizingMaskIntoConstraints = false
            bookArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
            bookArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
            bookArrow.topAnchor.constraint(equalTo: bookAppoimentCard.topAnchor, constant: 57).isActive = true
            bookArrow.trailingAnchor.constraint(equalTo: bookAppoimentCard.trailingAnchor, constant: -9).isActive = true
            
            //Pay bills label
            let lblPills = UILabel()
            scrollView.addSubview(lblPills)
            lblPills.translatesAutoresizingMaskIntoConstraints = false
            lblPills.textAlignment = .center
            lblPills.font = UIFont(name: String.defaultFontR, size: 31)
            lblPills.textColor = UIColor.support_voilet
            lblPills.text = "Pay Bills"
            lblPills.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            lblPills.topAnchor.constraint(equalTo: bookAppoimentCard.bottomAnchor, constant: 40).isActive = true
            lblPills.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            
            let payRechargeVCard = UIView()
            scrollView.addSubview(payRechargeVCard)
            payRechargeVCard.translatesAutoresizingMaskIntoConstraints = false
            payRechargeVCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            payRechargeVCard.topAnchor.constraint(equalTo: lblPills.bottomAnchor, constant: 20).isActive = true
            payRechargeVCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            payRechargeVCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
            payRechargeVCard.backgroundColor = UIColor.white
            //transforming it a card
            payRechargeVCard.layer.cornerRadius = 2
            payRechargeVCard.layer.shadowOffset = CGSize(width: 0, height: 5)
            payRechargeVCard.layer.shadowColor = UIColor.black.cgColor
            payRechargeVCard.layer.shadowOpacity = 0.2
            
            let payRechargeVRec = UITapGestureRecognizer(target: self, action: #selector(goToFBBPayV))
            payRechargeVCard.addGestureRecognizer(payRechargeVRec)
            
            //left image with colour
            let leftImagePayBill = UIImageView()
            payRechargeVCard.addSubview(leftImagePayBill)
            leftImagePayBill.translatesAutoresizingMaskIntoConstraints = false
            leftImagePayBill.backgroundColor = UIColor.cardImageColour
            leftImagePayBill.leadingAnchor.constraint(equalTo: payRechargeVCard.leadingAnchor).isActive = true
            leftImagePayBill.topAnchor.constraint(equalTo: payRechargeVCard.topAnchor).isActive = true
            leftImagePayBill.widthAnchor.constraint(equalToConstant: 12).isActive = true
            leftImagePayBill.bottomAnchor.constraint(equalTo: payRechargeVCard.bottomAnchor).isActive = true
            
            //round image with icon
            let roundImagePayV = UIImageView(image: #imageLiteral(resourceName: "ic_wifi"))
            roundImagePayV.image = roundImagePayV.image!.withRenderingMode(.alwaysTemplate)
            payRechargeVCard.addSubview(roundImagePayV)
            roundImagePayV.tintColor = UIColor.white
            roundImagePayV.backgroundColor = UIColor.vodaIconColour
            roundImagePayV.translatesAutoresizingMaskIntoConstraints = false
            roundImagePayV.topAnchor.constraint(equalTo: payRechargeVCard.topAnchor, constant: 30).isActive = true
            roundImagePayV.leadingAnchor.constraint(equalTo: leftImagePayBill.trailingAnchor, constant: 19).isActive = true
            roundImagePayV.widthAnchor.constraint(equalToConstant: 60).isActive = true
            roundImagePayV.heightAnchor.constraint(equalToConstant: 60).isActive = true
            roundImagePayV.layer.cornerRadius = roundImagePayV.frame.size.width / 2
            roundImagePayV.clipsToBounds = true
            
            //adding label
            let payByVLabel = UILabel()
            payRechargeVCard.addSubview(payByVLabel)
            payByVLabel.translatesAutoresizingMaskIntoConstraints = false
            payByVLabel.text = "Pay by Recharge Voucher"
            payByVLabel.numberOfLines = 0
            payByVLabel.lineBreakMode = .byWordWrapping
            payByVLabel.font = UIFont(name: String.defaultFontB, size: 20)
            payByVLabel.leadingAnchor.constraint(equalTo: roundImagePayV.trailingAnchor, constant: 8).isActive = true
            payByVLabel.topAnchor.constraint(equalTo: payRechargeVCard.topAnchor, constant: 40).isActive = true
            payByVLabel.trailingAnchor.constraint(equalTo: payRechargeVCard.trailingAnchor, constant: 1).isActive = true
            payByVLabel.numberOfLines = 0
            payByVLabel.lineBreakMode = .byWordWrapping
            
            let payByVLabelDesc = UILabel()
            payRechargeVCard.addSubview(payByVLabelDesc)
            payByVLabelDesc.translatesAutoresizingMaskIntoConstraints = false
            payByVLabelDesc.text = "Pay bill through Recharge Voucher"
            payByVLabelDesc.font = UIFont(name: String.defaultFontR, size: 13)
            payByVLabelDesc.leadingAnchor.constraint(equalTo: roundImagePayV.trailingAnchor, constant: 8).isActive = true
            payByVLabelDesc.topAnchor.constraint(equalTo: payByVLabel.bottomAnchor, constant: 5).isActive = true
            payByVLabelDesc.trailingAnchor.constraint(equalTo: payRechargeVCard.trailingAnchor, constant: -10).isActive = true
            payByVLabelDesc.numberOfLines = 0
            payByVLabelDesc.lineBreakMode = .byWordWrapping
            
            
            let payByVArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
            payRechargeVCard.addSubview(payByVArrow)
            payByVArrow.translatesAutoresizingMaskIntoConstraints = false
            payByVArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
            payByVArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
            payByVArrow.topAnchor.constraint(equalTo: payRechargeVCard.topAnchor, constant: 57).isActive = true
            payByVArrow.trailingAnchor.constraint(equalTo: payRechargeVCard.trailingAnchor, constant: -9).isActive = true
            
            let payByExpressPCard = UIView()
            scrollView.addSubview(payByExpressPCard)
            payByExpressPCard.translatesAutoresizingMaskIntoConstraints = false
            payByExpressPCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            payByExpressPCard.topAnchor.constraint(equalTo: payRechargeVCard.bottomAnchor, constant: 20).isActive = true
            payByExpressPCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            payByExpressPCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
            payByExpressPCard.backgroundColor = UIColor.white
            //transforming it a card
            payByExpressPCard.layer.cornerRadius = 2
            payByExpressPCard.layer.shadowOffset = CGSize(width: 0, height: 5)
            payByExpressPCard.layer.shadowColor = UIColor.black.cgColor
            payByExpressPCard.layer.shadowOpacity = 0.2
            
            let payViaExpressPayRec = UITapGestureRecognizer(target: self, action: #selector(goToExpressPay))
            payByExpressPCard.addGestureRecognizer(payViaExpressPayRec)
            
            //left image with colour
            let leftImageExpressPay = UIImageView()
            payByExpressPCard.addSubview(leftImageExpressPay)
            leftImageExpressPay.translatesAutoresizingMaskIntoConstraints = false
            leftImageExpressPay.backgroundColor = UIColor.cardImageColour
            leftImageExpressPay.leadingAnchor.constraint(equalTo: payByExpressPCard.leadingAnchor).isActive = true
            leftImageExpressPay.topAnchor.constraint(equalTo: payByExpressPCard.topAnchor).isActive = true
            leftImageExpressPay.widthAnchor.constraint(equalToConstant: 12).isActive = true
            leftImageExpressPay.bottomAnchor.constraint(equalTo: payByExpressPCard.bottomAnchor).isActive = true
            
            //round image with icon
            let roundImagePayExpress = UIImageView(image: #imageLiteral(resourceName: "ic_wifi"))
            roundImagePayExpress.image = roundImagePayExpress.image!.withRenderingMode(.alwaysTemplate)
            payByExpressPCard.addSubview(roundImagePayExpress)
            roundImagePayExpress.tintColor = UIColor.white
            roundImagePayExpress.backgroundColor = UIColor.vodaIconColour
            roundImagePayExpress.translatesAutoresizingMaskIntoConstraints = false
            roundImagePayExpress.topAnchor.constraint(equalTo: payByExpressPCard.topAnchor, constant: 30).isActive = true
            roundImagePayExpress.leadingAnchor.constraint(equalTo: leftImagePayBill.trailingAnchor, constant: 19).isActive = true
            roundImagePayExpress.widthAnchor.constraint(equalToConstant: 60).isActive = true
            roundImagePayExpress.heightAnchor.constraint(equalToConstant: 60).isActive = true
            roundImagePayExpress.layer.cornerRadius = roundImagePayExpress.frame.size.width / 2
            roundImagePayExpress.clipsToBounds = true
            
            //adding label
            let payByExpressLabel = UILabel()
            payByExpressPCard.addSubview(payByExpressLabel)
            payByExpressLabel.translatesAutoresizingMaskIntoConstraints = false
            payByExpressLabel.text = "Pay by ExpressPay"
            payByExpressLabel.numberOfLines = 0
            payByExpressLabel.lineBreakMode = .byWordWrapping
            payByExpressLabel.font = UIFont(name: String.defaultFontB, size: 20)
            payByExpressLabel.leadingAnchor.constraint(equalTo: roundImagePayExpress.trailingAnchor, constant: 8).isActive = true
            payByExpressLabel.topAnchor.constraint(equalTo: payByExpressPCard.topAnchor, constant: 40).isActive = true
            payByExpressLabel.trailingAnchor.constraint(equalTo: payByExpressPCard.trailingAnchor, constant: 1).isActive = true
            
            let payByExpressLabelDesc = UILabel()
            payByExpressPCard.addSubview(payByExpressLabelDesc)
            payByExpressLabelDesc.translatesAutoresizingMaskIntoConstraints = false
            payByExpressLabelDesc.text = "Pay via Credit Card through ExpressPay"
            payByExpressLabelDesc.font = UIFont(name: String.defaultFontR, size: 13)
            payByExpressLabelDesc.leadingAnchor.constraint(equalTo: roundImagePayExpress.trailingAnchor, constant: 8).isActive = true
            payByExpressLabelDesc.topAnchor.constraint(equalTo: payByExpressLabel.bottomAnchor, constant: 5).isActive = true
            payByExpressLabelDesc.trailingAnchor.constraint(equalTo: payByExpressPCard.trailingAnchor, constant: -10).isActive = true
            payByExpressLabelDesc.numberOfLines = 0
            payByExpressLabelDesc.lineBreakMode = .byWordWrapping
            
            let payExpressVArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
            payByExpressPCard.addSubview(payExpressVArrow)
            payExpressVArrow.translatesAutoresizingMaskIntoConstraints = false
            payExpressVArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
            payExpressVArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
            payExpressVArrow.topAnchor.constraint(equalTo: payByExpressPCard.topAnchor, constant: 57).isActive = true
            payExpressVArrow.trailingAnchor.constraint(equalTo: payByExpressPCard.trailingAnchor, constant: -9).isActive = true
            
            let payByUSSDPCard = UIView()
            scrollView.addSubview(payByUSSDPCard)
            payByUSSDPCard.translatesAutoresizingMaskIntoConstraints = false
            payByUSSDPCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            payByUSSDPCard.topAnchor.constraint(equalTo: payByExpressPCard.bottomAnchor, constant: 20).isActive = true
            payByUSSDPCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            payByUSSDPCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
            payByUSSDPCard.backgroundColor = UIColor.white
            //transforming it a card
            payByUSSDPCard.layer.cornerRadius = 2
            payByUSSDPCard.layer.shadowOffset = CGSize(width: 0, height: 5)
            payByUSSDPCard.layer.shadowColor = UIColor.black.cgColor
            payByUSSDPCard.layer.shadowOpacity = 0.2
            
            let payByUSSDRec = UITapGestureRecognizer(target: self, action: #selector(dialUSSD))
            payByUSSDPCard.addGestureRecognizer(payByUSSDRec)
            
            //left image with colour
            let leftImageUSSD = UIImageView()
            payByUSSDPCard.addSubview(leftImageUSSD)
            leftImageUSSD.translatesAutoresizingMaskIntoConstraints = false
            leftImageUSSD.backgroundColor = UIColor.cardImageColour
            leftImageUSSD.leadingAnchor.constraint(equalTo: payByUSSDPCard.leadingAnchor).isActive = true
            leftImageUSSD.topAnchor.constraint(equalTo: payByUSSDPCard.topAnchor).isActive = true
            leftImageUSSD.widthAnchor.constraint(equalToConstant: 12).isActive = true
            leftImageUSSD.bottomAnchor.constraint(equalTo: payByUSSDPCard.bottomAnchor).isActive = true
            
            //round image with icon
            let roundImagePayUSSD = UIImageView(image: #imageLiteral(resourceName: "ic_wifi"))
            roundImagePayUSSD.image = roundImagePayUSSD.image!.withRenderingMode(.alwaysTemplate)
            payByUSSDPCard.addSubview(roundImagePayUSSD)
            roundImagePayUSSD.tintColor = UIColor.white
            roundImagePayUSSD.backgroundColor = UIColor.vodaIconColour
            roundImagePayUSSD.translatesAutoresizingMaskIntoConstraints = false
            roundImagePayUSSD.topAnchor.constraint(equalTo: payByUSSDPCard.topAnchor, constant: 30).isActive = true
            roundImagePayUSSD.leadingAnchor.constraint(equalTo: leftImageUSSD.trailingAnchor, constant: 19).isActive = true
            roundImagePayUSSD.widthAnchor.constraint(equalToConstant: 60).isActive = true
            roundImagePayUSSD.heightAnchor.constraint(equalToConstant: 60).isActive = true
            roundImagePayUSSD.layer.cornerRadius = roundImagePayUSSD.frame.size.width / 2
            roundImagePayUSSD.clipsToBounds = true
            
            //adding label
            let payByUSSDLabel = UILabel()
            payByUSSDPCard.addSubview(payByUSSDLabel)
            payByUSSDLabel.translatesAutoresizingMaskIntoConstraints = false
            payByUSSDLabel.text = "Pay via USSD"
            payByUSSDLabel.numberOfLines = 0
            payByUSSDLabel.lineBreakMode = .byWordWrapping
            payByUSSDLabel.font = UIFont(name: String.defaultFontB, size: 20)
            payByUSSDLabel.leadingAnchor.constraint(equalTo: roundImagePayUSSD.trailingAnchor, constant: 8).isActive = true
            payByUSSDLabel.topAnchor.constraint(equalTo: payByUSSDPCard.topAnchor, constant: 40).isActive = true
            payByUSSDLabel.trailingAnchor.constraint(equalTo: payByUSSDPCard.trailingAnchor, constant: 1).isActive = true
            
            let payByUSSDLabelDesc = UILabel()
            payByUSSDPCard.addSubview(payByUSSDLabelDesc)
            payByUSSDLabelDesc.translatesAutoresizingMaskIntoConstraints = false
            payByUSSDLabelDesc.text = "Pay bill through USSD"
            payByUSSDLabelDesc.font = UIFont(name: String.defaultFontR, size: 13)
            payByUSSDLabelDesc.leadingAnchor.constraint(equalTo: roundImagePayUSSD.trailingAnchor, constant: 8).isActive = true
            payByUSSDLabelDesc.topAnchor.constraint(equalTo: payByUSSDLabel.bottomAnchor, constant: 5).isActive = true
            payByUSSDLabelDesc.trailingAnchor.constraint(equalTo: payByUSSDPCard.trailingAnchor, constant: -10).isActive = true
            payByUSSDLabelDesc.numberOfLines = 0
            payByUSSDLabelDesc.lineBreakMode = .byWordWrapping
            
            let payUSSDArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
            payByUSSDPCard.addSubview(payUSSDArrow)
            payUSSDArrow.translatesAutoresizingMaskIntoConstraints = false
            payUSSDArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
            payUSSDArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
            payUSSDArrow.topAnchor.constraint(equalTo: payByUSSDPCard.topAnchor, constant: 57).isActive = true
            payUSSDArrow.trailingAnchor.constraint(equalTo: payByUSSDPCard.trailingAnchor, constant: -9).isActive = true
            
            //Pay bills label
            let lblMore = UILabel()
            scrollView.addSubview(lblMore)
            lblMore.translatesAutoresizingMaskIntoConstraints = false
            lblMore.textAlignment = .center
            lblMore.font = UIFont(name: String.defaultFontR, size: 31)
            lblMore.textColor = UIColor.support_voilet
            lblMore.text = "More"
            lblMore.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            lblMore.topAnchor.constraint(equalTo: payByUSSDPCard.bottomAnchor, constant: 40).isActive = true
            lblMore.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            
            let requestFBBPCard = UIView()
            scrollView.addSubview(requestFBBPCard)
            requestFBBPCard.translatesAutoresizingMaskIntoConstraints = false
            requestFBBPCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            requestFBBPCard.topAnchor.constraint(equalTo: lblMore.bottomAnchor, constant: 20).isActive = true
            requestFBBPCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            requestFBBPCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
            requestFBBPCard.backgroundColor = UIColor.white
            //transforming it a card
            requestFBBPCard.layer.cornerRadius = 2
            requestFBBPCard.layer.shadowOffset = CGSize(width: 0, height: 5)
            requestFBBPCard.layer.shadowColor = UIColor.black.cgColor
            requestFBBPCard.layer.shadowOpacity = 0.2
            
            let requestFBBRec = UITapGestureRecognizer(target: self, action: #selector(requestBroadband))
            requestFBBPCard.addGestureRecognizer(requestFBBRec)
            
            
            //left image with colour
            let leftImageMore = UIImageView()
            requestFBBPCard.addSubview(leftImageMore)
            leftImageMore.translatesAutoresizingMaskIntoConstraints = false
            leftImageMore.backgroundColor = UIColor.cardImageColour
            leftImageMore.leadingAnchor.constraint(equalTo: requestFBBPCard.leadingAnchor).isActive = true
            leftImageMore.topAnchor.constraint(equalTo: requestFBBPCard.topAnchor).isActive = true
            leftImageMore.widthAnchor.constraint(equalToConstant: 12).isActive = true
            leftImageMore.bottomAnchor.constraint(equalTo: requestFBBPCard.bottomAnchor).isActive = true
            
            //round image with icon
            let roundImageRequestBB = UIImageView(image: #imageLiteral(resourceName: "ic_wifi"))
            roundImageRequestBB.image = roundImageRequestBB.image!.withRenderingMode(.alwaysTemplate)
            requestFBBPCard.addSubview(roundImageRequestBB)
            roundImageRequestBB.tintColor = UIColor.white
            roundImageRequestBB.backgroundColor = UIColor.vodaIconColour
            roundImageRequestBB.translatesAutoresizingMaskIntoConstraints = false
            roundImageRequestBB.topAnchor.constraint(equalTo: requestFBBPCard.topAnchor, constant: 30).isActive = true
            roundImageRequestBB.leadingAnchor.constraint(equalTo: leftImageMore.trailingAnchor, constant: 19).isActive = true
            roundImageRequestBB.widthAnchor.constraint(equalToConstant: 60).isActive = true
            roundImageRequestBB.heightAnchor.constraint(equalToConstant: 60).isActive = true
            roundImageRequestBB.layer.cornerRadius = roundImageRequestBB.frame.size.width / 2
            roundImageRequestBB.clipsToBounds = true
            
            //adding label
            let requestFBBLabel = UILabel()
            requestFBBPCard.addSubview(requestFBBLabel)
            requestFBBLabel.translatesAutoresizingMaskIntoConstraints = false
            requestFBBLabel.text = "Request Broadband"
            requestFBBLabel.numberOfLines = 0
            requestFBBLabel.lineBreakMode = .byWordWrapping
            requestFBBLabel.font = UIFont(name: String.defaultFontB, size: 20)
            requestFBBLabel.leadingAnchor.constraint(equalTo: roundImageRequestBB.trailingAnchor, constant: 8).isActive = true
            requestFBBLabel.topAnchor.constraint(equalTo: requestFBBPCard.topAnchor, constant: 40).isActive = true
            requestFBBLabel.trailingAnchor.constraint(equalTo: requestFBBPCard.trailingAnchor, constant: 1).isActive = true
            
            let requestFBBLabelDesc = UILabel()
            requestFBBPCard.addSubview(requestFBBLabelDesc)
            requestFBBLabelDesc.translatesAutoresizingMaskIntoConstraints = false
            requestFBBLabelDesc.text = "Request fixed broadband online"
            requestFBBLabelDesc.font = UIFont(name: String.defaultFontR, size: 13)
            requestFBBLabelDesc.leadingAnchor.constraint(equalTo: roundImageRequestBB.trailingAnchor, constant: 8).isActive = true
            requestFBBLabelDesc.topAnchor.constraint(equalTo: requestFBBLabel.bottomAnchor, constant: 5).isActive = true
            requestFBBLabelDesc.trailingAnchor.constraint(equalTo: requestFBBPCard.trailingAnchor, constant: -10).isActive = true
            requestFBBLabelDesc.numberOfLines = 0
            requestFBBLabelDesc.lineBreakMode = .byWordWrapping
            
            let requestFBBArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
            requestFBBPCard.addSubview(requestFBBArrow)
            requestFBBArrow.translatesAutoresizingMaskIntoConstraints = false
            requestFBBArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
            requestFBBArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
            requestFBBArrow.topAnchor.constraint(equalTo: requestFBBPCard.topAnchor, constant: 57).isActive = true
            requestFBBArrow.trailingAnchor.constraint(equalTo: requestFBBPCard.trailingAnchor, constant: -9).isActive = true
            
            let requestFBBRPCard = UIView()
            scrollView.addSubview(requestFBBRPCard)
            requestFBBRPCard.translatesAutoresizingMaskIntoConstraints = false
            requestFBBRPCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            requestFBBRPCard.topAnchor.constraint(equalTo: requestFBBPCard.bottomAnchor, constant: 20).isActive = true
            requestFBBRPCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            requestFBBRPCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
            requestFBBRPCard.backgroundColor = UIColor.white
            //transforming it a card
            requestFBBRPCard.layer.cornerRadius = 2
            requestFBBRPCard.layer.shadowOffset = CGSize(width: 0, height: 5)
            requestFBBRPCard.layer.shadowColor = UIColor.black.cgColor
            requestFBBRPCard.layer.shadowOpacity = 0.2
            
            let requestFBBRRec = UITapGestureRecognizer(target: self, action: #selector(requestBroadband))
            requestFBBRPCard.addGestureRecognizer(requestFBBRRec)
            
            //left image with colour
            let leftImageRR = UIImageView()
            requestFBBRPCard.addSubview(leftImageRR)
            leftImageRR.translatesAutoresizingMaskIntoConstraints = false
            leftImageRR.backgroundColor = UIColor.cardImageColour
            leftImageRR.leadingAnchor.constraint(equalTo: requestFBBRPCard.leadingAnchor).isActive = true
            leftImageRR.topAnchor.constraint(equalTo: requestFBBRPCard.topAnchor).isActive = true
            leftImageRR.widthAnchor.constraint(equalToConstant: 12).isActive = true
            leftImageRR.bottomAnchor.constraint(equalTo: requestFBBRPCard.bottomAnchor).isActive = true
            
            //round image with icon
            let roundImageRequestR = UIImageView(image: #imageLiteral(resourceName: "ic_wifi"))
            roundImageRequestR.image = roundImageRequestR.image!.withRenderingMode(.alwaysTemplate)
            requestFBBRPCard.addSubview(roundImageRequestR)
            roundImageRequestR.tintColor = UIColor.white
            roundImageRequestR.backgroundColor = UIColor.vodaIconColour
            roundImageRequestR.translatesAutoresizingMaskIntoConstraints = false
            roundImageRequestR.topAnchor.constraint(equalTo: requestFBBRPCard.topAnchor, constant: 30).isActive = true
            roundImageRequestR.leadingAnchor.constraint(equalTo: leftImageRR.trailingAnchor, constant: 19).isActive = true
            roundImageRequestR.widthAnchor.constraint(equalToConstant: 60).isActive = true
            roundImageRequestR.heightAnchor.constraint(equalToConstant: 60).isActive = true
            roundImageRequestR.layer.cornerRadius = roundImageRequestR.frame.size.width / 2
            roundImageRequestR.clipsToBounds = true
            
            //adding label
            let requestRLabel = UILabel()
            requestFBBRPCard.addSubview(requestRLabel)
            requestRLabel.translatesAutoresizingMaskIntoConstraints = false
            requestRLabel.text = "Request Broadband Relocation"
            requestRLabel.numberOfLines = 0
            requestRLabel.lineBreakMode = .byWordWrapping
            requestRLabel.font = UIFont(name: String.defaultFontB, size: 20)
            requestRLabel.leadingAnchor.constraint(equalTo: roundImageRequestR.trailingAnchor, constant: 8).isActive = true
            requestRLabel.topAnchor.constraint(equalTo: requestFBBRPCard.topAnchor, constant: 40).isActive = true
            requestRLabel.trailingAnchor.constraint(equalTo: requestFBBRPCard.trailingAnchor, constant: 1).isActive = true
            
            let requestRLabelDesc = UILabel()
            requestFBBRPCard.addSubview(requestRLabelDesc)
            requestRLabelDesc.translatesAutoresizingMaskIntoConstraints = false
            requestRLabelDesc.text = "Request fixed broadband relocation"
            requestRLabelDesc.font = UIFont(name: String.defaultFontR, size: 13)
            requestRLabelDesc.leadingAnchor.constraint(equalTo: roundImageRequestR.trailingAnchor, constant: 8).isActive = true
            requestRLabelDesc.topAnchor.constraint(equalTo: requestRLabel.bottomAnchor, constant: 5).isActive = true
            requestRLabelDesc.trailingAnchor.constraint(equalTo: requestFBBRPCard.trailingAnchor, constant: -10).isActive = true
            requestRLabelDesc.numberOfLines = 0
            requestRLabelDesc.lineBreakMode = .byWordWrapping
            
            let rRArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
            requestFBBRPCard.addSubview(rRArrow)
            rRArrow.translatesAutoresizingMaskIntoConstraints = false
            rRArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
            rRArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
            rRArrow.topAnchor.constraint(equalTo: requestFBBRPCard.topAnchor, constant: 57).isActive = true
            rRArrow.trailingAnchor.constraint(equalTo: requestFBBRPCard.trailingAnchor, constant: -9).isActive = true
            scrollView.contentSize.height = 1550
        }else {
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
                let postParameters = ["action":"products","option":"byType","msisdn":defaultNumber,"productType":selectedOffer.uppercased(),"os":getAppVersion()]
                if let jsonParameters = try? JSONSerialization.data(withJSONObject: postParameters, options: .prettyPrinted){
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
                        
                        //creating a task to send post request
                        let task = URLSession.shared.dataTask(with: request as URLRequest){
                            data, response, error in
                            if error != nil {
                                print("error is: \(error!.localizedDescription)")
                                DispatchQueue.main.async {
                                    self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: error!.localizedDescription)
                                    self.stop_activity_loader()
                                }
                                return;
                            }
                            //passing the response
                            do {
                                //converting response to NSDictionary
                                let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                                //parsing the json
                                if let parseJSON = myJSON {
                                    var responseBody: String?
                                    responseBody = parseJSON["responseBody"] as! String?
                                    print("responseBody:: \(responseBody ?? "")")
                                    if let resBody = responseBody{
                                        let decrypt = self.decryptAsyncRequest(requestBody: resBody)
                                        print("Decrypted:: \(decrypt)")
                                        let decryptedResponseBody = self.convertToNSDictionary(decrypt: decrypt)
                                        print(decryptedResponseBody)
                                        var responseCode: Int!
                                        var responseMessage: NSArray!
                                        responseCode = decryptedResponseBody["RESPONSECODE"] as! Int
                                        responseMessage = decryptedResponseBody["RESPONSEMESSAGE"] as! NSArray?
                                        
                                        //Now store in user defaults for quick retrieval next time
                                        print("This is the key:: \(self.selectedOffer)")
                                        self.preferences.set(responseMessage, forKey: self.selectedOffer)
                                        print(responseCode)
                                        print(responseMessage)
                                        print("****************************************************")
                                        let getOffers = self.preferences.object(forKey: self.selectedOffer)
                                        print(getOffers ?? "")
                                        DispatchQueue.main.async {
                                            self.activity_loader.stopAnimating()
                                            if let array = getOffers as! NSArray?{
                                                let totalOffers = array.count
                                                let castTotalOffers = CGFloat(totalOffers)
                                                var topAnchorConstraint: CGFloat = 170
                                                var cardHeight: CGFloat = 145
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
                                                        offerNameLbl.text = self.offerName
                                                        offerNameLbl.font = UIFont(name: String.defaultFontB, size: 20)
                                                        offerNameLbl.topAnchor.constraint(equalTo: offerView.topAnchor, constant: 38).isActive = true
                                                        offerNameLbl.leadingAnchor.constraint(equalTo: offerIcon.trailingAnchor, constant: 8).isActive = true
                                                        offerNameLbl.trailingAnchor.constraint(equalTo: offerView.trailingAnchor, constant: -10).isActive = true
                                                        
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
                                                        //(cardHeight * castTotalOffers) + 620
                                                        self.scrollView.contentSize.height = CGFloat(totalOffers) + topAnchorConstraint + 70
                                                        
                                                        //Adding gesture
                                                        let touchRec = UITapGestureRecognizer(target: self, action: #selector(self.goToBuyBundle))
                                                        offerView.addGestureRecognizer(touchRec)
                                                    }
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

                }
                            }else{
                print("here naa")
                if let array = vodafonePdts as! NSArray?{
                    totalOffers = array.count
                    let castTotalOffers = CGFloat(totalOffers!)
                    var topAnchorConstraint: CGFloat = 170
                    var cardHeight: CGFloat = 145
                    for (index, obj) in array.enumerated() {
                        if let dict = obj as? NSDictionary{
                            offerName = dict.value(forKey: "NAME") as! String
                            offerPrice = dict.value(forKey: "PRICE") as! String
                            offerDescription = dict.value(forKey: "DESCRIPTION") as! String
                            offerPID = dict.value(forKey: "PID") as! String
                            offerUSSD = dict.value(forKey: "USSD") as! String
                            
                            //creating the uiview
                            let offerView = GesturesView()
                            offerView.offerVariable = offerName
                            offerView.offerPrice = offerPrice
                            offerView.offerDescription = offerDescription
                            offerView.offerPID = offerPID
                            offerView.offerUSSD = offerUSSD
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
                            offerView.layer.shadowOpacity = 0.1
                            offerView.tag = index
                            
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
                            offerPriceLbl.text = "Price GHS " + offerPrice!
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
                            self.scrollView.contentSize.height = CGFloat(totalOffers!) + topAnchorConstraint + 70
                            
                            
                            //Adding gesture
                            let touchRec = UITapGestureRecognizer.init(target: self, action: #selector(goToBuyBundle(_sender:)))
                            offerView.addGestureRecognizer(touchRec)
                            
                            
                        }
                    }
                }
                //No do some background check again
                if CheckInternet.Connection() {
                    makeAsync(offer: selectedOffer, msisdn: defaultNumber)
                }else{
                    print("No internet")
                }
            }
        }
        
        if AcctType == "PHONE_MOBILE_PRE_P" || AcctType == "BB_FIXED_PRE_P"{
            prePaidMenu()
        }else{
            prePaidMenu()
        }
    }

    // setups
    func setUpViewDisp(){
        
        let motherView = UIView()
        motherView.translatesAutoresizingMaskIntoConstraints = false
        motherView.backgroundColor = UIColor.clear
        view.addSubview(motherView)
        motherView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        motherView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        motherView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        motherView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
        motherView.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: motherView.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: motherView.safeTopAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: motherView.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: motherView.safeBottomAnchor).isActive = true
        scrollView.contentSize.height = 2000
        
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
        topImage.leadingAnchor.constraint(equalTo: motherView.leadingAnchor).isActive = true
        topImage.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        topImage.trailingAnchor.constraint(equalTo: motherView.trailingAnchor).isActive = true
        
        scrollView.addSubview(backButton)
        let backImage = UIImage(named: "leftArrow")
        let backTint = backImage?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(backTint, for: .normal)
        backButton.tintColor = UIColor.white
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 10).isActive = true
        backButton.addTarget(self, action: #selector(goToOffers), for: .touchUpInside)
        
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
        lblMenu.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -14).isActive = true
        
        //Selected Offer
        let lblSelectedOffer = UILabel()
        scrollView.addSubview(lblSelectedOffer)
        lblSelectedOffer.translatesAutoresizingMaskIntoConstraints = false
        lblSelectedOffer.textColor = UIColor.white
        lblSelectedOffer.textAlignment = .center
        lblSelectedOffer.font = UIFont(name: String.defaultFontR, size: 31)
        if selectedOffer == "FBB" {
            lblSelectedOffer.text = "Fixed Broadband"
        }else if selectedOffer == "Data" {
            lblSelectedOffer.text = "Data Bundles"
        }
        else{
                lblSelectedOffer.text = selectedOffer
            }
            
        
        lblSelectedOffer.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        lblSelectedOffer.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 70).isActive = true
        lblSelectedOffer.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        lblSelectedOffer.numberOfLines = 0
        lblSelectedOffer.lineBreakMode = .byWordWrapping
    }
    
    //Function to dial vodafone cash dial
    @objc func displayVodafoneCashDialler(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Services", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "DialVodaCashViewController")
        self.addChildViewController(moveTo)
        moveTo.view.frame = self.view.frame
        self.view.addSubview(moveTo.view)
        moveTo.didMove(toParentViewController: self)
        //        present(moveTo!, animated: true, completion: nil)
    }
    
    //Function to vodafone cash agent locator
    @objc func displayVodafoneCashAgentLocator(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "StoreLocator", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "StoreLocatorVc")
        present(moveTo, animated: true, completion: nil)
    }
    
    //Function make USSD call
    @objc func dialUSSD(_sender: UITapGestureRecognizer){
        let ussdCode = "*900#"
        let url = URL(string: "telprompt://\(ussdCode)")
        UIApplication.shared.open(url!)
    }
    //Request broadband
    @objc func requestBroadband(_sender: UITapGestureRecognizer){
        let FBBURL = String.MVA_FBBURL
        UIApplication.shared.open(URL(string: "\(FBBURL)")! as URL, options: [:], completionHandler: nil)
    }

    //broadband balance
    @objc func goToCheckFBB(_sender: UITapGestureRecognizer){
//        let moveTo = storyboard?.instantiateViewController(withIdentifier: "checkFBBBalance")
        let storyboard = UIStoryboard(name: "FBB", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "checkFBBBalance")
        present(moveTo, animated: true, completion: nil)
    }
    
    //FBB Move
    @objc func goToFBBMove(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "FBB", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "fbbMove")
        present(moveTo, animated: true, completion: nil)
    }
    
    //Pay FBB with Voucher
    @objc func goToFBBPayV(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "FBB", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "fbbPayVoucherVc")
        present(moveTo, animated: true, completion: nil)
    }
    
    //Broadband Packages
    @objc func goToBBPackages(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "FBB", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "FBBPackages")
        present(moveTo, animated: true, completion: nil)
    }
    
    //Credit Transfer
    @objc func goToCreditTrans(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Services", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "creditTransferVc")
        present(moveTo, animated: true, completion: nil)
    }
    
    //Credit Transfer
    @objc func goToExpressPay(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "FBB", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "FBBPayExpressPay")
        present(moveTo, animated: true, completion: nil)
    }
    
    //Sim Swap
    @objc func showSimSwapModal(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Services", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "simSwapModal")
        self.addChildViewController(moveTo)
        moveTo.view.frame = self.view.frame
        self.view.addSubview(moveTo.view)
        moveTo.didMove(toParentViewController: self)
    }
    
    //Book Appointment
    @objc func goToAppointment(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Services", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "appointmentsVc")
        present(moveTo, animated: true, completion: nil)
    }
    
    //Function to go to buy offer
    @objc func goToBuyBundle(_sender: UITapGestureRecognizer){
        //        print(array[sender.view!.tag])
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
    
    //Function to go to Fleet Tracking
    @objc func goToFleetTracking(_sender: UITapGestureRecognizer){
        //        print(array[sender.view!.tag])
        let storyboard = UIStoryboard(name: "OffersExtras", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "fleetTracking") as? fleetTracking else {return}
        
        self.addChildViewController(moveTo)
        moveTo.view.frame = self.view.frame
        self.view.addSubview(moveTo.view)
        moveTo.didMove(toParentViewController: self)
    }
    
    //Function to go to Fleet Packages
    @objc func goToFleetPackages(_sender: UITapGestureRecognizer){
        //        print(array[sender.view!.tag])
        let storyboard = UIStoryboard(name: "OffersExtras", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "fleetPackages") as? fleetPackages else {return}
        
        self.addChildViewController(moveTo)
        moveTo.view.frame = self.view.frame
        self.view.addSubview(moveTo.view)
        moveTo.didMove(toParentViewController: self)
    }
    
    func makeAsync(offer:String, msisdn:String){
        let request_api = URL(string: String.offers)
        let request = NSMutableURLRequest(url: request_api!)
        request.httpMethod = "POST"
        
        let postParameters = ["action":"products","option":"byType","msisdn":msisdn,"productType":offer.uppercased(),"os":getAppVersion()]
        
        if let jsonParameters = try? JSONSerialization.data(withJSONObject: postParameters, options: .prettyPrinted){
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
                            var responseBody: String?
                            responseBody = parseJSON["responseBody"] as! String?
                            print("responseBody:: \(responseBody ?? "")")
                            if let resBody = responseBody{
                                let decrypt = self.decryptAsyncRequest(requestBody: resBody)
                                print("Decrypted:: \(decrypt)")
                                let decryptedResponseBody = self.convertToNSDictionary(decrypt: decrypt)
                                print(decryptedResponseBody)
                                
                                var responseCode: Int!
                                var responseMessage: NSArray!
                                
                                responseCode = decryptedResponseBody["RESPONSECODE"] as! Int
                                responseMessage = decryptedResponseBody["RESPONSEMESSAGE"] as! NSArray?
                                
                                let newTotalOffers = responseMessage.count
                                print("new count \(newTotalOffers)")
                                
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
                                                self.offerName = dict.value(forKey: "NAME") as? String
                                                self.offerPrice = dict.value(forKey: "PRICE") as! String
                                                self.offerDescription = dict.value(forKey: "DESCRIPTION") as! String
                                                self.offerPID = dict.value(forKey: "PID") as! String
                                                self.offerUSSD = dict.value(forKey: "USSD") as! String
                                                
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
                                                offerNameLbl.text = self.offerName
                                                offerNameLbl.font = UIFont(name: String.defaultFontB, size: 20)
                                                offerNameLbl.topAnchor.constraint(equalTo: offerView.topAnchor, constant: 38).isActive = true
                                                offerNameLbl.leadingAnchor.constraint(equalTo: offerIcon.trailingAnchor, constant: 8).isActive = true
                                                offerNameLbl.trailingAnchor.constraint(equalTo: offerView.trailingAnchor, constant: -10).isActive = true
                                                
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
                                                //(cardHeight * castTotalOffers) + 620
                                                self.scrollView.contentSize.height = CGFloat(totalOffers) + topAnchorConstraint + 70
                                                
                                                //Adding gesture
                                                let touchRec = UITapGestureRecognizer(target: self, action: #selector(self.goToBuyBundle))
                                                offerView.addGestureRecognizer(touchRec)
                                                
                                            }
                                        }
                                    }
                                }
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
        
    }

}
