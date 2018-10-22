//
//  AddServiceViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 12/06/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class AddServiceViewController: baseViewControllerM, UIPickerViewDelegate, UIPickerViewDataSource {
    
    

    let preferences = UserDefaults.standard
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var top_bg: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var moView: UIView!
    
    fileprivate var enterNumTopConstraint1: NSLayoutConstraint?
    fileprivate var enterNumTopConstraint2: NSLayoutConstraint?
    fileprivate var lblServiceTypeTop1: NSLayoutConstraint?
    fileprivate var lblServiceTypeTop2: NSLayoutConstraint?
    
    //create closure for button
    let vcButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //create closure for label
    let vcLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        return label
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
    
    let txtServiceType = UITextField()
    let lblaccNum = UILabel()
    let txtAccNum = UITextField()
    let txtBroadbandID = UITextField()
    let lblBroadband = UILabel()
    let btnAddService = UIButton()
    let cardView = UIView()
    let lblServiceType = UILabel()
    
    
    var selectedType: String?
    var broadbandID: String?
    var accNum: String?
    var username: String?
    
    var list = ["Fixed Broadband", "Mobile"]
//    var menuShowing = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViewsAddService()
        // change button colour.
        changeBackColour()
        changeMenuIconColour()
        //code to change image colours
//        self.perform(#selector(changeMenuIconsToWhite), with: nil, afterDelay: 0)
        self.hideKeyboardWhenTappedAround()
        createPickerView()
        createToolBar()
        //Select first index for service type
        txtServiceType.text = list[0]
        let responseData = preferences.object(forKey: "responseData") as! NSDictionary
        username = responseData["Username"] as? String
        
        if AcctType == "PHONE_MOBILE_PRE_P" || AcctType == "BB_FIXED_PRE_P"{
            prePaidMenu()
        }else{
            prePaidMenu()
        }
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        txtServiceType.addTarget(self, action: #selector(checkServiceSelected), for: .allEditingEvents)
        txtBroadbandID.addTarget(self, action: #selector(activateBtn), for: .editingChanged)
        txtAccNum.addTarget(self, action: #selector(activateBtn), for: .editingChanged)
        activity_loader.isHidden = true
    }
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        btnAddService.isHidden = true
    }
    
    //Function to startIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        btnAddService.isHidden = false
    }
    
    //Function to set up views
    func setUpViewsAddService(){
        
        //hamburger
        let btnHamburger = vcButton
        moView.addSubview(btnHamburger)
        let hamburger_image = UIImage(named: "hamburger")
        let tintedImage = hamburger_image?.withRenderingMode(.alwaysTemplate)
        btnHamburger.setImage(tintedImage, for: .normal)
        btnHamburger.tintColor = UIColor.white
        btnHamburger.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnHamburger.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnHamburger.topAnchor.constraint(equalTo: moView.safeTopAnchor, constant: 10).isActive = true
        btnHamburger.trailingAnchor.constraint(equalTo: moView.trailingAnchor, constant: -10).isActive = true
        btnHamburger.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        
        //menu label
        let menuLabel = vcLabel
        view.addSubview(menuLabel)
        menuLabel.text = "Menu"
        menuLabel.font = UIFont(name: String.defaultFontB, size: 14)
        menuLabel.topAnchor.constraint(equalTo: btnHamburger.bottomAnchor, constant: -5).isActive = true
        menuLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -11).isActive = true
        
        //card view
        
        moView.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = UIColor.white
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        cardView.topAnchor.constraint(equalTo: top_bg.bottomAnchor, constant: 20).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 450).isActive = true
        cardView.layer.cornerRadius = 2
        cardView.layer.shadowOffset = CGSize(width: 0, height: 5)
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity =  0.1
        
        //label for service type
        
        moView.addSubview(lblServiceType)
        lblServiceType.translatesAutoresizingMaskIntoConstraints = false
        lblServiceType.text = "Service Type"
        lblServiceType.textColor = UIColor.black
        lblServiceType.font = UIFont(name: String.defaultFontR, size: 17)
        lblServiceType.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblServiceTypeTop1 = lblServiceType.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20)
        lblServiceTypeTop2 = lblServiceType.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 40)
        lblServiceTypeTop1?.isActive = true
        
        //Text field for service type
        
        moView.addSubview(txtServiceType)
        txtServiceType.translatesAutoresizingMaskIntoConstraints = false
        txtServiceType.borderStyle = .roundedRect
        txtServiceType.backgroundColor = UIColor.white
        txtServiceType.font = UIFont(name: String.defaultFontR, size: 17)
        txtServiceType.heightAnchor.constraint(equalToConstant: 55).isActive = true
        txtServiceType.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtServiceType.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtServiceType.topAnchor.constraint(equalTo: lblServiceType.bottomAnchor, constant: 15).isActive = true
        
        //chevi down
        let cheviDown = UIImageView(image: #imageLiteral(resourceName: "chevDown"))
        moView.addSubview(cheviDown)
        cheviDown.translatesAutoresizingMaskIntoConstraints = false
        cheviDown.widthAnchor.constraint(equalToConstant: 30).isActive = true
        cheviDown.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cheviDown.trailingAnchor.constraint(equalTo: txtServiceType.trailingAnchor, constant: -10).isActive = true
        cheviDown.topAnchor.constraint(equalTo: txtServiceType.topAnchor, constant: 10).isActive = true
        
        //label for broadband ID
        
        moView.addSubview(lblBroadband)
        lblBroadband.translatesAutoresizingMaskIntoConstraints = false
        lblBroadband.text = "Enter your User ID"
        lblBroadband.textColor = UIColor.black
        lblBroadband.font = UIFont(name: String.defaultFontR, size: 17)
        lblBroadband.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblBroadband.topAnchor.constraint(equalTo: txtServiceType.bottomAnchor, constant: 30).isActive = true
        
        //Text field for broadband ID
        
        moView.addSubview(txtBroadbandID)
        txtBroadbandID.translatesAutoresizingMaskIntoConstraints = false
        txtBroadbandID.borderStyle = .roundedRect
        txtBroadbandID.backgroundColor = UIColor.white
        txtBroadbandID.font = UIFont(name: String.defaultFontR, size: 17)
        txtBroadbandID.heightAnchor.constraint(equalToConstant: 55).isActive = true
        txtBroadbandID.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtBroadbandID.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtBroadbandID.topAnchor.constraint(equalTo: lblBroadband.bottomAnchor, constant: 15).isActive = true
        
        //label for account number
        
        moView.addSubview(lblaccNum)
        lblaccNum.translatesAutoresizingMaskIntoConstraints = false
        lblaccNum.text = "Enter your account number"
        enterNumTopConstraint1 = lblaccNum.topAnchor.constraint(equalTo: txtBroadbandID.bottomAnchor, constant: 30)
        enterNumTopConstraint2 = lblaccNum.topAnchor.constraint(equalTo: txtServiceType.bottomAnchor, constant: 30)
        lblaccNum.textColor = UIColor.black
        lblaccNum.font = UIFont(name: String.defaultFontR, size: 17)
        lblaccNum.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        enterNumTopConstraint1?.isActive = true
        
        //Text field for broadband ID
        
        moView.addSubview(txtAccNum)
        txtAccNum.translatesAutoresizingMaskIntoConstraints = false
        txtAccNum.borderStyle = .roundedRect
        txtAccNum.backgroundColor = UIColor.white
        txtAccNum.font = UIFont(name: String.defaultFontR, size: 17)
        txtAccNum.heightAnchor.constraint(equalToConstant: 55).isActive = true
        txtAccNum.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtAccNum.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtAccNum.topAnchor.constraint(equalTo: lblaccNum.bottomAnchor, constant: 15).isActive = true
        
        // Add service button
        
        moView.addSubview(btnAddService)
        btnAddService.translatesAutoresizingMaskIntoConstraints = false
        btnAddService.backgroundColor = UIColor.grayButton
        btnAddService.setTitle("Add Service", for: .normal)
        btnAddService.titleLabel?.font = UIFont(name: String.defaultFontR, size: 20)
        btnAddService.setTitleColor(UIColor.white, for: .normal)
        btnAddService.topAnchor.constraint(equalTo: txtAccNum.bottomAnchor, constant: 30).isActive = true
        btnAddService.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        btnAddService.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        btnAddService.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnAddService.addTarget(self, action: #selector(addService), for: .touchUpInside)
        
        //activity loader
        moView.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.topAnchor.constraint(equalTo: txtAccNum.bottomAnchor, constant: 30).isActive = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = list[row]
        txtServiceType.text = selectedType
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Function to create picker view for accounts
    func createPickerView(){
        let accountPicker = UIPickerView()
        accountPicker.delegate = self
        txtServiceType.inputView = accountPicker
    }
    
    //Function to create a tool bar
    func createToolBar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        txtServiceType.inputAccessoryView =  toolBar
    }
    
    // change back button colour
    func changeBackColour(){
        let back_image = UIImage(named: "leftArrow")
        let tintedImage = back_image?.withRenderingMode(.alwaysTemplate)
        btnBack.setImage(tintedImage, for: .normal)
        btnBack.tintColor = UIColor.white
    }
    //change menu button icon colour
    func changeMenuIconColour(){
        
    }
    //NB have also hooked up the close btn 
   
    
    //change menu images to white colour
    @objc func checkServiceSelected(){
        if selectedType == "Mobile"{
            enterNumTopConstraint1?.isActive = false
            enterNumTopConstraint2?.isActive = true
            lblaccNum.text = "Enter your mobile number"
            lblBroadband.isHidden = true
            txtBroadbandID.isHidden = true
            txtAccNum.keyboardType = .numberPad
        }else{
            enterNumTopConstraint2?.isActive = false
            enterNumTopConstraint1?.isActive = true
            lblBroadband.isHidden = false
            txtBroadbandID.isHidden = false
            lblaccNum.text = "Enter your account number"
            txtAccNum.keyboardType = .alphabet
        }
        
        if txtBroadbandID.text != "" || txtAccNum.text != "" {
            btnAddService.backgroundColor = UIColor.vodaRed
        }
    }
    
    @objc func activateBtn(){
        if txtBroadbandID.text != "" || txtAccNum.text != "" {
            btnAddService.backgroundColor = UIColor.vodaRed
        }
    }
    
    @objc func addService(){
        txtBroadbandID.resignFirstResponder()
        txtAccNum.resignFirstResponder()
        broadbandID = txtBroadbandID.text
        accNum = txtAccNum.text
        print("accNum \(accNum)")
        
        if selectedType == "Mobile" {
            broadbandID = ""
            selectedType = "PHONE_MOBILE"
        }else{
            selectedType = "BB_FIXED"
        }
        if accNum == ""{
            //display error message
            let error_bg = UIView()
            scrollView.addSubview(error_bg)
            error_bg.translatesAutoresizingMaskIntoConstraints = false
            error_bg.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
            error_bg.topAnchor.constraint(equalTo: cardView.topAnchor, constant: -10).isActive = true
            error_bg.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
            error_bg.heightAnchor.constraint(equalToConstant: 40).isActive = true
            error_bg.backgroundColor = UIColor.grayButton
            lblServiceTypeTop1?.isActive = false
            lblServiceTypeTop2?.isActive = true
            
            //info image
            let infoImage = UIImageView(image: #imageLiteral(resourceName: "info"))
            scrollView.addSubview(infoImage)
            infoImage.translatesAutoresizingMaskIntoConstraints = false
            infoImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
            infoImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
            infoImage.leadingAnchor.constraint(equalTo: error_bg.leadingAnchor, constant: 10).isActive = true
            infoImage.topAnchor.constraint(equalTo: error_bg.topAnchor, constant: 8).isActive = true
            
            //label for error message
            let errorMessage = UILabel()
            scrollView.addSubview(errorMessage)
            errorMessage.translatesAutoresizingMaskIntoConstraints = false
            errorMessage.text = "All fields are required"
            errorMessage.textColor = UIColor.white
            errorMessage.font = UIFont(name: String.defaultFontR, size: 16)
            errorMessage.leadingAnchor.constraint(equalTo: infoImage.trailingAnchor, constant: 10).isActive = true
            errorMessage.topAnchor.constraint(equalTo: error_bg.topAnchor, constant: 10).isActive = true
            
        }else{
            //check for internet connectivity
            if !CheckInternet.Connection(){
                let storyboard = UIStoryboard(name: "Support", bundle: nil)
                let moveTo = storyboard.instantiateViewController(withIdentifier: "NointernetViewController")
                self.addChildViewController(moveTo)
                moveTo.view.frame = self.view.frame
                self.view.addSubview(moveTo.view)
                self.didMove(toParentViewController: moveTo.self)
            }else{
                start_activity_loader()
                var postParameters: Dictionary<String, Any> = [:]
                if selectedType == "PHONE_MOBILE" {
                    broadbandID = ""
                    
                    postParameters = [
                        "action":"addServiceToAccount",
                        "serviceType": selectedType!,
                        "primaryID": accNum!,
                        "secondaryID": "",
                        "username":username!,
                        "os":getAppVersion()
                    ]
                }else{
                    
                    postParameters = [
                        "action":"addServiceToAccount",
                        "serviceType": selectedType!,
                        "primaryID": broadbandID!,
                        "secondaryID": accNum!,
                        "username":username!,
                        "os":getAppVersion()
                    ]
                }
                
                print("para:: \(postParameters)")
                
                let asyn_call = URL(string: String.oldUserSVC)
                let request = NSMutableURLRequest(url: asyn_call!)
                request.httpMethod = "POST"
                
                
                //Convert to json
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
                        do{
                            //converting response to NSDictionary
                            let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            if let parseJSON = myJSON {
                                print("parse \(parseJSON)")
                                var responseCode: Int!
                                var responseMessage: String!
                                var serviceID: String!
                                var responseData: NSDictionary!
                                if let responseCodeOp = parseJSON["RESPONSECODE"] {
                                    responseCode = responseCodeOp as! Int
                                    if let responseMessageOp = parseJSON["RESPONSEMESSAGE"]{
                                        responseMessage = responseMessageOp as! String
                                        print("parse:: \(parseJSON)")
                                        DispatchQueue.main.async {
                                            if responseCode == 1{
                                                self.stop_activity_loader()
                                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: responseMessage)
                                            }else if responseCode == 2 {
                                                self.stop_activity_loader()
                                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: responseMessage)
                                            }
                                            else{
                                                responseData = parseJSON["RESPONSEDATA"] as! NSDictionary
                                                serviceID = responseData["ServiceID"] as! String
                                                let storyboard = UIStoryboard(name: "Services", bundle: nil)
                                                let moveTo = storyboard.instantiateViewController(withIdentifier: "AddServiceConfViewController") as! AddServiceConfViewController
                                                moveTo.responseMessage = responseMessage
                                                moveTo.serviceID = serviceID
                                                self.present(moveTo, animated: true, completion: nil)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                            }
                        }catch{
                            print(error.localizedDescription)
                            DispatchQueue.main.async {
                                self.stop_activity_loader()
                            }
                        }
                    }
                    task.resume()
                }
            }
        }
        
        
        
    }
    

}
