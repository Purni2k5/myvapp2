//
//  UpdateProfile.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 20/12/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class UpdateProfile: baseViewControllerM {

    var displayMsisdn: String?
    var displayName: String?
    var id: String?
    var displayImage: String?
    var username: String?
    
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
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let lblSelectedOffer: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let darkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        return view
    }()
    
    let displayImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblDisplayName: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: String.defaultFontR, size: 20)
        view.textColor = UIColor.white
        return view
    }()
    
    let lblDisplayNumber: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: String.defaultFontR, size: 13)
        view.textColor = UIColor.white
        return view
    }()
    
    let btnChangeImage: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    let serviceNameCard: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let deleteServiceCard: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let txtServiceName: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.borderStyle = .roundedRect
        text.font = UIFont(name: String.defaultFontR, size: 18)
        return text
    }()
    
    fileprivate var txtBottomConstraint: NSLayoutConstraint!
    
    let btnSave: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Save", for: .normal)
        view.backgroundColor = UIColor.gray
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        return view
    }()
    
    let btnDeleteService: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Delete from my account", for: .normal)
        view.backgroundColor = UIColor.vodaRed
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground

        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        username = UserData["Username"] as? String
        setUpViewsUpdateProfile()
        hideKeyboardWhenTappedAround()
        checkConnection()
        if AcctType == "PHONE_MOBILE_PRE_P" || AcctType == "BB_FIXED_PRE_P"{
            prePaidMenu()
        }else{
            prePaidMenu()
        }
    }

    
    
    func setUpViewsUpdateProfile(){
        view.addSubview(scrollView)
        scrollView.backgroundColor = UIColor.clear
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
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
        topImage.heightAnchor.constraint(equalToConstant: 450).isActive = true
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
        backButton.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        
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
        
        scrollView.addSubview(lblSelectedOffer)
        lblSelectedOffer.translatesAutoresizingMaskIntoConstraints = false
        lblSelectedOffer.textColor = UIColor.white
        lblSelectedOffer.textAlignment = .center
        lblSelectedOffer.font = UIFont(name: String.defaultFontR, size: 31)
        lblSelectedOffer.text = "Services"
        lblSelectedOffer.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        lblSelectedOffer.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 70).isActive = true
        lblSelectedOffer.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        lblSelectedOffer.numberOfLines = 0
        lblSelectedOffer.lineBreakMode = .byWordWrapping
        
        topImage.addSubview(darkView)
        darkView.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        darkView.topAnchor.constraint(equalTo: lblSelectedOffer.bottomAnchor, constant: 5).isActive = true
        darkView.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        darkView.bottomAnchor.constraint(equalTo: topImage.bottomAnchor, constant: -30).isActive = true
        
        darkView.addSubview(displayImageView)
        displayImageView.centerXAnchor.constraint(equalTo: darkView.centerXAnchor).isActive = true
        displayImageView.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 30).isActive = true
        displayImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        displayImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        displayImageView.clipsToBounds = true
        displayImageView.layer.cornerRadius = 60
        displayImageView.layer.borderColor = UIColor.white.cgColor
        displayImageView.layer.borderWidth = 2
        displayImageView.contentMode = .scaleAspectFit
        displayImageView.sd_setImage(with: URL(string: displayImage ?? ""), placeholderImage: UIImage(named: "default_profile"), options: [.continueInBackground, .progressiveDownload])
        
        darkView.addSubview(lblDisplayName)
        lblDisplayName.centerXAnchor.constraint(equalTo: darkView.centerXAnchor).isActive = true
        lblDisplayName.topAnchor.constraint(equalTo: displayImageView.bottomAnchor, constant: 20).isActive = true
        if let displayName = displayName {
            lblDisplayName.text = displayName
        }
        darkView.addSubview(lblDisplayNumber)
        lblDisplayNumber.centerXAnchor.constraint(equalTo: darkView.centerXAnchor).isActive = true
        lblDisplayNumber.topAnchor.constraint(equalTo: lblDisplayName.bottomAnchor, constant: 10).isActive = true
        if let displayMsisdn = displayMsisdn {
            lblDisplayNumber.text = displayMsisdn
        }
        
        view.addSubview(btnChangeImage)
        btnChangeImage.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 60).isActive = true
        btnChangeImage.topAnchor.constraint(equalTo: lblDisplayNumber.bottomAnchor, constant: 20).isActive = true
        btnChangeImage.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -60).isActive = true
        btnChangeImage.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnChangeImage.layer.borderColor = UIColor.white.cgColor
        btnChangeImage.layer.borderWidth = 1
        let gestureRec = UITapGestureRecognizer(target: self, action: #selector(openChooseType(_sender:)))
        btnChangeImage.addGestureRecognizer(gestureRec)
        
        let btnText = UILabel()
        btnText.translatesAutoresizingMaskIntoConstraints = false
        btnChangeImage.addSubview(btnText)
        btnText.text = "Change picture"
        btnText.textColor = UIColor.white
        btnText.font = UIFont(name: String.defaultFontR, size: 15)
        btnText.centerXAnchor.constraint(equalTo: btnChangeImage.centerXAnchor).isActive = true
        btnText.centerYAnchor.constraint(equalTo: btnChangeImage.centerYAnchor).isActive = true
        
        scrollView.addSubview(serviceNameCard)
        serviceNameCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        serviceNameCard.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 30).isActive = true
        serviceNameCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        serviceNameCard.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        let lblServiceName = UILabel()
        serviceNameCard.addSubview(lblServiceName)
        lblServiceName.translatesAutoresizingMaskIntoConstraints = false
        lblServiceName.text = "Service Name"
        lblServiceName.leadingAnchor.constraint(equalTo: serviceNameCard.leadingAnchor, constant: 20).isActive = true
        lblServiceName.topAnchor.constraint(equalTo: serviceNameCard.topAnchor, constant: 20).isActive = true
        lblServiceName.trailingAnchor.constraint(equalTo: serviceNameCard.trailingAnchor, constant: -20).isActive = true
        lblServiceName.numberOfLines = 0
        lblServiceName.lineBreakMode = .byWordWrapping
        lblServiceName.font = UIFont(name: String.defaultFontR, size: 15)
        
        serviceNameCard.addSubview(btnSave)
        btnSave.leadingAnchor.constraint(equalTo: serviceNameCard.leadingAnchor, constant: 20).isActive = true
        btnSave.topAnchor.constraint(equalTo: lblServiceName.bottomAnchor, constant: 75).isActive = true
        btnSave.trailingAnchor.constraint(equalTo: serviceNameCard.trailingAnchor, constant: -20).isActive = true
        btnSave.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnSave.addTarget(self, action: #selector(saveServiceName), for: .touchUpInside)
        
        serviceNameCard.addSubview(txtServiceName)
        if let textName = displayName {
            let defaultAccNameArr = textName.components(separatedBy: " ")
            
            displayName = defaultAccNameArr[0]
            txtServiceName.text = displayName
        }
        txtServiceName.leadingAnchor.constraint(equalTo: serviceNameCard.leadingAnchor, constant: 20).isActive = true
        txtServiceName.topAnchor.constraint(equalTo: lblServiceName.bottomAnchor, constant: 10).isActive = true
        txtServiceName.trailingAnchor.constraint(equalTo: serviceNameCard.trailingAnchor, constant: -20).isActive = true
//        txtServiceName.heightAnchor.constraint(equalToConstant: 55).isActive = true
        txtBottomConstraint = txtServiceName.bottomAnchor.constraint(equalTo: btnSave.topAnchor, constant: -10)
        txtBottomConstraint.isActive = true
        
        scrollView.addSubview(deleteServiceCard)
        deleteServiceCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        deleteServiceCard.topAnchor.constraint(equalTo: serviceNameCard.bottomAnchor, constant: 30).isActive = true
        deleteServiceCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        deleteServiceCard.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        deleteServiceCard.addSubview(btnDeleteService)
        btnDeleteService.leadingAnchor.constraint(equalTo: deleteServiceCard.leadingAnchor, constant: 20).isActive = true
        btnDeleteService.topAnchor.constraint(equalTo: deleteServiceCard.topAnchor, constant: 20).isActive = true
        btnDeleteService.trailingAnchor.constraint(equalTo: deleteServiceCard.trailingAnchor, constant: -20).isActive = true
        btnDeleteService.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnDeleteService.addTarget(self, action: #selector(deleteService), for: .touchUpInside)
        
        //activity loader
        scrollView.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.topAnchor.constraint(equalTo: txtServiceName.bottomAnchor, constant: 20).isActive = true
        scrollView.contentSize.height = 850
    }
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        btnSave.isHidden = true
    }
    
    //Function to stopIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        btnSave.isHidden = false
    }
    
    @objc func openChooseType(_sender: UITapGestureRecognizer){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let actionSheet = UIAlertController(title: "Picture Source", message: "Choose a source to upload your picture from", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }else{
                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Camera not available")
            }
            
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose an existing photo", style: .default, handler: { (action: UIAlertAction) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Restore default image", style: .default, handler: { (action: UIAlertAction) in
            self.displayImageView.image = UIImage(named: "default_profile")
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func saveServiceName(){
        let name = txtServiceName.text
        if CheckInternet.Connection(){
            if name == ""{
                toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Provide service name")
            }else{
                start_activity_loader()
                let async_call = URL(string: String.userSVC)
                let request = NSMutableURLRequest(url: async_call!)
                request.httpMethod = "POST"
                let postParameters = ["action":"updateServiceInfo", "name":name!, "serviceID":id!,"username":username!, "os":getAppVersion()]
                
                if let jsonParameters = try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted){
                    let theJSONText = String(data: jsonParameters,encoding: String.Encoding.utf8)
                    let requestBody: Dictionary<String, Any> = [
                        "requestBody":encryptAsyncRequest(requestBody: theJSONText!.description)
                    ]
                    
                    if let postData = (try? JSONSerialization.data(withJSONObject: requestBody, options: JSONSerialization.WritingOptions.prettyPrinted)){
                        
                        request.httpBody = postData
                        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                        request.addValue("application/json", forHTTPHeaderField: "Accept")
                        var session = preference.object(forKey: UserDefaultsKeys.userSession.rawValue) as! String
                        session = session.replacingOccurrences(of: "-", with: "")
                        request.addValue(session, forHTTPHeaderField: "session")
                        request.addValue(username!, forHTTPHeaderField: "username")
                        
                        let task = URLSession.shared.dataTask(with: request as URLRequest){
                            data, response, error in
                            if error != nil {
                                print("error is: \(error!.localizedDescription)")
                                DispatchQueue.main.async {
                                    self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process your request. Try again later...")
                                    self.stop_activity_loader()
                                }
                                return;
                            }
                            do {
                                let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                                
                                
                                if let parseJSON = myJSON {
                                    print("responseBody: \(parseJSON)")
                                    var sessionAuth: String!
                                    sessionAuth = parseJSON["SessionAuth"] as! String?
                                    if sessionAuth == "true" {
                                        DispatchQueue.main.async {
                                            self.logout()
                                        }

                                    }
//                                    var responseBody: String?
                                    var responseCode: Int!
                                    var responseMessage: String?
                                    DispatchQueue.main.async {
                                        responseCode = parseJSON["RESPONSECODE"] as! Int
                                        responseMessage = parseJSON["RESPONSEMESSAGE"] as? String
                                        if responseCode == 0 {
                                            if let responseMessage = responseMessage {
                                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "correct")), toast_message: responseMessage)
                                            }
                                        }else if responseCode == 1 {
                                            if let responseMessage = responseMessage {
                                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: responseMessage)
                                            }
                                        }else{
                                            self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process your request. Try again later ...")
                                        }
                                        self.stop_activity_loader()
                                    }
                                    

                                }
                            }catch{
                                print("error \(error.localizedDescription)")
                                DispatchQueue.main.async {
                                    self.stop_activity_loader()
                                    self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process your request. Try again later ...")
                                }
                            }
                        }
                        task.resume()
                    }
                }
                
            }
        }else{
            displayNoInternet()
        }
        
    }
    
    @objc func deleteService(){
        
        if CheckInternet.Connection(){
            start_activity_loader()
            let async_call = URL(string: String.userSVC)
            let request = NSMutableURLRequest(url: async_call!)
            request.httpMethod = "POST"
            let postParameters = ["action":"removeServiceFromAccount", "serviceID":id!,"username":username!, "os":getAppVersion()]
            
            if let jsonParameters = try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted){
                let theJSONText = String(data: jsonParameters,encoding: String.Encoding.utf8)
                let requestBody: Dictionary<String, Any> = [
                    "requestBody":encryptAsyncRequest(requestBody: theJSONText!.description)
                ]
                
                if let postData = (try? JSONSerialization.data(withJSONObject: requestBody, options: JSONSerialization.WritingOptions.prettyPrinted)){
                    
                    request.httpBody = postData
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                    var session = preference.object(forKey: UserDefaultsKeys.userSession.rawValue) as! String
                    session = session.replacingOccurrences(of: "-", with: "")
                    request.addValue(session, forHTTPHeaderField: "session")
                    request.addValue(username!, forHTTPHeaderField: "username")
                    
                    let task = URLSession.shared.dataTask(with: request as URLRequest){
                        data, response, error in
                        if error != nil {
                            print("error is: \(error!.localizedDescription)")
                            DispatchQueue.main.async {
                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process your request. Try again later...")
                                self.stop_activity_loader()
                            }
                            return;
                        }
                        do {
                            let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            
                            
                            if let parseJSON = myJSON {
                                print("responseBody: \(parseJSON)")
                                var sessionAuth: String!
                                sessionAuth = parseJSON["SessionAuth"] as! String?
                                if sessionAuth == "true" {
                                    DispatchQueue.main.async {
                                        self.logout()
                                    }
                                    
                                }
                                //                                    var responseBody: String?
                                var responseCode: Int!
                                var responseMessage: String?
                                DispatchQueue.main.async {
                                    responseCode = parseJSON["RESPONSECODE"] as! Int
                                    responseMessage = parseJSON["RESPONSEMESSAGE"] as? String
                                    if responseCode == 0 {
                                        if let responseMessage = responseMessage {
                                            self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "correct")), toast_message: responseMessage)
                                        }
                                    }else if responseCode == 1 {
                                        if let responseMessage = responseMessage {
                                            self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: responseMessage)
                                        }
                                    }else{
                                        self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process your request. Try again later ...")
                                    }
                                    self.stop_activity_loader()
                                }
                                
                                
                            }
                        }catch{
                            print("error \(error.localizedDescription)")
                            DispatchQueue.main.async {
                                self.stop_activity_loader()
                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process your request. Try again later ...")
                            }
                        }
                    }
                    task.resume()
                }
            }
        }else{
            displayNoInternet()
        }
        
    }
    
    /*@objc func openChooseType(_sender: UITapGestureRecognizer){
        print("here naa")
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "chooseUploadImageType")
        self.addChildViewController(moveTo)
        moveTo.view.frame = self.view.frame
        self.view.addSubview(moveTo.view)
        moveTo.didMove(toParentViewController: self)
    }*/
}

extension UpdateProfile: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            displayImageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
