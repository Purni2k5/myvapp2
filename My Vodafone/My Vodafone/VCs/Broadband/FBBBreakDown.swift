//
//  FBBBreakDown.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 23/10/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class FBBBreakDown: baseViewControllerM {
    var username: String?
    var userID: String?
    var accountNumber: String?
    var displayName: String?
    var ffbAccountName: String?
    var dService: String?
    var primaryID: String?
    var bbUsageDetails: String?
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
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
    
    //dark view
    let darkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.60)
        view.isOpaque = false
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
    
    let gaugeViewHolder = UIView()

    fileprivate func retrieveCached(_ bbUsageDetails: String) {
        var responseBody: String?
        var responseCode: Int!
        var responseMessage: NSDictionary!
        
        let decrypt = self.decryptAsyncRequest(requestBody: bbUsageDetails)
        print("Decrypted:: \(decrypt)")
        let decryptedResponseBody = self.convertToNSDictionary(decrypt: decrypt)
        print(decryptedResponseBody)
        responseCode = decryptedResponseBody["RESPONSECODE"] as! Int?
        
        if responseCode == 0 {
            self.stop_activity_loader()
            responseMessage = decryptedResponseBody["RESPONSEMESSAGE"] as! NSDictionary?
            let P_CURRENTVOL = responseMessage["P_CURRENTVOL"] as! String?
            let P_CURRENTBAL = responseMessage["P_CURRENTBAL"] as! String?
            let TOTALINITIAL = responseMessage["TOTALINITIAL"] as! String?
            let P_ADVANCEPAYMENT = responseMessage["P_ADVANCEPAYMENT"] as! String?
            let P_PLANNAME = responseMessage["P_PLANNAME"] as! String?
            let PERCENTAGE = responseMessage["PERCENTAGE"] as! String?
            let totalInitialUnit = responseMessage["TOTALINITIALUNIT"] as! String?
            let expireyDate = responseMessage["P_EXPIRYDATE"] as! String?
            let unit = responseMessage["UNIT"] as! String?
            let accountNumber = responseMessage["P_ACCOUNTNO"] as! String?
            let phoneNo = responseMessage["P_PHONENO"] as! String?
            let status = responseMessage["P_STATUS"] as! String?
            let serviceNo = responseMessage["P_SERVICENO"] as! String?
            
            let cardView1 = UIView()
            self.scrollView.addSubview(cardView1)
            cardView1.translatesAutoresizingMaskIntoConstraints = false
            cardView1.backgroundColor = UIColor.white
            cardView1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
            cardView1.topAnchor.constraint(equalTo: self.topImage.bottomAnchor, constant: 20).isActive = true
            cardView1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
            cardView1.heightAnchor.constraint(equalToConstant: 800).isActive = true
            cardView1.layer.cornerRadius = 2
            cardView1.layer.shadowOffset = CGSize(width: 0, height: 5)
            cardView1.layer.shadowColor = UIColor.black.cgColor
            cardView1.layer.shadowOpacity = 0.2
            if let percConv = PERCENTAGE{
                var PERCENTAGECov = Double(percConv)
                PERCENTAGECov = 100 - PERCENTAGECov!
                print("progress \(PERCENTAGECov ?? 0.00)")
                
                //label for plan
                let lblPlan = UILabel()
                cardView1.addSubview(lblPlan)
                lblPlan.translatesAutoresizingMaskIntoConstraints = false
                lblPlan.text = P_PLANNAME
                lblPlan.textColor = UIColor.black
                lblPlan.font = UIFont(name: String.defaultFontR, size: 25)
                lblPlan.numberOfLines = 0
                lblPlan.lineBreakMode = .byWordWrapping
                lblPlan.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                lblPlan.topAnchor.constraint(equalTo: cardView1.topAnchor, constant: 10).isActive = true
                lblPlan.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                
                //label for expiry Date
                let lblExpiryDate = UILabel()
                cardView1.addSubview(lblExpiryDate)
                lblExpiryDate.translatesAutoresizingMaskIntoConstraints = false
                lblExpiryDate.text = "Expires on: \(expireyDate ?? "")"
                lblExpiryDate.textColor = UIColor.black
                lblExpiryDate.font = UIFont(name: String.defaultFontR, size: 15)
                lblExpiryDate.numberOfLines = 0
                lblExpiryDate.lineBreakMode = .byWordWrapping
                lblExpiryDate.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                lblExpiryDate.topAnchor.constraint(equalTo: lblPlan.bottomAnchor, constant: 5).isActive = true
                lblExpiryDate.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                let sep1 = UIView()
                cardView1.addSubview(sep1)
                sep1.translatesAutoresizingMaskIntoConstraints = false
                sep1.backgroundColor = UIColor.gray.withAlphaComponent(0.40)
                sep1.heightAnchor.constraint(equalToConstant: 0.2).isActive = true
                sep1.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                sep1.topAnchor.constraint(equalTo: lblExpiryDate.bottomAnchor, constant: 30).isActive = true
                sep1.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -20).isActive = true
                
                //label for Percentage Used
                let lblPercUsed = UILabel()
                cardView1.addSubview(lblPercUsed)
                lblPercUsed.translatesAutoresizingMaskIntoConstraints = false
                lblPercUsed.text = "Percentage Used"
                lblPercUsed.textColor = UIColor.black
                lblPercUsed.font = UIFont(name: String.defaultFontR, size: 17)
                lblPercUsed.numberOfLines = 0
                lblPercUsed.lineBreakMode = .byWordWrapping
                lblPercUsed.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                lblPercUsed.topAnchor.constraint(equalTo: sep1.bottomAnchor, constant: 40).isActive = true
                lblPercUsed.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                
                let lblPercUsedValue = UILabel()
                cardView1.addSubview(lblPercUsedValue)
                lblPercUsedValue.translatesAutoresizingMaskIntoConstraints = false
                lblPercUsedValue.text = "\(PERCENTAGECov ?? 00.00)%"
                lblPercUsedValue.textColor = UIColor.black
                lblPercUsedValue.font = UIFont(name: String.defaultFontR, size: 17)
                lblPercUsedValue.numberOfLines = 0
                lblPercUsedValue.lineBreakMode = .byWordWrapping
                lblPercUsedValue.topAnchor.constraint(equalTo: sep1.bottomAnchor, constant: 40).isActive = true
                lblPercUsedValue.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                
                
                
                let sep2 = UIView()
                cardView1.addSubview(sep2)
                sep2.translatesAutoresizingMaskIntoConstraints = false
                sep2.backgroundColor = UIColor.gray.withAlphaComponent(0.40)
                sep2.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
                sep2.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                sep2.topAnchor.constraint(equalTo: lblPercUsed.bottomAnchor, constant: 30).isActive = true
                sep2.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -20).isActive = true
                
                //label for Account Number
                let lblAccNum = UILabel()
                cardView1.addSubview(lblAccNum)
                lblAccNum.translatesAutoresizingMaskIntoConstraints = false
                lblAccNum.text = "Account Number"
                lblAccNum.textColor = UIColor.black
                lblAccNum.font = UIFont(name: String.defaultFontR, size: 17)
                lblAccNum.numberOfLines = 0
                lblAccNum.lineBreakMode = .byWordWrapping
                lblAccNum.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                lblAccNum.topAnchor.constraint(equalTo: sep2.bottomAnchor, constant: 15).isActive = true
                lblAccNum.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                
                let lblAccNumValue = UILabel()
                cardView1.addSubview(lblAccNumValue)
                lblAccNumValue.translatesAutoresizingMaskIntoConstraints = false
                lblAccNumValue.text = accountNumber
                lblAccNumValue.textColor = UIColor.black
                lblAccNumValue.font = UIFont(name: String.defaultFontR, size: 17)
                lblAccNumValue.numberOfLines = 0
                lblAccNumValue.lineBreakMode = .byWordWrapping
                lblAccNumValue.topAnchor.constraint(equalTo: sep2.bottomAnchor, constant: 15).isActive = true
                lblAccNumValue.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                
                let sep3 = UIView()
                cardView1.addSubview(sep3)
                sep3.translatesAutoresizingMaskIntoConstraints = false
                sep3.backgroundColor = UIColor.gray.withAlphaComponent(0.40)
                sep3.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
                sep3.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                sep3.topAnchor.constraint(equalTo: lblAccNum.bottomAnchor, constant: 30).isActive = true
                sep3.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -20).isActive = true
                //label for Phone Number
                let lblPhoneNum = UILabel()
                cardView1.addSubview(lblPhoneNum)
                lblPhoneNum.translatesAutoresizingMaskIntoConstraints = false
                lblPhoneNum.text = "Phone Number"
                lblPhoneNum.textColor = UIColor.black
                lblPhoneNum.font = UIFont(name: String.defaultFontR, size: 17)
                lblPhoneNum.numberOfLines = 0
                lblPhoneNum.lineBreakMode = .byWordWrapping
                lblPhoneNum.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                lblPhoneNum.topAnchor.constraint(equalTo: sep3.bottomAnchor, constant: 15).isActive = true
                lblPhoneNum.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                
                let lblPhoneValue = UILabel()
                cardView1.addSubview(lblPhoneValue)
                lblPhoneValue.translatesAutoresizingMaskIntoConstraints = false
                lblPhoneValue.text = phoneNo
                lblPhoneValue.textColor = UIColor.black
                lblPhoneValue.font = UIFont(name: String.defaultFontR, size: 17)
                lblPhoneValue.numberOfLines = 0
                lblPhoneValue.lineBreakMode = .byWordWrapping
                lblPhoneValue.topAnchor.constraint(equalTo: sep3.bottomAnchor, constant: 15).isActive = true
                lblPhoneValue.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                
                let sep4 = UIView()
                cardView1.addSubview(sep4)
                sep4.translatesAutoresizingMaskIntoConstraints = false
                sep4.backgroundColor = UIColor.gray.withAlphaComponent(0.40)
                sep4.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
                sep4.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                sep4.topAnchor.constraint(equalTo: lblPhoneNum.bottomAnchor, constant: 30).isActive = true
                sep4.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -20).isActive = true
                
                //label for Service Name
                let lblService = UILabel()
                cardView1.addSubview(lblService)
                lblService.translatesAutoresizingMaskIntoConstraints = false
                lblService.text = "Service Name"
                lblService.textColor = UIColor.black
                lblService.font = UIFont(name: String.defaultFontR, size: 17)
                lblService.numberOfLines = 0
                lblService.lineBreakMode = .byWordWrapping
                lblService.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                lblService.topAnchor.constraint(equalTo: sep4.bottomAnchor, constant: 15).isActive = true
                lblService.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                
                let lblServiceValue = UILabel()
                cardView1.addSubview(lblServiceValue)
                lblServiceValue.translatesAutoresizingMaskIntoConstraints = false
                lblServiceValue.text = serviceNo
                lblServiceValue.textColor = UIColor.black
                lblServiceValue.font = UIFont(name: String.defaultFontR, size: 17)
                lblServiceValue.numberOfLines = 0
                lblServiceValue.lineBreakMode = .byWordWrapping
                lblServiceValue.topAnchor.constraint(equalTo: sep4.bottomAnchor, constant: 15).isActive = true
                lblServiceValue.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                
                let sep5 = UIView()
                cardView1.addSubview(sep5)
                sep5.translatesAutoresizingMaskIntoConstraints = false
                sep5.backgroundColor = UIColor.gray.withAlphaComponent(0.40)
                sep5.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
                sep5.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                sep5.topAnchor.constraint(equalTo: lblService.bottomAnchor, constant: 30).isActive = true
                sep5.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -20).isActive = true
                
                //label for Status
                let lblStatus = UILabel()
                cardView1.addSubview(lblStatus)
                lblStatus.translatesAutoresizingMaskIntoConstraints = false
                lblStatus.text = "Status"
                lblStatus.textColor = UIColor.black
                lblStatus.font = UIFont(name: String.defaultFontR, size: 17)
                lblStatus.numberOfLines = 0
                lblStatus.lineBreakMode = .byWordWrapping
                lblStatus.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                lblStatus.topAnchor.constraint(equalTo: sep5.bottomAnchor, constant: 15).isActive = true
                lblStatus.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                
                let lblStatusValue = UILabel()
                cardView1.addSubview(lblStatusValue)
                lblStatusValue.translatesAutoresizingMaskIntoConstraints = false
                lblStatusValue.text = status
                lblStatusValue.textColor = UIColor.black
                lblStatusValue.font = UIFont(name: String.defaultFontR, size: 17)
                lblStatusValue.numberOfLines = 0
                lblStatusValue.lineBreakMode = .byWordWrapping
                lblStatusValue.topAnchor.constraint(equalTo: sep5.bottomAnchor, constant: 15).isActive = true
                lblStatusValue.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                
                let sep6 = UIView()
                cardView1.addSubview(sep6)
                sep6.translatesAutoresizingMaskIntoConstraints = false
                sep6.backgroundColor = UIColor.gray.withAlphaComponent(0.40)
                sep6.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
                sep6.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                sep6.topAnchor.constraint(equalTo: lblStatus.bottomAnchor, constant: 30).isActive = true
                sep6.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -20).isActive = true
                
                //label for Plan
                let lblPlanSub = UILabel()
                cardView1.addSubview(lblPlanSub)
                lblPlanSub.translatesAutoresizingMaskIntoConstraints = false
                lblPlanSub.text = "Plan"
                lblPlanSub.textColor = UIColor.black
                lblPlanSub.font = UIFont(name: String.defaultFontR, size: 17)
                lblPlanSub.numberOfLines = 0
                lblPlanSub.lineBreakMode = .byWordWrapping
                lblPlanSub.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                lblPlanSub.topAnchor.constraint(equalTo: sep6.bottomAnchor, constant: 15).isActive = true
                lblPlanSub.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                
                let lblPlanValue = UILabel()
                cardView1.addSubview(lblPlanValue)
                lblPlanValue.translatesAutoresizingMaskIntoConstraints = false
                lblPlanValue.text = P_PLANNAME
                lblPlanValue.textColor = UIColor.black
                lblPlanValue.font = UIFont(name: String.defaultFontR, size: 17)
                lblPlanValue.numberOfLines = 0
                lblPlanValue.lineBreakMode = .byWordWrapping
                lblPlanValue.topAnchor.constraint(equalTo: sep6.bottomAnchor, constant: 15).isActive = true
                lblPlanValue.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                
                let sep7 = UIView()
                cardView1.addSubview(sep7)
                sep7.translatesAutoresizingMaskIntoConstraints = false
                sep7.backgroundColor = UIColor.gray.withAlphaComponent(0.40)
                sep7.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
                sep7.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                sep7.topAnchor.constraint(equalTo: lblPlanSub.bottomAnchor, constant: 30).isActive = true
                sep7.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -20).isActive = true
                
                //label for Initial Data
                let lblInitialData = UILabel()
                cardView1.addSubview(lblInitialData)
                lblInitialData.translatesAutoresizingMaskIntoConstraints = false
                lblInitialData.text = "Initial Data"
                lblInitialData.textColor = UIColor.black
                lblInitialData.font = UIFont(name: String.defaultFontR, size: 17)
                lblInitialData.numberOfLines = 0
                lblInitialData.lineBreakMode = .byWordWrapping
                lblInitialData.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                lblInitialData.topAnchor.constraint(equalTo: sep7.bottomAnchor, constant: 15).isActive = true
                lblInitialData.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                
                let lblInitialDataValue = UILabel()
                cardView1.addSubview(lblInitialDataValue)
                lblInitialDataValue.translatesAutoresizingMaskIntoConstraints = false
                lblInitialDataValue.text = "\(TOTALINITIAL ?? "")\(totalInitialUnit ?? "")"
                lblInitialDataValue.textColor = UIColor.black
                lblInitialDataValue.font = UIFont(name: String.defaultFontR, size: 17)
                lblInitialDataValue.numberOfLines = 0
                lblInitialDataValue.lineBreakMode = .byWordWrapping
                lblInitialDataValue.topAnchor.constraint(equalTo: sep7.bottomAnchor, constant: 15).isActive = true
                lblInitialDataValue.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                
                let sep8 = UIView()
                cardView1.addSubview(sep8)
                sep8.translatesAutoresizingMaskIntoConstraints = false
                sep8.backgroundColor = UIColor.gray.withAlphaComponent(0.40)
                sep8.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
                sep8.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                sep8.topAnchor.constraint(equalTo: lblInitialData.bottomAnchor, constant: 30).isActive = true
                sep8.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -20).isActive = true
                
                //label for Unused Data
                let lblUnusedData = UILabel()
                cardView1.addSubview(lblUnusedData)
                lblUnusedData.translatesAutoresizingMaskIntoConstraints = false
                lblUnusedData.text = "Unused Data"
                lblUnusedData.textColor = UIColor.black
                lblUnusedData.font = UIFont(name: String.defaultFontR, size: 17)
                lblUnusedData.numberOfLines = 0
                lblUnusedData.lineBreakMode = .byWordWrapping
                lblUnusedData.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                lblUnusedData.topAnchor.constraint(equalTo: sep8.bottomAnchor, constant: 15).isActive = true
                lblUnusedData.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                
                let lblUnusedDataValue = UILabel()
                cardView1.addSubview(lblUnusedDataValue)
                lblUnusedDataValue.translatesAutoresizingMaskIntoConstraints = false
                lblUnusedDataValue.text = "\(P_CURRENTVOL ?? "")\(unit ?? "")"
                lblUnusedDataValue.textColor = UIColor.black
                lblUnusedDataValue.font = UIFont(name: String.defaultFontR, size: 17)
                lblUnusedDataValue.numberOfLines = 0
                lblUnusedDataValue.lineBreakMode = .byWordWrapping
                lblUnusedDataValue.topAnchor.constraint(equalTo: sep8.bottomAnchor, constant: 15).isActive = true
                lblUnusedDataValue.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                
                let sep9 = UIView()
                cardView1.addSubview(sep9)
                sep9.translatesAutoresizingMaskIntoConstraints = false
                sep9.backgroundColor = UIColor.gray.withAlphaComponent(0.40)
                sep9.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
                sep9.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                sep9.topAnchor.constraint(equalTo: lblUnusedData.bottomAnchor, constant: 30).isActive = true
                sep9.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -20).isActive = true
                
                //label for Current Balance
                let lblCurrentBalance = UILabel()
                cardView1.addSubview(lblCurrentBalance)
                lblCurrentBalance.translatesAutoresizingMaskIntoConstraints = false
                lblCurrentBalance.text = "Current Balance"
                lblCurrentBalance.textColor = UIColor.black
                lblCurrentBalance.font = UIFont(name: String.defaultFontR, size: 17)
                lblCurrentBalance.numberOfLines = 0
                lblCurrentBalance.lineBreakMode = .byWordWrapping
                lblCurrentBalance.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                lblCurrentBalance.topAnchor.constraint(equalTo: sep9.bottomAnchor, constant: 15).isActive = true
                lblCurrentBalance.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                
                let lblCurrBalValue = UILabel()
                cardView1.addSubview(lblCurrBalValue)
                lblCurrBalValue.translatesAutoresizingMaskIntoConstraints = false
                lblCurrBalValue.text = "GHS \(P_CURRENTBAL ?? "")"
                lblCurrBalValue.textColor = UIColor.black
                lblCurrBalValue.font = UIFont(name: String.defaultFontR, size: 17)
                lblCurrBalValue.numberOfLines = 0
                lblCurrBalValue.lineBreakMode = .byWordWrapping
                lblCurrBalValue.topAnchor.constraint(equalTo: sep9.bottomAnchor, constant: 15).isActive = true
                lblCurrBalValue.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                
                let sep10 = UIView()
                cardView1.addSubview(sep10)
                sep10.translatesAutoresizingMaskIntoConstraints = false
                sep10.backgroundColor = UIColor.gray.withAlphaComponent(0.40)
                sep10.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
                sep10.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                sep10.topAnchor.constraint(equalTo: lblCurrentBalance.bottomAnchor, constant: 30).isActive = true
                sep10.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -20).isActive = true
                
                //label for Cash In Account
                let lblCashAcc = UILabel()
                cardView1.addSubview(lblCashAcc)
                lblCashAcc.translatesAutoresizingMaskIntoConstraints = false
                lblCashAcc.text = "Cash in Account"
                lblCashAcc.textColor = UIColor.black
                lblCashAcc.font = UIFont(name: String.defaultFontR, size: 17)
                lblCashAcc.numberOfLines = 0
                lblCashAcc.lineBreakMode = .byWordWrapping
                lblCashAcc.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                lblCashAcc.topAnchor.constraint(equalTo: sep10.bottomAnchor, constant: 15).isActive = true
                lblCashAcc.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                
                let lblCashAccValue = UILabel()
                cardView1.addSubview(lblCashAccValue)
                lblCashAccValue.translatesAutoresizingMaskIntoConstraints = false
                lblCashAccValue.text = "GHS \(P_ADVANCEPAYMENT ?? "")"
                lblCashAccValue.textColor = UIColor.black
                lblCashAccValue.font = UIFont(name: String.defaultFontR, size: 17)
                lblCashAccValue.numberOfLines = 0
                lblCashAccValue.lineBreakMode = .byWordWrapping
                lblCashAccValue.topAnchor.constraint(equalTo: sep10.bottomAnchor, constant: 15).isActive = true
                lblCashAccValue.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                
                let sep11 = UIView()
                cardView1.addSubview(sep11)
                sep11.translatesAutoresizingMaskIntoConstraints = false
                sep11.backgroundColor = UIColor.gray.withAlphaComponent(0.40)
                sep11.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
                sep11.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                sep11.topAnchor.constraint(equalTo: lblCashAcc.bottomAnchor, constant: 30).isActive = true
                sep11.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -20).isActive = true
                
                let btnGauge = UIButton()
                cardView1.addSubview(btnGauge)
                btnGauge.translatesAutoresizingMaskIntoConstraints = false
                btnGauge.backgroundColor = UIColor.vodaRed
                btnGauge.setTitle("View Gauge", for: .normal)
                btnGauge.setTitleColor(UIColor.white, for: .normal)
                btnGauge.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
                btnGauge.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                btnGauge.topAnchor.constraint(equalTo: sep11.bottomAnchor, constant: 20).isActive = true
                btnGauge.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -20).isActive = true
                btnGauge.heightAnchor.constraint(equalToConstant: 55).isActive = true
                btnGauge.addTarget(self, action: #selector(self.goToHome), for: .touchUpInside)
                
            }
            let responseData = decryptedResponseBody["RESPONSEDATA"] as! NSDictionary?
            
            if let resData = responseData {
                print(resData)
                let freeUnitJSON = resData["freeUnitJson"] as? NSArray
                var counter = 0
                if let array = freeUnitJSON {
                    for obj in array {
                        if let dict = obj as? NSDictionary{
                            let bundleName = dict.value(forKey: "BundleName") as! String?
                            let expiresOn = dict.value(forKey: "FormatedExpirationDate") as! String?
                            let percentageU = dict.value(forKey: "Percentage") as! String?
                            let InitialAmount = dict.value(forKey: "InitialAmount") as! String?
                            let CurrentAmount = dict.value(forKey: "CurrentAmount") as! String?
                            let ExpirationDuration = dict.value(forKey: "ExpirationDuration") as! String?
                            let CurrentUnit = dict.value(forKey: "CurrentUnit") as! String?
                            let InitialUnit = dict.value(forKey: "InitialUnit") as! String?
                            
                            
                            let cardView2 = UIView()
                            self.scrollView.addSubview(cardView2)
                            cardView2.translatesAutoresizingMaskIntoConstraints = false
                            cardView2.backgroundColor = UIColor.white
                            cardView2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
                            cardView2.topAnchor.constraint(equalTo: cardView1.bottomAnchor, constant: 30).isActive = true
                            cardView2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
                            cardView2.heightAnchor.constraint(equalToConstant: 300).isActive = true
                            cardView2.layer.cornerRadius = 2
                            cardView2.layer.shadowOffset = CGSize(width: 0, height: 5)
                            cardView2.layer.shadowColor = UIColor.black.cgColor
                            cardView2.layer.shadowOpacity = 0.2
                            counter = counter + 1
                            //label for plan
                            let lblPlanUnit = UILabel()
                            cardView2.addSubview(lblPlanUnit)
                            lblPlanUnit.translatesAutoresizingMaskIntoConstraints = false
                            lblPlanUnit.text = bundleName
                            lblPlanUnit.textColor = UIColor.black
                            lblPlanUnit.font = UIFont(name: String.defaultFontR, size: 25)
                            lblPlanUnit.numberOfLines = 0
                            lblPlanUnit.lineBreakMode = .byWordWrapping
                            lblPlanUnit.leadingAnchor.constraint(equalTo: cardView2.leadingAnchor, constant: 20).isActive = true
                            lblPlanUnit.topAnchor.constraint(equalTo: cardView2.topAnchor, constant: 10).isActive = true
                            lblPlanUnit.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -10).isActive = true
                            
                            //label for expiry Date
                            let lblExpiryDateUnit = UILabel()
                            cardView2.addSubview(lblExpiryDateUnit)
                            lblExpiryDateUnit.translatesAutoresizingMaskIntoConstraints = false
                            lblExpiryDateUnit.text = "Expires on: \(expiresOn ?? "")"
                            lblExpiryDateUnit.textColor = UIColor.black
                            lblExpiryDateUnit.font = UIFont(name: String.defaultFontR, size: 15)
                            lblExpiryDateUnit.numberOfLines = 0
                            lblExpiryDateUnit.lineBreakMode = .byWordWrapping
                            lblExpiryDateUnit.leadingAnchor.constraint(equalTo: cardView2.leadingAnchor, constant: 20).isActive = true
                            lblExpiryDateUnit.topAnchor.constraint(equalTo: lblPlanUnit.bottomAnchor, constant: 5).isActive = true
                            lblExpiryDateUnit.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -10).isActive = true
                            
                            //label for Percentage Used
                            let lblPercUsedFree = UILabel()
                            cardView2.addSubview(lblPercUsedFree)
                            lblPercUsedFree.translatesAutoresizingMaskIntoConstraints = false
                            lblPercUsedFree.text = "Percentage Used"
                            lblPercUsedFree.textColor = UIColor.black
                            lblPercUsedFree.font = UIFont(name: String.defaultFontR, size: 17)
                            lblPercUsedFree.numberOfLines = 0
                            lblPercUsedFree.lineBreakMode = .byWordWrapping
                            lblPercUsedFree.leadingAnchor.constraint(equalTo: cardView2.leadingAnchor, constant: 20).isActive = true
                            lblPercUsedFree.topAnchor.constraint(equalTo: lblExpiryDateUnit.bottomAnchor, constant: 40).isActive = true
                            lblPercUsedFree.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -10).isActive = true
                            let lblPercUsedValueFree = UILabel()
                            cardView2.addSubview(lblPercUsedValueFree)
                            lblPercUsedValueFree.translatesAutoresizingMaskIntoConstraints = false
                            lblPercUsedValueFree.textColor = UIColor.black
                            lblPercUsedValueFree.font = UIFont(name: String.defaultFontR, size: 17)
                            lblPercUsedValueFree.numberOfLines = 0
                            lblPercUsedValueFree.lineBreakMode = .byWordWrapping
                            lblPercUsedValueFree.topAnchor.constraint(equalTo: lblExpiryDateUnit.bottomAnchor, constant: 40).isActive = true
                            lblPercUsedValueFree.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -10).isActive = true
                            if let percConv = percentageU{
                                var PERCENTAGECov = Double(percConv)
                                PERCENTAGECov = 100 - PERCENTAGECov!
                                lblPercUsedValueFree.text = "\(PERCENTAGECov ?? 00.00)%"
                            }
                            //label for Percentage Used
                            let lblInitialAmt = UILabel()
                            cardView2.addSubview(lblInitialAmt)
                            lblInitialAmt.translatesAutoresizingMaskIntoConstraints = false
                            lblInitialAmt.text = "Initial Amount"
                            lblInitialAmt.textColor = UIColor.black
                            lblInitialAmt.font = UIFont(name: String.defaultFontR, size: 17)
                            lblInitialAmt.numberOfLines = 0
                            lblInitialAmt.lineBreakMode = .byWordWrapping
                            lblInitialAmt.leadingAnchor.constraint(equalTo: cardView2.leadingAnchor, constant: 20).isActive = true
                            lblInitialAmt.topAnchor.constraint(equalTo: lblPercUsedFree.bottomAnchor, constant: 40).isActive = true
                            lblInitialAmt.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -10).isActive = true
                            
                            let lblInitialAmtValue = UILabel()
                            cardView2.addSubview(lblInitialAmtValue)
                            lblInitialAmtValue.translatesAutoresizingMaskIntoConstraints = false
                            lblInitialAmtValue.text = "\(InitialAmount ?? "")\(InitialUnit ?? "")"
                            lblInitialAmtValue.textColor = UIColor.black
                            lblInitialAmtValue.font = UIFont(name: String.defaultFontR, size: 17)
                            lblInitialAmtValue.numberOfLines = 0
                            lblInitialAmtValue.lineBreakMode = .byWordWrapping
                            
                            lblInitialAmtValue.topAnchor.constraint(equalTo: lblPercUsedValueFree.bottomAnchor, constant: 40).isActive = true
                            lblInitialAmtValue.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -10).isActive = true
                            
                            //label for Current
                            let lblCurrentAmt = UILabel()
                            cardView2.addSubview(lblCurrentAmt)
                            lblCurrentAmt.translatesAutoresizingMaskIntoConstraints = false
                            lblCurrentAmt.text = "Current Amount"
                            lblCurrentAmt.textColor = UIColor.black
                            lblCurrentAmt.font = UIFont(name: String.defaultFontR, size: 17)
                            lblCurrentAmt.numberOfLines = 0
                            lblCurrentAmt.lineBreakMode = .byWordWrapping
                            lblCurrentAmt.leadingAnchor.constraint(equalTo: cardView2.leadingAnchor, constant: 20).isActive = true
                            lblCurrentAmt.topAnchor.constraint(equalTo: lblInitialAmt.bottomAnchor, constant: 40).isActive = true
                            lblCurrentAmt.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -10).isActive = true
                            
                            let lblCurrentAmtValue = UILabel()
                            cardView2.addSubview(lblCurrentAmtValue)
                            lblCurrentAmtValue.translatesAutoresizingMaskIntoConstraints = false
                            lblCurrentAmtValue.text = "\(CurrentAmount ?? "")\(CurrentUnit ?? "")"
                            lblCurrentAmtValue.textColor = UIColor.black
                            lblCurrentAmtValue.font = UIFont(name: String.defaultFontR, size: 17)
                            lblCurrentAmtValue.numberOfLines = 0
                            lblCurrentAmtValue.lineBreakMode = .byWordWrapping
                            lblCurrentAmtValue.topAnchor.constraint(equalTo: lblInitialAmt.bottomAnchor, constant: 40).isActive = true
                            lblCurrentAmtValue.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -10).isActive = true
                            
                            //label for Expiration
                            let lblExpiration = UILabel()
                            cardView2.addSubview(lblExpiration)
                            lblExpiration.translatesAutoresizingMaskIntoConstraints = false
                            lblExpiration.text = "Expiration"
                            lblExpiration.textColor = UIColor.black
                            lblExpiration.font = UIFont(name: String.defaultFontR, size: 17)
                            lblExpiration.numberOfLines = 0
                            lblExpiration.lineBreakMode = .byWordWrapping
                            lblExpiration.leadingAnchor.constraint(equalTo: cardView2.leadingAnchor, constant: 20).isActive = true
                            lblExpiration.topAnchor.constraint(equalTo: lblCurrentAmt.bottomAnchor, constant: 40).isActive = true
                            lblExpiration.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -10).isActive = true
                            
                            let lblExpirationValue = UILabel()
                            cardView2.addSubview(lblExpirationValue)
                            lblExpirationValue.translatesAutoresizingMaskIntoConstraints = false
                            lblExpirationValue.text = ExpirationDuration
                            lblExpirationValue.textColor = UIColor.black
                            lblExpirationValue.font = UIFont(name: String.defaultFontR, size: 17)
                            lblExpirationValue.numberOfLines = 0
                            lblExpirationValue.lineBreakMode = .byWordWrapping
                            lblExpirationValue.topAnchor.constraint(equalTo: lblCurrentAmt.bottomAnchor, constant: 40).isActive = true
                            lblExpirationValue.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -10).isActive = true
                            
                            if counter == array.count {
                                let btnBrowse = UIButton()
                                scrollView.addSubview(btnBrowse)
                                btnBrowse.translatesAutoresizingMaskIntoConstraints = false
                                btnBrowse.backgroundColor = UIColor.grayButton
                                btnBrowse.setTitle("Browse All", for: .normal)
                                btnBrowse.setTitleColor(UIColor.white, for: .normal)
                                btnBrowse.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
                                btnBrowse.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
                                btnBrowse.topAnchor.constraint(equalTo: cardView2.bottomAnchor, constant: 40).isActive = true
                                btnBrowse.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
                                btnBrowse.heightAnchor.constraint(equalToConstant: 55).isActive = true
                                btnBrowse.addTarget(self, action: #selector(self.goToOffers), for: .touchUpInside)
                            }
                        }
                    }
                }
            }
            self.scrollView.contentSize.height = (self.topImage.frame.size.height + 820) + 500
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground
        checkConnection()
        
        
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        username = UserData["Username"] as? String
        let services = preference.object(forKey: UserDefaultsKeys.ServiceList.rawValue)
        dService = preference.object(forKey: UserDefaultsKeys.DefaultService.rawValue) as? String
//        print(dService)
        if let serviceArray = services as? NSArray{
            var foundDefault = false
            for obj in serviceArray{
                print(foundDefault)
                print(obj)
                if foundDefault == false{
                    if let dict = obj as? NSDictionary {
                        displayName = dict.value(forKey: "DisplayName") as? String
                        let id = dict.value(forKey: "ID") as! String?
//                        print("ID: \(id)")
                        if id == dService{
                            displayName = dict.value(forKey: "DisplayName") as? String
                            userID = dict.value(forKey: "primaryID") as? String
                            accountNumber = dict.value(forKey: "SecondaryID") as? String
                            primaryID = dict.value(forKey: "primaryID") as? String
                            foundDefault = true
                        }
                    }
                }
                
            }
        }
        
        setUpViewsBreakdown()
        bbUsageDetails = preference.object(forKey: UserDefaultsKeys.BB_accountUsageDet.rawValue) as? String
        if let bbUsageDetails = bbUsageDetails{
            //Retrieve cached
            print("Cached \(bbUsageDetails)")
            retrieveCached(bbUsageDetails)
            start_activity_loader()
            updateRecords()
        }else{
            // async call
            start_activity_loader()
            updateRecords()
        }
    }
    
    func setUpViewsBreakdown(){
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
        topImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
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
        backButton.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
        
        //Selected Offer
        let lblSelectedOffer = UILabel()
        scrollView.addSubview(lblSelectedOffer)
        lblSelectedOffer.translatesAutoresizingMaskIntoConstraints = false
        lblSelectedOffer.textColor = UIColor.white
        lblSelectedOffer.textAlignment = .center
        lblSelectedOffer.font = UIFont(name: String.defaultFontR, size: 31)
        lblSelectedOffer.text = "Your products and services"
        lblSelectedOffer.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        lblSelectedOffer.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 50).isActive = true
        lblSelectedOffer.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        lblSelectedOffer.numberOfLines = 0
        lblSelectedOffer.lineBreakMode = .byWordWrapping
        
        topImage.addSubview(darkView)
        darkView.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        darkView.topAnchor.constraint(equalTo: lblSelectedOffer.bottomAnchor, constant: 10).isActive = true
        darkView.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        darkView.bottomAnchor.constraint(equalTo: topImage.bottomAnchor, constant: -24).isActive = true
        
        let speedCheckerImage = UIImageView(image: #imageLiteral(resourceName: "default_profile"))
        darkView.addSubview(speedCheckerImage)
        speedCheckerImage.translatesAutoresizingMaskIntoConstraints = false
        speedCheckerImage.centerXAnchor.constraint(equalTo: darkView.centerXAnchor).isActive = true
        speedCheckerImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        speedCheckerImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        speedCheckerImage.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 10).isActive = true
        speedCheckerImage.layer.cornerRadius = 50
        speedCheckerImage.layer.borderColor = UIColor.white.cgColor
        speedCheckerImage.layer.borderWidth = 1
        
        let lblCheck = UILabel()
        darkView.addSubview(lblCheck)
        lblCheck.translatesAutoresizingMaskIntoConstraints = false
        lblCheck.font = UIFont(name: String.defaultFontR, size: 25)
        if let displayName = displayName{
            lblCheck.text = displayName
        }
        
        lblCheck.textColor = UIColor.white
        lblCheck.textAlignment = .center
        lblCheck.numberOfLines = 0
        lblCheck.lineBreakMode = .byWordWrapping
        lblCheck.topAnchor.constraint(equalTo: speedCheckerImage.bottomAnchor, constant: 5).isActive = true
        lblCheck.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 30).isActive = true
        lblCheck.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -30).isActive = true
        
        let lblPrimaryID = UILabel()
        darkView.addSubview(lblPrimaryID)
        lblPrimaryID.translatesAutoresizingMaskIntoConstraints = false
        lblPrimaryID.font = UIFont(name: String.defaultFontR, size: 18)
        if let primaryID = primaryID{
            lblPrimaryID.text = primaryID
        }
        
        lblPrimaryID.textColor = UIColor.white
        lblPrimaryID.textAlignment = .center
        lblPrimaryID.numberOfLines = 0
        lblPrimaryID.lineBreakMode = .byWordWrapping
        lblPrimaryID.topAnchor.constraint(equalTo: lblCheck.bottomAnchor, constant: 5).isActive = true
        lblPrimaryID.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 30).isActive = true
        lblPrimaryID.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -30).isActive = true
        
        scrollView.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func updateRecords(){
        let async_call = URL(string: String.userURL)
        let request = NSMutableURLRequest(url: async_call!)
        request.httpMethod = "POST"
        
        let postParameters = ["action":"fbbBalance", "username":username!, "userid": userID!, "accountnumber": accountNumber!]
        if let jsonParameters = try? JSONSerialization.data(withJSONObject: postParameters, options: .prettyPrinted){
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
                        DispatchQueue.main.async {
                            self.stop_activity_loader()
                        }
                        print("error is \(error!.localizedDescription)")
                        return;
                    }
                    
                    do {
                        let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        //                        print("myJSON \(myJSON)")
                        if let parseJSON = myJSON {
                            var sessionAuth: String!
                            sessionAuth = parseJSON["SessionAuth"] as! String?
                            if sessionAuth == "true" {
                                self.logout()
                            }
                            var responseBody: String?
                            var responseCode: Int!
                            var responseMessage: NSDictionary!
                            responseBody = parseJSON["responseBody"] as! String?
                            
                            if responseBody != nil {
                                let resBody = responseBody
                                self.preference.set(resBody, forKey: UserDefaultsKeys.BB_accountUsageDet.rawValue)
                                let decrypt = self.decryptAsyncRequest(requestBody: resBody!)
                                print("Decrypted:: \(decrypt)")
                                let decryptedResponseBody = self.convertToNSDictionary(decrypt: decrypt)
                                print(decryptedResponseBody)
                                responseCode = decryptedResponseBody["RESPONSECODE"] as! Int?
                                DispatchQueue.main.async {
                                    if responseCode == 0 {
                                        self.stop_activity_loader()
                                        responseMessage = decryptedResponseBody["RESPONSEMESSAGE"] as! NSDictionary?
                                        let P_CURRENTVOL = responseMessage["P_CURRENTVOL"] as! String?
                                        let P_CURRENTBAL = responseMessage["P_CURRENTBAL"] as! String?
                                        let TOTALINITIAL = responseMessage["TOTALINITIAL"] as! String?
                                        let P_ADVANCEPAYMENT = responseMessage["P_ADVANCEPAYMENT"] as! String?
                                        let P_PLANNAME = responseMessage["P_PLANNAME"] as! String?
                                        let PERCENTAGE = responseMessage["PERCENTAGE"] as! String?
                                        let totalInitialUnit = responseMessage["TOTALINITIALUNIT"] as! String?
                                        let expireyDate = responseMessage["P_EXPIRYDATE"] as! String?
                                        let unit = responseMessage["UNIT"] as! String?
                                        let accountNumber = responseMessage["P_ACCOUNTNO"] as! String?
                                        let phoneNo = responseMessage["P_PHONENO"] as! String?
                                        let status = responseMessage["P_STATUS"] as! String?
                                        let serviceNo = responseMessage["P_SERVICENO"] as! String?
                                        
                                        let cardView1 = UIView()
                                        self.scrollView.addSubview(cardView1)
                                        cardView1.translatesAutoresizingMaskIntoConstraints = false
                                        cardView1.backgroundColor = UIColor.white
                                        cardView1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
                                        cardView1.topAnchor.constraint(equalTo: self.topImage.bottomAnchor, constant: 20).isActive = true
                                        cardView1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
                                        cardView1.heightAnchor.constraint(equalToConstant: 800).isActive = true
                                        cardView1.layer.cornerRadius = 2
                                        cardView1.layer.shadowOffset = CGSize(width: 0, height: 5)
                                        cardView1.layer.shadowColor = UIColor.black.cgColor
                                        cardView1.layer.shadowOpacity = 0.2
                                        if let percConv = PERCENTAGE{
                                            var PERCENTAGECov = Double(percConv)
                                            PERCENTAGECov = 100 - PERCENTAGECov!
                                            print("progress \(PERCENTAGECov ?? 0.00)")
                                            
                                            //label for plan
                                            let lblPlan = UILabel()
                                            cardView1.addSubview(lblPlan)
                                            lblPlan.translatesAutoresizingMaskIntoConstraints = false
                                            lblPlan.text = P_PLANNAME
                                            lblPlan.textColor = UIColor.black
                                            lblPlan.font = UIFont(name: String.defaultFontR, size: 25)
                                            lblPlan.numberOfLines = 0
                                            lblPlan.lineBreakMode = .byWordWrapping
                                            lblPlan.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                                            lblPlan.topAnchor.constraint(equalTo: cardView1.topAnchor, constant: 10).isActive = true
                                            lblPlan.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                                            
                                            //label for expiry Date
                                            let lblExpiryDate = UILabel()
                                            cardView1.addSubview(lblExpiryDate)
                                            lblExpiryDate.translatesAutoresizingMaskIntoConstraints = false
                                            lblExpiryDate.text = "Expires on: \(expireyDate ?? "")"
                                            lblExpiryDate.textColor = UIColor.black
                                            lblExpiryDate.font = UIFont(name: String.defaultFontR, size: 15)
                                            lblExpiryDate.numberOfLines = 0
                                            lblExpiryDate.lineBreakMode = .byWordWrapping
                                            lblExpiryDate.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                                            lblExpiryDate.topAnchor.constraint(equalTo: lblPlan.bottomAnchor, constant: 5).isActive = true
                                            lblExpiryDate.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                                            let sep1 = UIView()
                                            cardView1.addSubview(sep1)
                                            sep1.translatesAutoresizingMaskIntoConstraints = false
                                            sep1.backgroundColor = UIColor.gray.withAlphaComponent(0.40)
                                            sep1.heightAnchor.constraint(equalToConstant: 0.2).isActive = true
                                            sep1.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                                            sep1.topAnchor.constraint(equalTo: lblExpiryDate.bottomAnchor, constant: 30).isActive = true
                                            sep1.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -20).isActive = true
                                            
                                            //label for Percentage Used
                                            let lblPercUsed = UILabel()
                                            cardView1.addSubview(lblPercUsed)
                                            lblPercUsed.translatesAutoresizingMaskIntoConstraints = false
                                            lblPercUsed.text = "Percentage Used"
                                            lblPercUsed.textColor = UIColor.black
                                            lblPercUsed.font = UIFont(name: String.defaultFontR, size: 17)
                                            lblPercUsed.numberOfLines = 0
                                            lblPercUsed.lineBreakMode = .byWordWrapping
                                            lblPercUsed.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                                            lblPercUsed.topAnchor.constraint(equalTo: sep1.bottomAnchor, constant: 40).isActive = true
                                            lblPercUsed.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                                            
                                            let lblPercUsedValue = UILabel()
                                            cardView1.addSubview(lblPercUsedValue)
                                            lblPercUsedValue.translatesAutoresizingMaskIntoConstraints = false
                                            lblPercUsedValue.text = "\(PERCENTAGECov ?? 00.00)%"
                                            lblPercUsedValue.textColor = UIColor.black
                                            lblPercUsedValue.font = UIFont(name: String.defaultFontR, size: 17)
                                            lblPercUsedValue.numberOfLines = 0
                                            lblPercUsedValue.lineBreakMode = .byWordWrapping
                                            lblPercUsedValue.topAnchor.constraint(equalTo: sep1.bottomAnchor, constant: 40).isActive = true
                                            lblPercUsedValue.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                                            
                                            
                                            
                                            let sep2 = UIView()
                                            cardView1.addSubview(sep2)
                                            sep2.translatesAutoresizingMaskIntoConstraints = false
                                            sep2.backgroundColor = UIColor.gray.withAlphaComponent(0.40)
                                            sep2.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
                                            sep2.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                                            sep2.topAnchor.constraint(equalTo: lblPercUsed.bottomAnchor, constant: 30).isActive = true
                                            sep2.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -20).isActive = true
                                            
                                            //label for Account Number
                                            let lblAccNum = UILabel()
                                            cardView1.addSubview(lblAccNum)
                                            lblAccNum.translatesAutoresizingMaskIntoConstraints = false
                                            lblAccNum.text = "Account Number"
                                            lblAccNum.textColor = UIColor.black
                                            lblAccNum.font = UIFont(name: String.defaultFontR, size: 17)
                                            lblAccNum.numberOfLines = 0
                                            lblAccNum.lineBreakMode = .byWordWrapping
                                            lblAccNum.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                                            lblAccNum.topAnchor.constraint(equalTo: sep2.bottomAnchor, constant: 15).isActive = true
                                            lblAccNum.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                                            
                                            let lblAccNumValue = UILabel()
                                            cardView1.addSubview(lblAccNumValue)
                                            lblAccNumValue.translatesAutoresizingMaskIntoConstraints = false
                                            lblAccNumValue.text = accountNumber
                                            lblAccNumValue.textColor = UIColor.black
                                            lblAccNumValue.font = UIFont(name: String.defaultFontR, size: 17)
                                            lblAccNumValue.numberOfLines = 0
                                            lblAccNumValue.lineBreakMode = .byWordWrapping
                                            lblAccNumValue.topAnchor.constraint(equalTo: sep2.bottomAnchor, constant: 15).isActive = true
                                            lblAccNumValue.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                                            
                                            let sep3 = UIView()
                                            cardView1.addSubview(sep3)
                                            sep3.translatesAutoresizingMaskIntoConstraints = false
                                            sep3.backgroundColor = UIColor.gray.withAlphaComponent(0.40)
                                            sep3.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
                                            sep3.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                                            sep3.topAnchor.constraint(equalTo: lblAccNum.bottomAnchor, constant: 30).isActive = true
                                            sep3.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -20).isActive = true
                                            //label for Phone Number
                                            let lblPhoneNum = UILabel()
                                            cardView1.addSubview(lblPhoneNum)
                                            lblPhoneNum.translatesAutoresizingMaskIntoConstraints = false
                                            lblPhoneNum.text = "Phone Number"
                                            lblPhoneNum.textColor = UIColor.black
                                            lblPhoneNum.font = UIFont(name: String.defaultFontR, size: 17)
                                            lblPhoneNum.numberOfLines = 0
                                            lblPhoneNum.lineBreakMode = .byWordWrapping
                                            lblPhoneNum.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                                            lblPhoneNum.topAnchor.constraint(equalTo: sep3.bottomAnchor, constant: 15).isActive = true
                                            lblPhoneNum.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                                            
                                            let lblPhoneValue = UILabel()
                                            cardView1.addSubview(lblPhoneValue)
                                            lblPhoneValue.translatesAutoresizingMaskIntoConstraints = false
                                            lblPhoneValue.text = phoneNo
                                            lblPhoneValue.textColor = UIColor.black
                                            lblPhoneValue.font = UIFont(name: String.defaultFontR, size: 17)
                                            lblPhoneValue.numberOfLines = 0
                                            lblPhoneValue.lineBreakMode = .byWordWrapping
                                            lblPhoneValue.topAnchor.constraint(equalTo: sep3.bottomAnchor, constant: 15).isActive = true
                                            lblPhoneValue.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                                            
                                            let sep4 = UIView()
                                            cardView1.addSubview(sep4)
                                            sep4.translatesAutoresizingMaskIntoConstraints = false
                                            sep4.backgroundColor = UIColor.gray.withAlphaComponent(0.40)
                                            sep4.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
                                            sep4.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                                            sep4.topAnchor.constraint(equalTo: lblPhoneNum.bottomAnchor, constant: 30).isActive = true
                                            sep4.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -20).isActive = true
                                            
                                            //label for Service Name
                                            let lblService = UILabel()
                                            cardView1.addSubview(lblService)
                                            lblService.translatesAutoresizingMaskIntoConstraints = false
                                            lblService.text = "Service Name"
                                            lblService.textColor = UIColor.black
                                            lblService.font = UIFont(name: String.defaultFontR, size: 17)
                                            lblService.numberOfLines = 0
                                            lblService.lineBreakMode = .byWordWrapping
                                            lblService.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                                            lblService.topAnchor.constraint(equalTo: sep4.bottomAnchor, constant: 15).isActive = true
                                            lblService.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                                            
                                            let lblServiceValue = UILabel()
                                            cardView1.addSubview(lblServiceValue)
                                            lblServiceValue.translatesAutoresizingMaskIntoConstraints = false
                                            lblServiceValue.text = serviceNo
                                            lblServiceValue.textColor = UIColor.black
                                            lblServiceValue.font = UIFont(name: String.defaultFontR, size: 17)
                                            lblServiceValue.numberOfLines = 0
                                            lblServiceValue.lineBreakMode = .byWordWrapping
                                            lblServiceValue.topAnchor.constraint(equalTo: sep4.bottomAnchor, constant: 15).isActive = true
                                            lblServiceValue.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                                            
                                            let sep5 = UIView()
                                            cardView1.addSubview(sep5)
                                            sep5.translatesAutoresizingMaskIntoConstraints = false
                                            sep5.backgroundColor = UIColor.gray.withAlphaComponent(0.40)
                                            sep5.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
                                            sep5.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                                            sep5.topAnchor.constraint(equalTo: lblService.bottomAnchor, constant: 30).isActive = true
                                            sep5.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -20).isActive = true
                                            
                                            //label for Status
                                            let lblStatus = UILabel()
                                            cardView1.addSubview(lblStatus)
                                            lblStatus.translatesAutoresizingMaskIntoConstraints = false
                                            lblStatus.text = "Status"
                                            lblStatus.textColor = UIColor.black
                                            lblStatus.font = UIFont(name: String.defaultFontR, size: 17)
                                            lblStatus.numberOfLines = 0
                                            lblStatus.lineBreakMode = .byWordWrapping
                                            lblStatus.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                                            lblStatus.topAnchor.constraint(equalTo: sep5.bottomAnchor, constant: 15).isActive = true
                                            lblStatus.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                                            
                                            let lblStatusValue = UILabel()
                                            cardView1.addSubview(lblStatusValue)
                                            lblStatusValue.translatesAutoresizingMaskIntoConstraints = false
                                            lblStatusValue.text = status
                                            lblStatusValue.textColor = UIColor.black
                                            lblStatusValue.font = UIFont(name: String.defaultFontR, size: 17)
                                            lblStatusValue.numberOfLines = 0
                                            lblStatusValue.lineBreakMode = .byWordWrapping
                                            lblStatusValue.topAnchor.constraint(equalTo: sep5.bottomAnchor, constant: 15).isActive = true
                                            lblStatusValue.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                                            
                                            let sep6 = UIView()
                                            cardView1.addSubview(sep6)
                                            sep6.translatesAutoresizingMaskIntoConstraints = false
                                            sep6.backgroundColor = UIColor.gray.withAlphaComponent(0.40)
                                            sep6.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
                                            sep6.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                                            sep6.topAnchor.constraint(equalTo: lblStatus.bottomAnchor, constant: 30).isActive = true
                                            sep6.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -20).isActive = true
                                            
                                            //label for Plan
                                            let lblPlanSub = UILabel()
                                            cardView1.addSubview(lblPlanSub)
                                            lblPlanSub.translatesAutoresizingMaskIntoConstraints = false
                                            lblPlanSub.text = "Plan"
                                            lblPlanSub.textColor = UIColor.black
                                            lblPlanSub.font = UIFont(name: String.defaultFontR, size: 17)
                                            lblPlanSub.numberOfLines = 0
                                            lblPlanSub.lineBreakMode = .byWordWrapping
                                            lblPlanSub.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                                            lblPlanSub.topAnchor.constraint(equalTo: sep6.bottomAnchor, constant: 15).isActive = true
                                            lblPlanSub.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                                            
                                            let lblPlanValue = UILabel()
                                            cardView1.addSubview(lblPlanValue)
                                            lblPlanValue.translatesAutoresizingMaskIntoConstraints = false
                                            lblPlanValue.text = P_PLANNAME
                                            lblPlanValue.textColor = UIColor.black
                                            lblPlanValue.font = UIFont(name: String.defaultFontR, size: 17)
                                            lblPlanValue.numberOfLines = 0
                                            lblPlanValue.lineBreakMode = .byWordWrapping
                                            lblPlanValue.topAnchor.constraint(equalTo: sep6.bottomAnchor, constant: 15).isActive = true
                                            lblPlanValue.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                                            
                                            let sep7 = UIView()
                                            cardView1.addSubview(sep7)
                                            sep7.translatesAutoresizingMaskIntoConstraints = false
                                            sep7.backgroundColor = UIColor.gray.withAlphaComponent(0.40)
                                            sep7.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
                                            sep7.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                                            sep7.topAnchor.constraint(equalTo: lblPlanSub.bottomAnchor, constant: 30).isActive = true
                                            sep7.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -20).isActive = true
                                            
                                            //label for Initial Data
                                            let lblInitialData = UILabel()
                                            cardView1.addSubview(lblInitialData)
                                            lblInitialData.translatesAutoresizingMaskIntoConstraints = false
                                            lblInitialData.text = "Initial Data"
                                            lblInitialData.textColor = UIColor.black
                                            lblInitialData.font = UIFont(name: String.defaultFontR, size: 17)
                                            lblInitialData.numberOfLines = 0
                                            lblInitialData.lineBreakMode = .byWordWrapping
                                            lblInitialData.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                                            lblInitialData.topAnchor.constraint(equalTo: sep7.bottomAnchor, constant: 15).isActive = true
                                            lblInitialData.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                                            
                                            let lblInitialDataValue = UILabel()
                                            cardView1.addSubview(lblInitialDataValue)
                                            lblInitialDataValue.translatesAutoresizingMaskIntoConstraints = false
                                            lblInitialDataValue.text = "\(TOTALINITIAL ?? "")\(totalInitialUnit ?? "")"
                                            lblInitialDataValue.textColor = UIColor.black
                                            lblInitialDataValue.font = UIFont(name: String.defaultFontR, size: 17)
                                            lblInitialDataValue.numberOfLines = 0
                                            lblInitialDataValue.lineBreakMode = .byWordWrapping
                                            lblInitialDataValue.topAnchor.constraint(equalTo: sep7.bottomAnchor, constant: 15).isActive = true
                                            lblInitialDataValue.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                                            
                                            let sep8 = UIView()
                                            cardView1.addSubview(sep8)
                                            sep8.translatesAutoresizingMaskIntoConstraints = false
                                            sep8.backgroundColor = UIColor.gray.withAlphaComponent(0.40)
                                            sep8.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
                                            sep8.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                                            sep8.topAnchor.constraint(equalTo: lblInitialData.bottomAnchor, constant: 30).isActive = true
                                            sep8.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -20).isActive = true
                                            
                                            //label for Unused Data
                                            let lblUnusedData = UILabel()
                                            cardView1.addSubview(lblUnusedData)
                                            lblUnusedData.translatesAutoresizingMaskIntoConstraints = false
                                            lblUnusedData.text = "Unused Data"
                                            lblUnusedData.textColor = UIColor.black
                                            lblUnusedData.font = UIFont(name: String.defaultFontR, size: 17)
                                            lblUnusedData.numberOfLines = 0
                                            lblUnusedData.lineBreakMode = .byWordWrapping
                                            lblUnusedData.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                                            lblUnusedData.topAnchor.constraint(equalTo: sep8.bottomAnchor, constant: 15).isActive = true
                                            lblUnusedData.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                                            
                                            let lblUnusedDataValue = UILabel()
                                            cardView1.addSubview(lblUnusedDataValue)
                                            lblUnusedDataValue.translatesAutoresizingMaskIntoConstraints = false
                                            lblUnusedDataValue.text = "\(P_CURRENTVOL ?? "")\(unit ?? "")"
                                            lblUnusedDataValue.textColor = UIColor.black
                                            lblUnusedDataValue.font = UIFont(name: String.defaultFontR, size: 17)
                                            lblUnusedDataValue.numberOfLines = 0
                                            lblUnusedDataValue.lineBreakMode = .byWordWrapping
                                            lblUnusedDataValue.topAnchor.constraint(equalTo: sep8.bottomAnchor, constant: 15).isActive = true
                                            lblUnusedDataValue.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                                            
                                            let sep9 = UIView()
                                            cardView1.addSubview(sep9)
                                            sep9.translatesAutoresizingMaskIntoConstraints = false
                                            sep9.backgroundColor = UIColor.gray.withAlphaComponent(0.40)
                                            sep9.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
                                            sep9.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                                            sep9.topAnchor.constraint(equalTo: lblUnusedData.bottomAnchor, constant: 30).isActive = true
                                            sep9.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -20).isActive = true
                                            
                                            //label for Current Balance
                                            let lblCurrentBalance = UILabel()
                                            cardView1.addSubview(lblCurrentBalance)
                                            lblCurrentBalance.translatesAutoresizingMaskIntoConstraints = false
                                            lblCurrentBalance.text = "Current Balance"
                                            lblCurrentBalance.textColor = UIColor.black
                                            lblCurrentBalance.font = UIFont(name: String.defaultFontR, size: 17)
                                            lblCurrentBalance.numberOfLines = 0
                                            lblCurrentBalance.lineBreakMode = .byWordWrapping
                                            lblCurrentBalance.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                                            lblCurrentBalance.topAnchor.constraint(equalTo: sep9.bottomAnchor, constant: 15).isActive = true
                                            lblCurrentBalance.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                                            
                                            let lblCurrBalValue = UILabel()
                                            cardView1.addSubview(lblCurrBalValue)
                                            lblCurrBalValue.translatesAutoresizingMaskIntoConstraints = false
                                            lblCurrBalValue.text = "GHS \(P_CURRENTBAL ?? "")"
                                            lblCurrBalValue.textColor = UIColor.black
                                            lblCurrBalValue.font = UIFont(name: String.defaultFontR, size: 17)
                                            lblCurrBalValue.numberOfLines = 0
                                            lblCurrBalValue.lineBreakMode = .byWordWrapping
                                            lblCurrBalValue.topAnchor.constraint(equalTo: sep9.bottomAnchor, constant: 15).isActive = true
                                            lblCurrBalValue.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                                            
                                            let sep10 = UIView()
                                            cardView1.addSubview(sep10)
                                            sep10.translatesAutoresizingMaskIntoConstraints = false
                                            sep10.backgroundColor = UIColor.gray.withAlphaComponent(0.40)
                                            sep10.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
                                            sep10.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                                            sep10.topAnchor.constraint(equalTo: lblCurrentBalance.bottomAnchor, constant: 30).isActive = true
                                            sep10.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -20).isActive = true
                                            
                                            //label for Cash In Account
                                            let lblCashAcc = UILabel()
                                            cardView1.addSubview(lblCashAcc)
                                            lblCashAcc.translatesAutoresizingMaskIntoConstraints = false
                                            lblCashAcc.text = "Cash in Account"
                                            lblCashAcc.textColor = UIColor.black
                                            lblCashAcc.font = UIFont(name: String.defaultFontR, size: 17)
                                            lblCashAcc.numberOfLines = 0
                                            lblCashAcc.lineBreakMode = .byWordWrapping
                                            lblCashAcc.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                                            lblCashAcc.topAnchor.constraint(equalTo: sep10.bottomAnchor, constant: 15).isActive = true
                                            lblCashAcc.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                                            
                                            let lblCashAccValue = UILabel()
                                            cardView1.addSubview(lblCashAccValue)
                                            lblCashAccValue.translatesAutoresizingMaskIntoConstraints = false
                                            lblCashAccValue.text = "GHS \(P_ADVANCEPAYMENT ?? "")"
                                            lblCashAccValue.textColor = UIColor.black
                                            lblCashAccValue.font = UIFont(name: String.defaultFontR, size: 17)
                                            lblCashAccValue.numberOfLines = 0
                                            lblCashAccValue.lineBreakMode = .byWordWrapping
                                            lblCashAccValue.topAnchor.constraint(equalTo: sep10.bottomAnchor, constant: 15).isActive = true
                                            lblCashAccValue.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -10).isActive = true
                                            
                                            let sep11 = UIView()
                                            cardView1.addSubview(sep11)
                                            sep11.translatesAutoresizingMaskIntoConstraints = false
                                            sep11.backgroundColor = UIColor.gray.withAlphaComponent(0.40)
                                            sep11.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
                                            sep11.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                                            sep11.topAnchor.constraint(equalTo: lblCashAcc.bottomAnchor, constant: 30).isActive = true
                                            sep11.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -20).isActive = true
                                            
                                            let btnGauge = UIButton()
                                            cardView1.addSubview(btnGauge)
                                            btnGauge.translatesAutoresizingMaskIntoConstraints = false
                                            btnGauge.backgroundColor = UIColor.vodaRed
                                            btnGauge.setTitle("View Gauge", for: .normal)
                                            btnGauge.setTitleColor(UIColor.white, for: .normal)
                                            btnGauge.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
                                            btnGauge.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 20).isActive = true
                                            btnGauge.topAnchor.constraint(equalTo: sep11.bottomAnchor, constant: 20).isActive = true
                                            btnGauge.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -20).isActive = true
                                            btnGauge.heightAnchor.constraint(equalToConstant: 55).isActive = true
                                            btnGauge.addTarget(self, action: #selector(self.goToHome), for: .touchUpInside)
                                            
                                        }
                                        let responseData = decryptedResponseBody["RESPONSEDATA"] as! NSDictionary?
                                        
                                        if let resData = responseData {
                                            print(resData)
                                            let freeUnitJSON = resData["freeUnitJson"] as? NSArray
                                            var counter = 0
                                            if let array = freeUnitJSON {
                                                for obj in array {
                                                    if let dict = obj as? NSDictionary{
                                                        let bundleName = dict.value(forKey: "BundleName") as! String?
                                                        let expiresOn = dict.value(forKey: "FormatedExpirationDate") as! String?
                                                        let percentageU = dict.value(forKey: "Percentage") as! String?
                                                        let InitialAmount = dict.value(forKey: "InitialAmount") as! String?
                                                        let CurrentAmount = dict.value(forKey: "CurrentAmount") as! String?
                                                        let ExpirationDuration = dict.value(forKey: "ExpirationDuration") as! String?
                                                        let CurrentUnit = dict.value(forKey: "CurrentUnit") as! String?
                                                        let InitialUnit = dict.value(forKey: "InitialUnit") as! String?
                                                        
                                                        
                                                        let cardView2 = UIView()
                                                        self.scrollView.addSubview(cardView2)
                                                        cardView2.translatesAutoresizingMaskIntoConstraints = false
                                                        cardView2.backgroundColor = UIColor.white
                                                        cardView2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
                                                        cardView2.topAnchor.constraint(equalTo: cardView1.bottomAnchor, constant: 30).isActive = true
                                                        cardView2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
                                                        cardView2.heightAnchor.constraint(equalToConstant: 300).isActive = true
                                                        cardView2.layer.cornerRadius = 2
                                                        cardView2.layer.shadowOffset = CGSize(width: 0, height: 5)
                                                        cardView2.layer.shadowColor = UIColor.black.cgColor
                                                        cardView2.layer.shadowOpacity = 0.2
                                                        counter = counter + 1
                                                        //label for plan
                                                        let lblPlanUnit = UILabel()
                                                        cardView2.addSubview(lblPlanUnit)
                                                        lblPlanUnit.translatesAutoresizingMaskIntoConstraints = false
                                                        lblPlanUnit.text = bundleName
                                                        lblPlanUnit.textColor = UIColor.black
                                                        lblPlanUnit.font = UIFont(name: String.defaultFontR, size: 25)
                                                        lblPlanUnit.numberOfLines = 0
                                                        lblPlanUnit.lineBreakMode = .byWordWrapping
                                                        lblPlanUnit.leadingAnchor.constraint(equalTo: cardView2.leadingAnchor, constant: 20).isActive = true
                                                        lblPlanUnit.topAnchor.constraint(equalTo: cardView2.topAnchor, constant: 10).isActive = true
                                                        lblPlanUnit.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -10).isActive = true
                                                        
                                                        //label for expiry Date
                                                        let lblExpiryDateUnit = UILabel()
                                                        cardView2.addSubview(lblExpiryDateUnit)
                                                        lblExpiryDateUnit.translatesAutoresizingMaskIntoConstraints = false
                                                        lblExpiryDateUnit.text = "Expires on: \(expiresOn ?? "")"
                                                        lblExpiryDateUnit.textColor = UIColor.black
                                                        lblExpiryDateUnit.font = UIFont(name: String.defaultFontR, size: 15)
                                                        lblExpiryDateUnit.numberOfLines = 0
                                                        lblExpiryDateUnit.lineBreakMode = .byWordWrapping
                                                        lblExpiryDateUnit.leadingAnchor.constraint(equalTo: cardView2.leadingAnchor, constant: 20).isActive = true
                                                        lblExpiryDateUnit.topAnchor.constraint(equalTo: lblPlanUnit.bottomAnchor, constant: 5).isActive = true
                                                        lblExpiryDateUnit.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -10).isActive = true
                                                        
                                                        //label for Percentage Used
                                                        let lblPercUsedFree = UILabel()
                                                        cardView2.addSubview(lblPercUsedFree)
                                                        lblPercUsedFree.translatesAutoresizingMaskIntoConstraints = false
                                                        lblPercUsedFree.text = "Percentage Used"
                                                        lblPercUsedFree.textColor = UIColor.black
                                                        lblPercUsedFree.font = UIFont(name: String.defaultFontR, size: 17)
                                                        lblPercUsedFree.numberOfLines = 0
                                                        lblPercUsedFree.lineBreakMode = .byWordWrapping
                                                        lblPercUsedFree.leadingAnchor.constraint(equalTo: cardView2.leadingAnchor, constant: 20).isActive = true
                                                        lblPercUsedFree.topAnchor.constraint(equalTo: lblExpiryDateUnit.bottomAnchor, constant: 40).isActive = true
                                                        lblPercUsedFree.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -10).isActive = true
                                                        let lblPercUsedValueFree = UILabel()
                                                        cardView2.addSubview(lblPercUsedValueFree)
                                                        lblPercUsedValueFree.translatesAutoresizingMaskIntoConstraints = false
                                                        lblPercUsedValueFree.textColor = UIColor.black
                                                        lblPercUsedValueFree.font = UIFont(name: String.defaultFontR, size: 17)
                                                        lblPercUsedValueFree.numberOfLines = 0
                                                        lblPercUsedValueFree.lineBreakMode = .byWordWrapping
                                                        lblPercUsedValueFree.topAnchor.constraint(equalTo: lblExpiryDateUnit.bottomAnchor, constant: 40).isActive = true
                                                        lblPercUsedValueFree.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -10).isActive = true
                                                        if let percConv = percentageU{
                                                            var PERCENTAGECov = Double(percConv)
                                                            PERCENTAGECov = 100 - PERCENTAGECov!
                                                            lblPercUsedValueFree.text = "\(PERCENTAGECov ?? 00.00)%"
                                                    }
                                                        //label for Percentage Used
                                                        let lblInitialAmt = UILabel()
                                                        cardView2.addSubview(lblInitialAmt)
                                                        lblInitialAmt.translatesAutoresizingMaskIntoConstraints = false
                                                        lblInitialAmt.text = "Initial Amount"
                                                        lblInitialAmt.textColor = UIColor.black
                                                        lblInitialAmt.font = UIFont(name: String.defaultFontR, size: 17)
                                                        lblInitialAmt.numberOfLines = 0
                                                        lblInitialAmt.lineBreakMode = .byWordWrapping
                                                        lblInitialAmt.leadingAnchor.constraint(equalTo: cardView2.leadingAnchor, constant: 20).isActive = true
                                                        lblInitialAmt.topAnchor.constraint(equalTo: lblPercUsedFree.bottomAnchor, constant: 40).isActive = true
                                                        lblInitialAmt.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -10).isActive = true
                                                        
                                                        let lblInitialAmtValue = UILabel()
                                                        cardView2.addSubview(lblInitialAmtValue)
                                                        lblInitialAmtValue.translatesAutoresizingMaskIntoConstraints = false
                                                        lblInitialAmtValue.text = "\(InitialAmount ?? "")\(InitialUnit ?? "")"
                                                        lblInitialAmtValue.textColor = UIColor.black
                                                        lblInitialAmtValue.font = UIFont(name: String.defaultFontR, size: 17)
                                                        lblInitialAmtValue.numberOfLines = 0
                                                        lblInitialAmtValue.lineBreakMode = .byWordWrapping
                                                        
                                                        lblInitialAmtValue.topAnchor.constraint(equalTo: lblPercUsedValueFree.bottomAnchor, constant: 40).isActive = true
                                                        lblInitialAmtValue.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -10).isActive = true
                                                        
                                                        //label for Current
                                                        let lblCurrentAmt = UILabel()
                                                        cardView2.addSubview(lblCurrentAmt)
                                                        lblCurrentAmt.translatesAutoresizingMaskIntoConstraints = false
                                                        lblCurrentAmt.text = "Current Amount"
                                                        lblCurrentAmt.textColor = UIColor.black
                                                        lblCurrentAmt.font = UIFont(name: String.defaultFontR, size: 17)
                                                        lblCurrentAmt.numberOfLines = 0
                                                        lblCurrentAmt.lineBreakMode = .byWordWrapping
                                                        lblCurrentAmt.leadingAnchor.constraint(equalTo: cardView2.leadingAnchor, constant: 20).isActive = true
                                                        lblCurrentAmt.topAnchor.constraint(equalTo: lblInitialAmt.bottomAnchor, constant: 40).isActive = true
                                                        lblCurrentAmt.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -10).isActive = true
                                                        
                                                        let lblCurrentAmtValue = UILabel()
                                                        cardView2.addSubview(lblCurrentAmtValue)
                                                        lblCurrentAmtValue.translatesAutoresizingMaskIntoConstraints = false
                                                        lblCurrentAmtValue.text = "\(CurrentAmount ?? "")\(CurrentUnit ?? "")"
                                                        lblCurrentAmtValue.textColor = UIColor.black
                                                        lblCurrentAmtValue.font = UIFont(name: String.defaultFontR, size: 17)
                                                        lblCurrentAmtValue.numberOfLines = 0
                                                        lblCurrentAmtValue.lineBreakMode = .byWordWrapping
                                                        lblCurrentAmtValue.topAnchor.constraint(equalTo: lblInitialAmt.bottomAnchor, constant: 40).isActive = true
                                                        lblCurrentAmtValue.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -10).isActive = true
                                                        
                                                        //label for Expiration
                                                        let lblExpiration = UILabel()
                                                        cardView2.addSubview(lblExpiration)
                                                        lblExpiration.translatesAutoresizingMaskIntoConstraints = false
                                                        lblExpiration.text = "Expiration"
                                                        lblExpiration.textColor = UIColor.black
                                                        lblExpiration.font = UIFont(name: String.defaultFontR, size: 17)
                                                        lblExpiration.numberOfLines = 0
                                                        lblExpiration.lineBreakMode = .byWordWrapping
                                                        lblExpiration.leadingAnchor.constraint(equalTo: cardView2.leadingAnchor, constant: 20).isActive = true
                                                        lblExpiration.topAnchor.constraint(equalTo: lblCurrentAmt.bottomAnchor, constant: 40).isActive = true
                                                        lblExpiration.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -10).isActive = true
                                                        
                                                        let lblExpirationValue = UILabel()
                                                        cardView2.addSubview(lblExpirationValue)
                                                        lblExpirationValue.translatesAutoresizingMaskIntoConstraints = false
                                                        lblExpirationValue.text = ExpirationDuration
                                                        lblExpirationValue.textColor = UIColor.black
                                                        lblExpirationValue.font = UIFont(name: String.defaultFontR, size: 17)
                                                        lblExpirationValue.numberOfLines = 0
                                                        lblExpirationValue.lineBreakMode = .byWordWrapping
                                                        lblExpirationValue.topAnchor.constraint(equalTo: lblCurrentAmt.bottomAnchor, constant: 40).isActive = true
                                                        lblExpirationValue.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -10).isActive = true
                                                        
                                                        if counter == array.count {
                                                            let btnBrowse = UIButton()
                                                            self.scrollView.addSubview(btnBrowse)
                                                            btnBrowse.translatesAutoresizingMaskIntoConstraints = false
                                                            btnBrowse.backgroundColor = UIColor.grayButton
                                                            btnBrowse.setTitle("Browse All", for: .normal)
                                                            btnBrowse.setTitleColor(UIColor.white, for: .normal)
                                                            btnBrowse.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
                                                            btnBrowse.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
                                                            btnBrowse.topAnchor.constraint(equalTo: cardView2.bottomAnchor, constant: 40).isActive = true
                                                            btnBrowse.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
                                                            btnBrowse.heightAnchor.constraint(equalToConstant: 55).isActive = true
                                                            btnBrowse.addTarget(self, action: #selector(self.goToOffers), for: .touchUpInside)
                                                        }
                                                  }
                                                }
                                            }
                                        }
                                        self.scrollView.contentSize.height = (self.topImage.frame.size.height + 820) + 500
                                    }else{
                                        
                                        self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not update your records try again later...")
                                        print(error?.localizedDescription)
                                    }
                                }
                                
                            }
                        }
                    }catch{
                        print(error.localizedDescription)
                        DispatchQueue.main.async {
                            self.stop_activity_loader()
                        }
                    }
                }
                task.resume()
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @objc func goTo(){
        print("Clicked")
    }

}
