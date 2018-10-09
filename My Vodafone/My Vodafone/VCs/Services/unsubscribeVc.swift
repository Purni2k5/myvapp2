//
//  unsubscribeVc.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 08/10/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class unsubscribeVc: baseViewControllerM {
    var msisdn: String?
    var promotionID: String?
    var expirationDate: String?
    var plan: String?

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
    
    //create a closure for activity loader
    let activity_loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        view.hidesWhenStopped = true
        view.color = UIColor.vodaRed
        return view
    }()
    
    let btnRemove = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.dark_background
        setUpViewUns()
        modalPresentationCapturesStatusBarAppearance = true
        
//        print("\(msisdn!) \(promotionID) \(expirationDate!) \(plan!)")
        
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func setUpViewUns(){
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        scrollView.contentSize.height = 1000
        
        //dark view
        scrollView.addSubview(darkView)
        darkView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        darkView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        darkView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        darkView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        //Close button
        let btnClose = UIButton()
        scrollView.addSubview(btnClose)
        btnClose.translatesAutoresizingMaskIntoConstraints = false
        let closeImage = UIImage(named: "ic_close")
        btnClose.setImage(closeImage, for: .normal)
        btnClose.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnClose.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnClose.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 20).isActive = true
        btnClose.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -10).isActive = true
        btnClose.addTarget(self, action: #selector(closeModalB), for: .touchUpInside)
        
        //Header
        let lblHeader = UILabel()
        darkView.addSubview(lblHeader)
        lblHeader.translatesAutoresizingMaskIntoConstraints = false
        lblHeader.text = "Bundle Cancellation"
        lblHeader.font = UIFont(name: String.defaultFontR, size: 31)
        lblHeader.textColor = UIColor.white
        lblHeader.textAlignment = .center
        lblHeader.numberOfLines = 0
        lblHeader.lineBreakMode = .byWordWrapping
        lblHeader.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        lblHeader.bottomAnchor.constraint(equalTo: darkView.bottomAnchor, constant: -10).isActive = true
        lblHeader.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        
        //warning image
        let warningImage = UIImageView(image: #imageLiteral(resourceName: "warning"))
        scrollView.addSubview(warningImage)
        warningImage.translatesAutoresizingMaskIntoConstraints = false
        warningImage.widthAnchor.constraint(equalToConstant: 140).isActive = true
        warningImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        warningImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        warningImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 105).isActive = true
        
        let desc = UILabel()
        scrollView.addSubview(desc)
        desc.translatesAutoresizingMaskIntoConstraints = false
        desc.font = UIFont(name: String.defaultFontR, size: 20)
        if let plan = plan {
            let msisdnRip = msisdn?.dropFirst(3)
            desc.text = "You are about to cancel your \(plan) from \(msisdnRip!). \n\n This bundle will expire on \(expirationDate!) \n\n You will lose all resources associated with this bundle."
        }
        desc.textColor = UIColor.white
        desc.textAlignment = .center
        desc.topAnchor.constraint(equalTo: warningImage.bottomAnchor, constant: 20).isActive = true
        desc.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        desc.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        desc.numberOfLines = 0
        desc.lineBreakMode = .byWordWrapping
        
        
        scrollView.addSubview(btnRemove)
        btnRemove.translatesAutoresizingMaskIntoConstraints = false
        btnRemove.backgroundColor = UIColor.vodaRed
        btnRemove.setTitle("Remove this product", for: .normal)
        btnRemove.setTitleColor(UIColor.white, for: .normal)
        btnRemove.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnRemove.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        btnRemove.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: 20).isActive = true
        btnRemove.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        btnRemove.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnRemove.addTarget(self, action: #selector(removePdt), for: .touchUpInside)
        
        let btnCancel = UIButton()
        scrollView.addSubview(btnCancel)
        btnCancel.translatesAutoresizingMaskIntoConstraints = false
        btnCancel.backgroundColor = UIColor.grayButton
        btnCancel.setTitle("Cancel", for: .normal)
        btnCancel.setTitleColor(UIColor.white, for: .normal)
        btnCancel.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnCancel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        btnCancel.topAnchor.constraint(equalTo: btnRemove.bottomAnchor, constant: 10).isActive = true
        btnCancel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        btnCancel.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnCancel.addTarget(self, action: #selector(closeModalB), for: .touchUpInside)
        
        //activity loader
        scrollView.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: 20).isActive = true
        
    }
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
        btnRemove.isHidden = true
    }
    
    //Function to stopIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        btnRemove.isHidden = false
    }
    
    @objc func removePdt(){
        let async_call = URL(string: String.userURL)
        if !CheckInternet.Connection(){
            displayNoInternet()
        }else{
            if let promoID = promotionID{
                start_activity_loader()
                let postParameters: Dictionary<String, Any> = [
                    "action":"bundleUnsubscription",
                    "msisdn":msisdn!,
                    "bundleid":promoID,
                    "os":getDeviceOS()
                ]
                let request = NSMutableURLRequest(url: async_call!)
                request.httpMethod = "POST"
                
                if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
                    request.httpBody = postData
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                    
                    let task = URLSession.shared.dataTask(with: request as URLRequest){
                        data, response, error in
                        if error != nil{
                            DispatchQueue.main.async {
                                print("error is:: \(error!.localizedDescription)")
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
                                DispatchQueue.main.async {
                                    if responseCode == 0 {
                                        if let responseMessage = parseJSON["RESPONSEMESSAGE"] as! String?{
                                            self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "correct")), toast_message: responseMessage)
                                            UIView.animate(withDuration: 1, delay: 0.5, animations: {
                                                
                                            }, completion: { (true) in
                                                self.view.removeFromSuperview()
                                            })
                                        }
                                    }else{
                                        self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process your request try again later...")
                                    }
                                    self.stop_activity_loader()
                                }
                            }
                        }catch{
                            DispatchQueue.main.async {
                                self.stop_activity_loader()
                                print(error.localizedDescription)
                            }
                        }
                    }
                    task.resume()
                }
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
            }
        }
    }
}
