//
//  checkFBBBalance.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 30/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class checkFBBBalance: baseViewControllerM {

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
    
    let txtAccNo = UITextField()
    let txtUserID = UITextField()
    let btnCheck = UIButton()
    let checkBox = UIButton()
    
    var isChecked: Bool = false
    var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground
        checkConnection()
        setUpViewsCheckFBB()
        hideKeyboardWhenTappedAround()
        
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        username = UserData["Username"] as? String
        
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
    }
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        btnCheck.isHidden = true
    }
    
    //Function to startIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        btnCheck.isHidden = false
    }
    
    func setUpViewsCheckFBB(){
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
        lblUserID.text = "User ID"
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
        txtAccNo.addTarget(self, action: #selector(checkTxtInputs), for: .editingChanged)
        
        //check box
        
        scrollView.addSubview(checkBox)
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        let checkBoxImage = UIImage(named: "Checkbox")
        checkBox.setImage(checkBoxImage, for: .normal)
        checkBox.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        checkBox.topAnchor.constraint(equalTo: txtAccNo.bottomAnchor, constant: 20).isActive = true
        checkBox.widthAnchor.constraint(equalToConstant: 20).isActive = true
        checkBox.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        checkBox.addTarget(self, action: #selector(checkButtonFunction), for: .touchUpInside)
        
        // Checkbox label
        let checkLabel = UILabel()
        scrollView.addSubview(checkLabel)
        checkLabel.translatesAutoresizingMaskIntoConstraints = false
        checkLabel.font = UIFont(name: String.defaultFontR, size: 15)
        checkLabel.textColor = UIColor.black
        checkLabel.numberOfLines = 0
        checkLabel.lineBreakMode = .byWordWrapping
        checkLabel.text = "Remember my account details"
        checkLabel.leadingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: 10).isActive = true
        checkLabel.topAnchor.constraint(equalTo: txtAccNo.bottomAnchor, constant: 25).isActive = true
        
        //Button to check balance
        
        scrollView.addSubview(btnCheck)
        btnCheck.translatesAutoresizingMaskIntoConstraints = false
        btnCheck.backgroundColor = UIColor.grayButton
        btnCheck.setTitle("Check", for: .normal)
        btnCheck.setTitleColor(UIColor.white, for: .normal)
        btnCheck.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnCheck.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        btnCheck.topAnchor.constraint(equalTo: checkLabel.bottomAnchor, constant: 40).isActive = true
        btnCheck.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        btnCheck.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnCheck.isEnabled = false
        btnCheck.addTarget(self, action: #selector(checkBalance), for: .touchUpInside)
        
        //activity loader
        scrollView.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.topAnchor.constraint(equalTo: checkLabel.bottomAnchor, constant: 40).isActive = true
        
        scrollView.contentSize.height = view.frame.size.height + cardView.frame.size.height
    }
    
    @objc func goToFBB(){
        guard let moveTo = storyboard?.instantiateViewController(withIdentifier: "displayChosenOfferVc") as? displayChosenOfferVc else {return}
        moveTo.selectedOffer = "FBB"
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func checkTxtInputs(){
        if txtUserID.text != "" && txtAccNo.text != ""{
            btnCheck.backgroundColor = UIColor.vodaRed
            btnCheck.isEnabled = true
        }
    }
    
    @objc func checkBalance(){
        if !CheckInternet.Connection(){
            let moveTo = storyboard?.instantiateViewController(withIdentifier: "NointernetViewController") as! NointernetViewController
            
            self.addChildViewController(moveTo)
            moveTo.view.frame = self.view.frame
            self.view.addSubview(moveTo.view)
            moveTo.didMove(toParentViewController: self)
        }else{
            self.start_activity_loader()
            let userID = txtUserID.text
            let accountNumber = txtAccNo.text
            if userID == "" || accountNumber == "" {
                self.stop_activity_loader()
                toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "All fields are required")
            }else{
                let async_api = URL(string: String.userURL)
                let request = NSMutableURLRequest(url: async_api!)
                
                let postParameters: Dictionary<String, Any> = [
                    "action":"fbbBalance",
                    "userid":userID!,
                    "accountnumber":accountNumber!,
                    "username":username!
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
                                        self.txtUserID.text = ""
                                        self.txtAccNo.text = ""
                                        self.stop_activity_loader()
                                        
                                        guard let moveTo = self.storyboard?.instantiateViewController(withIdentifier: "displayFBBBalance") as? displayFBBBalance else {return}
                                        moveTo.accNo = accNo
                                        moveTo.phoneNo = phoneNo
                                        moveTo.serviceNo = serviceNo
                                        moveTo.status = status
                                        moveTo.unusedData = unusedData
                                        moveTo.cashInAccount = cashInAccount
                                        moveTo.plan = plan
                                        self.addChildViewController(moveTo)
                                        moveTo.view.frame = self.view.frame
                                        self.view.addSubview(moveTo.view)
                                        moveTo.didMove(toParentViewController: self)
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
    
    @objc func checkButtonFunction(_ sender: UIButton){
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (success) in
            sender.isSelected = !sender.isSelected
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.transform = .identity
                if self.isChecked {
                    
                    self.checkBox.setImage(UIImage(named: "Checkbox"), for: .normal)
                }else{
                    self.checkBox.setImage(UIImage(named: "UnCheckbox"), for: .normal)
                }
                self.isChecked = !self.isChecked
            }, completion: nil)
        }
    }

}
