//
//  creditTransferVc.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 10/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class creditTransferVc: baseViewControllerM {

    fileprivate var lblUserIDTop1: NSLayoutConstraint?
    fileprivate var lblUserIDTop2: NSLayoutConstraint?
    fileprivate var cardViewHeight1: NSLayoutConstraint?
    fileprivate var cardViewHeight2: NSLayoutConstraint?
    
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
//        view.heightAnchor.constraint(equalToConstant: 480).isActive = true
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
    
    let txtRecipient = UITextField()
    let txtAmt = UITextField()
    let txtConfAmt = UITextField()
    let txtPin = UITextField()
    let btnTransfer = UIButton()
    
    let lblTransferRecipient = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground
        hideKeyboardWhenTappedAround()
        setUpViewsCreditT()
        
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        username = UserData["Username"] as? String
        
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        txtRecipient.addTarget(self, action: #selector(checkTxtInputs), for: .touchUpInside)
        txtAmt.addTarget(self, action: #selector(checkTxtInputs), for: .touchUpInside)
        txtConfAmt.addTarget(self, action: #selector(checkTxtInputs), for: .touchUpInside)
        txtPin.addTarget(self, action: #selector(checkTxtInputs), for: .touchUpInside)
    }
    
    func setUpViewsCreditT(){
        view.addSubview(scrollView)
        
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
        backButton.addTarget(self, action: #selector(goToServices), for: .touchUpInside)
        
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
        lblSelectedOffer.text = "Credit Transfer"
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
        cardViewHeight1 = cardView.heightAnchor.constraint(equalToConstant: 480)
        cardViewHeight2 = cardView.heightAnchor.constraint(equalToConstant: 520)
        cardViewHeight1?.isActive = true
        
        scrollView.addSubview(lblTransferRecipient)
        lblTransferRecipient.translatesAutoresizingMaskIntoConstraints = false
        lblTransferRecipient.text = "Transfer Recipiet"
        lblTransferRecipient.font = UIFont(name: String.defaultFontR, size: 16)
        lblTransferRecipient.textColor = UIColor.black
        lblTransferRecipient.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblUserIDTop1 = lblTransferRecipient.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20)
        lblUserIDTop2 = lblTransferRecipient.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 80)
        lblUserIDTop1?.isActive = true
        
        
        scrollView.addSubview(txtRecipient)
        txtRecipient.translatesAutoresizingMaskIntoConstraints = false
        txtRecipient.font = UIFont(name: String.defaultFontR, size: 16)
        txtRecipient.backgroundColor = UIColor.white
        txtRecipient.borderStyle = .roundedRect
        txtRecipient.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtRecipient.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtRecipient.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtRecipient.topAnchor.constraint(equalTo: lblTransferRecipient.bottomAnchor, constant: 10).isActive = true
        txtRecipient.keyboardType = .numberPad
        txtRecipient.addTarget(self, action: #selector(checkTxtInputs), for: .editingChanged)
        txtRecipient.addTarget(self, action: #selector(checkTxtInputs), for: .editingChanged)
        
        let lblAmt = UILabel()
        scrollView.addSubview(lblAmt)
        lblAmt.translatesAutoresizingMaskIntoConstraints = false
        lblAmt.text = "Transfer Amount"
        lblAmt.font = UIFont(name: String.defaultFontR, size: 16)
        lblAmt.textColor = UIColor.black
        lblAmt.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblAmt.topAnchor.constraint(equalTo: txtRecipient.bottomAnchor, constant: 20).isActive = true
        
        scrollView.addSubview(txtAmt)
        txtAmt.translatesAutoresizingMaskIntoConstraints = false
        txtAmt.backgroundColor = UIColor.white
        txtAmt.borderStyle = .roundedRect
        txtAmt.font = UIFont(name: String.defaultFontR, size: 16)
        txtAmt.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtAmt.topAnchor.constraint(equalTo: lblAmt.bottomAnchor, constant: 10).isActive = true
        txtAmt.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtAmt.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtAmt.keyboardType = .numberPad
        txtAmt.addTarget(self, action: #selector(checkTxtInputs), for: .editingChanged)
        
        let lblConfirmAmt = UILabel()
        scrollView.addSubview(lblConfirmAmt)
        lblConfirmAmt.translatesAutoresizingMaskIntoConstraints = false
        lblConfirmAmt.text = "Confirm Transfer Amount"
        lblConfirmAmt.textColor = UIColor.black
        lblConfirmAmt.font = UIFont(name: String.defaultFontR, size: 16)
        lblConfirmAmt.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblConfirmAmt.topAnchor.constraint(equalTo: txtAmt.bottomAnchor, constant: 20).isActive = true
        
        scrollView.addSubview(txtConfAmt)
        txtConfAmt.translatesAutoresizingMaskIntoConstraints = false
        txtConfAmt.backgroundColor = UIColor.white
        txtConfAmt.font = UIFont(name: String.defaultFontR, size: 16)
        txtConfAmt.borderStyle = .roundedRect
        txtConfAmt.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtConfAmt.topAnchor.constraint(equalTo: lblConfirmAmt.bottomAnchor, constant: 10).isActive = true
        txtConfAmt.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtConfAmt.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtConfAmt.keyboardType = .numberPad
        txtConfAmt.addTarget(self, action: #selector(checkTxtInputs), for: .editingChanged)
        
        let lblPin = UILabel()
        scrollView.addSubview(lblPin)
        lblPin.translatesAutoresizingMaskIntoConstraints = false
        lblPin.font = UIFont(name: String.defaultFontR, size: 16)
        lblPin.textColor = UIColor.black
        lblPin.text = "Pin"
        lblPin.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblPin.topAnchor.constraint(equalTo: txtConfAmt.bottomAnchor, constant: 20).isActive = true
        
        scrollView.addSubview(txtPin)
        txtPin.translatesAutoresizingMaskIntoConstraints = false
        txtPin.backgroundColor = UIColor.white
        txtPin.font = UIFont(name: String.defaultFontR, size: 16)
        txtPin.borderStyle = .roundedRect
        txtPin.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtPin.topAnchor.constraint(equalTo: lblPin.bottomAnchor, constant: 10).isActive = true
        txtPin.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtPin.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtPin.keyboardType = .numberPad
        txtPin.addTarget(self, action: #selector(checkTxtInputs), for: .editingChanged)
        
        scrollView.addSubview(btnTransfer)
        btnTransfer.translatesAutoresizingMaskIntoConstraints = false
        btnTransfer.backgroundColor = UIColor.grayButton
        btnTransfer.isEnabled = false
        btnTransfer.setTitle("Transfer Now", for: .normal)
        btnTransfer.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnTransfer.setTitleColor(UIColor.white, for: .normal)
        btnTransfer.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnTransfer.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        btnTransfer.topAnchor.constraint(equalTo: txtPin.bottomAnchor, constant: 30).isActive = true
        btnTransfer.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        btnTransfer.addTarget(self, action: #selector(transfer), for: .touchUpInside)
        
        scrollView.contentSize.height = view.frame.size.height * 2
    }
    
    @objc func checkTxtInputs(){
        if txtRecipient.text != "" && txtAmt.text != "" && txtConfAmt.text != "" && txtPin.text != "" && txtAmt.text == txtConfAmt.text {
            btnTransfer.isEnabled = true
            btnTransfer.backgroundColor = UIColor.vodaRed
            
        }else{
            btnTransfer.isEnabled = false
            btnTransfer.backgroundColor = UIColor.grayButton
            
        }
    }

    func errorDialog(errorMssg: String){
        let errorView = UIView()
        self.view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.backgroundColor = UIColor.darkGray
        errorView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        errorView.leadingAnchor.constraint(equalTo: self.cardView.leadingAnchor, constant: 20).isActive = true
        errorView.topAnchor.constraint(equalTo: self.cardView.topAnchor, constant: 10).isActive = true
        errorView.trailingAnchor.constraint(equalTo: self.cardView.trailingAnchor, constant: -20).isActive = true
        //image
        let errorImage = UIImageView(image: #imageLiteral(resourceName: "info"))
        errorView.addSubview(errorImage)
        errorImage.translatesAutoresizingMaskIntoConstraints = false
        errorImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        errorImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        errorImage.leadingAnchor.constraint(equalTo: errorView.leadingAnchor, constant: 10).isActive = true
        errorImage.topAnchor.constraint(equalTo: errorView.topAnchor, constant: 10).isActive = true
        
        //error message
        let errorMessage = UILabel()
        errorView.addSubview(errorMessage)
        errorMessage.translatesAutoresizingMaskIntoConstraints = false
        errorMessage.text = errorMssg
        errorMessage.textColor = UIColor.white
        errorMessage.font = UIFont(name: String.defaultFontR, size: 18)
        errorMessage.numberOfLines = 0
        errorMessage.lineBreakMode = .byWordWrapping
        errorMessage.leadingAnchor.constraint(equalTo: errorImage.trailingAnchor, constant: 10).isActive = true
        errorMessage.topAnchor.constraint(equalTo: errorView.topAnchor, constant: 15).isActive = true
        errorMessage.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -1).isActive = true
    }
    
    @objc func transfer(){
        let recipient = txtRecipient.text
        let amt = txtAmt.text
        let pin = txtPin.text
        
        let ussd = "*116*" + recipient! + "*" + amt! + "*" + pin! + "#"
        print("ussd \(ussd)")
        let url = URL(string: "telprompt://\(ussd)")
        UIApplication.shared.open(url!)
    }
    
    
    @objc func goToServices(){
        let storyboard = UIStoryboard(name: "OffersExtras", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "displayChosenOfferVc") as? displayChosenOfferVc else {return}
        moveTo.selectedOffer = "Services"
        present(moveTo, animated: true, completion: nil)
    }
}
