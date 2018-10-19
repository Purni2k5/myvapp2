//
//  confirmFBBVoucher.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 05/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class confirmFBBVoucher: baseViewControllerM {
    
    var P_PHONENO: String?
    var currentBal: String?
    var accNo: String?
    var vouchercode: String?
    var username: String?
    var msisdn: String?
    var userID: String?

    //closure for scroll view
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //dark view
    let darkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
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
    
    let btnContinue = UIButton()
    let btnCancel = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.dark_background
        setUpVeiwsCFBBVoucher()
        
        
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        username = UserData["Username"] as? String
        msisdn = preference.object(forKey: "defaultMSISDN") as! String?
    }

    func setUpVeiwsCFBBVoucher(){
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.contentSize.height = 800
        
        view.addSubview(darkView)
        darkView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        darkView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        darkView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        darkView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
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
        btnClose.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        
        //Title
        let lblTitle = UILabel()
        darkView.addSubview(lblTitle)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.textColor = UIColor.white
        lblTitle.text = "Pay by Voucher"
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont(name: String.defaultFontR, size: 31)
        lblTitle.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        lblTitle.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 80).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: 20).isActive = true
        
        //Account details
        let lblDesc = UILabel()
        scrollView.addSubview(lblDesc)
        lblDesc.translatesAutoresizingMaskIntoConstraints = false
        lblDesc.textColor = UIColor.white
        lblDesc.textAlignment = .center
        lblDesc.font = UIFont(name: String.defaultFontR, size: 20)
        lblDesc.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        lblDesc.topAnchor.constraint(equalTo: darkView.bottomAnchor, constant: 20).isActive = true
        lblDesc.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        lblDesc.numberOfLines = 0
        lblDesc.lineBreakMode = .byWordWrapping
        lblDesc.text = "You have requested to make payment for the following account"
        
        let lblAccNo = UILabel()
        scrollView.addSubview(lblAccNo)
        lblAccNo.translatesAutoresizingMaskIntoConstraints = false
        lblAccNo.textColor = UIColor.white
        lblAccNo.textAlignment = .center
        lblAccNo.font = UIFont(name: String.defaultFontR, size: 20)
        lblAccNo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        lblAccNo.topAnchor.constraint(equalTo: lblDesc.bottomAnchor, constant: 3).isActive = true
        lblAccNo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        lblAccNo.numberOfLines = 0
        lblAccNo.lineBreakMode = .byWordWrapping
        if let accNo = accNo{
            lblAccNo.text = "Account Number: \(accNo)"
        }
        
        let lblPhoneNo = UILabel()
        scrollView.addSubview(lblPhoneNo)
        lblPhoneNo.translatesAutoresizingMaskIntoConstraints = false
        lblPhoneNo.textColor = UIColor.white
        lblPhoneNo.textAlignment = .center
        lblPhoneNo.font = UIFont(name: String.defaultFontR, size: 20)
        lblPhoneNo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        lblPhoneNo.topAnchor.constraint(equalTo: lblAccNo.bottomAnchor, constant: 3).isActive = true
        lblPhoneNo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        lblPhoneNo.numberOfLines = 0
        lblPhoneNo.lineBreakMode = .byWordWrapping
        if let P_PHONENO = P_PHONENO{
            lblPhoneNo.text = "Phone Number: \(P_PHONENO)"
        }
        
        let lblCurrBal = UILabel()
        scrollView.addSubview(lblCurrBal)
        lblCurrBal.translatesAutoresizingMaskIntoConstraints = false
        lblCurrBal.textColor = UIColor.white
        lblCurrBal.textAlignment = .center
        lblCurrBal.font = UIFont(name: String.defaultFontR, size: 20)
        lblCurrBal.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        lblCurrBal.topAnchor.constraint(equalTo: lblPhoneNo.bottomAnchor, constant: 3).isActive = true
        lblCurrBal.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        lblCurrBal.numberOfLines = 0
        lblCurrBal.lineBreakMode = .byWordWrapping
        if let currentBal = currentBal{
            lblCurrBal.text = "Current Balance GHS: \(currentBal)"
        }
        
        // continue button
        
        scrollView.addSubview(btnContinue)
        btnContinue.translatesAutoresizingMaskIntoConstraints = false
        btnContinue.backgroundColor = UIColor.vodaRed
        btnContinue.setTitle("Continue", for: .normal)
        btnContinue.setTitleColor(UIColor.white, for: .normal)
        btnContinue.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnContinue.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        btnContinue.topAnchor.constraint(equalTo: lblCurrBal.bottomAnchor, constant: 20).isActive = true
        btnContinue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        btnContinue.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnContinue.addTarget(self, action: #selector(purchase), for: .touchUpInside)
        
        // cancel button
        
        scrollView.addSubview(btnCancel)
        btnCancel.translatesAutoresizingMaskIntoConstraints = false
        btnCancel.backgroundColor = UIColor.grayButton
        btnCancel.setTitle("Cancel", for: .normal)
        btnCancel.setTitleColor(UIColor.white, for: .normal)
        btnCancel.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnCancel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        btnCancel.topAnchor.constraint(equalTo: btnContinue.bottomAnchor, constant: 20).isActive = true
        btnCancel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        btnCancel.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnCancel.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        
        //activity loader
        scrollView.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.topAnchor.constraint(equalTo: lblCurrBal.bottomAnchor, constant: 20).isActive = true
        
        scrollView.contentSize.height = view.frame.size.height
        
    }
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        btnContinue.isHidden = true
    }
    
    //Function to stopIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        btnContinue.isHidden = false
    }
    
    @objc func purchase(){
        if !CheckInternet.Connection(){
            displayNoInternet()
        }else{
            start_activity_loader()
            let postParameters: Dictionary<String, Any> = [
                "action": "fbbPayViaVoucher",
                "msisdn":msisdn!,
                "vouchercode": vouchercode!,
                "accountnumber":accNo!,
                "userid":userID!,
                "username":username!,
                "os":getAppVersion()
            ]
            
            let async_call = URL(string: String.oldUserURL)
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
                            //
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
                            if responseCode == 1 || responseCode == 2 {
                                var responseMessage: String?
                                responseMessage = parseJSON["RESPONSEMESSAGE"] as! String?
                                self.stop_activity_loader()
                                self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: responseMessage!)
                            }else{
                                self.view.removeFromSuperview()
                            }
                        }
                    }catch{
                        print(error.localizedDescription)
                        DispatchQueue.main.async {
                            self.stop_activity_loader()
                            self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: error.localizedDescription)
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    @objc func closeModal(){
        self.view.removeFromSuperview()
    }

}
