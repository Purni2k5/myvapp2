//
//  FreeSHS.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 12/11/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class FreeSHS: baseViewControllerM {

    var username: String?
    var selectedAccount: String?
    var selectedAmt: String?
    var hasRated: Bool?
    
    let scrollView: UIScrollView = {
       let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let darkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
        return view
    }()
    
    let txtMobileNumber: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: String.defaultFontR, size: 17)
        view.borderStyle = .roundedRect
        view.backgroundColor = UIColor.white
        view.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return view
    }()
    
    let txtMobileNumberHidden: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: String.defaultFontR, size: 17)
        view.borderStyle = .roundedRect
        view.backgroundColor = UIColor.white
        view.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return view
    }()
    
    let txtAmt: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: String.defaultFontR, size: 17)
        view.borderStyle = .roundedRect
        view.backgroundColor = UIColor.white
        view.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return view
    }()
    
    let txtAmtHidden: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: String.defaultFontR, size: 17)
        view.borderStyle = .roundedRect
        view.backgroundColor = UIColor.white
        view.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return view
    }()
    
    let btnSubmit: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.vodaRed
        view.setTitle("Submit", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        return view
    }()
    
    let btnCancel: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.grayButton
        view.setTitle("Cancel", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        view.addTarget(self, action: #selector(closeModalB), for: .touchUpInside)
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
    
    fileprivate var btnSubmitTop: NSLayoutConstraint!
    var registeredAccounts = [String]()
    let amtArray = ["0.5", "1", "2", "5", "10", "20", "50", "100", "Enter amount"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.dark_background
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        username = UserData["Username"] as? String
        hasRated = preference.object(forKey: UserDefaultsKeys.hasRated.rawValue) as? Bool
        
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
                        txtMobileNumber.text = accountInfo
                        txtMobileNumberHidden.text = contactPhone
                    }
                    if accountType.contains("BB_FIXED"){
                        
                    }else{
                        registeredAccounts.append(accountInfo)
                    }
                    
                    
                }
                iterate = iterate + 1
            }
            
            
        }
        hideKeyboardWhenTappedAround()
        setUpViewsFreeSHS()
        createPickerView()
        createPickerViewAmt()
        createToolBar()
        txtAmt.text = amtArray[0]
        txtAmtHidden.text = amtArray[0]
    }
    
    //Create a picker view
    func createPickerView(){
        let picker = UIPickerView()
        picker.delegate = self
        picker.tag = 1
        txtMobileNumber.inputView = picker
    }
    
    func createPickerViewAmt(){
        let picker = UIPickerView()
        picker.delegate = self
        picker.tag = 2
        txtAmt.inputView = picker
    }
    
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
    
    func setUpViewsFreeSHS(){
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(darkView)
        darkView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        darkView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        darkView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        darkView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        //close button
        let btnClose = UIButton()
        btnClose.translatesAutoresizingMaskIntoConstraints = false
        darkView.addSubview(btnClose)
        let closeImage = UIImage(named: "ic_close")
        btnClose.setImage(closeImage, for: .normal)
        btnClose.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnClose.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnClose.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 20).isActive = true
        btnClose.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -10).isActive = true
        btnClose.addTarget(self, action: #selector(closeModalB), for: .touchUpInside)
        
        let lblHeader = UILabel()
        darkView.addSubview(lblHeader)
        lblHeader.translatesAutoresizingMaskIntoConstraints = false
        lblHeader.text = "Free SHS Donation"
        lblHeader.textColor = UIColor.white
        lblHeader.font = UIFont(name: String.defaultFontR, size: 31)
        lblHeader.numberOfLines = 0
        lblHeader.lineBreakMode = .byWordWrapping
        lblHeader.textAlignment = .center
        lblHeader.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        lblHeader.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 100).isActive = true
        lblHeader.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        
        let freeshsLogo = UIImageView(image: #imageLiteral(resourceName: "freeshs"))
        freeshsLogo.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(freeshsLogo)
        freeshsLogo.widthAnchor.constraint(equalToConstant: 200).isActive = true
        freeshsLogo.heightAnchor.constraint(equalToConstant:200).isActive = true
        freeshsLogo.topAnchor.constraint(equalTo: darkView.bottomAnchor, constant: 3).isActive = true
        freeshsLogo.centerXAnchor.constraint(equalTo: darkView.centerXAnchor).isActive = true
        
        let lblDesc = UILabel()
        scrollView.addSubview(lblDesc)
        lblDesc.translatesAutoresizingMaskIntoConstraints = false
        lblDesc.text = "Mobile number you want to donate from"
        lblDesc.textColor = UIColor.white
        lblDesc.font = UIFont(name: String.defaultFontR, size: 15)
        lblDesc.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        lblDesc.topAnchor.constraint(equalTo: freeshsLogo.bottomAnchor, constant: 5).isActive = true
        
        scrollView.addSubview(txtMobileNumber)
        txtMobileNumber.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        txtMobileNumber.topAnchor.constraint(equalTo: lblDesc.bottomAnchor, constant: 5).isActive = true
        txtMobileNumber.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        
        let dropDown = UIImageView(image: #imageLiteral(resourceName: "chevDown"))
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        txtMobileNumber.addSubview(dropDown)
        dropDown.heightAnchor.constraint(equalToConstant: 40).isActive = true
        dropDown.widthAnchor.constraint(equalToConstant: 40).isActive = true
        dropDown.topAnchor.constraint(equalTo: txtMobileNumber.topAnchor, constant: 5).isActive = true
        dropDown.trailingAnchor.constraint(equalTo: txtMobileNumber.trailingAnchor, constant: -10).isActive = true
        
        scrollView.addSubview(txtMobileNumberHidden)
        txtMobileNumberHidden.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        txtMobileNumberHidden.topAnchor.constraint(equalTo: lblDesc.bottomAnchor, constant: 30).isActive = true
        txtMobileNumberHidden.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        txtMobileNumberHidden.isHidden = true
        
        let lblAmtDesc = UILabel()
        scrollView.addSubview(lblAmtDesc)
        lblAmtDesc.translatesAutoresizingMaskIntoConstraints = false
        lblAmtDesc.text = "Select how much to donate"
        lblAmtDesc.textColor = UIColor.white
        lblAmtDesc.font = UIFont(name: String.defaultFontR, size: 15)
        lblAmtDesc.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        lblAmtDesc.topAnchor.constraint(equalTo: txtMobileNumber.bottomAnchor, constant: 30).isActive = true
        
        scrollView.addSubview(txtAmt)
        txtAmt.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        txtAmt.topAnchor.constraint(equalTo: lblAmtDesc.bottomAnchor, constant: 5).isActive = true
        txtAmt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        
        let dropDown2 = UIImageView(image: #imageLiteral(resourceName: "chevDown"))
        dropDown2.translatesAutoresizingMaskIntoConstraints = false
        txtAmt.addSubview(dropDown2)
        dropDown2.heightAnchor.constraint(equalToConstant: 40).isActive = true
        dropDown2.widthAnchor.constraint(equalToConstant: 40).isActive = true
        dropDown2.topAnchor.constraint(equalTo: txtAmt.topAnchor, constant: 5).isActive = true
        dropDown2.trailingAnchor.constraint(equalTo: txtAmt.trailingAnchor, constant: -10).isActive = true
        
        scrollView.addSubview(txtAmtHidden)
        txtAmtHidden.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        txtAmtHidden.topAnchor.constraint(equalTo: txtAmt.bottomAnchor, constant: 10).isActive = true
        txtAmtHidden.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        txtAmtHidden.isHidden = true
        
        scrollView.addSubview(btnSubmit)
        btnSubmit.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        btnSubmitTop = btnSubmit.topAnchor.constraint(equalTo: txtAmt.bottomAnchor, constant: 30)
        btnSubmitTop.isActive = true
        btnSubmit.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        btnSubmit.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnSubmit.addTarget(self, action: #selector(submitPayment), for: .touchUpInside)
        
        scrollView.addSubview(btnCancel)
        btnCancel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        btnCancel.topAnchor.constraint(equalTo: btnSubmit.bottomAnchor, constant: 10).isActive = true
        btnCancel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        btnCancel.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        //activity loader
        scrollView.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.topAnchor.constraint(equalTo: txtAmt.bottomAnchor, constant: 30).isActive = true
        
        scrollView.contentSize.height = view.frame.height + 120
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    //Function to create a tool bar
    func createToolBar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(FreeSHS.dismissKeyBoard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        txtMobileNumber.inputAccessoryView =  toolBar
        txtAmt.inputAccessoryView = toolBar
    }
    
    //Function to dismiss keyboard
    @objc func dismissKeyBoard(){
        view.endEditing(true)
    }
    
    @objc func submitPayment(){
        let msisdn = txtMobileNumberHidden.text!
        let amt = txtAmtHidden.text!
        
        if !CheckInternet.Connection(){
            displayNoInternet()
        }else{
            if msisdn.isEmpty || amt.isEmpty {
                toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Select amount you want to donate")
            }else{
                start_activity_loader()
                let async_call = URL(string: String.userURL)
                let request = NSMutableURLRequest(url: async_call!)
                request.httpMethod = "POST"
                
                let postParameters = ["action":"Donation", "msisdn":msisdn, "amount":amt, "username":username!, "os":getAppVersion()]
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
                                print("error is::\(error!.localizedDescription)")
                                DispatchQueue.main.async {
                                    self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process your request. Kindly try again...")
                                }
                                return;
                            }
                            do {
                                let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                                
                                if let parseJSON = myJSON {
//                                    print("responseBody: \(parseJSON)")
                                    DispatchQueue.main.async {
                                        var sessionAuth: String!
                                        sessionAuth = parseJSON["SessionAuth"] as! String?
                                        if sessionAuth == "true" {
                                          self.logout()
                                        }
                                        var responseBody: String?
                                        var responseCode: Int!
                                        var responseMessage: String!
                                        responseBody = parseJSON["responseBody"] as! String?
                                        if let responseBody = responseBody {
                                            let decrypt = self.decryptAsyncRequest(requestBody: responseBody)
                                            let decryptedResponseBody = self.convertToNSDictionary(decrypt: decrypt)
                                            print(decryptedResponseBody)
                                            responseCode = decryptedResponseBody["RESPONSECODE"] as! Int?
                                            if responseCode == 0 {
                                                responseMessage = decryptedResponseBody["RESPONSEMESSAGE"] as! String?
                                                UIView.animate(withDuration: 1, delay: 3, animations: {
                                                    self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "correct")), toast_message: responseMessage)
                                                }, completion: { (true) in
                                                    if self.hasRated == nil || self.hasRated == false {
                                                        self.showRatings()
                                                    }else{
                                                        self.view.removeFromSuperview()
                                                    }
                                                })
                                                
                                            }else if responseCode == 1 {
                                                responseMessage = decryptedResponseBody["RESPONSEMESSAGE"] as! String?
                                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: responseMessage)
                                            }else{
                                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process your request. Kindly retry.")
                                            }
                                        }
                                        self.stop_activity_loader()
                                    }
                                }
                            }catch{
                                print("catch: \(error.localizedDescription)")
                                DispatchQueue.main.async {
                                    self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process your request. Kindly try again...")
                                }
                            }
                        }
                        task.resume()
                    }
                }
            }
        }
        
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
        
    }

}

extension FreeSHS: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return registeredAccounts.count
        }else{
            return amtArray.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return registeredAccounts[row]
        }else{
            return amtArray[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if pickerView.tag == 1 {
            selectedAccount = registeredAccounts[row]
            txtMobileNumber.text = registeredAccounts[row]
            
            let accArr = selectedAccount?.components(separatedBy: " ")
            let arrayPick = accArr!.count - 1
            let accountNumber = accArr![arrayPick] //Last
            txtMobileNumberHidden.text = accountNumber
        }else{
            selectedAmt = amtArray[row]
            txtAmt.text = amtArray[row]
            if selectedAmt == "Enter amount"{
                btnSubmitTop.constant = 75
                txtAmtHidden.isHidden = false
                txtAmtHidden.text = "0.5"
            }else{
                btnSubmitTop.constant = 30
                txtAmtHidden.isHidden = true
                txtAmtHidden.text = selectedAmt
            }
        }
        
    }
}
