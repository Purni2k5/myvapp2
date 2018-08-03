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
    var offerName: String!
    
    let browseLabel = UILabel()
    
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
    
    //create card view
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.heightAnchor.constraint(equalToConstant: 120).isActive = true
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Change view's background colour
        view.backgroundColor = UIColor.grayBackground
        view.addSubview(scrollView)
        
        setUpViews()
        
        print("transfered:: \(selectedOffer)")
       
        let vodafonePdts = preferences.object(forKey: selectedOffer)
        let UserData = preferences.object(forKey: "responseData") as! NSDictionary
        let defaultNumber = UserData["Contact"] as! String
//        print("voda:: \(selectedOffer)")
        //Check if offer is dynamic or not
        if selectedOffer == "Vodafone Cash" {
            let vodaCashMenu = cardView
            scrollView.addSubview(vodaCashMenu)
            vodaCashMenu.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 20).isActive = true
            vodaCashMenu.topAnchor.constraint(equalTo: superView.topAnchor, constant: 260).isActive = true
            vodaCashMenu.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -20).isActive = true
            vodaCashMenu.layer.cornerRadius = 2
            vodaCashMenu.layer.shadowOffset = CGSize(width: 0, height: 5)
            vodaCashMenu.layer.shadowColor = UIColor.black.cgColor
            vodaCashMenu.layer.shadowOpacity = 0.1
            
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
            
            //Vodafone cash Agent
            let vodaCashAgent = UIView()
            scrollView.addSubview(vodaCashAgent)
            vodaCashAgent.translatesAutoresizingMaskIntoConstraints = false
            vodaCashAgent.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 20).isActive = true
            vodaCashAgent.topAnchor.constraint(equalTo: vodaCashMenu.bottomAnchor, constant: 50).isActive = true
            vodaCashAgent.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -20).isActive = true
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
            
            //Adding gestures
            let vodaCashMenuRec = UITapGestureRecognizer(target: self, action: #selector(displayVodafoneCashDialler))
            vodaCashMenu.addGestureRecognizer(vodaCashMenuRec)
            
            
            
        }else if selectedOffer == "Services"{
            let creditTransferCard = cardView
            scrollView.addSubview(creditTransferCard)
            creditTransferCard.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 20).isActive = true
            creditTransferCard.topAnchor.constraint(equalTo: superView.topAnchor, constant: 260).isActive = true
            creditTransferCard.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -20).isActive = true
            creditTransferCard.layer.cornerRadius = 2
            creditTransferCard.layer.shadowOffset = CGSize(width: 0, height: 5)
            creditTransferCard.layer.shadowColor = UIColor.black.cgColor
            creditTransferCard.layer.shadowOpacity = 0.1
            
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
            simSwapCard.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 20).isActive = true
            simSwapCard.topAnchor.constraint(equalTo: creditTransferCard.bottomAnchor, constant: 20).isActive = true
            simSwapCard.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -20).isActive = true
            simSwapCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
            simSwapCard.backgroundColor = UIColor.white
            //transforming it a card
            simSwapCard.layer.cornerRadius = 2
            simSwapCard.layer.shadowOffset = CGSize(width: 0, height: 5)
            simSwapCard.layer.shadowColor = UIColor.black.cgColor
            simSwapCard.layer.shadowOpacity = 0.1
            
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
            bookAppoimentCard.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 20).isActive = true
            bookAppoimentCard.topAnchor.constraint(equalTo: simSwapCard.bottomAnchor, constant: 20).isActive = true
            bookAppoimentCard.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -20).isActive = true
            bookAppoimentCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
            bookAppoimentCard.backgroundColor = UIColor.white
            //transforming it a card
            bookAppoimentCard.layer.cornerRadius = 2
            bookAppoimentCard.layer.shadowOffset = CGSize(width: 0, height: 5)
            bookAppoimentCard.layer.shadowColor = UIColor.black.cgColor
            bookAppoimentCard.layer.shadowOpacity = 0.1
            
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
        }else if selectedOffer == "FBB" {
            
            superView.addSubview(browseLabel)
            browseLabel.translatesAutoresizingMaskIntoConstraints = false
            browseLabel.text = "Browse"
            browseLabel.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 20).isActive = true
            browseLabel.topAnchor.constraint(equalTo: superView.topAnchor, constant: 200).isActive = true
            browseLabel.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -20).isActive = true
            
            scrollView.contentSize.height = 1000
            
        }else{
            
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
                                                self.offerName = dict.value(forKey: "NAME") as! String
                                                let offerPrice = dict.value(forKey: "PRICE") as! String
                                                let offerDescription = dict.value(forKey: "DESCRIPTION") as! String
                                                
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
                                                offerNameLbl.text = self.offerName
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
                                                
                                                //Adding gesture
                                                let touchRec = UITapGestureRecognizer(target: self, action: #selector(self.goToBuyBundle))
                                                offerView.addGestureRecognizer(touchRec)
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
                            offerName = dict.value(forKey: "NAME") as! String
                            let offerPrice = dict.value(forKey: "PRICE") as! String
                            let offerDescription = dict.value(forKey: "DESCRIPTION") as! String
                            
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
                            
                            
                            //Adding gesture
//                            let touchRec = UITapGestureRecognizer(target: self, action: goToBuyBundle(_sender: self, offerNanni: "KooNimo"))
//                            offerView.addGestureRecognizer(touchRec)
                            
                            
                        }
                    }
                }
                //No do some background check again
                makeAsync(offer: selectedOffer, msisdn: defaultNumber)
                
            }
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
                                            self.offerName = dict.value(forKey: "NAME") as? String
                                            let offerPrice = dict.value(forKey: "PRICE") as! String
                                            let offerDescription = dict.value(forKey: "DESCRIPTION") as! String
                                            
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
                                            offerNameLbl.text = self.offerName
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
                                            
                                            //Adding gesture
                                            let touchRec = UITapGestureRecognizer(target: self, action: #selector(self.goToBuyBundle))
                                            offerView.addGestureRecognizer(touchRec)
                                            
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
    
    //Function to dial vodafone cash dial
    @objc func displayVodafoneCashDialler(_sender: UITapGestureRecognizer){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "DialVodaCashViewController")
        self.addChildViewController(moveTo!)
        moveTo!.view.frame = self.view.frame
        self.view.addSubview(moveTo!.view)
        moveTo!.didMove(toParentViewController: self)
//        present(moveTo!, animated: true, completion: nil)
    }
    
    //Function to go to buy offer
    @objc func goToBuyBundle(_sender: UITapGestureRecognizer, offerNanni: String){
        guard let moveTo = storyboard?.instantiateViewController(withIdentifier: "BuyOfferViewController") as? BuyOfferViewController else {return}
        moveTo.selectedOffer = offerNanni
        moveTo.selectedOfferPrice = "2GS"
        moveTo.selectedOfferDesc = "Hurray"
        self.addChildViewController(moveTo)
        moveTo.view.frame = self.view.frame
        self.view.addSubview(moveTo.view)
        moveTo.didMove(toParentViewController: self)
    }
    

    func setUpViews(){
        //Scroll view
        scrollView.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        scrollView.addSubview(appBackImage)
        scrollView.addSubview(viewButton)
        scrollView.addSubview(hamburgerButton)
        scrollView.addSubview(menuLabel)
        scrollView.addSubview(selectedOfferLabel)
        scrollView.addSubview(browseLabel)
        
        
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
