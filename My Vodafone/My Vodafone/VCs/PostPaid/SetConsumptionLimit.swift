//
//  SetComsumptionLimit.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 05/12/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class SetConsumptionLimit: baseViewControllerM {

    var username: String?
    var msisdn: String?
    var hasRated: Bool?
    
    var strtDateCard: String?
    var endDateCard: String?
    var usedAmt: String?
    var limitAmt: String?
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    
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
    
    let lblDate: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 15)
        return view
    }()
    
    let cardViewConsumption: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let cardViewForm: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let lblCardViewConHeader: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.black
        return view
    }()
    
    let txtIDType: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 45).isActive = true
        view.font = UIFont(name: String.defaultFontR, size: 15)
        view.borderStyle = .roundedRect
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let txtIDNo: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 45).isActive = true
        view.font = UIFont(name: String.defaultFontR, size: 15)
        view.borderStyle = .roundedRect
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let txtLimitAmt: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 45).isActive = true
        view.font = UIFont(name: String.defaultFontR, size: 15)
        view.borderStyle = .roundedRect
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let txtStrtDate: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 45).isActive = true
        view.font = UIFont(name: String.defaultFontR, size: 15)
        view.borderStyle = .roundedRect
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let txtendDate: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 45).isActive = true
        view.font = UIFont(name: String.defaultFontR, size: 15)
        view.borderStyle = .roundedRect
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let txtaltNo: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 45).isActive = true
        view.font = UIFont(name: String.defaultFontR, size: 15)
        view.borderStyle = .roundedRect
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let btnSubmit: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.grayButton
        view.setTitle("Submit", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        view.heightAnchor.constraint(equalToConstant: 55).isActive = true
        return view
    }()
    
    let lblStartDateCard: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: String.defaultFontR, size: 14)
        view.text = "Start Date:"
        view.textColor = UIColor.black
        return view
    }()
    
    let lblEndDateCard: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: String.defaultFontR, size: 14)
        view.text = "End Date:"
        view.textColor = UIColor.black
        return view
    }()
    
    let lblUsedAmtCard: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: String.defaultFontR, size: 22)
        view.text = "Used Amount:"
        view.textColor = UIColor.support_voilet
        return view
    }()
    
    let lblLimitAmtCard: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: String.defaultFontR, size: 22)
        view.text = "Limit Amount:"
        view.textColor = UIColor.support_voilet
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
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        btnSubmit.isHidden = true
    }
    
    //Function to stopIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        btnSubmit.isHidden = false
    }
    
    private var strtDatePicker: UIDatePicker?
    private var endDatePicker: UIDatePicker?
    
    let IDTypeArray = ["Driving License", "Health ID", "National ID Card", "Passport", "Voter ID Card"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground

        let responseData = preference.object(forKey: "responseData") as! NSDictionary
        username = responseData["Username"] as? String
        msisdn = preference.object(forKey: "defaultMSISDN") as! String?
        hasRated = preference.object(forKey: UserDefaultsKeys.hasRated.rawValue) as? Bool
        
        
        setUpViewsSetConsumption()
        getConsumptionLimit()
        hideKeyboardWhenTappedAround()
        createPickerView()
        createToolBar()
        checkConnection()
    }
    
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
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyBoard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        txtIDType.inputAccessoryView =  toolBar
    }
    
    //Function to dismiss keyboard
    @objc func dismissKeyBoard(){
        view.endEditing(true)
    }
    
    func setUpViewsSetConsumption(){
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        scrollView.addSubview(topImage)
        let timeOfDay = greetings()
        if timeOfDay == "morning"{
            topImage.image = UIImage(named: "bg2")
        }else if timeOfDay == "afternoon" {
            topImage.image = UIImage(named: "afternoon_bg")
        }else{
            topImage.image = UIImage(named: "evening_bg2")
        }
        topImage.heightAnchor.constraint(equalToConstant: 170).isActive = true
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
        backButton.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 20).isActive = true
        backButton.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 10).isActive = true
        backButton.addTarget(self, action: #selector(goToBack), for: .touchUpInside)
        
        let lblHeader = UILabel()
        scrollView.addSubview(lblHeader)
        lblHeader.translatesAutoresizingMaskIntoConstraints = false
        lblHeader.text = "Consumption Limit"
        lblHeader.textColor = UIColor.white
        lblHeader.font = UIFont(name: String.defaultFontR, size: 31)
        lblHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblHeader.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 50).isActive = true
        lblHeader.numberOfLines = 0
        lblHeader.lineBreakMode = .byWordWrapping
        
        scrollView.addSubview(cardViewConsumption)
        cardViewConsumption.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cardViewConsumption.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 20).isActive = true
        cardViewConsumption.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        cardViewConsumption.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        let redView = UIImageView()
        cardViewConsumption.addSubview(redView)
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.backgroundColor = UIColor.red
        redView.widthAnchor.constraint(equalToConstant: 5).isActive = true
        redView.leadingAnchor.constraint(equalTo: cardViewConsumption.leadingAnchor).isActive = true
        redView.topAnchor.constraint(equalTo: cardViewConsumption.topAnchor).isActive = true
        redView.bottomAnchor.constraint(equalTo: cardViewConsumption.bottomAnchor).isActive = true
        
        let profileImage = UIImageView(image: #imageLiteral(resourceName: "default_profile"))
        cardViewConsumption.addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.leadingAnchor.constraint(equalTo: redView.trailingAnchor, constant: 20).isActive = true
        profileImage.topAnchor.constraint(equalTo: cardViewConsumption.topAnchor, constant: 20).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        cardViewConsumption.addSubview(lblCardViewConHeader)
        lblCardViewConHeader.text = "Your current consumption limit"
        lblCardViewConHeader.font = UIFont(name: String.defaultFontR, size: 18)
        lblCardViewConHeader.numberOfLines = 0
        lblCardViewConHeader.lineBreakMode = .byWordWrapping
        lblCardViewConHeader.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10).isActive = true
        lblCardViewConHeader.topAnchor.constraint(equalTo: cardViewConsumption.topAnchor, constant: 20).isActive = true
        lblCardViewConHeader.trailingAnchor.constraint(equalTo: cardViewConsumption.trailingAnchor, constant: -10).isActive = true
        
        cardViewConsumption.addSubview(lblStartDateCard)
        lblStartDateCard.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10).isActive = true
        lblStartDateCard.topAnchor.constraint(equalTo: lblCardViewConHeader.bottomAnchor, constant: 10).isActive = true
        lblStartDateCard.trailingAnchor.constraint(equalTo: cardViewConsumption.trailingAnchor, constant: -10).isActive = true
        lblStartDateCard.numberOfLines = 0
        lblStartDateCard.lineBreakMode = .byWordWrapping
        
        cardViewConsumption.addSubview(lblUsedAmtCard)
        lblUsedAmtCard.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10).isActive = true
        lblUsedAmtCard.topAnchor.constraint(equalTo: lblStartDateCard.bottomAnchor, constant: 10).isActive = true
        lblUsedAmtCard.trailingAnchor.constraint(equalTo: cardViewConsumption.trailingAnchor, constant: -10).isActive = true
        lblUsedAmtCard.numberOfLines = 0
        lblUsedAmtCard.lineBreakMode = .byWordWrapping
        
        cardViewConsumption.addSubview(lblLimitAmtCard)
        lblLimitAmtCard.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10).isActive = true
        lblLimitAmtCard.topAnchor.constraint(equalTo: lblUsedAmtCard.bottomAnchor, constant: 10).isActive = true
        lblLimitAmtCard.trailingAnchor.constraint(equalTo: cardViewConsumption.trailingAnchor, constant: -10).isActive = true
        lblLimitAmtCard.numberOfLines = 0
        lblLimitAmtCard.lineBreakMode = .byWordWrapping
        
        cardViewConsumption.addSubview(lblEndDateCard)
        lblEndDateCard.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10).isActive = true
        lblEndDateCard.topAnchor.constraint(equalTo: lblLimitAmtCard.bottomAnchor, constant: 10).isActive = true
        lblEndDateCard.trailingAnchor.constraint(equalTo: cardViewConsumption.trailingAnchor, constant: -10).isActive = true
        lblEndDateCard.numberOfLines = 0
        lblEndDateCard.lineBreakMode = .byWordWrapping
        
        let lblFrmHeader = UILabel()
        lblFrmHeader.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(lblFrmHeader)
        lblFrmHeader.textColor = UIColor.support_voilet
        lblFrmHeader.text = "Set Consumption Limit"
        lblFrmHeader.font = UIFont(name: String.defaultFontR, size: 31)
        lblFrmHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblFrmHeader.topAnchor.constraint(equalTo: cardViewConsumption.bottomAnchor, constant: 30).isActive = true
        lblFrmHeader.numberOfLines = 0
        lblFrmHeader.lineBreakMode = .byWordWrapping
        
        scrollView.addSubview(cardViewForm)
        cardViewForm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cardViewForm.topAnchor.constraint(equalTo: lblFrmHeader.bottomAnchor, constant: 20).isActive = true
        cardViewForm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        cardViewForm.heightAnchor.constraint(equalToConstant: 700).isActive = true
        
        let lblIDType = UILabel()
        cardViewForm.addSubview(lblIDType)
        lblIDType.translatesAutoresizingMaskIntoConstraints = false
        lblIDType.text = "ID Type"
        lblIDType.textColor = UIColor.black
        lblIDType.font = UIFont(name: String.defaultFontR, size: 15)
        lblIDType.numberOfLines = 0
        lblIDType.lineBreakMode = .byWordWrapping
        lblIDType.leadingAnchor.constraint(equalTo: cardViewForm.leadingAnchor, constant: 20).isActive = true
        lblIDType.topAnchor.constraint(equalTo: cardViewForm.topAnchor, constant: 30).isActive = true
        lblIDType.trailingAnchor.constraint(equalTo: cardViewForm.trailingAnchor, constant: -20).isActive = true
        
        cardViewForm.addSubview(txtIDType)
        txtIDType.leadingAnchor.constraint(equalTo: cardViewForm.leadingAnchor, constant: 20).isActive = true
        txtIDType.topAnchor.constraint(equalTo: lblIDType.bottomAnchor, constant: 10).isActive = true
        txtIDType.trailingAnchor.constraint(equalTo: cardViewForm.trailingAnchor, constant: -20).isActive = true
        
        let dropDownImage = UIImageView()
        txtIDType.addSubview(dropDownImage)
        dropDownImage.translatesAutoresizingMaskIntoConstraints = false
        let dropImage = UIImage(named: "dropdown")
        dropDownImage.image = dropImage?.withRenderingMode(.alwaysTemplate)
        dropDownImage.tintColor = UIColor.black
        dropDownImage.topAnchor.constraint(equalTo: txtIDType.topAnchor, constant: 20).isActive = true
        dropDownImage.trailingAnchor.constraint(equalTo: txtIDType.trailingAnchor, constant: -20).isActive = true
        dropDownImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        dropDownImage.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        let lblIDNo = UILabel()
        cardViewForm.addSubview(lblIDNo)
        lblIDNo.translatesAutoresizingMaskIntoConstraints = false
        lblIDNo.text = "Enter ID number"
        lblIDNo.textColor = UIColor.black
        lblIDNo.font = UIFont(name: String.defaultFontR, size: 15)
        lblIDNo.numberOfLines = 0
        lblIDNo.lineBreakMode = .byWordWrapping
        lblIDNo.leadingAnchor.constraint(equalTo: cardViewForm.leadingAnchor, constant: 20).isActive = true
        lblIDNo.topAnchor.constraint(equalTo: txtIDType.bottomAnchor, constant: 30).isActive = true
        lblIDNo.trailingAnchor.constraint(equalTo: cardViewForm.trailingAnchor, constant: -20).isActive = true
        
        cardViewForm.addSubview(txtIDNo)
        txtIDNo.leadingAnchor.constraint(equalTo: cardViewForm.leadingAnchor, constant: 20).isActive = true
        txtIDNo.topAnchor.constraint(equalTo: lblIDNo.bottomAnchor, constant: 10).isActive = true
        txtIDNo.trailingAnchor.constraint(equalTo: cardViewForm.trailingAnchor, constant: -20).isActive = true
        txtIDNo.placeholder = "eg: G832hr34"
        
        let lblLimitAmt = UILabel()
        cardViewForm.addSubview(lblLimitAmt)
        lblLimitAmt.translatesAutoresizingMaskIntoConstraints = false
        lblLimitAmt.text = "Limit Amount"
        lblLimitAmt.textColor = UIColor.black
        lblLimitAmt.font = UIFont(name: String.defaultFontR, size: 15)
        lblLimitAmt.numberOfLines = 0
        lblLimitAmt.lineBreakMode = .byWordWrapping
        lblLimitAmt.leadingAnchor.constraint(equalTo: cardViewForm.leadingAnchor, constant: 20).isActive = true
        lblLimitAmt.topAnchor.constraint(equalTo: txtIDNo.bottomAnchor, constant: 30).isActive = true
        lblLimitAmt.trailingAnchor.constraint(equalTo: cardViewForm.trailingAnchor, constant: -20).isActive = true
        
        cardViewForm.addSubview(txtLimitAmt)
        txtLimitAmt.leadingAnchor.constraint(equalTo: cardViewForm.leadingAnchor, constant: 20).isActive = true
        txtLimitAmt.topAnchor.constraint(equalTo: lblLimitAmt.bottomAnchor, constant: 10).isActive = true
        txtLimitAmt.trailingAnchor.constraint(equalTo: cardViewForm.trailingAnchor, constant: -20).isActive = true
        txtLimitAmt.keyboardType = .numbersAndPunctuation
        
        let lbStrDate = UILabel()
        cardViewForm.addSubview(lbStrDate)
        lbStrDate.translatesAutoresizingMaskIntoConstraints = false
        lbStrDate.text = "Enter start date"
        lbStrDate.textColor = UIColor.black
        lbStrDate.font = UIFont(name: String.defaultFontR, size: 15)
        lbStrDate.numberOfLines = 0
        lbStrDate.lineBreakMode = .byWordWrapping
        lbStrDate.leadingAnchor.constraint(equalTo: cardViewForm.leadingAnchor, constant: 20).isActive = true
        lbStrDate.topAnchor.constraint(equalTo: txtLimitAmt.bottomAnchor, constant: 30).isActive = true
        lbStrDate.trailingAnchor.constraint(equalTo: cardViewForm.trailingAnchor, constant: -20).isActive = true
        
        cardViewForm.addSubview(txtStrtDate)
        txtStrtDate.leadingAnchor.constraint(equalTo: cardViewForm.leadingAnchor, constant: 20).isActive = true
        txtStrtDate.topAnchor.constraint(equalTo: lbStrDate.bottomAnchor, constant: 10).isActive = true
        txtStrtDate.trailingAnchor.constraint(equalTo: cardViewForm.trailingAnchor, constant: -20).isActive = true
        strtDatePicker = UIDatePicker()
        strtDatePicker?.datePickerMode = .date
        strtDatePicker?.addTarget(self, action: #selector(strtDateChanged(datePicker:)), for: .valueChanged)
        txtStrtDate.inputView = strtDatePicker
        
        let lbEndDate = UILabel()
        cardViewForm.addSubview(lbEndDate)
        lbEndDate.translatesAutoresizingMaskIntoConstraints = false
        lbEndDate.text = "Enter end date"
        lbEndDate.textColor = UIColor.black
        lbEndDate.font = UIFont(name: String.defaultFontR, size: 15)
        lbEndDate.numberOfLines = 0
        lbEndDate.lineBreakMode = .byWordWrapping
        lbEndDate.leadingAnchor.constraint(equalTo: cardViewForm.leadingAnchor, constant: 20).isActive = true
        lbEndDate.topAnchor.constraint(equalTo: txtStrtDate.bottomAnchor, constant: 30).isActive = true
        lbEndDate.trailingAnchor.constraint(equalTo: cardViewForm.trailingAnchor, constant: -20).isActive = true
        
        cardViewForm.addSubview(txtendDate)
        txtendDate.leadingAnchor.constraint(equalTo: cardViewForm.leadingAnchor, constant: 20).isActive = true
        txtendDate.topAnchor.constraint(equalTo: lbEndDate.bottomAnchor, constant: 10).isActive = true
        txtendDate.trailingAnchor.constraint(equalTo: cardViewForm.trailingAnchor, constant: -20).isActive = true
        endDatePicker = UIDatePicker()
        endDatePicker?.datePickerMode = .date
        endDatePicker?.addTarget(self, action: #selector(endDateChanged(datePicker:)), for: .valueChanged)
        txtendDate.inputView = endDatePicker
        
        let lbAltNo = UILabel()
        cardViewForm.addSubview(lbAltNo)
        lbAltNo.translatesAutoresizingMaskIntoConstraints = false
        lbAltNo.text = "Enter an alternative contact number"
        lbAltNo.textColor = UIColor.black
        lbAltNo.font = UIFont(name: String.defaultFontR, size: 15)
        lbAltNo.numberOfLines = 0
        lbAltNo.lineBreakMode = .byWordWrapping
        lbAltNo.leadingAnchor.constraint(equalTo: cardViewForm.leadingAnchor, constant: 20).isActive = true
        lbAltNo.topAnchor.constraint(equalTo: txtendDate.bottomAnchor, constant: 30).isActive = true
        lbAltNo.trailingAnchor.constraint(equalTo: cardViewForm.trailingAnchor, constant: -20).isActive = true
        
        cardViewForm.addSubview(txtaltNo)
        txtaltNo.leadingAnchor.constraint(equalTo: cardViewForm.leadingAnchor, constant: 20).isActive = true
        txtaltNo.topAnchor.constraint(equalTo: lbAltNo.bottomAnchor, constant: 10).isActive = true
        txtaltNo.trailingAnchor.constraint(equalTo: cardViewForm.trailingAnchor, constant: -20).isActive = true
        txtaltNo.keyboardType = .phonePad
        
        cardViewForm.addSubview(btnSubmit)
        btnSubmit.leadingAnchor.constraint(equalTo: cardViewForm.leadingAnchor, constant: 20).isActive = true
        btnSubmit.topAnchor.constraint(equalTo: txtaltNo.bottomAnchor, constant: 30).isActive = true
        btnSubmit.trailingAnchor.constraint(equalTo: cardViewForm.trailingAnchor, constant: -20).isActive = true
        btnSubmit.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnSubmit.addTarget(self, action: #selector(sendRequest), for: .touchUpInside)
        
        //activity loader
        scrollView.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.topAnchor.constraint(equalTo: txtaltNo.bottomAnchor, constant: 30).isActive = true
        
        scrollView.contentSize.height = view.frame.height + 450
        
    }
    
    @objc func goToBack(){
        let storyboard = UIStoryboard(name: "PostPaid", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "SinceLastBill")
        present(moveTo, animated: true, completion: nil)
    
    }
    
    @objc func sendRequest(){
        let idNumber = txtIDNo.text
        let idType = txtIDType.text
        let limitAmount = txtLimitAmt.text
        let startDate = txtStrtDate.text
        let endDate = txtendDate.text
        let altMsisdn = txtaltNo.text
        
        if idNumber == "" || idType == "" || limitAmount == "" || startDate == "" || endDate == "" || altMsisdn == "" {
            toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "All fields are mandatory")
        }else if altMsisdn!.count < 10 {
            toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Alternate msisdn can't be less than 10 digits")
        }
        else{
            if CheckInternet.Connection(){
                start_activity_loader()
                let async_call = URL(string: String.userURL)
                let request = NSMutableURLRequest(url: async_call!)
                request.httpMethod = "POST"
                let postParameters = ["action":"consumptionLimitSR", "msisdn":msisdn!, "username":username!, "limitAmount":limitAmount!, "startDate":startDate, "endDate":endDate, "altMsisdn":altMsisdn, "idType":idType, "idNumber":idNumber!, "os":getAppVersion()]
                if let jsonParameters = try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted){
                    let theJSONText = String(data: jsonParameters,encoding: String.Encoding.utf8)
                    let requestBody: Dictionary<String, Any> = [
                        "requestBody":encryptAsyncRequest(requestBody: theJSONText!.description)
                    ]
                    if let postData = (try? JSONSerialization.data(withJSONObject: requestBody, options: JSONSerialization.WritingOptions.prettyPrinted)){
                        request.httpBody = postData
                        request.addValue("application/json", forHTTPHeaderField: "Content-Accept")
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
                                    self.stop_activity_loader()
                                    self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry couldn't process your request. Please try again later...")
                                }
                                return
                            }
                            
                            do {
                                let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                                if let parseJSON = myJSON {
                                    DispatchQueue.main.async {
                                        self.stop_activity_loader()
                                        var sessionAuth: String!
                                        sessionAuth = parseJSON["SessionAuth"] as! String?
                                        if sessionAuth == "true" {
                                            self.logout()
                                        }
                                        var responseBody: String?
                                        var responseCode: Int!
                                        var responseMessage: String!
                                        responseBody = parseJSON["responseBody"] as? String
                                        if let responseBody = responseBody {
                                            let decrypt = self.decryptAsyncRequest(requestBody: responseBody)
                                            let decryptedResponseBody = self.convertToNSDictionary(decrypt: decrypt)
                                            print(decryptedResponseBody)
                                            responseCode = decryptedResponseBody["RESPONSECODE"] as! Int?
                                            if responseCode == 0{
                                                responseMessage = decryptedResponseBody["RESPONSEMESSAGE"] as? String
                                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: responseMessage)
                                                if self.hasRated == nil || self.hasRated == false {
                                                    self.showRatings()
                                                }else{
                                                    
                                                }
                                                
                                            }else if responseCode == 1 {
                                                responseMessage = decryptedResponseBody["RESPONSEMESSAGE"] as? String
                                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: responseMessage)
                                            }else{
                                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry couldn't process your request. Please try again later...")
                                            }
                                        }
                                    }
                                }
                            }catch{
                                print(error.localizedDescription)
                                DispatchQueue.main.async {
                                    self.stop_activity_loader()
                                    self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry couldn't process your request. Please try again later...")
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
        
        
        
    }
    
    func getConsumptionLimit(){
        if CheckInternet.Connection(){
            let async_call = URL(string: String.userURL)
            let request = NSMutableURLRequest(url: async_call!)
            request.httpMethod = "POST"
            let postParameters = ["action":"getConsumptionLimit", "msisdn":msisdn!, "username":username!, "os":getAppVersion()]
            if let jsonParameters = try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted){
                let theJSONText = String(data: jsonParameters,encoding: String.Encoding.utf8)
                let requestBody: Dictionary<String, Any> = [
                    "requestBody":encryptAsyncRequest(requestBody: theJSONText!.description)
                ]
                if let postData = (try? JSONSerialization.data(withJSONObject: requestBody, options: JSONSerialization.WritingOptions.prettyPrinted)){
                    request.httpBody = postData
                    request.addValue("application/json", forHTTPHeaderField: "Content-Accept")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                    var session = preference.object(forKey: UserDefaultsKeys.userSession.rawValue) as! String
                    session = session.replacingOccurrences(of: "-", with: "")
                    request.addValue(session, forHTTPHeaderField: "session")
                    request.addValue(username!, forHTTPHeaderField: "username")
                    
                    let task = URLSession.shared.dataTask(with: request as URLRequest){
                        data, response, error in
                        if error != nil {
                            print("error is: \(error!.localizedDescription)")
                            
                            return
                        }
                        
                        do {
                            let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            if let parseJSON = myJSON {
                                DispatchQueue.main.async {
                                    self.stop_activity_loader()
                                    var sessionAuth: String!
                                    sessionAuth = parseJSON["SessionAuth"] as! String?
                                    if sessionAuth == "true" {
                                        self.logout()
                                    }
                                    var responseBody: String?
                                    var responseCode: Int!
                                    var responseMessage: NSDictionary!
                                    responseBody = parseJSON["responseBody"] as? String
                                    if let responseBody = responseBody {
                                        let decrypt = self.decryptAsyncRequest(requestBody: responseBody)
                                        let decryptedResponseBody = self.convertToNSDictionary(decrypt: decrypt)
                                        print(decryptedResponseBody)
                                        responseCode = decryptedResponseBody["RESPONSECODE"] as! Int?
                                        if responseCode == 0{
                                            responseMessage = decryptedResponseBody["RESPONSEMESSAGE"] as? NSDictionary
                                            self.strtDateCard = responseMessage["StartTimeDesc"] as? String
                                            self.endDateCard = responseMessage["EndTimeDesc"] as? String
                                            self.limitAmt = responseMessage["LimitAmount"] as? String
                                            self.usedAmt = responseMessage["UsedAmount"] as? String
                                            
                                            if let startDate = self.strtDateCard {
                                                self.lblStartDateCard.text = "Start Date: \(startDate)"
                                            }
                                            
                                            if let endDate = self.strtDateCard {
                                                self.lblEndDateCard.text = "End Date: \(endDate)"
                                            }
                                            
                                            if let usedAmount = self.usedAmt {
                                                self.lblUsedAmtCard.text = "Used Amount: \(usedAmount)"
                                            }
                                            
                                            if let limitAmount = self.limitAmt {
                                                self.lblLimitAmtCard.text = "Limit Amount: \(limitAmount)"
                                            }
                                            
                                            
                                        }else if responseCode == 1 {
                                            
                                        }else{
                                            
                                        }
                                    }
                                }
                            }
                        }catch{
                            print(error.localizedDescription)
                        }
                    }
                    task.resume()
                }
            }
        }
    }
    
    @objc func strtDateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        txtStrtDate.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @objc func endDateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        txtendDate.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }

}

extension SetConsumptionLimit: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return IDTypeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return IDTypeArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtIDType.text = IDTypeArray[row]
    }
    
}
