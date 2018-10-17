//
//  linkFBBVc.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 03/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class linkFBBVc: baseViewControllerM {

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
    
    let txtFxLineNo = UITextField()
    let txtUserID = UITextField()
    let txtLinkedNo = UITextField()
    let btnLink = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground
        setUpViewsLinkFBB()
        hideKeyboardWhenTappedAround()
        
        
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
    }
    
    func setUpViewsLinkFBB(){
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
        if let userID = bbUserID {
            txtUserID.text = userID
        }
//        txtUserID.addTarget(self, action: #selector(checkTxtInputs), for: .editingChanged)
        
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
//        txtFxLineNo.addTarget(self, action: #selector(checkTxtInputs), for: .editingChanged)
        
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
        
        scrollView.addSubview(btnLink)
        btnLink.translatesAutoresizingMaskIntoConstraints = false
        btnLink.backgroundColor = UIColor.vodaRed
        btnLink.setTitle("Link Number", for: .normal)
        btnLink.setTitleColor(UIColor.white, for: .normal)
        btnLink.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnLink.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        btnLink.topAnchor.constraint(equalTo: txtLinkedNo.bottomAnchor, constant: 40).isActive = true
        btnLink.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        btnLink.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnLink.addTarget(self, action: #selector(linkNumber), for: .touchUpInside)
        
        //activity loader
        scrollView.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.topAnchor.constraint(equalTo: txtLinkedNo.bottomAnchor, constant: 40).isActive = true
        
        scrollView.contentSize.height = view.frame.size.height + cardView.frame.size.height
    }
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        btnLink.isHidden = true
    }
    
    //Function to stopIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        btnLink.isHidden = false
    }
    
    @objc func goToFBBMove(){
        let storyboard = UIStoryboard(name: "FBB", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "fbbMove")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func linkNumber(){
        //check for internet connectivity
        if !CheckInternet.Connection(){
            displayNoInternet()
        }else{
            let msisdn = txtLinkedNo.text
            let actKey = txtFxLineNo.text
            let userID = txtUserID.text
            
            if userID == ""{
                txtUserID.becomeFirstResponder()
                toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "User ID is required")
            }else{
                if actKey == "" {
                    txtFxLineNo.becomeFirstResponder()
                    toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Broadband Fixedline Number is required")
                }else{
                    if msisdn == "" {
                        txtLinkedNo.becomeFirstResponder()
                        toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Pairing Number is required")
                    }else if msisdn?.count != 10 {
                        txtLinkedNo.becomeFirstResponder()
                        toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Pairing Number length is invalid")
                    }else {
                        start_activity_loader()
                        let postParameters: Dictionary<String, Any> = [
                            "action":"FbbShareBucketPairCheck",
                            "msisdn": msisdn!,
                            "actKey": actKey!,
                            "userID": userID!,
                            "os":getAppVersion()
                        ]
                        let asyn_call = URL(string: String.MVA_FBBMOVE)
                        let request = NSMutableURLRequest(url: asyn_call!)
                        request.httpMethod = "POST"
                        
                        //converting post parameters to json
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
                                    // converting the response to NSDictionary
                                    let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                                    if let parseJSON = myJSON {
                                        var responseCode: Int?
                                        var responseMessage: String?
                                        
                                        print(parseJSON)
                                        responseCode = parseJSON["RESPONSECODE"] as! Int?
                                        responseMessage = parseJSON["RESPONSEMESSAGE"] as! String?
                                        DispatchQueue.main.async {
                                            if responseCode == 0 {
                                                let storyboard = UIStoryboard(name: "FBB", bundle: nil)
                                                guard let moveTo = storyboard.instantiateViewController(withIdentifier: "confirmFBBMove") as? confirmFBBMove else {return}
                                                moveTo.displayMessage = responseMessage
                                                moveTo.msisdn = msisdn!
                                                moveTo.actKey = actKey!
                                                moveTo.userID = userID!
                                                self.present(moveTo, animated: true, completion: nil)
                                            }else{
                                                self.stop_activity_loader()
                                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: responseMessage!)
                                            }
                                        }
                                    }
                                }catch {
                                    DispatchQueue.main.async {
                                        self.stop_activity_loader()
                                        self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: error.localizedDescription)
                                    }
                                }
                            }
                            task.resume()
                        }
                        /*guard let moveTo = self.storyboard?.instantiateViewController(withIdentifier: "confirmFBBMove") as? confirmFBBMove else {return}
                        moveTo.displayMessage = "Kwaku"
                        self.present(moveTo, animated: true, completion: nil)*/
                    }
                }
            }
        }
    }

}
