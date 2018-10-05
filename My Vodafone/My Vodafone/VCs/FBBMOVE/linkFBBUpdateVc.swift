//
//  linkFBBUpdateVc.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 05/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class linkFBBUpdateVc: baseViewControllerM {

    fileprivate var lblUserIDTop1: NSLayoutConstraint?
    fileprivate var lblUserIDTop2: NSLayoutConstraint?
    fileprivate var cardViewHeight1: NSLayoutConstraint?
    fileprivate var cardViewHeight2: NSLayoutConstraint?
    var bbUserID: String?
    var fixedLineNo: String?
    
    var shareStatusMessage: String?
    var shareStatus: Int?
    var C_SUB_ADSL_SHARE_VALIDITY: String?
    var C_SUB_ADSL_SHARE: String?
    var C_SUB_ADSL_SHARE_DATE: String?
    
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
    
    let txtFxLineNo = UITextField()
    let txtUserID = UITextField()
    let txtLinkedNo = UITextField()
    let btnUpdate = UIButton()
    let btnProceed = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground
        setUpViewsFBBLUpdate()
        hideKeyboardWhenTappedAround()
        
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
        
    }

    func setUpViewsFBBLUpdate(){
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
        backButton.addTarget(self, action: #selector(goToFBBMove), for: .touchUpInside)
        
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
        lblSelectedOffer.text = "Broadband & Mobile \nLinking"
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
        cardViewHeight2 = cardView.heightAnchor.constraint(equalToConstant: 580)
        cardViewHeight1?.isActive = true
        
        let lblUserID = UILabel()
        scrollView.addSubview(lblUserID)
        lblUserID.translatesAutoresizingMaskIntoConstraints = false
        lblUserID.text = "Broadband User ID"
        lblUserID.font = UIFont(name: String.defaultFontR, size: 16)
        lblUserID.textColor = UIColor.black
        lblUserID.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblUserIDTop1 = lblUserID.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 30)
        lblUserIDTop2 = lblUserID.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 80)
        lblUserIDTop1?.isActive = true
        
        
        scrollView.addSubview(txtUserID)
        txtUserID.translatesAutoresizingMaskIntoConstraints = false
        txtUserID.font = UIFont(name: String.defaultFontR, size: 16)
        txtUserID.backgroundColor = UIColor.white
        txtUserID.borderStyle = .roundedRect
        txtUserID.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtUserID.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtUserID.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtUserID.topAnchor.constraint(equalTo: lblUserID.bottomAnchor, constant: 10).isActive = true
        if let userID = bbUserID {
            txtUserID.text = userID
        }
        
        let lblFxLineNo = UILabel()
        scrollView.addSubview(lblFxLineNo)
        lblFxLineNo.translatesAutoresizingMaskIntoConstraints = false
        lblFxLineNo.text = "Broadband Fixed Line Number"
        lblFxLineNo.font = UIFont(name: String.defaultFontR, size: 16)
        lblFxLineNo.textColor = UIColor.black
        lblFxLineNo.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblFxLineNo.topAnchor.constraint(equalTo: txtUserID.bottomAnchor, constant: 30).isActive = true
        
        
        
        scrollView.addSubview(txtFxLineNo)
        txtFxLineNo.translatesAutoresizingMaskIntoConstraints = false
        txtFxLineNo.font = UIFont(name: String.defaultFontR, size: 16)
        txtFxLineNo.backgroundColor = UIColor.white
        txtFxLineNo.borderStyle = .roundedRect
        txtFxLineNo.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtFxLineNo.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtFxLineNo.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtFxLineNo.topAnchor.constraint(equalTo: lblFxLineNo.bottomAnchor, constant: 10).isActive = true
        if let fxNo = fixedLineNo {
            txtFxLineNo.text = fxNo
        }
        
        
        let lblLinkedNo = UILabel()
        scrollView.addSubview(lblLinkedNo)
        lblLinkedNo.translatesAutoresizingMaskIntoConstraints = false
        lblLinkedNo.text = "Linked Number"
        lblLinkedNo.font = UIFont(name: String.defaultFontR, size: 16)
        lblLinkedNo.textColor = UIColor.black
        lblLinkedNo.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblLinkedNo.topAnchor.constraint(equalTo: txtFxLineNo.bottomAnchor, constant: 30).isActive = true
        
        
        
        scrollView.addSubview(txtLinkedNo)
        txtLinkedNo.translatesAutoresizingMaskIntoConstraints = false
        txtLinkedNo.font = UIFont(name: String.defaultFontR, size: 16)
        txtLinkedNo.backgroundColor = UIColor.white
        txtLinkedNo.borderStyle = .roundedRect
        txtLinkedNo.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtLinkedNo.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtLinkedNo.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtLinkedNo.topAnchor.constraint(equalTo: lblLinkedNo.bottomAnchor, constant: 10).isActive = true
        txtLinkedNo.keyboardType = .phonePad
        if let linkedNo = C_SUB_ADSL_SHARE {
            txtLinkedNo.text = linkedNo
        }
        
        scrollView.addSubview(btnUpdate)
        btnUpdate.translatesAutoresizingMaskIntoConstraints = false
        btnUpdate.backgroundColor = UIColor.vodaRed
        btnUpdate.setTitle("Update", for: .normal)
        btnUpdate.setTitleColor(UIColor.white, for: .normal)
        btnUpdate.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnUpdate.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        btnUpdate.topAnchor.constraint(equalTo: txtLinkedNo.bottomAnchor, constant: 40).isActive = true
        btnUpdate.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        btnUpdate.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnUpdate.addTarget(self, action: #selector(updateRecords), for: .touchUpInside)
        
        scrollView.addSubview(btnProceed)
        btnProceed.translatesAutoresizingMaskIntoConstraints = false
        btnProceed.backgroundColor = UIColor.grayButton
        btnProceed.setTitle("Proceed to move data", for: .normal)
        btnProceed.setTitleColor(UIColor.white, for: .normal)
        btnProceed.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnProceed.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        btnProceed.topAnchor.constraint(equalTo: btnUpdate.bottomAnchor, constant: 10).isActive = true
        btnProceed.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        btnProceed.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnProceed.addTarget(self, action: #selector(proceed), for: .touchUpInside)
        
        //activity loader
        scrollView.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.topAnchor.constraint(equalTo: txtLinkedNo.bottomAnchor, constant: 40).isActive = true
        
        scrollView.contentSize.height = view.frame.size.height + cardView.frame.size.height
    }
    
    @objc func goToFBBMove(){
        let storyboard = UIStoryboard(name: "FBB", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "fbbMove")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func updateRecords(){
        let userID = txtUserID.text
        let bbActKey = txtFxLineNo.text
        let linkedNo = txtLinkedNo.text
        //check if all fields are present
        if userID == "" || bbActKey == "" || linkedNo == "" {
            lblUserIDTop1?.isActive = false
            lblUserIDTop2?.isActive = true
            cardViewHeight1?.isActive = false
            cardViewHeight2?.isActive = true
            
            let errorView = UIView()
            self.view.addSubview(errorView)
            errorView.translatesAutoresizingMaskIntoConstraints = false
            errorView.backgroundColor = UIColor.darkGray
            errorView.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
            errorMessage.text = "All fields are required"
            errorMessage.textColor = UIColor.white
            errorMessage.font = UIFont(name: String.defaultFontR, size: 18)
            errorMessage.numberOfLines = 0
            errorMessage.lineBreakMode = .byWordWrapping
            errorMessage.leadingAnchor.constraint(equalTo: errorImage.trailingAnchor, constant: 10).isActive = true
            errorMessage.topAnchor.constraint(equalTo: errorView.topAnchor, constant: 10).isActive = true
            errorMessage.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -1).isActive = true
        }else{
            // check if permitted to update
            if shareStatus != 0 {
                errorDialog(errorMssg: shareStatusMessage!)
            }else{
                //check for internet
                if !CheckInternet.Connection(){
                    displayNoInternet()
                }else{
                    //TODO go ahead and update
                }
            }
        }
    }
    
    @objc func proceed(){
        let userID = txtUserID.text
        let bbNo = txtFxLineNo.text
        let linkedNo = txtFxLineNo.text
        
        //check if internet exist
        if !CheckInternet.Connection(){
            let storyboard = UIStoryboard(name: "Support", bundle: nil)
            let moveTo = storyboard.instantiateViewController(withIdentifier: "NointernetViewController") as! NointernetViewController
            
            self.addChildViewController(moveTo)
            moveTo.view.frame = self.view.frame
            self.view.addSubview(moveTo.view)
            moveTo.didMove(toParentViewController: self)
        }else{
            if userID == "" || bbNo == "" || linkedNo == "" {
                errorDialog(errorMssg: "All fields are required")
            }else{
                // move to sharing screen
                let storyboard = UIStoryboard(name: "FBB", bundle: nil)
                guard let moveTo = storyboard.instantiateViewController(withIdentifier: "fbbShareVc") as? fbbShareVc else{return}
                moveTo.userID = userID
                moveTo.bbNo = bbNo
                moveTo.linkedNo = linkedNo
                present(moveTo, animated: true, completion: nil)
            }
        }
    }
    
    func errorDialog(errorMssg: String){
        let errorView = UIView()
        self.view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.backgroundColor = UIColor.darkGray
        errorView.heightAnchor.constraint(equalToConstant: 55).isActive = true
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
        errorMessage.topAnchor.constraint(equalTo: errorView.topAnchor, constant: 5).isActive = true
        errorMessage.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -1).isActive = true
    }

}
