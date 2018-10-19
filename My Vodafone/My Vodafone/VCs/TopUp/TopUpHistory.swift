//
//  TopUpHistory.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 09/10/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

struct HistoryCellData {
    let date: String?
    let mainIcon: UIImage?
    let dateTime: String?
    let amount: String?
    let topUpType: String?
}

class TopUpHistory: baseViewControllerM, UIPickerViewDelegate, UIPickerViewDataSource {
    

    var username: String?
    var selectedAccount: String?
    fileprivate var cardViewHeight: NSLayoutConstraint?
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
        return view
    }()
    
    //Store table
    let storeTableView: UITableView = {
        let tableView = UITableView()
        return tableView
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
    
    let txtTopUpNumber = UITextField()
    let txtSrchType = UITextField()
    let separator1 = UIView()
    
    var registeredAccounts = [String]()
    let srchList = ["Order By-Date", "Order By-Amount"]
    var cellID = "cellID"
    var topUpData = [HistoryCellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground

        setUpViewsTopUpHist()
        checkConnection()
        populatePickerView()
        createPickerView()
        createPickerViewSrchType()
        createToolBar()
        
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        username = UserData["Username"] as? String
        
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
        getHistoryFromUserDefaults()
        getHistory()
    }
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
    }
    
    //Function to stopIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
    }
    
    func setUpViewsTopUpHist(){
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
        backButton.addTarget(self, action: #selector(goToTopUpM), for: .touchUpInside)
        
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
        lblSelectedOffer.text = "Top Up History"
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
        cardViewHeight = cardView.heightAnchor.constraint(equalToConstant: 380)
        cardViewHeight?.isActive = true
        
        cardView.addSubview(txtTopUpNumber)
        txtTopUpNumber.translatesAutoresizingMaskIntoConstraints = false
        txtTopUpNumber.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        txtTopUpNumber.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10).isActive = true
        txtTopUpNumber.widthAnchor.constraint(equalToConstant: 120).isActive = true
        txtTopUpNumber.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtTopUpNumber.backgroundColor = UIColor.white
        txtTopUpNumber.font = UIFont(name: String.defaultFontR, size: 17)
        txtTopUpNumber.layer.borderColor = UIColor.gray.cgColor
        txtTopUpNumber.layer.borderWidth = 1.0
        txtTopUpNumber.borderStyle = .roundedRect
        
        cardView.addSubview(txtSrchType)
        txtSrchType.translatesAutoresizingMaskIntoConstraints = false
        txtSrchType.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        txtSrchType.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10).isActive = true
        txtSrchType.widthAnchor.constraint(equalToConstant: 120).isActive = true
        txtSrchType.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtSrchType.font = UIFont(name: String.defaultFontR, size: 17)
        txtSrchType.layer.borderColor = UIColor.gray.cgColor
        txtSrchType.layer.borderWidth = 1.0
        txtSrchType.borderStyle = .roundedRect
        
        
        separator1.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(separator1)
        separator1.backgroundColor = UIColor.gray.withAlphaComponent(0.10)
        separator1.heightAnchor.constraint(equalToConstant: 0.2).isActive = true
        separator1.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        separator1.topAnchor.constraint(equalTo: txtTopUpNumber.bottomAnchor, constant: 20).isActive = true
        separator1.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        
        cardView.addSubview(storeTableView)
        storeTableView.translatesAutoresizingMaskIntoConstraints = false
        storeTableView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        storeTableView.topAnchor.constraint(equalTo: separator1.bottomAnchor).isActive = true
        storeTableView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        storeTableView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
        storeTableView.register(TopUpHistoryCells.self, forCellReuseIdentifier: cellID)
        storeTableView.delegate = self
        storeTableView.dataSource = self
        storeTableView.tag = 999
        
        //activity loader
        scrollView.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        activity_loader.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
        
    }
    
    func populatePickerView(){
        let Services = preference.object(forKey: UserDefaultsKeys.ServiceList.rawValue)
        if let array = Services as? NSArray{
            var iterate = 0
            for obj in array {
                
                if let dict = obj as? NSDictionary {
                    let displayName = dict.value(forKey: "DisplayName") as! String
                    
                    var contactPhone = dict.value(forKey: "ContactPhone") as! String
                    let accountType = dict.value(forKey: "Type") as! String
                    let truncNum = contactPhone.dropFirst(3)
                    contactPhone = "0\(truncNum)"
                    let accountInfo = displayName + " " + contactPhone
                    if iterate == 0 {
                        txtTopUpNumber.text = contactPhone
                    }
                    if accountType.contains("BB_FIXED"){
                        
                    }else{
                        registeredAccounts.append(accountInfo)
                    }
                    
                    
                }
                iterate = iterate + 1
            }
        }
        txtSrchType.text = srchList[0]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return registeredAccounts.count
        }else{
            return srchList.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return registeredAccounts[row]
            }else{
            return srchList[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            selectedAccount = registeredAccounts[row]
            
            let accArr = selectedAccount?.components(separatedBy: " ")
            let arrayPick = accArr!.count - 1
            let accountNumber = accArr![arrayPick] //Last
            txtTopUpNumber.text = accountNumber
        }else{
            txtSrchType.text = srchList[row]
        }
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: String.defaultFontR, size: 19)
            pickerLabel?.textAlignment = .center
        }
        if pickerView.tag == 1 {
            pickerLabel?.text = registeredAccounts[row]
        }else{
            pickerLabel?.text = srchList[row]
        }
        
        
        return pickerLabel!
    }
    
    //Function to create picker view for accounts
    func createPickerView(){
        let accountPicker = UIPickerView()
        accountPicker.delegate = self
        accountPicker.tag = 1
        txtTopUpNumber.inputView = accountPicker
    }
    
    func createPickerViewSrchType(){
        let picker = UIPickerView()
        picker.delegate = self
        picker.tag = 2
        txtSrchType.inputView = picker
    }
    //Function to create a tool bar
    func createToolBar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(BuyOfferViewController.dismissKeyBoard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        txtTopUpNumber.inputAccessoryView =  toolBar
        txtSrchType.inputAccessoryView = toolBar
    }
    //Function to dismiss keyboard
    @objc func dismissKeyBoard(){
        view.endEditing(true)
    }

    override func viewDidAppear(_ animated: Bool) {
        txtSrchType.addTarget(self, action: #selector(focusSrchType), for: .touchDown)
        txtTopUpNumber.addTarget(self, action: #selector(updateHistory), for: .editingDidEnd)
    }
    @objc func focusTopUpNumber(textField: UITextField){
        txtTopUpNumber.layer.borderColor = UIColor.vodaRed.cgColor
        txtTopUpNumber.layer.borderWidth = 1.0
    }
    @objc func focusSrchType(textField: UITextField){
        print("Sensed")
        txtSrchType.layer.borderColor = UIColor.vodaRed.cgColor
        txtSrchType.layer.borderWidth = 1.0
        
    }
    
    func getHistoryFromUserDefaults(){
        var msisdn = txtTopUpNumber.text!
        msisdn = "\(msisdn)_topUpHistory"
        if let topUpHistory = preference.object(forKey: msisdn) as! NSArray?{
            for obj in topUpHistory {
                if let dict = obj as? NSDictionary {
                    let purchaseDate = dict.value(forKey: "DATE") as! String
                    let dateTime = dict.value(forKey: "DATETIME") as! String
                    let amount = dict.value(forKey: "AMOUNT") as! String
                    var type = dict.value(forKey: "TYPE") as! String
                    if type == "S_CARD"{
                        type = "Scratch Card"
                    }else if type == "VF_CASH" {
                        type = "Vodafone Cash"
                    }else{
                        type = "Other"
                    }
                    //                                                print(purchaseDate)
                    let history = HistoryCellData(date: purchaseDate, mainIcon: #imageLiteral(resourceName: "ic_top_up"), dateTime: dateTime, amount: "GHS \(amount)", topUpType: "Top up via \(type)")
                    self.topUpData.append(history)
                    
                    
                }
            }
            self.storeTableView.reloadData()
        }else{
            
        }
    }
    
    func getHistory(){
        if !CheckInternet.Connection(){
            displayNoInternet()
        }else{
            start_activity_loader()
            let msisdn = txtTopUpNumber.text!
            var srchType = txtSrchType.text!
            if srchType == "Order By-Date"{
                srchType = "0"
            }else{
                srchType = "1"
            }
            let async_call = URL(string: String.oldUserURL)
            let request = NSMutableURLRequest(url: async_call!)
            request.httpMethod = "POST"
            let postParameters: Dictionary<String, Any> = [
                "action":"topuphistory",
                "option":srchType,
                "username":username!,
                "msisdn":msisdn,
                "os":getAppVersion()
            ]
            
            if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
                request.httpBody = postData
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                
                let task = URLSession.shared.dataTask(with: request as URLRequest){
                    data, response, error in
                    if error != nil {
                        print("error is \(error!.localizedDescription)")
                        DispatchQueue.main.async {
                            self.stop_activity_loader()
                            self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process request..")
                        }
                        return
                    }
                    
                    do {
                        let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        if let parseJSON = myJSON {
                            var responseCode: Int?
                            var responseMessage: NSArray?
                            responseCode = parseJSON["RESPONSECODE"] as! Int?
                            print(parseJSON)
                            DispatchQueue.main.async {
                                if responseCode == 0 {
                                    self.stop_activity_loader()
                                    responseMessage = parseJSON["RESPONSEMESSAGE"] as! NSArray?
//                                    print(responseMessage)
                                    if let resMessage = responseMessage {
                                        let cachedKey = "\(msisdn)_topUpHistory"
                                        self.preference.set(resMessage, forKey: cachedKey)
                                        if self.storeTableView.visibleCells.isEmpty{
                                            
                                        }else{
                                            for _ in self.topUpData {
                                                self.topUpData.remove(at: 0)
                                                let indexPath = IndexPath(item: 0, section: 0)
                                                self.storeTableView.deleteRows(at: [indexPath], with: .fade)
                                            }
                                        }
                                        for obj in resMessage {
                                            if let dict = obj as? NSDictionary {
                                                let purchaseDate = dict.value(forKey: "DATE") as! String
                                                let dateTime = dict.value(forKey: "DATETIME") as! String
//                                                let category = dict.value(forKey: "CATEGORY") as! String
                                                let amount = dict.value(forKey: "AMOUNT") as! String
                                                var type = dict.value(forKey: "TYPE") as! String
                                                if type == "S_CARD"{
                                                    type = "Scratch Card"
                                                }else if type == "VF_CASH" {
                                                    type = "Vodafone Cash"
                                                }else{
                                                    type = "Other"
                                                }
//                                                print(purchaseDate)
                                                let history = HistoryCellData(date: purchaseDate, mainIcon: #imageLiteral(resourceName: "ic_top_up"), dateTime: dateTime, amount: "GHS \(amount)", topUpType: "Top up via \(type)")
                                                self.topUpData.append(history)
                                               
                                            }
                                        }
                                    }
                                }else if responseCode == 1 {
                                    self.stop_activity_loader()
                                    self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process request..")
                                }else{
                                    self.stop_activity_loader()
                                    self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process request..")
                                }
                                self.storeTableView.reloadData()
                            }
                            
                        }
                    }catch {
                        DispatchQueue.main.async {
                            self.stop_activity_loader()
                            self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process request..")
                            print(error.localizedDescription)
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    @objc func updateHistory(){
        var previousNo = txtTopUpNumber.text!
        if !CheckInternet.Connection(){
            displayNoInternet()
        }else{
            for _ in self.topUpData {
                self.topUpData.remove(at: 0)
                let indexPath = IndexPath(item: 0, section: 0)
                self.storeTableView.deleteRows(at: [indexPath], with: .fade)
            }
            previousNo = "\(previousNo)_topUpHistory"
            if let topUpHistory = preference.object(forKey: previousNo) as! NSArray?{
                for obj in topUpHistory {
                    if let dict = obj as? NSDictionary {
                        let purchaseDate = dict.value(forKey: "DATE") as! String
                        let dateTime = dict.value(forKey: "DATETIME") as! String
                        let amount = dict.value(forKey: "AMOUNT") as! String
                        var type = dict.value(forKey: "TYPE") as! String
                        if type == "S_CARD"{
                            type = "Scratch Card"
                        }else if type == "VF_CASH" {
                            type = "Vodafone Cash"
                        }else{
                            type = "Other"
                        }
                        //                                                print(purchaseDate)
                        let history = HistoryCellData(date: purchaseDate, mainIcon: #imageLiteral(resourceName: "ic_top_up"), dateTime: dateTime, amount: "GHS \(amount)", topUpType: "Top up via \(type)")
                        self.topUpData.append(history)
                        
                        
                    }
                }
                self.storeTableView.reloadData()
            }
            refreshData()
        }
        
    }
    
    func refreshData(){
        
        start_activity_loader()
        let msisdn = txtTopUpNumber.text!
        var srchType = txtSrchType.text!
        if srchType == "Order By-Date"{
            srchType = "0"
        }else{
            srchType = "1"
        }
        let async_call = URL(string: String.oldUserURL)
        let request = NSMutableURLRequest(url: async_call!)
        request.httpMethod = "POST"
        let postParameters: Dictionary<String, Any> = [
            "action":"topuphistory",
            "option":srchType,
            "username":username!,
            "msisdn":msisdn,
            "os":getAppVersion()
        ]
        
        if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
            request.httpBody = postData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                if error != nil {
                    print("error is \(error!.localizedDescription)")
                    DispatchQueue.main.async {
                        self.stop_activity_loader()
                        self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process request..")
                    }
                    return
                }
                
                do {
                    let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    if let parseJSON = myJSON {
                        var responseCode: Int?
                        var responseMessage: NSArray?
                        responseCode = parseJSON["RESPONSECODE"] as! Int?
                        print(parseJSON)
                        DispatchQueue.main.async {
                            if responseCode == 0 {
                                self.stop_activity_loader()
                                responseMessage = parseJSON["RESPONSEMESSAGE"] as! NSArray?
                                if let resMessage = responseMessage {
                                    let cachedKey = "\(msisdn)_topUpHistory"
                                    self.preference.set(resMessage, forKey: cachedKey)
                                    if self.storeTableView.visibleCells.isEmpty{
                                        
                                    }else{
                                        for _ in self.topUpData {
                                            self.topUpData.remove(at: 0)
                                            let indexPath = IndexPath(item: 0, section: 0)
                                            self.storeTableView.deleteRows(at: [indexPath], with: .fade)
                                        }
                                    }
                                    for obj in resMessage {
                                        if let dict = obj as? NSDictionary {
                                            let purchaseDate = dict.value(forKey: "DATE") as! String
                                            let dateTime = dict.value(forKey: "DATETIME") as! String
                                            let amount = dict.value(forKey: "AMOUNT") as! String
                                            var type = dict.value(forKey: "TYPE") as! String
                                            if type == "S_CARD"{
                                                type = "Scratch Card"
                                            }else if type == "VF_CASH" {
                                                type = "Vodafone Cash"
                                            }else{
                                                type = "Other"
                                            }
                                            //                                                print(purchaseDate)
                                            let history = HistoryCellData(date: purchaseDate, mainIcon: #imageLiteral(resourceName: "ic_top_up"), dateTime: dateTime, amount: "GHS \(amount)", topUpType: "Top up via \(type)")
                                            self.topUpData.append(history)
                                            
                                            
                                        }
                                    }
                                }
                            }else if responseCode == 1 {
                                self.stop_activity_loader()
                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process request..")
                            }else{
                                self.stop_activity_loader()
                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process request..")
                            }
                            
                            self.storeTableView.reloadData()
                        }
                        
                    }
                }catch {
                    DispatchQueue.main.async {
                        self.stop_activity_loader()
                        self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process request..")
                        print(error.localizedDescription)
                    }
                }
            }
            task.resume()
        }
    }
    }
    


extension TopUpHistory: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topUpData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = storeTableView.dequeueReusableCell(withIdentifier: cellID) as! TopUpHistoryCells
        cell.date = topUpData[indexPath.row].date
        cell.dateTime = topUpData[indexPath.row].dateTime
        cell.amount = topUpData[indexPath.row].amount
        cell.topUpType = topUpData[indexPath.row].topUpType
        cell.mainIcon = topUpData[indexPath.row].mainIcon
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset.left = 30
        cell.separatorInset.right = 30
        cell.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        return cell
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "StoreLocator", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "GetDirectionToStore")
        present(moveTo, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     self.locationData.remove(at: indexPath.row)
     tableView.deleteRows(at: [indexPath], with: .fade)
     }
     }*/
}
