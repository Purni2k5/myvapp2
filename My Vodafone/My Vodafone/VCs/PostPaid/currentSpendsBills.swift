//
//  currentSpendsBills.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 09/11/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class currentSpendsBills: baseViewControllerM {
    
    var y_end: Int?
    var y_interval: Int?
    var y_unit: String?
    
    var username: String?
    var msisdn: String?
    
    let baseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.grayBackground
        return view
    }()
    
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
    
    let darkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        return view
    }()
    
    let lblYEnd: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 13)
        return view
    }()
    
    let lblYInterval: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 13)
        return view
    }()
    
    let yEndView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        return view
    }()
    
    let yIntervalView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        return view
    }()
    
    let lblYourPlan: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 13)
        return view
    }()
    
    let lblAvgOutSpend: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 13)
        return view
    }()
    
    let lblAvgOutSpendValue: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 13)
        return view
    }()
    
    let lblFirstMonth: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 13)
        return view
    }()
    
    let lblSecondMonth: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 13)
        return view
    }()
    
    let lblThirdMonth: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 13)
        return view
    }()
    
    let lblFourthMonth: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 13)
        return view
    }()
    
    let lblFifthMonth: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 13)
        return view
    }()
    
    let lblSixthMonth: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 13)
        return view
    }()
    
    //create a closure for activity loader
    let activity_loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        view.hidesWhenStopped = true
        return view
    }()
    let lblAverage = UILabel()
    let firstMonthBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.support_voilet
        view.widthAnchor.constraint(equalToConstant: 13).isActive = true
        view.layer.cornerRadius = 2
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground
        
        let responseData = preference.object(forKey: "responseData") as! NSDictionary
        username = responseData["Username"] as? String
        msisdn = preference.object(forKey: "defaultMSISDN") as! String?

        setUpViewsCurrSp()
        loadCurrentSpend()
        checkConnection()
    }
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
    }
    
    //Function to stopIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
    }

    func setUpViewsCurrSp(){
        view.addSubview(baseView)
        baseView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        baseView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        baseView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        baseView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: baseView.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor).isActive = true
        scrollView.contentSize.height = 1000
        
        scrollView.addSubview(topImage)
        let timeOfDay = greetings()
        if timeOfDay == "morning"{
            topImage.image = UIImage(named: "bg2")
        }else if timeOfDay == "afternoon" {
            topImage.image = UIImage(named: "afternoon_bg")
        }else{
            topImage.image = UIImage(named: "evening_bg2")
        }
        topImage.heightAnchor.constraint(equalToConstant: 550).isActive = true
        topImage.leadingAnchor.constraint(equalTo: baseView.leadingAnchor).isActive = true
        topImage.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        topImage.trailingAnchor.constraint(equalTo: baseView.trailingAnchor).isActive = true
        
        scrollView.addSubview(backButton)
        let backImage = UIImage(named: "leftArrow")
        let backTint = backImage?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(backTint, for: .normal)
        backButton.tintColor = UIColor.white
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 10).isActive = true
        backButton.addTarget(self, action: #selector(goToPostHome), for: .touchUpInside)
        
        let lblHeader = UILabel()
        scrollView.addSubview(lblHeader)
        lblHeader.translatesAutoresizingMaskIntoConstraints = false
        lblHeader.text = "Current spends and bills"
        lblHeader.textColor = UIColor.white
        lblHeader.font = UIFont(name: String.defaultFontR, size: 31)
        lblHeader.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
        lblHeader.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 50).isActive = true
        lblHeader.numberOfLines = 0
        lblHeader.lineBreakMode = .byWordWrapping
        
        topImage.addSubview(darkView)
        darkView.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        darkView.topAnchor.constraint(equalTo: lblHeader.bottomAnchor, constant: 10).isActive = true
        darkView.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        darkView.bottomAnchor.constraint(equalTo: topImage.bottomAnchor, constant: -35).isActive = true
        
        
        darkView.addSubview(lblAverage)
        lblAverage.translatesAutoresizingMaskIntoConstraints = false
        lblAverage.text = ""
        lblAverage.textColor = UIColor.white
        lblAverage.textAlignment = .center
        lblAverage.font = UIFont(name: String.defaultFontR, size: 16)
        lblAverage.numberOfLines = 0
        lblAverage.lineBreakMode = .byWordWrapping
        lblAverage.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 50).isActive = true
        lblAverage.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 20).isActive = true
        lblAverage.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -50).isActive = true
        
        darkView.addSubview(lblYEnd)
        lblYEnd.text = "GHS -- -- --"
        lblYEnd.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 10).isActive = true
        lblYEnd.topAnchor.constraint(equalTo: lblAverage.bottomAnchor, constant: 30).isActive = true
        lblYEnd.numberOfLines = 0
        lblYEnd.lineBreakMode = .byWordWrapping
        
        darkView.addSubview(yEndView)
        yEndView.leadingAnchor.constraint(equalTo: lblYEnd.trailingAnchor, constant: 10).isActive = true
        yEndView.topAnchor.constraint(equalTo: lblAverage.bottomAnchor, constant: 38).isActive = true
        yEndView.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -15).isActive = true
        
        darkView.addSubview(lblYInterval)
        lblYInterval.text = "GHS -- -- --"
        lblYInterval.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 10).isActive = true
        lblYInterval.topAnchor.constraint(equalTo: lblYEnd.bottomAnchor, constant: 90).isActive = true
        lblYInterval.numberOfLines = 0
        lblYInterval.lineBreakMode = .byWordWrapping
        
        darkView.addSubview(yIntervalView)
        yIntervalView.leadingAnchor.constraint(equalTo: lblYInterval.trailingAnchor, constant: 10).isActive = true
        yIntervalView.topAnchor.constraint(equalTo: lblYEnd.bottomAnchor, constant: 98).isActive = true
        yIntervalView.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -15).isActive = true
        
        darkView.addSubview(lblFirstMonth)
        lblFirstMonth.leadingAnchor.constraint(equalTo: lblYInterval.trailingAnchor, constant: 10).isActive = true
        lblFirstMonth.topAnchor.constraint(equalTo: yIntervalView.bottomAnchor, constant: 160).isActive = true
        lblFirstMonth.text = "May"
        
        
        
    }
    
    func loadCurrentSpend(){
        let async_call = URL(string: String.userURL)
        let request = NSMutableURLRequest(url: async_call!)
        
        let postParameters = ["action":"getBillHistory", "username":username!, "msisdn":msisdn!, "os":getAppVersion()]
        
        if let jsonParameters = try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted){
            let theJSONText = String(data:  jsonParameters, encoding: String.Encoding.utf8)
            let requestBody: Dictionary<String, Any> = [
                "requestBody":encryptAsyncRequest(requestBody: theJSONText!.description)
            ]
            if let postData = (try? JSONSerialization.data(withJSONObject: requestBody, options: JSONSerialization.WritingOptions.prettyPrinted)){
                request.httpBody = postData
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                
                var session = preference.object(forKey: UserDefaultsKeys.userSession.rawValue) as! String
                session = session.replacingOccurrences(of: "-", with: "")
                request.addValue(session, forHTTPHeaderField: "session")
                request.addValue(username!, forHTTPHeaderField: "username")
                
                let task = URLSession.shared.dataTask(with: request as URLRequest){
                    data, response, error in
                    if error != nil {
                        print("error is:: \(error!.localizedDescription)")
                        DispatchQueue.main.async {
                            self.stop_activity_loader()
                            self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process your request. Try again later...")
                        }
                        return;
                    }
                    do {
                        let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        if let parseJSON = myJSON {
                            print("responseBodys: \(parseJSON)")
                            var sessionAuth: String!
                            sessionAuth = parseJSON["SessionAuth"] as! String?
                            if sessionAuth == "true" {
                                DispatchQueue.main.async {
                                    self.logout()
                                }
                            }
                            var responseBody: String?
                            var responseCode: Int!
                            var responseMessage: NSDictionary!
                            responseBody = parseJSON["responseBody"] as! String?
                            if let responseBody = responseBody {
                                DispatchQueue.main.async {
                                    let decrypt = self.decryptAsyncRequest(requestBody: responseBody)
                                    let decryptedResponseBody = self.convertToNSDictionary(decrypt: decrypt)
//                                    print(decryptedResponseBody)
                                    responseCode = decryptedResponseBody["RESPONSECODE"] as! Int?
                                    if responseCode == 0 {
                                        self.stop_activity_loader()
                                        responseMessage = decryptedResponseBody["RESPONSEMESSAGE"] as? NSDictionary
                                        let graph = responseMessage["GRAPH"] as? NSDictionary
                                        let desc = responseMessage["DESC"] as? String
                                        if let descWrapped = desc {
                                            self.lblAverage.text = descWrapped
                                        }
                                        if let graphWrapped = graph {
                                            self.y_end = graphWrapped["Y_End"] as! Int?
                                            self.y_interval = graphWrapped["Y_Interval"] as! Int?
                                            self.y_unit = graphWrapped["Y_Unit"] as! String?
                                            if let y_end = self.y_end{
                                                self.lblYEnd.text = "GHS \(String(y_end))"
                                            }
                                            if let y_interval = self.y_interval{
                                                self.lblYInterval.text = "GHS \(String(y_interval))"
                                            }
                                        }
                                        let history = responseMessage["HISTORY"] as? NSArray
                                        if let array = history {
                                            for obj in array {
                                                if let dict = obj as? NSDictionary{
                                                    let billMonth = dict.value(forKey: "BillMonth") as! String?
                                                    print(billMonth)
                                                }
                                            }
                                        }
                                    } else if responseCode == 1 {
                                        self.stop_activity_loader()
                                        self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process your request. Try again later...")
                                    }
                                    else{
                                        self.stop_activity_loader()
                                        self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process your request. Try again later...")
                                    }
                                }
                            }else{
                                
                            }
                        }
                    }catch{
                        print("catch \(error.localizedDescription)")
                        DispatchQueue.main.async {
                            self.stop_activity_loader()
                            self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process your request. Try again later...")
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    @objc func goToPostHome(){
        let storyboard = UIStoryboard(name: "PostPaid", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "postPaidHome")
        present(moveTo, animated: true, completion: nil)
    }

}
