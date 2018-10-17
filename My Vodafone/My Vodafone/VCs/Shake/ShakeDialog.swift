//
//  ShakeDialog.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 16/10/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class ShakeDialog: baseViewControllerM {
  
    var username: String?
    var msisdn: String?
    
    var responseCode: Int?
    var responseMessage: String?
    var pid: String?
    var sessionID: String?
    
    //Display image
    let dialogImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Message
    let lblMessage: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 20)
        view.textAlignment = .center
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        return view
    }()
    
    //Confirm button
    let btnConfirm: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.vodaRed
        view.setTitle("Confirm", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        return view
    }()
    
    //Cancel button
    let btnCancel: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.support_dark_gray1
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
        view.color = UIColor.vodaRed
        view.hidesWhenStopped = true
        return view
    }()
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        btnConfirm.isHidden = true
        btnCancel.isHidden = true
        lblMessage.text = "Confirming your bundle purchase"
        
    }
    
    //Function to stopIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        btnCancel.isHidden = false
    }
    
    //Function to change Dialog Image
    func changeDialogImage(statusCode: Int){
        if statusCode == 0 {
            let dImage = UIImage(named: "shake_complete")
            dialogImage.image = dImage
        }else if statusCode == 1 {
            let dImage = UIImage(named: "shake_hand")
            dialogImage.image = dImage
        }
        else{
            let dImage = UIImage(named: "warning")
            dialogImage.image = dImage
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.grayButton
        setUpViewsShakeDialog()
        
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        username = UserData["Username"] as? String
        msisdn = preference.object(forKey: "defaultMSISDN") as! String?
    }
    
    func setUpViewsShakeDialog(){
        view.addSubview(dialogImage)
        dialogImage.image = UIImage(named: "warning")
        dialogImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        dialogImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        dialogImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dialogImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        
        view.addSubview(lblMessage)
        if responseCode == 1 {
            lblMessage.text = responseMessage
        }else if responseCode == 0 {
            lblMessage.text = responseMessage
        }else{
            lblMessage.text = "Sorry could not process request at this time"
        }
        lblMessage.topAnchor.constraint(equalTo: dialogImage.bottomAnchor, constant: 30).isActive = true
        lblMessage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        lblMessage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        
        //confirm button
        view.addSubview(btnConfirm)
        if responseCode == 0 {
            btnConfirm.isEnabled = false
        }else if responseCode == 1 {
            btnConfirm.isEnabled = true
        }else{
            btnConfirm.isEnabled = false
        }
        btnConfirm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        btnConfirm.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnConfirm.widthAnchor.constraint(equalToConstant: 150).isActive = true
        btnConfirm.topAnchor.constraint(equalTo: lblMessage.bottomAnchor, constant: 40).isActive = true
        btnConfirm.addTarget(self, action: #selector(confirmXPurchase), for: .touchUpInside)
        
        view.addSubview(btnCancel)
        btnCancel.topAnchor.constraint(equalTo: lblMessage.bottomAnchor, constant: 40).isActive = true
        btnCancel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        btnCancel.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnCancel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        view.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.topAnchor.constraint(equalTo: lblMessage.bottomAnchor, constant: 40).isActive = true
        
        
    }
    
    @objc func confirmXPurchase(){
        if !CheckInternet.Connection(){
            displayNoInternet()
        }else{
            start_activity_loader()
            changeDialogImage(statusCode: 1)
            
            let async_call = URL(string: String.MVA_SHAKE_PROMOS)
            let request = NSMutableURLRequest(url: async_call!)
            request.httpMethod = "POST"
            
            let postParameters: Dictionary<String, Any> = [
                "action":"ShakeBuyPackage",
                "msisdn":msisdn!,
                "bundleid":pid!,
                "username":username!,
                "bundletoremove":"",
                "sessionID":sessionID!,
                "os":getAppVersion()
            ]
            
            if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
                request.httpBody = postData
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                
                let task = URLSession.shared.dataTask(with: request as URLRequest){
                    data, response, error in
                    if error != nil {
                        DispatchQueue.main.async {
                            print("error is:: \(error!.localizedDescription)")
                            self.changeDialogImage(statusCode: 2)
                            self.stop_activity_loader()
                        }
                        return
                    }
                    
                    do {
                        let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        if let parseJSON = myJSON {
                            var responseCode: Int?
                            responseCode = parseJSON["RESPONSECODE"] as! Int?
                            DispatchQueue.main.async {
                                if responseCode == 2 {
                                    let rMessage = parseJSON["RESPONSEMESSAGE"] as! String?
                                    let sdErrorMessage = parseJSON["SDERRORMESSAGE"] as! String?
                                    self.stop_activity_loader()
                                    self.changeDialogImage(statusCode: 2)
                                    if let rMessage = rMessage {
                                        self.lblMessage.text = rMessage
                                    }
                                }else if responseCode == 0 {
                                    let rMessage = parseJSON["RESPONSEMESSAGE"] as! String?
                                    self.stop_activity_loader()
                                    UIView.animate(withDuration: 1, delay: 5, options: .curveEaseIn, animations: {
                                        self.changeDialogImage(statusCode: 0)
                                        if let rMessage = rMessage {
                                            self.lblMessage.text = rMessage
                                        }
                                    }, completion: { (true) in
                                        // Go to home screen
                                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                        let moveTo = storyboard.instantiateViewController(withIdentifier: "homeVC")
                                        self.present(moveTo, animated: true, completion: nil)
                                    })
                                    
                                    
                                }else{
                                    let rMessage = parseJSON["RESPONSEMESSAGE"] as! String?
                                    print("error message: \(rMessage ?? "")")
                                    self.stop_activity_loader()
                                    self.changeDialogImage(statusCode: 2)
                                    self.lblMessage.text = "Sorry could not process your request"
                                }
                            }
                        }
                    }catch{
                        DispatchQueue.main.async {
                            print("error is:: \(error.localizedDescription)")
                            self.changeDialogImage(statusCode: 2)
                            self.stop_activity_loader()
                            self.lblMessage.text = "Sorry could not process request at this time"
                        }
                    }
                }
                task.resume()
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
        }
        
        
        
    }
    
    
    override var prefersStatusBarHidden: Bool{
        return true
    }

}
