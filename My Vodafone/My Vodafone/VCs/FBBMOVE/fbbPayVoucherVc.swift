//
//  fbbPayVoucherVc.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 04/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class fbbPayVoucherVc: baseViewControllerM {
    
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
        view.heightAnchor.constraint(equalToConstant: 470).isActive = true
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
    
    let txtUserID = UITextField()
    let txtAccNo = UITextField()
    let txtVoucherCode = UITextField()
    let btnPay = UIButton()
    
    var username: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground
        setUpViewsFbbPayV()
        hideKeyboardWhenTappedAround()
        
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        username = UserData["Username"] as? String
        
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        txtVoucherCode.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
        txtUserID.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
        txtAccNo.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
    }

    func setUpViewsFbbPayV(){
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
        
        
        let lblSelectedOffer = UILabel()
        scrollView.addSubview(lblSelectedOffer)
        lblSelectedOffer.translatesAutoresizingMaskIntoConstraints = false
        lblSelectedOffer.textColor = UIColor.white
        lblSelectedOffer.textAlignment = .center
        lblSelectedOffer.font = UIFont(name: String.defaultFontR, size: 31)
        lblSelectedOffer.text = "Pay With Recharge Voucher"
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
        lblUserID.text = "User ID"
        lblUserID.font = UIFont(name: String.defaultFontR, size: 16)
        lblUserID.textColor = UIColor.black
        lblUserID.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblUserIDTop1 = lblUserID.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20)
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
        
        let lblAccNo = UILabel()
        scrollView.addSubview(lblAccNo)
        lblAccNo.translatesAutoresizingMaskIntoConstraints = false
        lblAccNo.text = "Account Number"
        lblAccNo.font = UIFont(name: String.defaultFontR, size: 16)
        lblAccNo.textColor = UIColor.black
        lblAccNo.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblAccNo.topAnchor.constraint(equalTo: txtUserID.bottomAnchor, constant: 40).isActive = true
        
        scrollView.addSubview(txtAccNo)
        txtAccNo.translatesAutoresizingMaskIntoConstraints = false
        txtAccNo.font = UIFont(name: String.defaultFontR, size: 16)
        txtAccNo.backgroundColor = UIColor.white
        txtAccNo.borderStyle = .roundedRect
        txtAccNo.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtAccNo.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtAccNo.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtAccNo.topAnchor.constraint(equalTo: lblAccNo.bottomAnchor, constant: 10).isActive = true
        
        let lblVoucherCode = UILabel()
        scrollView.addSubview(lblVoucherCode)
        lblVoucherCode.translatesAutoresizingMaskIntoConstraints = false
        lblVoucherCode.text = "Voucher Code"
        lblVoucherCode.font = UIFont(name: String.defaultFontR, size: 16)
        lblVoucherCode.textColor = UIColor.black
        lblVoucherCode.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblVoucherCode.topAnchor.constraint(equalTo: txtAccNo.bottomAnchor, constant: 40).isActive = true
        
        scrollView.addSubview(txtVoucherCode)
        txtVoucherCode.translatesAutoresizingMaskIntoConstraints = false
        txtVoucherCode.font = UIFont(name: String.defaultFontR, size: 16)
        txtVoucherCode.backgroundColor = UIColor.white
        txtVoucherCode.borderStyle = .roundedRect
        txtVoucherCode.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtVoucherCode.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtVoucherCode.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtVoucherCode.topAnchor.constraint(equalTo: lblVoucherCode.bottomAnchor, constant: 10).isActive = true
        
        
        scrollView.addSubview(btnPay)
        btnPay.translatesAutoresizingMaskIntoConstraints = false
        btnPay.backgroundColor = UIColor.grayButton
        btnPay.setTitle("Pay", for: .normal)
        btnPay.setTitleColor(UIColor.white, for: .normal)
        btnPay.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnPay.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        btnPay.topAnchor.constraint(equalTo: txtVoucherCode.bottomAnchor, constant: 40).isActive = true
        btnPay.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        btnPay.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnPay.isEnabled = false
        btnPay.addTarget(self, action: #selector(checkBalance), for: .touchUpInside)
        
        //activity loader
        scrollView.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.topAnchor.constraint(equalTo: txtVoucherCode.bottomAnchor, constant: 40).isActive = true
        
        scrollView.contentSize.height = view.frame.size.height + 50
    }
    
    @objc func goToFBB(){
        let storyboard = UIStoryboard(name: "OffersExtras", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "displayChosenOfferVc") as? displayChosenOfferVc else {return}
        moveTo.selectedOffer = "FBB"
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func checkBalance(){
        let userID = txtUserID.text
        let accNo = txtAccNo.text
        let voucher = txtVoucherCode.text
        //check for internet connectivity
        if !CheckInternet.Connection(){
            displayNoInternet()
        }else{
            // validate
            if userID == ""{
                lblUserIDTop1?.isActive = false
                lblUserIDTop2?.isActive = true
                errorDialog(errorMssg: "User ID is required")
            }else if accNo == "" {
                lblUserIDTop1?.isActive = false
                lblUserIDTop2?.isActive = true
                errorDialog(errorMssg: "Account Number is required")
            }else if voucher == "" {
                lblUserIDTop1?.isActive = false
                lblUserIDTop2?.isActive = true
                errorDialog(errorMssg: "Voucher code is required")
            }else{
                start_activity_loader()
                let postParameters: Dictionary<String, Any> = [
                    "action":"fbbBalance",
                    "userid":userID!,
                    "accountnumber":accNo!,
                    "username":username!,
                    "os":getAppVersion()
                ]
                
                let async_call = URL(string: String.userURL)
                let request = NSMutableURLRequest(url: async_call!)
                request.httpMethod = "POST"
                
                // convert post parameters to json
                if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
                    request.httpBody = postData
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                    
                    //create a task to send request
                    let task = URLSession.shared.dataTask(with: request as URLRequest){
                        data, response, error in
                        if error != nil {
                            print("error is:: \(error!.localizedDescription)")
                            DispatchQueue.main.async {
                                self.errorDialog(errorMssg: error!.localizedDescription)
                                self.stop_activity_loader()
                            }
                            return;
                        }
                            //parsing the response
                            do {
                                //converting response to NSDictionary
                                let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                                if let parseJSON = myJSON {
                                    var responseCode: Int?
                                    var responseMessage: NSDictionary!
                                    print(parseJSON)
                                    responseCode = parseJSON["RESPONSECODE"] as! Int?
                                    DispatchQueue.main.async {
                                        if responseCode == 1 || responseCode == 2 {
                                            self.lblUserIDTop1?.isActive = false
                                            self.lblUserIDTop2?.isActive = true
                                            var responseMessage: String?
                                            responseMessage = parseJSON["RESPONSEMESSAGE"] as! String?
                                            self.stop_activity_loader()
                                            self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: responseMessage!)
                                            self.errorDialog(errorMssg: responseMessage!)
                                        }else{
                                            self.stop_activity_loader()
                                            responseMessage = parseJSON["RESPONSEMESSAGE"] as! NSDictionary?
                                            
                                            
                                            let P_PHONENO = responseMessage["P_PHONENO"] as! String?
                                            let P_ADVANCEPAYMENT = responseMessage["P_ADVANCEPAYMENT"] as! String?
                                            
                                            let storyboard = UIStoryboard(name: "FBB", bundle: nil)
                                            guard let moveTo = storyboard.instantiateViewController(withIdentifier: "confirmFBBVoucher") as? confirmFBBVoucher else {return}
                                            moveTo.P_PHONENO = P_PHONENO
                                            moveTo.accNo = accNo!
                                            moveTo.currentBal = P_ADVANCEPAYMENT
                                            moveTo.vouchercode = voucher!
                                            moveTo.userID = userID
                                            
                                            self.addChildViewController(moveTo)
                                            moveTo.view.frame = self.view.frame
                                            self.view.addSubview(moveTo.view)
                                            moveTo.didMove(toParentViewController: self)
                                        }
                                    }
                                }
                            }catch{
                                print(error.localizedDescription)
                                DispatchQueue.main.async {
                                    self.errorDialog(errorMssg: error.localizedDescription)
                                    self.stop_activity_loader()
                                }
                            }
                        
                    }
                    task.resume()
                }
            }
        }
    }
    
    @objc func checkInputs(){
        let userID = txtUserID.text
        let accNo = txtAccNo.text
        let voucher = txtVoucherCode.text
        
        if userID == "" || accNo == "" || voucher == ""{
            btnPay.backgroundColor = UIColor.grayButton
            btnPay.isEnabled = false
        }else if userID != "" && (accNo == "" || voucher == ""){
            btnPay.backgroundColor = UIColor.grayButton
            btnPay.isEnabled = false
        }else if accNo != "" && (userID == "" || voucher == ""){
            btnPay.backgroundColor = UIColor.grayButton
            btnPay.isEnabled = false
        }else if voucher != "" && (userID == "" || accNo == ""){
            btnPay.backgroundColor = UIColor.grayButton
            btnPay.isEnabled = false
        }else{
            btnPay.backgroundColor = UIColor.vodaRed
            btnPay.isEnabled = true
        }
    }
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        btnPay.isHidden = true
    }
    
    //Function to stopIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        btnPay.isHidden = false
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
        errorImage.topAnchor.constraint(equalTo: errorView.topAnchor, constant: 20).isActive = true
        
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
        errorMessage.topAnchor.constraint(equalTo: errorView.topAnchor, constant: 20).isActive = true
        errorMessage.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -1).isActive = true
    }

}
