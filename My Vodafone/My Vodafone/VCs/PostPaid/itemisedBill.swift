//
//  itemisedBill.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 29/11/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

struct BillHistoryDataCells{
    let recipinet: String?
    let charge: String?
    let timeStamp: String?
}
class itemisedBill: baseViewControllerM {

    var parsedDate: String?
    var displayName: String?
    var username: String?
    var beginTime: String?
    var endTime: String?
    var msisdn: String?
    
    var eventDesc: String?
    var timeStamp: String?
    var charge: String?
    
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
    
    let lblDate: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 15)
        return view
    }()
    
    let lblSinceLastBill: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 30)
        return view
    }()
    
    let lblDisplayName: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 15)
        return view
    }()
    
    let displayImageView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "default_profile"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    //table
    let historyTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
    
    var cellID = "cellID"
    var billHistoryData = [BillHistoryDataCells]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground
        
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        username = UserData["Username"] as? String
        msisdn = preference.object(forKey: "defaultMSISDN") as! String?
        let billHistory = preference.object(forKey: UserDefaultsKeys.postPaidBreakDown.rawValue) as? String
        if let billHistoryWrapped = billHistory {
            let decrypt = decryptAsyncRequest(requestBody: billHistoryWrapped)
            let decryptedResponse = convertToNSDictionary(decrypt: decrypt)
            let responseMessage = decryptedResponse["RESPONSEMESSAGE"] as? NSDictionary
            if let responMess = responseMessage {
                let currentSpend = responMess["CurrentSpend"] as? NSDictionary
                if let currentSpend = currentSpend{
                    self.beginTime = currentSpend["UsageBeginTimeRaw"] as? String
                    self.endTime = currentSpend["UsageEndTimeRaw"] as? String
                    
                }
            }
            
            
        }
        

        setUpViewsItemisedBill()
        checkConnection()
        
        if CheckInternet.Connection(){
            getBillHistory()
        }
    }
    
    func setUpViewsItemisedBill(){
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        scrollView.addSubview(topImage)
        let timeOfDay = greetings()
        if timeOfDay == "morning"{
            topImage.image = UIImage(named: "bg2")
        }else if timeOfDay == "afternoon" {
            topImage.image = UIImage(named: "afternoon_bg")
        }else{
            topImage.image = UIImage(named: "evening_bg2")
        }
        topImage.heightAnchor.constraint(equalToConstant: 350).isActive = true
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
        backButton.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 20).isActive = true
        backButton.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 10).isActive = true
        backButton.addTarget(self, action: #selector(goToSinceLastBill), for: .touchUpInside)
        
        let lblHeader = UILabel()
        scrollView.addSubview(lblHeader)
        lblHeader.translatesAutoresizingMaskIntoConstraints = false
        lblHeader.text = "Itemised bill"
        lblHeader.textColor = UIColor.white
        lblHeader.font = UIFont(name: String.defaultFontR, size: 31)
        lblHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblHeader.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 50).isActive = true
        lblHeader.numberOfLines = 0
        lblHeader.lineBreakMode = .byWordWrapping
        
        scrollView.addSubview(darkView)
        darkView.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        darkView.topAnchor.constraint(equalTo: lblHeader.bottomAnchor, constant: 20).isActive = true
        darkView.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        darkView.bottomAnchor.constraint(equalTo: topImage.bottomAnchor, constant: -21).isActive = true
        
        darkView.addSubview(lblSinceLastBill)
        lblSinceLastBill.text = "Since last bill"
        lblSinceLastBill.font = UIFont(name: String.defaultFontR, size: 15)
        lblSinceLastBill.textColor = UIColor.white
        lblSinceLastBill.centerXAnchor.constraint(equalTo: darkView.centerXAnchor).isActive = true
        lblSinceLastBill.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 20).isActive = true
        lblSinceLastBill.numberOfLines = 0
        lblSinceLastBill.lineBreakMode = .byWordWrapping
        
        darkView.addSubview(displayImageView)
        displayImageView.centerXAnchor.constraint(equalTo: darkView.centerXAnchor).isActive = true
        displayImageView.topAnchor.constraint(equalTo: lblSinceLastBill.bottomAnchor, constant: 10).isActive = true
        displayImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        displayImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        displayImageView.layer.cornerRadius = 40
        displayImageView.layer.borderColor = UIColor.white.cgColor
        displayImageView.layer.borderWidth = 2
        
        darkView.addSubview(lblDisplayName)
        if let displayName = displayName {
            lblDisplayName.text = displayName
        }
        
        lblDisplayName.textColor = UIColor.white
        lblDisplayName.font = UIFont(name: String.defaultFontR, size: 15)
        lblDisplayName.topAnchor.constraint(equalTo: displayImageView.bottomAnchor, constant: 10).isActive = true
        lblDisplayName.centerXAnchor.constraint(equalTo: darkView.centerXAnchor).isActive = true
        
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        darkView.addSubview(separator)
        separator.backgroundColor = UIColor.white
        separator.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        separator.topAnchor.constraint(equalTo: lblDisplayName.bottomAnchor, constant: 10).isActive = true
        separator.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        
        darkView.addSubview(lblDate)
        lblDate.textColor = UIColor.white
        if let parseDate = parsedDate {
          lblDate.text = parseDate
        }
        
        lblDate.centerXAnchor.constraint(equalTo: darkView.centerXAnchor).isActive = true
        lblDate.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 10).isActive = true
        lblDate.numberOfLines = 0
        lblDate.lineBreakMode = .byWordWrapping
        
        scrollView.addSubview(cardView)
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cardView.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 20).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        cardView.addSubview(historyTableView)
        historyTableView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        historyTableView.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        historyTableView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        historyTableView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
        historyTableView.backgroundColor = UIColor.clear
        historyTableView.separatorStyle = .none
        historyTableView.register(PostPaidBillHistoryCells.self, forCellReuseIdentifier: cellID)
        historyTableView.tag = 999
        historyTableView.delegate = self
        historyTableView.dataSource = self
        
        //activity loader
        scrollView.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 40).isActive = true
        
        
        
        
    }
    
    func getBillHistory(){
        start_activity_loader()
        let async_call = URL(string: String.userURL)
        let request = NSMutableURLRequest(url: async_call!)
        request.httpMethod = "POST"
        
        let postParameters = ["action":"getUsageHistory", "username":username!, "msisdn":msisdn!, "accountType":"Post-Paid Account", "beginTime":beginTime!, "endTime":endTime!, "beginRow":"0", "os":getAppVersion()]
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
                        print("error is: \(error!.localizedDescription)")
                        DispatchQueue.main.async {
                            self.stop_activity_loader()
                            self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process your request. Try again later")
                        }
                        return
                    }
                    
                    do {
                        let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        if let parseJSON = myJSON {
                            print("myJSON \(parseJSON)")
                            
                            var responseBody: String?
                            var responseCode: Int!
                            var responseMessage: NSDictionary!
                            responseBody = parseJSON["responseBody"] as? String
                            if let responseBody = responseBody {
                                DispatchQueue.main.async {
                                    let decrypt = self.decryptAsyncRequest(requestBody: responseBody)
                                    let decryptedResponseBody = self.convertToNSDictionary(decrypt: decrypt)
                                    responseCode = decryptedResponseBody["RESPONSECODE"] as! Int?
                                    if responseCode == 0 {
                                        self.preference.set(responseBody, forKey: UserDefaultsKeys.postPaidBillHistory.rawValue)
                                        responseMessage = decryptedResponseBody["RESPONSEMESSAGE"] as? NSDictionary
//                                        print("decrypt \(responseMessage)")
                                        let historyDictionary = responseMessage["HISTORY"] as? NSDictionary
                                        if let historyDictionary = historyDictionary{
                                            let historyAll = historyDictionary["ALL"] as? NSArray
                                            if let array = historyAll {
                                                for obj in array {
                                                    print(obj)
                                                    if let dict = obj as? NSDictionary {
                                                        self.eventDesc = dict.value(forKey: "EventDesc") as? String
                                                        self.charge = dict.value(forKey: "Charge") as? String
                                                        self.timeStamp = dict.value(forKey: "TimeStamp") as? String
                                                        
                                                        let historyAppend = BillHistoryDataCells(recipinet: self.eventDesc ?? "", charge: self.charge ?? "", timeStamp: self.timeStamp ?? "")
                                                        self.billHistoryData.append(historyAppend)
                                                    }
                                                }
                                                self.historyTableView.reloadData()
                                            }
                                        }
                                        
                                    }
                                    
                                    self.stop_activity_loader()
                                    self.scrollView.contentSize.height = self.view.frame.height + 20 + self.cardView.frame.height
                                }
                                
                            }
                        }
                    }catch{
                        print(error.localizedDescription)
                        DispatchQueue.main.async {
                            self.stop_activity_loader()
                            self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process your request. Try again later")
                        }
                    }
                }
                task.resume()
            }
        }
        
    }
    
    @objc func goToSinceLastBill(){
        let storyboard = UIStoryboard(name: "PostPaid", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "SinceLastBill")
        present(moveTo, animated: true, completion: nil)
    }

}

extension itemisedBill: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return billHistoryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(withIdentifier: cellID) as! PostPaidBillHistoryCells
        cell.recipient = billHistoryData[indexPath.row].recipinet
        cell.charge = billHistoryData[indexPath.row].charge
        cell.timeStamp = billHistoryData[indexPath.row].timeStamp
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        return cell
    }
    
    
}
