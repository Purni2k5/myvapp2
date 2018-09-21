//
//  RoamingFaultReporting.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 21/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class RoamingFaultReporting: baseViewControllerM, UIPickerViewDelegate, UIPickerViewDataSource {

    var username: String?
    //create a closure for motherView
    let motherViewR: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.grayBackground
        return view
    }()
    //create a closure for scroll view
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    //create closure for top image
    let topImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //create closure for back button
    let btnBack: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //create a closure for hamburger
    let btnMenu: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
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
    
    let btnSend = UIButton()
    let txtMSISDN = UITextField()
    let txtReportType = UITextField()
    let txtReportCat = UITextField()
    let txtReportCom = UITextView()
    let txtAltNumber = UITextField()
    let cheviDown = UIImageView()
    
    let reportTypeList = ["Mobile"]
    let reportCatList = ["Select your report category","Cannot Bundle", "Bundle Refunds", "Cannot Recharge", "Over Scratched Card", "Recharge Not Reflecting", "SMS Issues", "Cannot Send SMS", "Cannot Receive SMS", "Cannot Make Calls", "Cannot Receive Calls", "Roaming Issues", "Cannot Browse", "Other"]

    var msisdn: String?
    var reportType: String?
    var reportCat: String?
    var reportCom: String?
    var altNum: String?
    var listToReturn: Int?
    var returnTypeString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground
        checkConnection()
        
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        username = UserData["Username"] as? String
        msisdn = preference.object(forKey: "defaultMSISDN") as! String?
        setUpViewsRoamingFault()
        
        self.hideKeyboardWhenTappedAround()
        createPickerView()
        createCatPicker()
        createToolBar()
        //Select first index for service type
        txtReportType.text = reportTypeList[0]
        
        
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        txtMSISDN.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
        //        txtReportType.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
        //        txtReportCat.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
        txtAltNumber.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
    }
    
    func setUpViewsRoamingFault(){
        view.addSubview(motherView)
        motherView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        motherView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        motherView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        motherView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
        motherView.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: motherView.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: motherView.safeTopAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: motherView.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: motherView.safeBottomAnchor).isActive = true
        
        scrollView.addSubview(topImage)
        let top_image = UIImage(named: "bg2")
        topImage.image = top_image
        topImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        topImage.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        topImage.trailingAnchor.constraint(equalTo: motherView.trailingAnchor).isActive = true
        topImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        //Back button
        scrollView.addSubview(btnBack)
        let backImage = UIImage(named: "leftArrow")
        let tintedImage = backImage?.withRenderingMode(.alwaysTemplate)
        btnBack.setImage(tintedImage, for: .normal)
        btnBack.tintColor = UIColor.white
        btnBack.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 10).isActive = true
        btnBack.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 10).isActive = true
        btnBack.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnBack.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnBack.addTarget(self, action: #selector(goToTravelling), for: .touchUpInside)
        
        //Menu
        scrollView.addSubview(btnMenu)
        let menu_image = UIImage(named: "menu")
        btnMenu.setImage(menu_image, for: .normal)
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
        lblMenu.topAnchor.constraint(equalTo: btnMenu.bottomAnchor, constant: 1).isActive = true
        lblMenu.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -13).isActive = true
        
        //Header
        let lblReport = UILabel()
        scrollView.addSubview(lblReport)
        lblReport.translatesAutoresizingMaskIntoConstraints = false
        lblReport.text = "Report a Fault"
        lblReport.textColor = UIColor.white
        lblReport.textAlignment = .center
        lblReport.font = UIFont(name: String.defaultFontR, size: 30)
        lblReport.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        lblReport.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 90).isActive = true
        lblReport.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        
        //Card view
        let cardView = UIView()
        scrollView.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = UIColor.white
        cardView.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 20).isActive = true
        cardView.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 30).isActive = true
        cardView.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -20).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 700).isActive = true
        cardView.layer.cornerRadius = 2
        cardView.layer.shadowOffset = CGSize(width: 0, height: 5)
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.2
        
        //txt msisdn
        
        scrollView.addSubview(txtMSISDN)
        txtMSISDN.translatesAutoresizingMaskIntoConstraints = false
        txtMSISDN.backgroundColor = UIColor.white
        txtMSISDN.borderStyle = .roundedRect
        txtMSISDN.font = UIFont(name: String.defaultFontR, size: 17)
        txtMSISDN.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtMSISDN.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtMSISDN.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 50).isActive = true
        txtMSISDN.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtMSISDN.text = msisdn!
        
        // label for report type
        let lblReportType = UILabel()
        scrollView.addSubview(lblReportType)
        lblReportType.translatesAutoresizingMaskIntoConstraints = false
        lblReportType.textColor = UIColor.black
        lblReportType.text = "Report Type"
        lblReportType.font = UIFont(name: String.defaultFontR, size: 17)
        lblReportType.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblReportType.topAnchor.constraint(equalTo: txtMSISDN.bottomAnchor, constant: 30).isActive = true
        lblReportType.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        
        //txt report Type
        
        scrollView.addSubview(txtReportType)
        txtReportType.translatesAutoresizingMaskIntoConstraints = false
        txtReportType.backgroundColor = UIColor.white
        txtReportType.borderStyle = .roundedRect
        txtReportType.font = UIFont(name: String.defaultFontR, size: 17)
        txtReportType.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtReportType.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtReportType.topAnchor.constraint(equalTo: lblReportType.bottomAnchor, constant: 10).isActive = true
        txtReportType.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        
        txtReportType.addSubview(cheviDown)
        cheviDown.translatesAutoresizingMaskIntoConstraints = false
        cheviDown.image = UIImage(named: "chevDown")
        cheviDown.widthAnchor.constraint(equalToConstant: 30).isActive = true
        cheviDown.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cheviDown.topAnchor.constraint(equalTo: txtReportType.topAnchor, constant: 10).isActive = true
        cheviDown.trailingAnchor.constraint(equalTo: txtReportType.trailingAnchor, constant: -10).isActive = true
        
        // label for report category
        let lblReportCat = UILabel()
        scrollView.addSubview(lblReportCat)
        lblReportCat.translatesAutoresizingMaskIntoConstraints = false
        lblReportCat.textColor = UIColor.black
        lblReportCat.text = "Report Category"
        lblReportCat.font = UIFont(name: String.defaultFontR, size: 17)
        lblReportCat.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblReportCat.topAnchor.constraint(equalTo: txtReportType.bottomAnchor, constant: 30).isActive = true
        lblReportCat.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        
        //txt report Type
        
        scrollView.addSubview(txtReportCat)
        txtReportCat.translatesAutoresizingMaskIntoConstraints = false
        txtReportCat.backgroundColor = UIColor.white
        txtReportCat.borderStyle = .roundedRect
        txtReportCat.placeholder = "Select your report category"
        txtReportCat.font = UIFont(name: String.defaultFontR, size: 17)
        txtReportCat.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtReportCat.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtReportCat.topAnchor.constraint(equalTo: lblReportCat.bottomAnchor, constant: 10).isActive = true
        txtReportCat.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        
        let reportCatChevi = UIImageView()
        txtReportCat.addSubview(reportCatChevi)
        reportCatChevi.translatesAutoresizingMaskIntoConstraints = false
        reportCatChevi.image = UIImage(named: "chevDown")
        reportCatChevi.widthAnchor.constraint(equalToConstant: 30).isActive = true
        reportCatChevi.heightAnchor.constraint(equalToConstant: 30).isActive = true
        reportCatChevi.topAnchor.constraint(equalTo: txtReportCat.topAnchor, constant: 10).isActive = true
        reportCatChevi.trailingAnchor.constraint(equalTo: txtReportCat.trailingAnchor, constant: -10).isActive = true
        
        // label for report comment
        let lblReportCom = UILabel()
        scrollView.addSubview(lblReportCom)
        lblReportCom.translatesAutoresizingMaskIntoConstraints = false
        lblReportCom.textColor = UIColor.black
        lblReportCom.text = "Report Comment"
        lblReportCom.font = UIFont(name: String.defaultFontR, size: 17)
        lblReportCom.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblReportCom.topAnchor.constraint(equalTo: txtReportCat.bottomAnchor, constant: 30).isActive = true
        lblReportCom.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        
        //txt report comments
        
        scrollView.addSubview(txtReportCom)
        txtReportCom.translatesAutoresizingMaskIntoConstraints = false
        txtReportCom.backgroundColor = UIColor.white
        txtReportCom.layer.borderColor = UIColor.gray.withAlphaComponent(0.60).cgColor
        txtReportCom.layer.borderWidth = 0.8
        txtReportCom.font = UIFont(name: String.defaultFontR, size: 17)
        txtReportCom.heightAnchor.constraint(equalToConstant: 110).isActive = true
        txtReportCom.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtReportCom.topAnchor.constraint(equalTo: lblReportCom.bottomAnchor, constant: 10).isActive = true
        txtReportCom.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtReportCom.isScrollEnabled = false
        
        
        // label for report type
        let lblAltNum = UILabel()
        scrollView.addSubview(lblAltNum)
        lblAltNum.translatesAutoresizingMaskIntoConstraints = false
        lblAltNum.textColor = UIColor.black
        lblAltNum.text = "Alternative Number"
        lblAltNum.font = UIFont(name: String.defaultFontR, size: 17)
        lblAltNum.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblAltNum.topAnchor.constraint(equalTo: txtReportCom.bottomAnchor, constant: 30).isActive = true
        lblAltNum.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        
        //txt report Type
        
        scrollView.addSubview(txtAltNumber)
        txtAltNumber.translatesAutoresizingMaskIntoConstraints = false
        txtAltNumber.backgroundColor = UIColor.white
        txtAltNumber.borderStyle = .roundedRect
        txtAltNumber.keyboardType = .numberPad
        txtAltNumber.font = UIFont(name: String.defaultFontR, size: 17)
        txtAltNumber.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtAltNumber.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtAltNumber.topAnchor.constraint(equalTo: lblAltNum.bottomAnchor, constant: 10).isActive = true
        txtAltNumber.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        
        //Send button
        
        scrollView.addSubview(btnSend)
        btnSend.translatesAutoresizingMaskIntoConstraints = false
        btnSend.backgroundColor = UIColor.grayButton
        btnSend.setTitle("Send", for: .normal)
        btnSend.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnSend.setTitleColor(UIColor.white, for: .normal)
        btnSend.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        btnSend.topAnchor.constraint(equalTo: txtAltNumber.bottomAnchor, constant: 30).isActive = true
        btnSend.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        btnSend.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnSend.addTarget(self, action: #selector(sendFault), for: .touchUpInside)
        scrollView.contentSize.height = 920
        
        view.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.topAnchor.constraint(equalTo: txtAltNumber.bottomAnchor, constant: 30).isActive = true
        
    }
    
    @objc func checkInputs(){
        msisdn = txtMSISDN.text
        reportType = txtReportType.text
        reportCat = txtReportCat.text
        reportCom = txtReportCom.text
        altNum = txtAltNumber.text
        print(altNum!.count)
        if msisdn == "" || msisdn!.count < 10 || reportType == "" || reportCom == "" || altNum == "" || altNum!.count < 10 {
            btnSend.backgroundColor = UIColor.grayButton
        }else{
            btnSend.backgroundColor = UIColor.vodaRed
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return reportTypeList.count
        }else{
            return reportCatList.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return reportTypeList[row]
        }else{
            return reportCatList[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            txtReportType.text = reportTypeList[row]
        }else{
            txtReportCat.text = reportCatList[row]
        }
        
    }
    
    //Function to create picker view for accounts
    func createPickerView(){
        let accountPicker = UIPickerView()
        accountPicker.delegate = self
        accountPicker.tag = 1
        txtReportType.inputView = accountPicker
    }
    
    //Function to create picker view for report categories
    func createCatPicker(){
        let catPicker = UIPickerView()
        catPicker.delegate = self
        catPicker.tag = 2
        txtReportCat.inputView = catPicker
    }
    //Function to create a tool bar
    func createToolBar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        txtReportType.inputAccessoryView =  toolBar
        txtReportCat.inputAccessoryView = toolBar
    }
    
    //Report fault
    @objc func sendFault(){
        msisdn = txtMSISDN.text
        reportType = txtReportType.text
        reportCat = txtReportCat.text
        reportCom = txtReportCom.text
        altNum = txtAltNumber.text
        if msisdn == "" || msisdn!.count < 10{
            toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Provide phone number or a valid phone number")
        }else{
            if reportType == "" {
                toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Choose report type")
            }else{
                if reportCat == "" {
                    toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Choose report category")
                }else{
                    if reportCom == "" {
                        toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Provide description of the fault")
                    }else{
                        if altNum == "" {
                            toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Provide alternative phone number")
                        }else{
                            if altNum!.count < 10 {
                                toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Please alternative number is invalid")
                            }else{
                                //check for internet connectivity
                                if !CheckInternet.Connection(){
                                    let storyboard = UIStoryboard(name: "Support", bundle: nil)
                                    let moveTo = storyboard.instantiateViewController(withIdentifier: "NointernetViewController")
                                    self.addChildViewController(moveTo)
                                    moveTo.view.frame = self.view.frame
                                    self.view.addSubview(moveTo.view)
                                    moveTo.didMove(toParentViewController: self)
                                }else{
                                    start_activity_loader()
                                    let async_call = URL(string: String.userURL)
                                    let request = NSMutableURLRequest(url: async_call!)
                                    request.httpMethod = "POST"
                                    let postParameters: Dictionary<String, Any> = [
                                        "action":"faultReporting",
                                        "alternativecontact":altNum!,
                                        "reporttype":reportType!,
                                        "reportcategory":reportCat!,
                                        "comment":reportCom!,
                                        "username":username!,
                                        "msisdn":msisdn!,
                                        "type":"roamingfaultreporting"
                                    ]
                                    
                                    if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
                                        request.httpBody = postData
                                        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                                        request.addValue("application/json", forHTTPHeaderField: "Accept")
                                        
                                        let task = URLSession.shared.dataTask(with: request as URLRequest){
                                            data, response, error in
                                            
                                            do {
                                                let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                                                if let parseJSON = myJSON {
                                                    var responseCode: Int?
                                                    responseCode = parseJSON["RESPONSECODE"] as! Int?
                                                    DispatchQueue.main.async {
                                                        if responseCode == 0{
                                                            let responseMessage = parseJSON["RESPONSEMESSAGE"] as! String?
                                                            self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "correct")), toast_message: responseMessage!)
                                                        }else{
                                                            self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry try again...")
                                                        }
                                                        self.stop_activity_loader()
                                                    }
                                                }
                                            }catch{
                                                print(error.localizedDescription)
                                                DispatchQueue.main.async {
                                                    self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry request could not be processed")
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
                }
            }
        }
    }

    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        btnSend.isHidden = true
    }
    
    //Function to startIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        btnSend.isHidden = false
    }
}
