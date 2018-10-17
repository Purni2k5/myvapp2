//
//  changePlanForm.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 12/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class changePlanForm: baseViewControllerM {

    var accNo: String?
    var phoneNo: String?
    var serviceNo: String?
    var status: String?
    var unusedData: String?
    var cashInAccount: String?
    let cheviDown = UIImageView()
    var plan: String?
    var userID: String?
    var username: String?
    var msisdn: String?
    fileprivate var lblUserIDTop1: NSLayoutConstraint?
    fileprivate var lblUserIDTop2: NSLayoutConstraint?
    fileprivate var cardViewHeight1: NSLayoutConstraint?
    fileprivate var cardViewHeight2: NSLayoutConstraint?
    
    var FBBPlans = [String]()
    
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
    
    let txtNewPlan = UITextField()
    let txtContactPerson = UITextField()
    let txtReason = UITextView()
    let btnNext = UIButton()
    
    //Create a picker view
    func createPickerView(){
        let picker = UIPickerView()
        picker.delegate = self
        txtNewPlan.inputView = picker
    }
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        btnNext.isHidden = true
    }
    
    //Function to startIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        btnNext.isHidden = false
    }
    
    //Function to create a tool bar
    func createToolBar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(fbbShareVc.dismissKeyBoard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        txtNewPlan.inputAccessoryView =  toolBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground
        let bbPackages = preference.object(forKey: "BBPACKAGES")
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        username = UserData["Username"] as? String
        msisdn = preference.object(forKey: "defaultMSISDN") as! String?
        if let array = bbPackages as! NSArray?{
            for obj in array{
                if let dict = obj as? NSDictionary{
                    let packageName = dict.value(forKey: "NAME") as! String
                    FBBPlans.append(packageName)
                }
            }
        }
        setUpViewsChange()
        hideKeyboardWhenTappedAround()
        createPickerView()
        createToolBar()
        // Do any additional setup after loading the view.
        
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
    }
    
    func setUpViewsChange() {
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
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
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
        lblSelectedOffer.text = "Plan Change"
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
        cardViewHeight1 = cardView.heightAnchor.constraint(equalToConstant: 480)
        cardViewHeight2 = cardView.heightAnchor.constraint(equalToConstant: 580)
        cardViewHeight1?.isActive = true
        
        let lblNewPlan = UILabel()
        scrollView.addSubview(lblNewPlan)
        lblNewPlan.translatesAutoresizingMaskIntoConstraints = false
        lblNewPlan.text = "New Plan"
        lblNewPlan.font = UIFont(name: String.defaultFontR, size: 16)
        lblNewPlan.textColor = UIColor.black
        lblNewPlan.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblUserIDTop1 = lblNewPlan.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 30)
        lblUserIDTop2 = lblNewPlan.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 80)
        lblUserIDTop1?.isActive = true
        
        
        scrollView.addSubview(txtNewPlan)
        txtNewPlan.translatesAutoresizingMaskIntoConstraints = false
        txtNewPlan.font = UIFont(name: String.defaultFontR, size: 16)
        txtNewPlan.backgroundColor = UIColor.white
        txtNewPlan.borderStyle = .roundedRect
        txtNewPlan.placeholder = "Select new plan"
        txtNewPlan.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtNewPlan.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtNewPlan.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtNewPlan.topAnchor.constraint(equalTo: lblNewPlan.bottomAnchor, constant: 10).isActive = true
        txtNewPlan.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
        
        txtNewPlan.addSubview(cheviDown)
        cheviDown.translatesAutoresizingMaskIntoConstraints = false
        cheviDown.image = UIImage(named: "chevDown")
        cheviDown.widthAnchor.constraint(equalToConstant: 30).isActive = true
        cheviDown.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cheviDown.topAnchor.constraint(equalTo: txtNewPlan.topAnchor, constant: 10).isActive = true
        cheviDown.trailingAnchor.constraint(equalTo: txtNewPlan.trailingAnchor, constant: -10).isActive = true
        
        let lblContactP = UILabel()
        scrollView.addSubview(lblContactP)
        lblContactP.translatesAutoresizingMaskIntoConstraints = false
        lblContactP.text = "Contact person mobile number"
        lblContactP.font = UIFont(name: String.defaultFontR, size: 16)
        lblContactP.textColor = UIColor.black
        lblContactP.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblContactP.topAnchor.constraint(equalTo: txtNewPlan.bottomAnchor, constant: 30).isActive = true
        
        
        scrollView.addSubview(txtContactPerson)
        txtContactPerson.translatesAutoresizingMaskIntoConstraints = false
        txtContactPerson.font = UIFont(name: String.defaultFontR, size: 16)
        txtContactPerson.backgroundColor = UIColor.white
        txtContactPerson.borderStyle = .roundedRect
        txtContactPerson.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtContactPerson.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtContactPerson.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtContactPerson.topAnchor.constraint(equalTo: lblContactP.bottomAnchor, constant: 10).isActive = true
        txtContactPerson.keyboardType = .numberPad
        txtContactPerson.addTarget(self, action: #selector(checkInputs), for: .editingChanged)
        
        let lblReason = UILabel()
        scrollView.addSubview(lblReason)
        lblReason.translatesAutoresizingMaskIntoConstraints = false
        lblReason.text = "Reason for change"
        lblReason.font = UIFont(name: String.defaultFontR, size: 16)
        lblReason.textColor = UIColor.black
        lblReason.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblReason.topAnchor.constraint(equalTo: txtContactPerson.bottomAnchor, constant: 30).isActive = true
        
        scrollView.addSubview(txtReason)
        txtReason.translatesAutoresizingMaskIntoConstraints = false
        txtReason.font = UIFont(name: String.defaultFontR, size: 16)
        txtReason.backgroundColor = UIColor.white
        txtReason.layer.borderColor = UIColor.gray.withAlphaComponent(0.60).cgColor
        txtReason.layer.borderWidth = 0.8
        txtReason.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtReason.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtReason.heightAnchor.constraint(equalToConstant: 120).isActive = true
        txtReason.topAnchor.constraint(equalTo: lblReason.bottomAnchor, constant: 10).isActive = true
        txtReason.delegate = self
        txtReason.isScrollEnabled = false
        
        
        scrollView.addSubview(btnNext)
        btnNext.translatesAutoresizingMaskIntoConstraints = false
        btnNext.isEnabled = false
        btnNext.backgroundColor = UIColor.grayButton
        btnNext.setTitle("Send Request", for: .normal)
        btnNext.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnNext.setTitleColor(UIColor.white, for: .normal)
        btnNext.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        btnNext.topAnchor.constraint(equalTo: txtReason.bottomAnchor, constant: 30).isActive = true
        btnNext.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        btnNext.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnNext.addTarget(self, action: #selector(sendRequest), for: .touchUpInside)
        
        //activity loader
        scrollView.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.topAnchor.constraint(equalTo: txtReason.bottomAnchor, constant: 40).isActive = true
        scrollView.contentSize.height = 1000
    }
    
    @objc func checkInputs(){
        if txtNewPlan.text != "" && txtContactPerson.text != "" && txtReason.text != ""  && txtContactPerson.text?.count == 10{
            btnNext.isEnabled = true
            btnNext.backgroundColor = UIColor.vodaRed
        }else{
            btnNext.isEnabled = false
            btnNext.backgroundColor = UIColor.grayButton
        }
    }
    
    @objc func sendRequest(){
        if !CheckInternet.Connection(){
            displayNoInternet()
        }else{
            start_activity_loader()
            let newPlan = txtNewPlan.text
            let alternativecontact = txtContactPerson.text
            let reason = txtReason.text
            
            let async_call = URL(string: String.userURL)
            
            let request = NSMutableURLRequest(url: async_call!)
            
            let postParameters: Dictionary<String, Any> = [
                "action":"planchange",
                "userid":userID!,
                "newplan":newPlan!,
                "reason":reason!,
                "alternativecontact":alternativecontact!,
                "mobile":phoneNo!,
                "currentplan":plan!,
                "username":username!,
                "msisdn":msisdn!,
                "accountnumber":accNo!,
                "os":getAppVersion()
            ]
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
                            self.lblUserIDTop1?.isActive = false
                            self.lblUserIDTop2?.isActive = true
                            self.cardViewHeight1?.isActive = false
                            self.cardViewHeight2?.isActive = true
                            self.errorDialog(errorMssg: error!.localizedDescription)
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
                                    let responseMessage: String?
                                    responseMessage = parseJSON["RESPONSEMESSAGE"] as! String?
                                    self.stop_activity_loader()
                                    self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: responseMessage!)
                                }else {
                                    let responseMessage: String?
                                    responseMessage = parseJSON["RESPONSEMESSAGE"] as! String?
                                    self.stop_activity_loader()
                                    self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "correct")), toast_message: responseMessage!)
                                    
                                }
                            }
                        }
                    }catch{
                        print(error.localizedDescription)
                        DispatchQueue.main.async {
                            self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: error.localizedDescription)
                        }
                    }
                }
                task.resume()
            }
        }
    }
   
    @objc func goBack(){
        let storyboard = UIStoryboard(name: "FBB", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "FBBPackages")
        present(moveTo, animated: true, completion: nil)
    }

    //Function to dismiss keyboard
    @objc func dismissKeyBoard(){
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





extension changePlanForm: UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return FBBPlans.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return FBBPlans[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtNewPlan.text = FBBPlans[row]
    }
    
    func textViewDidChange(_ textView: UITextView) {
        checkInputs()
        let size = CGSize(width: txtReason.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
