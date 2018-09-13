//
//  AddServiceConfViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 16/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class AddServiceConfViewController: baseViewControllerM {

    var responseMessage: String?
    var serviceID: String?
    var activationCode: String?
    var countCode: Int?
    var username:  String?
    
//    let preference = UserDefaults.standard
    
    //create a closure for
    let topImage: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "bg2"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Service Header
    let lblServiceH: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.textAlignment = .center
        view.font = UIFont(name: String.defaultFontR, size: 30)
        view.text = "Service Activation"
        return view
    }()
    
    //closure for cardView
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    //create closure for back button
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //create label
    let lblTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.black
        view.font = UIFont(name: String.defaultFontR, size: 17)
        return view
    }()
    
    //txt field
    let txtCode: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 17)
        view.borderStyle = .roundedRect
        view.keyboardType = .numberPad
        return view
    }()
    
    //Activate button
    let btnActivate: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    //create activity loader closure
    let activity_loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        view.hidesWhenStopped = true
        view.color = UIColor.vodaRed
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground
        setUpViewsAddS()
        let responseData = preference.object(forKey: "responseData") as! NSDictionary
        username = responseData["Username"] as? String
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Display Success message
        toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "correct")), toast_message: responseMessage!)
        activity_loader.isHidden = true
        txtCode.addTarget(self, action: #selector(checkOTPSize), for: .editingChanged)
    }

    func setUpViewsAddS(){
        //top image
        view.addSubview(topImage)
        topImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topImage.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        topImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
//        topImage.contentMode = .scaleToFill
        
        //back button
        view.addSubview(backButton)
        let back_image = UIImage(named: "leftArrow")
        let tintedImage = back_image?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(tintedImage, for: .normal)
        backButton.tintColor = UIColor.white
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 10).isActive = true
        backButton.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 10).isActive = true
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        //Service Activation
        view.addSubview(lblServiceH)
        lblServiceH.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        lblServiceH.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        lblServiceH.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 90).isActive = true
        
        //card
        view.addSubview(cardView)
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        cardView.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 20).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        cardView.layer.cornerRadius = 2
        cardView.layer.shadowOffset = CGSize(width: 0, height: 5)
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.2
        
        //Title
        view.addSubview(lblTitle)
        lblTitle.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblTitle.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 30).isActive = true
        lblTitle.text = "Enter your activation code"
        
        //Text field
        view.addSubview(txtCode)
        txtCode.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 20).isActive = true
        txtCode.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtCode.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtCode.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        //activate btn
        view.addSubview(btnActivate)
        btnActivate.setTitle("Activate Service", for: .normal)
        btnActivate.backgroundColor = UIColor.grayButton
        btnActivate.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        btnActivate.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        btnActivate.topAnchor.constraint(equalTo: txtCode.bottomAnchor, constant: 30).isActive = true
        btnActivate.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnActivate.isEnabled = false
        btnActivate.addTarget(self, action: #selector(activateService), for: .touchUpInside)
        
        //activity loader
        view.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.topAnchor.constraint(equalTo: btnActivate.bottomAnchor, constant: 20).isActive = true
    }
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        btnActivate.isHidden = true
    }
    
    //Function to startIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        btnActivate.isHidden = false
    }
    
    //Function to go back
    @objc func goBack(){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "AddServiceViewController")
        present(moveTo!, animated: true, completion: nil)
    }
    
    //Function to activate service
    @objc func activateService(){
        txtCode.resignFirstResponder()
        activationCode = txtCode.text
        if activationCode == "" {
            toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Provide activation code")
        }else{
            // check for internet connection
            if !CheckInternet.Connection(){
                let moveTo = storyboard?.instantiateViewController(withIdentifier: "NointernetViewController")
                self.addChildViewController(moveTo!)
                moveTo!.view.frame = self.view.frame
                self.view.addSubview(moveTo!.view)
                moveTo!.didMove(toParentViewController: self)
            }else{
                start_activity_loader()
                let postParameters: Dictionary<String, Any> = [
                    "action":"activateService",
                    "activationCode":activationCode!,
                    "serviceID":serviceID!,
                    "username":username!,
                    "os":getAppVersion()
                ]
                let async_call = URL(string: String.userSVC)
                let request = NSMutableURLRequest(url: async_call!)
                request.httpMethod = "POST"
                
                //convert post parameters to json
                if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
                    request.httpBody = postData
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                    
                    // creating a task to send request
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
                        do{
                            //converting the response to NSDictionary
                            let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            if let parseJSON = myJSON {
                                var responseCode: Int!
                                var responseMessage: String!
                                
                                responseCode = parseJSON["RESPONSECODE"] as! Int
                                responseMessage = parseJSON["RESPONSEMESSAGE"] as! String
                                
                                DispatchQueue.main.async {
                                    if responseCode == 1 {
                                        self.stop_activity_loader()
                                        self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: responseMessage)
                                    }else if responseCode == 2 {
                                        self.stop_activity_loader()
                                        self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: responseMessage)
                                    }
                                    else{
                                        self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "correct")), toast_message: responseMessage)
                                        UIView.animate(withDuration: 1, delay: 3, animations: {
                                            let moveTo = self.storyboard?.instantiateViewController(withIdentifier: "ProductsServicesViewController")
                                            self.present(moveTo!, animated: true, completion: nil)
                                        })
                                    }
                                    self.stop_activity_loader()
                                }
                            }
                        }catch{
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
    
    //Function count otp
    @objc func checkOTPSize(){
        activationCode = txtCode.text
        countCode = activationCode?.count
        if countCode == 5 {
            btnActivate.isEnabled = true
            btnActivate.backgroundColor = UIColor.vodaRed
        }else{
            btnActivate.isEnabled = false
            btnActivate.backgroundColor = UIColor.grayButton
        }
        
    }
}
