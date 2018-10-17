//
//  confirmChangePlan.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 06/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class confirmChangePlan: baseViewControllerM {

    var planName: String?
    var planPrice: String?
    var USSDURL: String?
    var planPID: String?
    var username: String?
    
    fileprivate var lblUserIDTop1: NSLayoutConstraint?
    fileprivate var lblUserIDTop2: NSLayoutConstraint?
    var bbUserID: String?
    var fixedLineNo: String?
    
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
        view.heightAnchor.constraint(equalToConstant: 400).isActive = true
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
    let btnNext = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewConfirmChange()
        view.backgroundColor = UIColor.grayBackground
        hideKeyboardWhenTappedAround()
        
       
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        username = UserData["Username"] as? String
        
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkTxtInputs()
    }
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        btnNext.isHidden = true
    }
    
    //Function to startIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        btnNext.isHidden = false
    }

    func setUpViewConfirmChange() {
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
        backButton.addTarget(self, action: #selector(goToPackages), for: .touchUpInside)
        
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
        lblSelectedOffer.text = "Confirm Account"
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
        if let userID = preference.object(forKey: "FBBUSERID"){
            txtUserID.text = userID as? String
        }
        txtUserID.addTarget(self, action: #selector(checkTxtInputs), for: .editingChanged)
        
        let lblAccNo = UILabel()
        scrollView.addSubview(lblAccNo)
        lblAccNo.translatesAutoresizingMaskIntoConstraints = false
        lblAccNo.text = "Account Number"
        lblAccNo.font = UIFont(name: String.defaultFontR, size: 16)
        lblAccNo.textColor = UIColor.black
        lblAccNo.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblAccNo.topAnchor.constraint(equalTo: txtUserID.bottomAnchor, constant: 30).isActive = true
        
        
        
        scrollView.addSubview(txtAccNo)
        txtAccNo.translatesAutoresizingMaskIntoConstraints = false
        txtAccNo.font = UIFont(name: String.defaultFontR, size: 16)
        txtAccNo.backgroundColor = UIColor.white
        txtAccNo.borderStyle = .roundedRect
        txtAccNo.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtAccNo.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtAccNo.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtAccNo.topAnchor.constraint(equalTo: lblAccNo.bottomAnchor, constant: 10).isActive = true
        if let accNo = preference.object(forKey: "FBBUSERACCOUNT"){
            txtAccNo.text = accNo as? String
        }
        txtAccNo.addTarget(self, action: #selector(checkTxtInputs), for: .editingChanged)
        
        scrollView.addSubview(btnNext)
        btnNext.translatesAutoresizingMaskIntoConstraints = false
        btnNext.backgroundColor = UIColor.grayButton
        btnNext.isEnabled = false
        btnNext.setTitle("Next", for: .normal)
        btnNext.setTitleColor(UIColor.white, for: .normal)
        btnNext.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnNext.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        btnNext.topAnchor.constraint(equalTo: txtAccNo.bottomAnchor, constant: 40).isActive = true
        btnNext.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        btnNext.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnNext.addTarget(self, action: #selector(clickNext), for: .touchUpInside)
        
        //activity loader
        scrollView.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.topAnchor.constraint(equalTo: txtAccNo.bottomAnchor, constant: 40).isActive = true
        
        scrollView.contentSize.height = view.frame.size.height + 55
    }
    
    @objc func checkTxtInputs(){
        if txtUserID.text != "" && txtAccNo.text != ""{
            btnNext.backgroundColor = UIColor.vodaRed
            btnNext.isEnabled = true
        }
    }
    
    @objc func goToPackages(){
        let storyboard = UIStoryboard(name: "FBB", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "FBBPackages")
        present(moveTo, animated: true, completion: nil)
    }

    
    @objc func clickNext(){
        if !CheckInternet.Connection(){
            displayNoInternet()
        }else{
            self.start_activity_loader()
            let userID = txtUserID.text
            let accNo = txtAccNo.text
            if userID == "" || accNo == "" {
                self.stop_activity_loader()
                toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "All fields are required")
            }else{
                let async_api = URL(string: String.userURL)
                let request = NSMutableURLRequest(url: async_api!)
                
                let postParameters: Dictionary<String, Any> = [
                    "action":"fbbBalance",
                    "userid":userID!,
                    "accountnumber":accNo!,
                    "username":username!,
                    "os":getAppVersion()
                ]
                
                print(postParameters)
                request.httpMethod = "POST"
                //convert post parameters to json
                if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
                    request.httpBody = postData
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                    
                    //creating a task to send request
                    let task = URLSession.shared.dataTask(with: request as URLRequest) {
                        data, response, error in
                        if error != nil {
                            print("error is:: \(error!.localizedDescription)")
                            DispatchQueue.main.async {
                                self.stop_activity_loader()
                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: error!.localizedDescription)
                            }
                            return;
                        }
                        //passing the response
                        do {
                            //converting response to NSDictionary
                            let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            if let parseJSON = myJSON {
                                var responseCode: Int?
                                var responseMessage: NSDictionary!
                                
                                responseCode = parseJSON["RESPONSECODE"] as! Int?
                                DispatchQueue.main.async {
                                    if responseCode == 1 || responseCode == 2 {
                                        var responseMessage: String?
                                        responseMessage = parseJSON["RESPONSEMESSAGE"] as! String?
                                        self.stop_activity_loader()
                                        self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: responseMessage!)
                                    }else{
                                        responseMessage = parseJSON["RESPONSEMESSAGE"] as! NSDictionary?
                                        let accNo = responseMessage["P_ACCOUNTNO"] as! String?
                                        let phoneNo = responseMessage["P_PHONENO"] as! String?
                                        let serviceNo = responseMessage["P_SERVICENO"] as! String?
                                        let status = responseMessage["P_STATUS"] as! String?
                                        let unusedData = responseMessage["P_CURRENTVOL"] as! String?
                                        let cashInAccount = responseMessage["P_CURRENTBAL"] as! String?
                                        let plan = responseMessage["P_PLANNAME"] as! String?
                                        
                                        self.stop_activity_loader()
                                        let storyboard = UIStoryboard(name: "FBB", bundle: nil)
                                        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "changePlanForm") as? changePlanForm else {return}
                                        moveTo.accNo = accNo
                                        moveTo.phoneNo = phoneNo
                                        moveTo.serviceNo = serviceNo
                                        moveTo.status = status
                                        moveTo.unusedData = unusedData
                                        moveTo.cashInAccount = cashInAccount
                                        moveTo.plan = plan
                                        moveTo.userID = userID
                                        
                                        self.present(moveTo, animated: true, completion: nil)
                                    }
                                }
                            }
                        }catch {
                            print(error.localizedDescription)
                            DispatchQueue.main.async {
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
