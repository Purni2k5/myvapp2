//
//  fbbMove.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 31/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class fbbMove: baseViewControllerM {

    fileprivate var lblUserIDTop1: NSLayoutConstraint?
    fileprivate var lblUserIDTop2: NSLayoutConstraint?
    
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
    
    let txtFxLineNo = UITextField()
    let txtUserID = UITextField()
    let btnCheck = UIButton()
    
    var username: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground
        setUpViewsFbbMove()
        hideKeyboardWhenTappedAround()
        
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        username = UserData["Username"] as? String
        
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        txtFxLineNo.addTarget(self, action: #selector(checkTxtInputs), for: .editingChanged)
        checkTxtInputs()
    }
    
    func setUpViewsFbbMove(){
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
        lblSelectedOffer.text = "Fixed Broadband"
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
        
        let lblUserID = UILabel()
        scrollView.addSubview(lblUserID)
        lblUserID.translatesAutoresizingMaskIntoConstraints = false
        lblUserID.text = "Broadband User ID"
        lblUserID.font = UIFont(name: String.defaultFontR, size: 16)
        lblUserID.textColor = UIColor.black
        lblUserID.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblUserIDTop1 = lblUserID.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20)
        lblUserIDTop2 = lblUserID.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 40)
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
        txtUserID.addTarget(self, action: #selector(checkTxtInputs), for: .editingChanged)
        let getUserID = preference.object(forKey: "FBBUSERID")
        if let getPrefUserID = getUserID {
            txtUserID.text = getPrefUserID as? String
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
        txtFxLineNo.addTarget(self, action: #selector(checkTxtInputs), for: .editingChanged)
        let getUserFxNo = preference.object(forKey: "FBBACTKEY")
        if let getPrefUserFxNo = getUserFxNo {
            txtFxLineNo.text = getPrefUserFxNo as? String
        }
        
        //Button to check balance
        
        scrollView.addSubview(btnCheck)
        btnCheck.translatesAutoresizingMaskIntoConstraints = false
        btnCheck.backgroundColor = UIColor.grayButton
        btnCheck.setTitle("Next", for: .normal)
        btnCheck.setTitleColor(UIColor.white, for: .normal)
        btnCheck.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnCheck.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        btnCheck.topAnchor.constraint(equalTo: txtFxLineNo.bottomAnchor, constant: 40).isActive = true
        btnCheck.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        btnCheck.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnCheck.isEnabled = false
        btnCheck.addTarget(self, action: #selector(checkFBBMove), for: .touchUpInside)
        
        //activity loader
        scrollView.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.topAnchor.constraint(equalTo: txtFxLineNo.bottomAnchor, constant: 40).isActive = true
        
        scrollView.contentSize.height = view.frame.size.height + cardView.frame.size.height
    }
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        btnCheck.isHidden = true
    }
    
    @objc func checkTxtInputs(){
        if txtUserID.text != "" && txtFxLineNo.text != ""{
            btnCheck.backgroundColor = UIColor.vodaRed
            btnCheck.isEnabled = true
        }
    }
    
    @objc func goToFBB(){
        let storyboard = UIStoryboard(name: "OffersExtras", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "displayChosenOfferVc") as? displayChosenOfferVc else {return}
        moveTo.selectedOffer = "FBB"
        present(moveTo, animated: true, completion: nil)
    }
    
    //Function to stopIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        btnCheck.isHidden = false
    }

    @objc func checkFBBMove(){
        if !CheckInternet.Connection(){
            let storyboard = UIStoryboard(name: "Support", bundle: nil)
            let moveTo = storyboard.instantiateViewController(withIdentifier: "NointernetViewController") as! NointernetViewController
            
            self.addChildViewController(moveTo)
            moveTo.view.frame = self.view.frame
            self.view.addSubview(moveTo.view)
            moveTo.didMove(toParentViewController: self)
        }else{
            start_activity_loader()
            var userID = txtUserID.text
            userID = userID?.trimmingCharacters(in: .whitespacesAndNewlines)
            var  actKey = txtFxLineNo.text
            actKey = actKey?.trimmingCharacters(in: .whitespacesAndNewlines)
            if userID == "" || actKey == "" {
                stop_activity_loader()
                toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "All fields are required")
            }else{
                
                let postParameters: Dictionary<String, Any> = [
                    "action":"FbbShareBucketCheck",
                    "actKey":actKey!,
                    "userID":userID!,
                    "os":getAppVersion()
                ]
                
                print(postParameters)
                let asyn_call = URL(string: String.MVA_FBBMOVE)
                let request = NSMutableURLRequest(url: asyn_call!)
                request.httpMethod = "POST"
                //Convert post parameters to json
                if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
                    request.httpBody = postData
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                    
                    //creating a task to send request
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
                        
                        //parsing the response
                        do {
                            //converting the response to NSDictionary
                            let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            if let parseJSON = myJSON {
                                var responseCode: Int?
//                                var shareStatusMessage: String?
                                var responseMessage:  String?
                                var shareStatus: Int?
                                var ssMessage: String?
                                print(parseJSON)
                                
                                responseCode = parseJSON["RESPONSECODE"] as! Int?
                                if responseCode == 1 || responseCode == 2 {
                                    responseMessage = parseJSON["RESPONSEMESSAGE"] as! String?
                                    DispatchQueue.main.async {
                                        self.stop_activity_loader()
                                        self.lblUserIDTop1?.isActive = false
                                        self.lblUserIDTop2?.isActive = true
                                        let errorBack = UIView()
                                        self.scrollView.addSubview(errorBack)
                                        errorBack.translatesAutoresizingMaskIntoConstraints = false
                                        errorBack.backgroundColor = UIColor.darkGray
                                        errorBack.leadingAnchor.constraint(equalTo: self.cardView.leadingAnchor, constant: 20).isActive = true
                                        errorBack.topAnchor.constraint(equalTo: self.cardView.topAnchor, constant: 5).isActive = true
                                        errorBack.trailingAnchor.constraint(equalTo: self.cardView.trailingAnchor, constant: -20).isActive = true
                                        errorBack.heightAnchor.constraint(equalToConstant: 50).isActive = true
                                        
                                        let infoImage = UIImageView(image: #imageLiteral(resourceName: "info"))
                                        self.scrollView.addSubview(infoImage)
                                        infoImage.translatesAutoresizingMaskIntoConstraints = false
                                        infoImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
                                        infoImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
                                        infoImage.leadingAnchor.constraint(equalTo: errorBack.leadingAnchor, constant: 20).isActive = true
                                        infoImage.topAnchor.constraint(equalTo: errorBack.topAnchor, constant: 10).isActive = true
                                        
                                        let errorMessage = UILabel()
                                        self.scrollView.addSubview(errorMessage)
                                        errorMessage.translatesAutoresizingMaskIntoConstraints = false
                                        errorMessage.text = responseMessage
                                        errorMessage.textColor = UIColor.white
                                        errorMessage.font = UIFont(name: String.defaultFontR, size: 17)
                                        errorMessage.leadingAnchor.constraint(equalTo: infoImage.trailingAnchor, constant: 10).isActive = true
                                        errorMessage.topAnchor.constraint(equalTo: errorBack.topAnchor, constant: 15).isActive = true
                                        errorMessage.trailingAnchor.constraint(equalTo: errorBack.trailingAnchor, constant: -1).isActive = true
                                        errorMessage.numberOfLines = 0
                                        errorMessage.lineBreakMode = .byWordWrapping
                                    }
                                }else{
                                    DispatchQueue.main.async {
                                        if let shareStatusMessage = parseJSON["SHARESTATUSMESSAGE"] as! String?{
                                            ssMessage = shareStatusMessage
                                            shareStatus = parseJSON["SHARESTATUS"] as! Int?
                                            let responseData = parseJSON["RESPONSEMESSAGE"] as! NSDictionary?
                                            let subADSLShare = responseData!["C_SUB_ADSL_SHARE"] as! String?
                                            let subADSLShareValidity = responseData!["C_SUB_ADSL_SHARE_VALIDITY"] as! String?
                                            let subADSLShareDate = responseData!["C_SUB_ADSL_SHARE_DATE"] as! String?
                                            
                                            //Move to update linked number
                                            let storyboard = UIStoryboard(name: "FBB", bundle: nil)
                                            guard let moveTo = storyboard.instantiateViewController(withIdentifier: "linkFBBUpdateVc") as? linkFBBUpdateVc else {return}
                                            moveTo.shareStatusMessage = ssMessage
                                            moveTo.shareStatus = shareStatus
                                            moveTo.C_SUB_ADSL_SHARE_VALIDITY = subADSLShareValidity
                                            moveTo.C_SUB_ADSL_SHARE_DATE = subADSLShareDate
                                            moveTo.C_SUB_ADSL_SHARE = subADSLShare
                                            moveTo.bbUserID = userID
                                            moveTo.fixedLineNo = actKey
                                            self.present(moveTo, animated: true, completion: nil)
                                            
                                        }else{
                                            let storyboard = UIStoryboard(name: "FBB", bundle: nil)
                                            guard let moveTo = storyboard.instantiateViewController(withIdentifier: "linkFBBVc") as? linkFBBVc else {return}
                                            moveTo.bbUserID = self.txtUserID.text
                                            moveTo.fixedLineNo = self.txtFxLineNo.text
                                            self.present(moveTo, animated: true, completion: nil)
                                        }
                                    }
                                }
                            }
                        }catch{
                            print(error)
                            DispatchQueue.main.async {
                                print("error nie:: \(error.localizedDescription)")
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
    

}
