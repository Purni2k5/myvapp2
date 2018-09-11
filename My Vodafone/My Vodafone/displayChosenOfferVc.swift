//
//  displayChosenOfferVc.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 29/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class displayChosenOfferVc: baseViewControllerM {

    var selectedOffer: String?
    let preferences = UserDefaults.standard
    var totalOffers:Int?
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
    
    //create card view
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.heightAnchor.constraint(equalToConstant: 120).isActive = true
        var offerVariable: String?
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground
        setUpViewDisp()
        checkConnection()
        if let sOffer = selectedOffer{
            let vodafonePdts = preferences.object(forKey: sOffer)
        }
        let UserData = preferences.object(forKey: "responseData") as! NSDictionary
        let defaultNumber = UserData["Contact"] as! String
        
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
        } else if selectedOffer == "FBB" {
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
        }
        
        if AcctType == "PHONE_MOBILE_PRE_P" {
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
        topImage.image = UIImage(named: "bg2")
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
        if let selOffer = selectedOffer {
            if selOffer == "FBB"{
                lblSelectedOffer.text = "Fixed Broadband"
            }else{
                lblSelectedOffer.text = selOffer
            }
            
        }
        lblSelectedOffer.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        lblSelectedOffer.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 70).isActive = true
        lblSelectedOffer.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        lblSelectedOffer.numberOfLines = 0
        lblSelectedOffer.lineBreakMode = .byWordWrapping
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
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "checkFBBBalance")
        present(moveTo!, animated: true, completion: nil)
    }
    
    //FBB Move
    @objc func goToFBBMove(_sender: UITapGestureRecognizer){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "fbbMove")
        present(moveTo!, animated: true, completion: nil)
    }
    
    //Pay FBB with Voucher
    @objc func goToFBBPayV(_sender: UITapGestureRecognizer){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "fbbPayVoucherVc")
        present(moveTo!, animated: true, completion: nil)
    }
    
    //Broadband Packages
    @objc func goToBBPackages(_sender: UITapGestureRecognizer){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "FBBPackages")
        present(moveTo!, animated: true, completion: nil)
    }
    
    //Credit Transfer
    @objc func goToCreditTrans(_sender: UITapGestureRecognizer){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "creditTransferVc")
        present(moveTo!, animated: true, completion: nil)
    }

}
