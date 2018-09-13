//
//  confirmFBBMove.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 03/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class confirmFBBMove: baseViewControllerM {

    fileprivate var lblUserIDTop1: NSLayoutConstraint?
    fileprivate var lblUserIDTop2: NSLayoutConstraint?
    var displayMessage: String?
    
    var msisdn: String?
    var userID: String?
    var actKey: String?
    
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
    
    //create card view
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
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
    
    let txtPin = UITextField()
    let btnConfirm = UIButton()
    let errorView = UIView()
    let errorMessage = UILabel()         
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground
        setUpViewsConfirm()
        hideKeyboardWhenTappedAround()
        
        toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "correct")), toast_message: displayMessage!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        txtPin.addTarget(self, action: #selector(checkInput), for: .editingChanged)
    }

    func setUpViewsConfirm(){
        view.addSubview(topImage)
        topImage.image = UIImage(named: "bg2")
        topImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        topImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImage.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        topImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(backButton)
        let backImage = UIImage(named: "leftArrow")
        let backTint = backImage?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(backTint, for: .normal)
        backButton.tintColor = UIColor.white
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 10).isActive = true
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        let lblSelectedOffer = UILabel()
        view.addSubview(lblSelectedOffer)
        lblSelectedOffer.translatesAutoresizingMaskIntoConstraints = false
        lblSelectedOffer.textColor = UIColor.white
        lblSelectedOffer.textAlignment = .center
        lblSelectedOffer.font = UIFont(name: String.defaultFontR, size: 31)
        lblSelectedOffer.text = "Confirmation"
        lblSelectedOffer.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        lblSelectedOffer.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 70).isActive = true
        lblSelectedOffer.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        lblSelectedOffer.numberOfLines = 0
        lblSelectedOffer.lineBreakMode = .byWordWrapping
        
        view.addSubview(cardView)
        cardView.layer.cornerRadius = 2
        cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.2
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cardView.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 20).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        let lblUserID = UILabel()
        view.addSubview(lblUserID)
        lblUserID.translatesAutoresizingMaskIntoConstraints = false
        lblUserID.text = "Confirmation Token"
        lblUserID.font = UIFont(name: String.defaultFontR, size: 16)
        lblUserID.textColor = UIColor.black
        lblUserID.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblUserIDTop1 = lblUserID.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20)
        lblUserIDTop2 = lblUserID.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 80)
        lblUserIDTop1?.isActive = true
        
        
        view.addSubview(txtPin)
        txtPin.translatesAutoresizingMaskIntoConstraints = false
        txtPin.font = UIFont(name: String.defaultFontR, size: 16)
        txtPin.backgroundColor = UIColor.white
        txtPin.borderStyle = .roundedRect
        txtPin.keyboardType = .numberPad
        txtPin.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtPin.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtPin.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtPin.topAnchor.constraint(equalTo: lblUserID.bottomAnchor, constant: 10).isActive = true
        
        view.addSubview(btnConfirm)
        btnConfirm.translatesAutoresizingMaskIntoConstraints = false
        btnConfirm.backgroundColor = UIColor.grayButton
        btnConfirm.setTitle("Confirm", for: .normal)
        btnConfirm.setTitleColor(UIColor.white, for: .normal)
        btnConfirm.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnConfirm.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        btnConfirm.topAnchor.constraint(equalTo: txtPin.bottomAnchor, constant: 40).isActive = true
        btnConfirm.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        btnConfirm.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnConfirm.addTarget(self, action: #selector(goToFBBShare), for: .touchUpInside)
        
        //activity loader
        view.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.topAnchor.constraint(equalTo: txtPin.bottomAnchor, constant: 40).isActive = true
    }

    @objc func goBack(){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "linkFBBVc")
        present(moveTo!, animated: true, completion: nil)
    }
    
    @objc func checkInput(){
        let pinCount = txtPin.text
        if pinCount?.count != 5 {
            btnConfirm.backgroundColor = UIColor.grayButton
            btnConfirm.isEnabled = false
        }else{
            btnConfirm.backgroundColor = UIColor.vodaRed
            btnConfirm.isEnabled = true
        }
    }
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        btnConfirm.isHidden = true
    }
    
    //Function to stopIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        btnConfirm.isHidden = false
    }
    
    @objc func goToFBBShare(){
        let code = txtPin.text
        if !CheckInternet.Connection(){
            let moveTo = storyboard?.instantiateViewController(withIdentifier: "NointernetViewController") as! NointernetViewController
            
            self.addChildViewController(moveTo)
            moveTo.view.frame = self.view.frame
            self.view.addSubview(moveTo.view)
            moveTo.didMove(toParentViewController: self)
        }else{
            start_activity_loader()
            let postParameters: Dictionary<String, Any> = [
                "action":"FbbShareBucketPairConfirm",
                "msisdn":msisdn!,
                "code":code!,
                "actKey":actKey!,
                "userID":userID!,
                "os":getAppVersion()
            ]
            
            let async_call = URL(string: String.MVA_FBBMOVE)
            let request = NSMutableURLRequest(url: async_call!)
            request.httpMethod = "POST"
            
            //convert post parameters to json
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
                            self.lblUserIDTop1?.isActive = false
                            self.lblUserIDTop2?.isActive = true
                            
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
                            errorMessage.text = error!.localizedDescription
                            errorMessage.textColor = UIColor.white
                            errorMessage.font = UIFont(name: String.defaultFontR, size: 18)
                            errorMessage.numberOfLines = 0
                            errorMessage.lineBreakMode = .byWordWrapping
                            errorMessage.leadingAnchor.constraint(equalTo: errorImage.trailingAnchor, constant: 10).isActive = true
                            errorMessage.topAnchor.constraint(equalTo: errorView.topAnchor, constant: 10).isActive = true
                            errorMessage.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -1).isActive = true
                        }
                        return;
                    }
                    //parsing the response
                    do {
                        //converting response
                        let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        if let parseJSON = myJSON {
                            var responseCode: Int?
                            var responseMessage: String?
                            
                            responseCode = parseJSON["RESPONSECODE"] as! Int?
                            DispatchQueue.main.async {
                                if responseCode == 1 || responseCode == 2 {
                                    self.stop_activity_loader()
                                    responseMessage = parseJSON["RESPONSEMESSAGE"] as! String?
                                    
                                    self.stop_activity_loader()
                                    self.lblUserIDTop1?.isActive = false
                                    self.lblUserIDTop2?.isActive = true
                                    
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
                                    errorMessage.text = responseMessage
                                    errorMessage.textColor = UIColor.white
                                    errorMessage.font = UIFont(name: String.defaultFontR, size: 18)
                                    errorMessage.numberOfLines = 0
                                    errorMessage.lineBreakMode = .byWordWrapping
                                    errorMessage.leadingAnchor.constraint(equalTo: errorImage.trailingAnchor, constant: 10).isActive = true
                                    errorMessage.topAnchor.constraint(equalTo: errorView.topAnchor, constant: 10).isActive = true
                                    errorMessage.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -1).isActive = true
                                }else{
                                    self.preference.set(self.msisdn!, forKey: "FBBLINKEDNUMBER")
                                    self.preference.set(self.actKey!, forKey: "FBBACTKEY")
                                    self.preference.set(self.userID!, forKey: "FBBUSERID")
                                    guard let moveTo = self.storyboard?.instantiateViewController(withIdentifier: "fbbShareVc") as? fbbShareVc else {return}
                                    self.present(moveTo, animated: true, completion: nil)
                                }
                            }
                        }
                    }catch {
                        print(error.localizedDescription)
                        DispatchQueue.main.async {
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
                            errorMessage.text = error.localizedDescription
                            errorMessage.textColor = UIColor.white
                            errorMessage.font = UIFont(name: String.defaultFontR, size: 18)
                            errorMessage.numberOfLines = 0
                            errorMessage.lineBreakMode = .byWordWrapping
                            errorMessage.leadingAnchor.constraint(equalTo: errorImage.trailingAnchor, constant: 10).isActive = true
                            errorMessage.topAnchor.constraint(equalTo: errorView.topAnchor, constant: 10).isActive = true
                            errorMessage.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -1).isActive = true
                        }
                    }
                }
                task.resume()
            }
        }
//        let moveTo = storyboard?.instantiateViewController(withIdentifier: "fbbShareVc")
//        present(moveTo!, animated: true, completion: nil)
    }
}
