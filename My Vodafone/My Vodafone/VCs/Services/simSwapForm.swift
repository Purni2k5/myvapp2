//
//  simSwapForm.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 13/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class simSwapForm: baseViewControllerM, UIPickerViewDelegate, UIPickerViewDataSource {
    
    fileprivate var lblTransferTop1: NSLayoutConstraint?
    fileprivate var lblTransferTop2: NSLayoutConstraint?
    
    fileprivate var cardViewHeight1: NSLayoutConstraint?
    fileprivate var cardViewHeight2: NSLayoutConstraint?
    private var datePicker: UIDatePicker?
    var msisdn: String?
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
    
    let txtDataToMove = UITextField()
    
    //Create a picker view
    func createPickerView(){
        let picker = UIPickerView()
        picker.delegate = self
        picker.tag = 1
        txtIDType.inputView = picker
    }
    
    //Function to create a tool bar
    func createToolBar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(fbbShareVc.dismissKeyBoard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        txtIDType.inputAccessoryView =  toolBar
    }
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        btnSubmit.isHidden = true
    }
    
    //Function to startIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        btnSubmit.isHidden = false
    }
    
    //Function to dismiss keyboard
    @objc func dismissKeyBoard(){
        view.endEditing(true)
    }
    
    let idType = ["Driving License", "NHIS", "National ID Card", "Passport", "Voter ID Card"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return idType.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return idType[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtIDType.text = idType[row]
    }
    
    var username: String?
    let txtFName = UITextField()
    let txtLName = UITextField()
    let btnSubmit = UIButton()
    let txtIDType = UITextField()
    let cheviDown = UIImageView()
    let txtIDNo = UITextField()
    let txtDOB = UITextField()
    let txtAltNo = UITextField()
    let txtBBRemMobile = UITextField()
    let txtSimCard1 = UITextField()
    let txtSimCard2 = UITextField()
    var cardViewSize: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.grayBackground
        setUpViewsSimSwap()
        hideKeyboardWhenTappedAround()
        createPickerView()
        createToolBar()
        
        
        
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        username = UserData["Username"] as? String
        msisdn = preference.object(forKey: "defaultMSISDN") as! String?
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        cardViewSize = cardView.frame.size.height
        let topImageSize = topImage.frame.size.height
        if cardViewSize != 0.0 {
            scrollView.contentSize.height = topImageSize + cardViewSize! + 250
        }
    }
    
    
    func setUpViewsSimSwap(){
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
        backButton.addTarget(self, action: #selector(goToServ), for: .touchUpInside)
        
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
        lblSelectedOffer.text = "Sim Swap"
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
        cardViewHeight1 = cardView.heightAnchor.constraint(equalToConstant: 850)
        cardViewHeight2 = cardView.heightAnchor.constraint(equalToConstant: 900)
        cardViewHeight1?.isActive = true
        
        let lblFName = UILabel()
        scrollView.addSubview(lblFName)
        lblFName.translatesAutoresizingMaskIntoConstraints = false
        lblFName.text = "First Name"
        lblFName.font = UIFont(name: String.defaultFontR, size: 16)
        lblFName.textColor = UIColor.black
        lblFName.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblTransferTop1 = lblFName.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20)
        lblTransferTop2 = lblFName.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 80)
        lblTransferTop1?.isActive = true
        
        scrollView.addSubview(txtFName)
        txtFName.translatesAutoresizingMaskIntoConstraints = false
        txtFName.font = UIFont(name: String.defaultFontR, size: 16)
        txtFName.backgroundColor = UIColor.white
        txtFName.borderStyle = .roundedRect
        txtFName.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtFName.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtFName.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtFName.topAnchor.constraint(equalTo: lblFName.bottomAnchor, constant: 10).isActive = true
        txtFName.placeholder = "eg. John"
        txtFName.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
        
        let lblLName = UILabel()
        scrollView.addSubview(lblLName)
        lblLName.translatesAutoresizingMaskIntoConstraints = false
        lblLName.text = "Last Name"
        lblLName.font = UIFont(name: String.defaultFontR, size: 16)
        lblLName.textColor = UIColor.black
        lblLName.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblLName.topAnchor.constraint(equalTo: txtFName.bottomAnchor, constant: 30).isActive = true
        
        scrollView.addSubview(txtLName)
        txtLName.translatesAutoresizingMaskIntoConstraints = false
        txtLName.font = UIFont(name: String.defaultFontR, size: 16)
        txtLName.backgroundColor = UIColor.white
        txtLName.borderStyle = .roundedRect
        txtLName.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtLName.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtLName.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtLName.topAnchor.constraint(equalTo: lblLName.bottomAnchor, constant: 10).isActive = true
        txtLName.placeholder = "eg. Doe"
        txtLName.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
        
        let lblIDType = UILabel()
        scrollView.addSubview(lblIDType)
        lblIDType.translatesAutoresizingMaskIntoConstraints = false
        lblIDType.text = "ID Type"
        lblIDType.font = UIFont(name: String.defaultFontR, size: 16)
        lblIDType.textColor = UIColor.black
        lblIDType.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblIDType.topAnchor.constraint(equalTo: txtLName.bottomAnchor, constant: 30).isActive = true
        
        scrollView.addSubview(txtIDType)
        txtIDType.translatesAutoresizingMaskIntoConstraints = false
        txtIDType.font = UIFont(name: String.defaultFontR, size: 16)
        txtIDType.backgroundColor = UIColor.white
        txtIDType.borderStyle = .roundedRect
        txtIDType.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtIDType.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtIDType.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtIDType.topAnchor.constraint(equalTo: lblIDType.bottomAnchor, constant: 10).isActive = true
        txtIDType.placeholder = "Select ID Type"
        txtIDType.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
        
        txtIDType.addSubview(cheviDown)
        cheviDown.translatesAutoresizingMaskIntoConstraints = false
        cheviDown.image = UIImage(named: "chevDown")
        cheviDown.widthAnchor.constraint(equalToConstant: 30).isActive = true
        cheviDown.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cheviDown.topAnchor.constraint(equalTo: txtIDType.topAnchor, constant: 10).isActive = true
        cheviDown.trailingAnchor.constraint(equalTo: txtIDType.trailingAnchor, constant: -10).isActive = true
        
        let lblIDNumber = UILabel()
        scrollView.addSubview(lblIDNumber)
        lblIDNumber.translatesAutoresizingMaskIntoConstraints = false
        lblIDNumber.text = "Enter ID Number"
        lblIDNumber.font = UIFont(name: String.defaultFontR, size: 16)
        lblIDNumber.textColor = UIColor.black
        lblIDNumber.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblIDNumber.topAnchor.constraint(equalTo: txtIDType.bottomAnchor, constant: 30).isActive = true
        
        scrollView.addSubview(txtIDNo)
        txtIDNo.translatesAutoresizingMaskIntoConstraints = false
        txtIDNo.font = UIFont(name: String.defaultFontR, size: 16)
        txtIDNo.backgroundColor = UIColor.white
        txtIDNo.borderStyle = .roundedRect
        txtIDNo.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtIDNo.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtIDNo.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtIDNo.topAnchor.constraint(equalTo: lblIDNumber.bottomAnchor, constant: 10).isActive = true
        txtIDNo.placeholder = "eg. G832hr34"
        txtIDNo.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
        
        let lblDOB = UILabel()
        scrollView.addSubview(lblDOB)
        lblDOB.translatesAutoresizingMaskIntoConstraints = false
        lblDOB.text = "Enter date of birth"
        lblDOB.font = UIFont(name: String.defaultFontR, size: 16)
        lblDOB.textColor = UIColor.black
        lblDOB.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblDOB.topAnchor.constraint(equalTo: txtIDNo.bottomAnchor, constant: 30).isActive = true
        
        scrollView.addSubview(txtDOB)
        txtDOB.translatesAutoresizingMaskIntoConstraints = false
        txtDOB.font = UIFont(name: String.defaultFontR, size: 16)
        txtDOB.backgroundColor = UIColor.white
        txtDOB.borderStyle = .roundedRect
        txtDOB.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtDOB.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtDOB.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtDOB.topAnchor.constraint(equalTo: lblDOB.bottomAnchor, constant: 10).isActive = true
        txtDOB.placeholder = ""
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        txtDOB.inputView = datePicker
        txtDOB.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
        
        let lblAltNo = UILabel()
        scrollView.addSubview(lblAltNo)
        lblAltNo.translatesAutoresizingMaskIntoConstraints = false
        lblAltNo.text = "Alternative Contacts"
        lblAltNo.font = UIFont(name: String.defaultFontR, size: 16)
        lblAltNo.textColor = UIColor.black
        lblAltNo.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblAltNo.topAnchor.constraint(equalTo: txtDOB.bottomAnchor, constant: 30).isActive = true
        
        scrollView.addSubview(txtAltNo)
        txtAltNo.translatesAutoresizingMaskIntoConstraints = false
        txtAltNo.font = UIFont(name: String.defaultFontR, size: 16)
        txtAltNo.backgroundColor = UIColor.white
        txtAltNo.borderStyle = .roundedRect
        txtAltNo.keyboardType = .numberPad
        txtAltNo.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtAltNo.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtAltNo.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtAltNo.topAnchor.constraint(equalTo: lblAltNo.bottomAnchor, constant: 10).isActive = true
        txtAltNo.placeholder = "eg. 0202001234"
        txtAltNo.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
        
        let lblNewSims = UILabel()
        scrollView.addSubview(lblNewSims)
        lblNewSims.translatesAutoresizingMaskIntoConstraints = false
        lblNewSims.text = "New SIM card"
        lblNewSims.font = UIFont(name: String.defaultFontR, size: 16)
        lblNewSims.textColor = UIColor.black
        lblNewSims.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblNewSims.topAnchor.constraint(equalTo: txtAltNo.bottomAnchor, constant: 30).isActive = true
        
        scrollView.addSubview(txtSimCard1)
        txtSimCard1.translatesAutoresizingMaskIntoConstraints = false
        txtSimCard1.font = UIFont(name: String.defaultFontR, size: 16)
        txtSimCard1.backgroundColor = UIColor.white
        txtSimCard1.borderStyle = .roundedRect
        txtSimCard1.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtSimCard1.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtSimCard1.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtSimCard1.topAnchor.constraint(equalTo: lblNewSims.bottomAnchor, constant: 10).isActive = true
        txtSimCard1.placeholder = "eg. 123456789"
        txtSimCard1.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
        
        scrollView.addSubview(txtSimCard2)
        txtSimCard2.translatesAutoresizingMaskIntoConstraints = false
        txtSimCard2.font = UIFont(name: String.defaultFontR, size: 16)
        txtSimCard2.backgroundColor = UIColor.white
        txtSimCard2.borderStyle = .roundedRect
        txtSimCard2.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtSimCard2.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtSimCard2.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtSimCard2.topAnchor.constraint(equalTo: txtSimCard1.bottomAnchor, constant: 10).isActive = true
        txtSimCard2.placeholder = "eg. 123456789"
        txtSimCard2.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
        
        scrollView.addSubview(btnSubmit)
        btnSubmit.translatesAutoresizingMaskIntoConstraints = false
        btnSubmit.backgroundColor = UIColor.grayButton
        btnSubmit.isEnabled = false
        btnSubmit.setTitle("Submit Request", for: .normal)
        btnSubmit.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnSubmit.setTitleColor(UIColor.white, for: .normal)
        btnSubmit.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        btnSubmit.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        btnSubmit.topAnchor.constraint(equalTo: txtSimCard2.bottomAnchor, constant: 20).isActive = true
        btnSubmit.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnSubmit.addTarget(self, action: #selector(sendRequest), for: .touchUpInside)
        
        scrollView.contentSize.height = 3800
    }
    
    
    //Function to go to Services
    @objc func goToServ(){
        let storyboard = UIStoryboard(name: "OffersExtras", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "displayChosenOfferVc") as? displayChosenOfferVc else {return}
        moveTo.selectedOffer = "Services"
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func sendRequest(){
        let fName = txtFName.text
        let lName = txtLName.text
        let idTypeSel = idType.index(of: txtIDType.text!)
        let idNo = txtIDNo.text
        let dob  = txtDOB.text
        let altNo = txtAltNo.text
        let simCard1 = txtSimCard1.text
        let simCard2 = txtSimCard2.text
        
        if !CheckInternet.Connection(){
            displayNoInternet()
        }else{
            start_activity_loader()
            
            let postParameters: Dictionary<String, Any> = [
                "action":"simSwap",
                "firstname":fName!,
                "lastname":lName!,
                "idtype":String(idTypeSel!),
                "idnumber":idNo!,
                "dob":dob!,
                "sim_number":simCard1!,
                "alternatenumber":altNo!,
                "msisdn":msisdn!,
                "os":getAppVersion()
            ]
            
            let async_call = URL(string: String.userURL)
            let request = NSMutableURLRequest(url: async_call!)
            request.httpMethod = "POST"
            
            if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
                request.httpBody = postData
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                
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
                    
                    do {
                        let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        if let parseJSON = myJSON {
                            var responseCode: Int?
                            responseCode = parseJSON["RESPONSECODE"] as! Int?
                            
                            DispatchQueue.main.async {
                                if responseCode == 1 || responseCode == 2 {
                                    let responseMessage = parseJSON["RESPONSEMESSAGE"] as! String?
                                    self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: responseMessage!)
                                }else{
                                    let responseMessage = parseJSON["RESPONSEMESSAGE"] as! String?
                                    self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "correct")), toast_message: responseMessage!)
                                }
                            }
                        }
                        
                    }catch{
                        print(error.localizedDescription)
                        DispatchQueue.main.async {
                            self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry request not processed try again later")
                        }
                    }
                }
                task.resume()
            }
        }
        
    }
    
    @objc func checkInputs(){
        if txtSimCard2.text != "" && txtSimCard1.text != "" && txtAltNo.text != "" && txtDOB.text != "" && txtIDType.text != "" && txtLName.text != "" && txtFName.text != "" && txtIDNo.text != ""{
            btnSubmit.isEnabled = true
            btnSubmit.backgroundColor = UIColor.vodaRed
        }else{
            btnSubmit.isEnabled = false
            btnSubmit.backgroundColor = UIColor.grayButton
        }
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        txtDOB.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    func errorDialog(errorMssg: String){
        let errorView = UIView()
        self.view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.backgroundColor = UIColor.darkGray
        errorView.heightAnchor.constraint(equalToConstant: 60).isActive = true
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
        errorMessage.text = errorMssg
        errorMessage.textColor = UIColor.white
        errorMessage.font = UIFont(name: String.defaultFontR, size: 18)
        errorMessage.numberOfLines = 0
        errorMessage.lineBreakMode = .byWordWrapping
        errorMessage.leadingAnchor.constraint(equalTo: errorImage.trailingAnchor, constant: 10).isActive = true
        errorMessage.topAnchor.constraint(equalTo: errorView.topAnchor, constant: 15).isActive = true
        errorMessage.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -1).isActive = true
    }

}
