//
//  toppingUpViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 04/07/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class toppingUpViewController: baseViewControllerM, UIPickerViewDelegate, UIPickerViewDataSource, CNContactPickerDelegate {

//    let preference = UserDefaults.standard
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var txtTopUpNumber: UITextField!
    @IBOutlet weak var txtScratchNumber: UITextField!
    @IBOutlet weak var errorDialog: UIImageView!
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var lblErrorMessage: UILabel!
    @IBOutlet weak var lblMobileNum: UILabel!
    
    let txtHiddenPurchaseNum = UITextField()
    let btnContacts = UIButton()
    var selectedAccount: String?
    var defaultNumber: String?
    
    //contraints for labels
    @IBOutlet weak var lblMobileNoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var txtTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var btnProceed: UIButton!
    
    //api urlhttp://testpay.vodafonecash.com.gh/MyVodafoneAPI/UserSvc
    let topUpUrl = URL(string: "https://myvodafoneappmw.vodafone.com.gh/MVAppAPI/User")
    var username:String = ""
    
    var registeredAccounts = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        indicator.isHidden = true

        // change close btn colour.
        changeColour()
        //get default number and load
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        defaultNumber = preference.object(forKey: "defaultMSISDN") as! String
        username = UserData["Username"] as! String
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
                        txtTopUpNumber.text = accountInfo
                        txtHiddenPurchaseNum.text = contactPhone
                    }
                    if accountType.contains("BB_FIXED"){
                        
                    }else{
                        registeredAccounts.append(accountInfo)
                    }
                    
                    
                }
                iterate = iterate + 1
            }
            
            registeredAccounts.append("Buy for other number")
        }
        
//        txtTopUpNumber.text = defaultNumber
        createPickerView()
        createToolBar()
        
        print("default::\(defaultNumber)")
        print("username::\(username)")
        view.addSubview(txtHiddenPurchaseNum)
        txtHiddenPurchaseNum.translatesAutoresizingMaskIntoConstraints = false
        txtHiddenPurchaseNum.backgroundColor = UIColor.white
        txtHiddenPurchaseNum.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        txtHiddenPurchaseNum.topAnchor.constraint(equalTo: lblMobileNum.bottomAnchor, constant: 5).isActive = true
        txtHiddenPurchaseNum.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90).isActive = true
        txtHiddenPurchaseNum.heightAnchor.constraint(equalToConstant: 55).isActive = true
        txtHiddenPurchaseNum.borderStyle = .roundedRect
        txtHiddenPurchaseNum.isHidden = true
        
        view.addSubview(btnContacts)
        btnContacts.translatesAutoresizingMaskIntoConstraints = false
        let contactsImage = UIImage(named: "contactsHi")
        btnContacts.setImage(contactsImage, for: .normal)
        btnContacts.widthAnchor.constraint(equalToConstant: 70).isActive = true
        btnContacts.heightAnchor.constraint(equalToConstant: 60).isActive = true
        btnContacts.topAnchor.constraint(equalTo: lblMobileNum.bottomAnchor, constant: 1).isActive = true
        btnContacts.leadingAnchor.constraint(equalTo: txtHiddenPurchaseNum.trailingAnchor, constant: 5).isActive = true
        btnContacts.isHidden = true
        btnContacts.addTarget(self, action: #selector(showContacts), for: .touchUpInside)
    }
    @IBAction func closeTopu(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    //Function to complete transaction
    @IBAction func topUp(_ sender: Any) {
        //hide keyboard
        txtTopUpNumber.resignFirstResponder()
        txtScratchNumber.resignFirstResponder()
        let numberTopUp = txtHiddenPurchaseNum.text
        let scratchNumber = txtScratchNumber.text
        
        if numberTopUp == ""{
            errorDialog.isHidden = false
            errorImage.isHidden = false
            lblErrorMessage.isHidden = false
            lblErrorMessage.text = "Provide mobile number"
            lblMobileNoTopConstraint.constant = 68
            txtTopUpNumber.becomeFirstResponder()
        }else {
            errorDialog.isHidden = true
            errorImage.isHidden = true
            lblErrorMessage.isHidden = true
            lblMobileNoTopConstraint.constant = 20
            if scratchNumber == "" {
                errorDialog.isHidden = false
                errorImage.isHidden = false
                lblErrorMessage.isHidden = false
                lblErrorMessage.text = "Provide scratch card pin"
                lblMobileNoTopConstraint.constant = 68
                txtScratchNumber.becomeFirstResponder()
            }else{
                startAsyncLoader()
                //create nsurl request
                let request = NSMutableURLRequest(url: topUpUrl!)
                request.httpMethod = "POST"
                let postParameters = ["action":"topUp", "msisdn":numberTopUp!, "pin":scratchNumber!, "username":username, "os":getAppVersion()]
                print("Pster: \(postParameters)")
                
                if let jsonParameters = try? JSONSerialization.data(withJSONObject: postParameters, options: .prettyPrinted) {
                    
                    let theJSONText = String(data: jsonParameters,encoding: String.Encoding.utf8)
                    
                    let requestBody: Dictionary<String, Any> = [
                        "requestBody":encryptAsyncRequest(requestBody: theJSONText!.description)
                    ]
                    print("Pster: \(requestBody)")
                    if let postData = (try? JSONSerialization.data(withJSONObject: requestBody, options: JSONSerialization.WritingOptions.prettyPrinted)){
                        request.httpBody = postData
                        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                        request.addValue("application/json", forHTTPHeaderField: "Accept")
                        var session = preference.object(forKey: UserDefaultsKeys.userSession.rawValue) as! String
                        session = session.replacingOccurrences(of: "-", with: "")
                        
                        request.addValue(session, forHTTPHeaderField: "session")
                        request.addValue(username, forHTTPHeaderField: "username")
                        
                        //creating task to send post data
                        let task = URLSession.shared.dataTask(with: request as URLRequest){
                            data, response, error in
                            if error != nil {
                                print("error is:: \(error!)")
                                DispatchQueue.main.async {
                                    self.stopAsyncLoader()
                                }
                                return;
                            }
                            //parsing the response
                            do{
                                //converting response to NSDictionary
                                let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                                //parsing the json
                                if let parseJSON = myJSON {
                                    var responseBody: String?
                                    responseBody = parseJSON["responseBody"] as! String?
                                    
                                    let decrypt = self.decryptAsyncRequest(requestBody: responseBody!)
                                    
                                    let decryptedResponseBody = self.convertToNSDictionary(decrypt: decrypt)
                                    print(decryptedResponseBody)
                                    var responseCode: Int!
                                    var responseMessage: String!
                                    
                                    responseCode = decryptedResponseBody["RESPONSECODE"] as! Int?
                                    DispatchQueue.main.async {
                                        if responseCode == 0 {
                                            responseMessage = decryptedResponseBody["RESPONSEMESSAGE"] as! String?
                                            UIView.animate(withDuration: 1, delay: 2, options: .curveEaseIn, animations: {
                                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: responseMessage ?? "")
                                            }, completion: { (true) in
                                                self.view.removeFromSuperview()
                                            })
                                        }else if responseCode == 1{
                                            responseMessage = decryptedResponseBody["RESPONSEMESSAGE"] as! String?
                                            UIView.animate(withDuration: 1, delay: 2, options: .curveEaseIn, animations: {
                                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: responseMessage ?? "")
                                            }, completion: { (true) in
                                                self.view.removeFromSuperview()
                                            })
                                        }else{
                                            UIView.animate(withDuration: 1, delay: 2, options: .curveEaseIn, animations: {
                                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Could not process your request please try again...")
                                            }, completion: { (true) in
                                                self.view.removeFromSuperview()
                                            })
                                        }
                                        self.stopAsyncLoader()
                                        
                                    }
                                }
                                
                            }catch{
                                DispatchQueue.main.async {
                                    self.stopAsyncLoader()
                                }
                                print("error here")
                                print(error.localizedDescription)
                            }
                        }
                        task.resume()
                        
                    }
                }
                
            }
        }
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
        txtTopUpNumber.text = selectedAccount
        let accArr = selectedAccount?.components(separatedBy: " ")
        let arrayPick = accArr!.count - 1
        let accountNumber = accArr![arrayPick] //Last
        txtHiddenPurchaseNum.text = accountNumber
        if selectedAccount == "Buy for other number"{
            txtHiddenPurchaseNum.text = defaultNumber
            txtHiddenPurchaseNum.becomeFirstResponder()
            txtHiddenPurchaseNum.isHidden = false
            btnContacts.isHidden = false
            txtTopConstraint.constant = 70
        }else{
            txtHiddenPurchaseNum.isHidden = true
            btnContacts.isHidden = true
            txtTopConstraint.constant = 5
        }
    }
    
    //Function to create picker view for accounts
    func createPickerView(){
        let accountPicker = UIPickerView()
        accountPicker.delegate = self
        txtTopUpNumber.inputView = accountPicker
    }
    //Function to create a tool bar
    func createToolBar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(BuyOfferViewController.dismissKeyBoard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        txtTopUpNumber.inputAccessoryView =  toolBar
    }
    //Function to dismiss keyboard
    @objc func dismissKeyBoard(){
        view.endEditing(true)
    }
    
    @objc func showContacts(){
        let entityType = CNEntityType.contacts
        let authStatus = CNContactStore.authorizationStatus(for: entityType)
        
        if authStatus == CNAuthorizationStatus.notDetermined {
            let contactStore = CNContactStore.init()
            contactStore.requestAccess(for: entityType, completionHandler: { (success, nil) in
                if success {
                    self.openContacts()
                }else{
                    print("Not authorized")
                }
            })
        }else if authStatus == CNAuthorizationStatus.authorized {
            openContacts()
        }
    }
    
    func openContacts(){
        let contactPicker = CNContactPickerViewController.init()
        contactPicker.delegate = self
        present(contactPicker, animated: true, completion: nil)
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        picker.dismiss(animated: true) {
            
        }
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        //When user selects any contact
        var phoneNo = "Phone number not available"
        let phoneString = ((((contact.phoneNumbers[0] as AnyObject).value(forKey: "labelValuePair") as AnyObject).value(forKey: "value") as AnyObject).value(forKey: "stringValue"))
        phoneNo = phoneString as! String
        if phoneNo.contains("+233") || phoneNo.contains("+"){
            let newPhoneNo = phoneNo.dropFirst(4)
            phoneNo = "0\(newPhoneNo)"
        }else if phoneNo.contains("("){
            print("this")
            phoneNo = phoneNo.replacingOccurrences(of: "(", with: "")
            phoneNo = phoneNo.replacingOccurrences(of: ")", with: "")
            phoneNo = phoneNo.replacingOccurrences(of: "-", with: "")
            phoneNo = phoneNo.replacingOccurrences(of: " ", with: "")
        }
        else if phoneNo.contains("233"){
            let newPhoneNo = phoneNo.dropFirst(3)
            phoneNo = "0\(newPhoneNo)"
        }
        phoneNo = phoneNo.replacingOccurrences(of: " ", with: "")
        
        txtHiddenPurchaseNum.text = phoneNo
    }
    
    
    //change close btn colour
    func changeColour(){
        let close_image = UIImage(named: "new_close")
        let tintedImage = close_image?.withRenderingMode(.alwaysTemplate)
        btnClose.setImage(tintedImage, for: .normal)
        btnClose.tintColor = UIColor.white
    }
    
    //Function to start indicator
    func startAsyncLoader(){
        indicator.isHidden = false
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        btnProceed.isHidden = true
    }
    
    //Function to stop Indicator
    func stopAsyncLoader(){
        indicator.isHidden = true
        indicator.stopAnimating()
        btnProceed.isHidden = false
    }
    

}
