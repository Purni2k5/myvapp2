//
//  RegisterViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 09/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var errorDialogBg: UIImageView!
    @IBOutlet weak var info: UIImageView!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var register: UIButton!
    
    @IBOutlet weak var usernameTopConstraints: NSLayoutConstraint!
    
    
    var username:String?
    var password:String?
    var passClone:String?
    var msisdn:String?
    var totalmsisdn:Int?
    var totalPassChar: Int?
    
    //create activity loader closure
    let activity_loader: UIActivityIndicatorView = {
        let activity_loader = UIActivityIndicatorView()
        activity_loader.translatesAutoresizingMaskIntoConstraints = false
        activity_loader.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activity_loader.startAnimating()
        activity_loader.hidesWhenStopped = true
        activity_loader.isHidden = false
        return activity_loader
        
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        txtPhoneNumber.addTarget(self, action: #selector(checkInputFields), for: .editingChanged)
        
    }

    override func viewDidLayoutSubviews() {
        activity_loader.isHidden = true
    }
    
    
    @IBAction func btnRegister(_ sender: Any) {
        username = txtUsername.text
        password = txtPassword.text
        msisdn = txtPhoneNumber.text
        txtPhoneNumber.resignFirstResponder()
        //First check for internet connection
        if !CheckInternet.Connection(){
            let moveTo = storyboard?.instantiateViewController(withIdentifier: "NointernetViewController")
            self.addChildViewController(moveTo!)
            moveTo!.view.frame = self.view.frame
            self.view.addSubview(moveTo!.view)
            moveTo!.didMove(toParentViewController: self)
        }else{
            if username != "" && password != "" && msisdn != "" {
                //Check if username contains space
                
                if username!.contains(" "){
                    displayErrorMessage(errorMess: "Username should not contain spaces")
                }else{
                    print("Here now")
                    start_activity_loader()
                    // secure pass
                    username = username?.trimmingCharacters(in: .whitespacesAndNewlines)
                    password = password?.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    password = md5(password!)
                    password = password?.sha1()
                    passClone = password
                    
                    let postParameters: Dictionary<String, Any> = [
                        "action":"createNewAccount",
                        "contact":msisdn!,
                        "username":username!,
                        "password":password!,
                        "passClone":passClone!
                    ]
                    let async_api = URL(string: String.userSVC)
                    let request = NSMutableURLRequest(url: async_api!)
                    request.httpMethod = "POST"
                    //converting parameters to json
                    if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
                        request.httpBody = postData
                        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                        request.addValue("application/json", forHTTPHeaderField: "Accept")
                        
                        //creating a task to send request
                        let task = URLSession.shared.dataTask(with: request as URLRequest){
                            data, response, error in
                            if error != nil {
                                print("error is:: \(error!.localizedDescription)")
                                self.stop_activity_loader()
                                return;
                            }
                        }
                        task.resume()
                    }
                }
                
//                let moveTo = storyboard?.instantiateViewController(withIdentifier: "AccountConfViewController")
//                present(moveTo!, animated: true, completion: nil)
            }else{
                print("Some fields are empty")
            }
        }
    }
    
    func setUpViews(){
        view.addSubview(activity_loader)
        activity_loader.topAnchor.constraint(equalTo: txtPhoneNumber.bottomAnchor, constant: 30).isActive = true
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func checkInputFields(){
        msisdn = txtPhoneNumber.text
        totalmsisdn = msisdn?.count
        password = txtPassword.text
        totalPassChar = password?.count
        if totalmsisdn! == 10 && totalPassChar! >= 4 && password != "" && username != "" {
            register.backgroundColor = UIColor.vodaRed
            register.isEnabled = true
        }else{
            register.backgroundColor = UIColor.grayButton
            register.isEnabled = false
        }
        
    }
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        register.isHidden = true
    }
    
    //Function to startIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        register.isHidden = false
    }
    
    func displayErrorMessage(errorMess: String){
        usernameTopConstraints.constant = 80
        errorMessage.text = errorMess
        errorDialogBg.isHidden = false
        info.isHidden = false
        errorMessage.isHidden = false
    }
    
    //Hashing function
    func md5(_ string: String) -> String {
        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
        var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5_Init(context)
        CC_MD5_Update(context, string, CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8)))
        CC_MD5_Final(&digest, context)
        context.deallocate(capacity: 1)
        var hexString = ""
        for byte in digest {
            hexString += String(format:"%02x", byte)
        }
        return hexString
    }
    

}
