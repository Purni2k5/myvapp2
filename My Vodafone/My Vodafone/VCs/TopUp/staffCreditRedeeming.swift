//
//  staffCreditRedeeming.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 17/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class staffCreditRedeeming: baseViewControllerM {

    var msisdn: String?
    var displayAmt: String?
    var username: String?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        username = UserData["Username"] as? String
        view.backgroundColor = UIColor.dark_background
        setUpViewsRedeem()
    }
    
    func setUpViewsRedeem(){
        let btnClose = UIButton()
        view.addSubview(btnClose)
        btnClose.translatesAutoresizingMaskIntoConstraints = false
        let close_image = UIImage(named: "ic_close")
        btnClose.setImage(close_image, for: .normal)
        btnClose.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnClose.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnClose.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 10).isActive = true
        btnClose.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        btnClose.addTarget(self, action: #selector(closeModalB), for: .touchUpInside)
        
        let lblHeader = UILabel()
        view.addSubview(lblHeader)
        lblHeader.translatesAutoresizingMaskIntoConstraints = false
        lblHeader.text = "Staff Credit"
        lblHeader.textColor = UIColor.white
        lblHeader.font = UIFont(name: String.defaultFontR, size: 31)
        lblHeader.textAlignment = .center
        lblHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        lblHeader.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        lblHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
        let lblDesc = UILabel()
        view.addSubview(lblDesc)
        lblDesc.translatesAutoresizingMaskIntoConstraints = false
        lblDesc.textAlignment = .center
        lblDesc.textColor = UIColor.white
        lblDesc.font = UIFont(name: String.defaultFontR, size: 25)
        lblDesc.text = "You have requested to redeem your \(displayAmt!) staff credit for \(msisdn!)"
        lblDesc.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        lblDesc.topAnchor.constraint(equalTo: lblHeader.bottomAnchor, constant: 20).isActive = true
        lblDesc.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        lblDesc.numberOfLines = 0
        lblDesc.lineBreakMode = .byWordWrapping
        
        let imgCoupons = UIImageView(image: #imageLiteral(resourceName: "coupons"))
        view.addSubview(imgCoupons)
        imgCoupons.translatesAutoresizingMaskIntoConstraints = false
        imgCoupons.contentMode = .scaleAspectFill
        imgCoupons.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imgCoupons.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imgCoupons.topAnchor.constraint(equalTo: lblDesc.bottomAnchor, constant: 20).isActive = true
        imgCoupons.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        view.addSubview(btnContinue)
        btnContinue.translatesAutoresizingMaskIntoConstraints = false
        btnContinue.setTitle("Yes Continue", for: .normal)
        btnContinue.backgroundColor = UIColor.vodaRed
        btnContinue.setTitleColor(UIColor.white, for: .normal)
        btnContinue.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        btnContinue.topAnchor.constraint(equalTo: imgCoupons.bottomAnchor, constant: 10).isActive = true
        btnContinue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        btnContinue.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnContinue.addTarget(self, action: #selector(redeemCredit), for: .touchUpInside)
        
        let btnCancel = UIButton()
        view.addSubview(btnCancel)
        btnCancel.translatesAutoresizingMaskIntoConstraints = false
        btnCancel.setTitle("Cancel", for: .normal)
        btnCancel.backgroundColor = UIColor.grayButton
        btnCancel.setTitleColor(UIColor.white, for: .normal)
        btnCancel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        btnCancel.topAnchor.constraint(equalTo: btnContinue.bottomAnchor, constant: 10).isActive = true
        btnCancel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        btnCancel.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnCancel.addTarget(self, action: #selector(closeModalB), for: .touchUpInside)
        
        //activity loader
        view.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.topAnchor.constraint(equalTo: imgCoupons.bottomAnchor, constant: 20).isActive = true
    }
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        btnContinue.isHidden = true
    }
    
    @objc func redeemCredit(){
        if CheckInternet.Connection(){
            start_activity_loader()
            var primaryID = msisdn?.dropFirst(1)
            msisdn = "233\(primaryID!)"
            let postParameters:  Dictionary<String, Any> = [
                "action":"creditStaffMobilePrepaid",
                "msisdn":msisdn!,
                "username":username!,
                "os":getAppVersion()
            ]
            let async_call = URL(string: String.oldUserSVC)
            let request = NSMutableURLRequest(url: async_call!)
            request.httpMethod = "POST"
            if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
                request.httpBody = postData
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                
                let task = URLSession.shared.dataTask(with: request as URLRequest){
                    data, response, error in
                    if error != nil {
                        DispatchQueue.main.async {
                            self.stop_activity_loader()
                            self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: error!.localizedDescription)
                        }
                        return;
                    }
                    
                    do {
                        let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        if let parseJSON = myJSON {
                            let responseCode = parseJSON["RESPONSECODE"] as! Int?
                            let responseMessage = parseJSON["RESPONSEMESSAGE"] as! String?
                            DispatchQueue.main.async {
                                if responseCode == 0 {
                                    self.stop_activity_loader()
                                    self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "correct")), toast_message: responseMessage!)
                                }else{
                                    self.stop_activity_loader()
                                    self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: responseMessage!)
                                }
                            }
                        }
                    }catch{
                        DispatchQueue.main.async {
                            self.stop_activity_loader()
                            self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry try again..")
                        }
                    }
                }
                task.resume()
            }
        }else{
            let storyboard = UIStoryboard(name: "Support", bundle: nil)
            let moveTo = storyboard.instantiateViewController(withIdentifier: "NointernetViewController") as! NointernetViewController
            
            self.addChildViewController(moveTo)
            moveTo.view.frame = self.view.frame
            self.view.addSubview(moveTo.view)
            moveTo.didMove(toParentViewController: self)
        }
    }
    
    //Function to startIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        btnContinue.isHidden = false
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
}
