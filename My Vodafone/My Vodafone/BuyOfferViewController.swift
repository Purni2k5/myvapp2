//
//  BuyOfferViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 03/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class BuyOfferViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let preferences = UserDefaults.standard
    var selectedOffer: String = ""
    var selectedOfferPrice: String = ""
    var selectedOfferDesc: String = ""
    var selectedAccount:  String?
    var selectedNumberHidden: String?
    
    //create a closure for scroll view
    let vcScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.dark_background
        scrollView.contentSize.height = 2000
        return scrollView
    }()
    
    //create closure for dark view
    let darkView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //create a closure for close button
    let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //create a closre for offer label
    let offerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        return label
    }()
    
    //create a closure for error view
    let errorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
//        view.layer.shadowOpacity = 0.1
        return view
    }()
    
    //create a closure label
    let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //create a closure for errorDate label
    let errorDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //create activity loader closure
    let activity_loader: UIActivityIndicatorView = {
        let activity_loader = UIActivityIndicatorView()
        activity_loader.translatesAutoresizingMaskIntoConstraints = false
        activity_loader.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
//        activity_loader.color = UIColor.vodaRed
        //        activity_loader.backgroundColor = UIColor.cardImageColour
        activity_loader.startAnimating()
        activity_loader.hidesWhenStopped = true
        activity_loader.isHidden = false
        return activity_loader
        
    }()
    
    let circularView = UIView()
    let txtPurchaseNum = UITextField()
    let txtHiddenPurchaseNum = UITextField()
    let buyButton = UIButton()
    
    var registeredAccounts = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationCapturesStatusBarAppearance = true
        
        view.addSubview(vcScrollView)
        setUpViews()
        let Services = preferences.object(forKey: "ServiceList")
        if let array = Services as? NSArray{
            var iterate = 0
            for obj in array {
                print("BJS \(obj)")
                if let dict = obj as? NSDictionary {
                    let displayName = dict.value(forKey: "DisplayName") as! String
                    
                    var contactPhone = dict.value(forKey: "ContactPhone") as! String
                    let accountType = dict.value(forKey: "Type") as! String
                    let truncNum = contactPhone.dropFirst(3)
                    contactPhone = "0\(truncNum)"
                    let accountInfo = displayName + " " + contactPhone
                    if iterate == 0 {
                        txtPurchaseNum.text = accountInfo
                        txtHiddenPurchaseNum.text = contactPhone
                    }
                    if accountType.contains("BB_FIXED"){
                        
                    }else{
                        registeredAccounts.append(accountInfo)
                    }
                    
                    print("account Info \(accountInfo)")
                }
                iterate = iterate + 1
            }
        }
        // Do any additional setup after loading the view.
        print(selectedOfferDesc)
        print(selectedOfferPrice)
        print(selectedOffer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpViews(){
        //scrollView
        vcScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        vcScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        vcScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        vcScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        //Dark view
        let childDarkView = darkView
        vcScrollView.addSubview(childDarkView)
        childDarkView.leadingAnchor.constraint(equalTo: vcScrollView.leadingAnchor).isActive = true
        childDarkView.topAnchor.constraint(equalTo: vcScrollView.topAnchor).isActive = true
        childDarkView.trailingAnchor.constraint(equalTo: vcScrollView.trailingAnchor).isActive = true
        childDarkView.widthAnchor.constraint(equalTo: vcScrollView.widthAnchor).isActive = true
        childDarkView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        //Close button
        childDarkView.addSubview(closeButton)
        let close_image = UIImage(named: "ic_close")
        closeButton.setImage(close_image, for: .normal)
        closeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: childDarkView.trailingAnchor, constant: -10).isActive = true
        closeButton.topAnchor.constraint(equalTo: childDarkView.topAnchor, constant: 10).isActive = true
        closeButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        
        //Offer Label
        childDarkView.addSubview(offerLabel)
        offerLabel.text = selectedOffer
        offerLabel.font = UIFont(name: String.defaultFontR, size: 29)
        offerLabel.textAlignment = .center
        offerLabel.topAnchor.constraint(equalTo: childDarkView.topAnchor, constant: 55).isActive = true
        offerLabel.leadingAnchor.constraint(equalTo: childDarkView.leadingAnchor, constant: 20).isActive = true
        offerLabel.trailingAnchor.constraint(equalTo: childDarkView.trailingAnchor, constant: -20).isActive = true
        
        //Offer Description
        let offerDesc = UILabel()
        vcScrollView.addSubview(offerDesc)
        offerDesc.translatesAutoresizingMaskIntoConstraints = false
        offerDesc.numberOfLines = 0
        offerDesc.lineBreakMode = .byWordWrapping
        offerDesc.text = selectedOfferDesc
        offerDesc.font = UIFont(name: String.defaultFontR, size: 20)
        offerDesc.textColor = UIColor.white
        offerDesc.textAlignment = .center
//        offerDesc.setLineSpacing(lineHeightMultiple: 1.2)
        offerDesc.leadingAnchor.constraint(equalTo: vcScrollView.leadingAnchor, constant: 50).isActive = true
        offerDesc.trailingAnchor.constraint(equalTo: vcScrollView.trailingAnchor, constant: -50).isActive = true
        offerDesc.topAnchor.constraint(equalTo: childDarkView.bottomAnchor, constant: 20).isActive = true
        offerDesc.centerXAnchor.constraint(equalTo: vcScrollView.centerXAnchor).isActive = true
        
        //Circular view to hold amt.
        circularView.translatesAutoresizingMaskIntoConstraints = false
        vcScrollView.addSubview(circularView)
        circularView.backgroundColor = UIColor.vodaRed
        circularView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        circularView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        circularView.centerXAnchor.constraint(equalTo: vcScrollView.centerXAnchor).isActive = true
        circularView.topAnchor.constraint(equalTo: offerDesc.bottomAnchor, constant: 10).isActive = true
        
        //Label to display amt in circular view
        let amtLabel = UILabel()
        circularView.addSubview(amtLabel)
        amtLabel.translatesAutoresizingMaskIntoConstraints = false
        amtLabel.font = UIFont(name: String.defaultFontR, size: 21)
        amtLabel.textColor = UIColor.white
        amtLabel.textAlignment = .center
        amtLabel.text = "GHS \(selectedOfferPrice)"
        amtLabel.centerXAnchor.constraint(equalTo: circularView.centerXAnchor).isActive = true
        amtLabel.centerYAnchor.constraint(equalTo: circularView.centerYAnchor).isActive = true
        
        //Purchase number textfield
        
        vcScrollView.addSubview(txtPurchaseNum)
        txtPurchaseNum.translatesAutoresizingMaskIntoConstraints = false
        txtPurchaseNum.font = UIFont(name: String.defaultFontR, size: 18)
        txtPurchaseNum.heightAnchor.constraint(equalToConstant: 55).isActive = true
        txtPurchaseNum.leadingAnchor.constraint(equalTo: vcScrollView.leadingAnchor, constant: 40).isActive = true
        txtPurchaseNum.trailingAnchor.constraint(equalTo: vcScrollView.trailingAnchor, constant: -40).isActive = true
        txtPurchaseNum.topAnchor.constraint(equalTo: circularView.bottomAnchor, constant: 20).isActive = true
        txtPurchaseNum.backgroundColor = UIColor.white
        txtPurchaseNum.borderStyle = .roundedRect
        
        //hidden Purchase number textfield
        
        vcScrollView.addSubview(txtHiddenPurchaseNum)
        txtHiddenPurchaseNum.translatesAutoresizingMaskIntoConstraints = false
        txtHiddenPurchaseNum.font = UIFont(name: String.defaultFontR, size: 18)
        txtHiddenPurchaseNum.heightAnchor.constraint(equalToConstant: 55).isActive = true
        txtHiddenPurchaseNum.leadingAnchor.constraint(equalTo: vcScrollView.leadingAnchor, constant: 40).isActive = true
        txtHiddenPurchaseNum.trailingAnchor.constraint(equalTo: vcScrollView.trailingAnchor, constant: -40).isActive = true
        txtHiddenPurchaseNum.topAnchor.constraint(equalTo: circularView.bottomAnchor, constant: 20).isActive = true
        txtHiddenPurchaseNum.backgroundColor = UIColor.white
        txtHiddenPurchaseNum.borderStyle = .roundedRect
        txtHiddenPurchaseNum.isHidden = true
        
        //Creating a buy button
        
        vcScrollView.addSubview(buyButton)
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        buyButton.backgroundColor = UIColor.vodaRed
        buyButton.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        buyButton.setTitle("Buy", for: .normal)
        buyButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        buyButton.topAnchor.constraint(equalTo: txtPurchaseNum.bottomAnchor, constant: 20).isActive = true
        buyButton.leadingAnchor.constraint(equalTo: vcScrollView.leadingAnchor, constant: 40).isActive = true
        buyButton.trailingAnchor.constraint(equalTo: vcScrollView.trailingAnchor, constant: -40).isActive = true
        buyButton.addTarget(self, action: #selector(btnBuy), for: .touchUpInside)
        
        //Creating a no button
        let noButton = UIButton()
        vcScrollView.addSubview(noButton)
        noButton.translatesAutoresizingMaskIntoConstraints = false
        noButton.backgroundColor = UIColor.grayButton
        noButton.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        noButton.setTitle("No thanks", for: .normal)
        noButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        noButton.topAnchor.constraint(equalTo: buyButton.bottomAnchor, constant: 20).isActive = true
        noButton.leadingAnchor.constraint(equalTo: vcScrollView.leadingAnchor, constant: 40).isActive = true
        noButton.trailingAnchor.constraint(equalTo: vcScrollView.trailingAnchor, constant: -40).isActive = true
        
        //Creating a buy button
        let browseButton = UIButton()
        vcScrollView.addSubview(browseButton)
        browseButton.translatesAutoresizingMaskIntoConstraints = false
        browseButton.backgroundColor = UIColor.grayButton
        browseButton.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        browseButton.setTitle("Browse All", for: .normal)
        browseButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        browseButton.topAnchor.constraint(equalTo: noButton.bottomAnchor, constant: 20).isActive = true
        browseButton.leadingAnchor.constraint(equalTo: vcScrollView.leadingAnchor, constant: 40).isActive = true
        browseButton.trailingAnchor.constraint(equalTo: vcScrollView.trailingAnchor, constant: -40).isActive = true
        
        vcScrollView.addSubview(errorView)
        errorView.leadingAnchor.constraint(equalTo: vcScrollView.leadingAnchor).isActive = true
        errorView.trailingAnchor.constraint(equalTo: vcScrollView.trailingAnchor, constant: 0).isActive = true
        errorView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        errorView.widthAnchor.constraint(equalTo: vcScrollView.widthAnchor).isActive = true
        errorView.topAnchor.constraint(equalTo: browseButton.bottomAnchor, constant: 20).isActive = true
        
        createPickerView()
        createToolBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Now make view circular
        circularView.layer.cornerRadius = circularView.frame.size.width / 2
        circularView.clipsToBounds = true
    }
    

    //Function to close modal
    @objc func closeModal(){
        self.view.removeFromSuperview()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return registeredAccounts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return registeredAccounts[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedAccount = registeredAccounts[row]
        txtPurchaseNum.text = selectedAccount
        let accArr = selectedAccount?.components(separatedBy: " ")
        let arrayPick = accArr!.count - 1
        let accountNumber = accArr![arrayPick] //Last
        txtHiddenPurchaseNum.text = accountNumber
    }
    
    //Function to create picker view for accounts
    func createPickerView(){
        let accountPicker = UIPickerView()
        accountPicker.delegate = self
        txtPurchaseNum.inputView = accountPicker
    }
    //Function to create a tool bar
    func createToolBar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(BuyOfferViewController.dismissKeyBoard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        txtPurchaseNum.inputAccessoryView =  toolBar
    }
    //Function to dismiss keyboard
    @objc func dismissKeyBoard(){
        view.endEditing(true)
    }
    //Function to check bundle purchase
    @objc func btnBuy(){
        vcScrollView.addSubview(activity_loader)
        activity_loader.topAnchor.constraint(equalTo: txtPurchaseNum.bottomAnchor, constant: 30).isActive = true
        activity_loader.centerXAnchor.constraint(equalTo: vcScrollView.centerXAnchor).isActive = true
        buyButton.isHidden = true
        
        //Now make the async call
        let checkUrl = URL(string: String.buyPackage)
        let request = NSMutableURLRequest(url: checkUrl!)
        request.httpMethod = "POST"
        
        let postParameters: Dictionary<String, Any> = [
            "action":"buyPackageCheck",
            "msisdn":"msisdn",
            "username":"username",
            "bundleid":"bundleid"
        ]
    }
    //Function to hide status bar
    override var prefersStatusBarHidden: Bool{
        return true
    }
}
