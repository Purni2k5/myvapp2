//
//  SinceLastBill.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 26/11/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class SinceLastBill: baseViewControllerM {

    var darkViewDate: String?
    var totalAmt: String?
    var planDesc: String?
    var lastUpdated: String?
    var displayName: String?
    var msisdn: String?
    var username: String?
    var dService: String?
    var spentOnCall: String?
    var spentOnData: String?
    var spentOnTexts: String?
    var spentOnOther: String?
    var outPlanCollapseAmt: String?
    
    var isBreakDownShowing: Bool = false
    var isOutPlanShowing: Bool = false
    
    fileprivate var separator3Top: NSLayoutConstraint!
    fileprivate var collapsedViewHeight: NSLayoutConstraint!
    
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
    
    let lblAmtSpent: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 30)
        return view
    }()
    
    let lblPlanDesc: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 15)
        return view
    }()
    
    let lblLastUpdated: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 16)
        return view
    }()
    
    let lblDisplayName: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.black
        view.font = UIFont(name: String.defaultFontR, size: 17)
        return view
    }()
    
    let lblMSISDN: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.black
        view.font = UIFont(name: String.defaultFontR, size: 16)
        return view
    }()
    
    let lblCardAmt: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.support_dark_voilet
        view.font = UIFont(name: String.defaultFontB, size: 20)
        return view
    }()
    
    let lblCardDesc: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.black
        view.font = UIFont(name: String.defaultFontR, size: 16)
        return view
    }()
    
    let btnCollapse: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let btnCollapseOutPlan: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let collapsedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let lblOutPlanCollapse: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.black
        view.font = UIFont(name: String.defaultFontR, size: 16)
        return view
    }()
    let lblInPlanCollapse: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.black
        view.font = UIFont(name: String.defaultFontR, size: 16)
        return view
    }()
    
    let lblOutPlanCollapseAmt: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.black
        view.font = UIFont(name: String.defaultFontB, size: 16)
        return view
    }()
    
    let lblInPlanCollapseAmt: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.black
        view.font = UIFont(name: String.defaultFontR, size: 16)
        return view
    }()
    
    let callsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.support_light_gray
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return view
    }()
    let DataView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.support_light_gray
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return view
    }()
    let textsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.support_light_gray
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return view
    }()
    let otherView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.support_light_gray
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return view
    }()
    
    let lblCallsAmt = UILabel()
    let lblDataAmt = UILabel()
    let lblTextAmt = UILabel()
    let lblOtherAmt = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.grayBackground
        let lastBillDetails = preference.object(forKey: UserDefaultsKeys.postPaidBreakDown.rawValue) as? String
        
        let services = preference.object(forKey: UserDefaultsKeys.ServiceList.rawValue)
        //        print(services)
        dService = preference.object(forKey: UserDefaultsKeys.DefaultService.rawValue) as? String
        
        msisdn = preference.object(forKey: "defaultMSISDN") as? String
        
        if let serviceArray = services as? NSArray{
            var foundDefault = false
            for obj in serviceArray{
                print(foundDefault)
                if foundDefault == false{
                    if let dict = obj as? NSDictionary {
                        displayName = dict.value(forKey: "DisplayName") as? String
                        let id = dict.value(forKey: "ID") as! String?
                        
                        if id == dService{
                            displayName = dict.value(forKey: "DisplayName") as? String
                            AcctType = dict.value(forKey: "Type") as! String?
                            foundDefault = true
                            
                        }
                    }
                }
                
            }
        }
        
        if let lastBillDetailsWrapped = lastBillDetails {
            let decrypt = decryptAsyncRequest(requestBody: lastBillDetailsWrapped)
            let decryptedResponse = convertToNSDictionary(decrypt: decrypt)
            
            let responseCode = decryptedResponse["RESPONSECODE"] as? Int
            if responseCode == 0 {
                let responseMessage = decryptedResponse["RESPONSEMESSAGE"] as? NSDictionary
                if let resMessage = responseMessage {
                    let currentSpendData = resMessage["CurrentSpend"] as! NSDictionary?
                    let outOfPlanSpend = resMessage["OutOfPlanSpend"] as! NSDictionary?
                    if let outOfPlanSpendWrapped = outOfPlanSpend {
                        totalAmt = outOfPlanSpendWrapped["Total"] as? String
                        if let totalAmt = totalAmt {
                            lblAmtSpent.text = totalAmt
                        }
                    }
                    if let currSpendData = currentSpendData {
                        planDesc = currSpendData["Desc"] as? String
                        if let planDesc = planDesc {
                            lblPlanDesc.text = planDesc
                        }
                        lastUpdated = currSpendData["LastUpdateDesc"] as? String
                        darkViewDate = currSpendData["LastUpdated"] as? String
                        if let lastUpdated = lastUpdated {
                            lblLastUpdated.text = lastUpdated
                        }
                        if let darkViewDate = darkViewDate {
                            lblDate.text = darkViewDate
                        }
                        let currentSpendBkDown = currSpendData["Breakdown"] as? NSArray
                        if let bkArray = currentSpendBkDown{
                            for bkObj in bkArray{
                                print("bkObj \(bkObj)")
                                if let dict1 = bkObj as? NSDictionary{
                                    let type = dict1.value(forKey: "Type") as? String
                                    if type == "Out of plan"{
                                        outPlanCollapseAmt = dict1.value(forKey: "Total") as? String
                                        let summaryArray = dict1.value(forKey: "Summary") as? NSArray
                                        if let summArray = summaryArray {
                                            for sumObj in summArray{
                                                if let dict2 = sumObj as? NSDictionary{
                                                    let type2 = dict2.value(forKey: "Type") as? String
                                                    if type2 == "Calls"{
                                                        spentOnCall = dict2.value(forKey: "Amount") as? String
                                                    }else if type2 == "Texts"{
                                                        spentOnTexts = dict2.value(forKey: "Amount") as? String
                                                    }else if type2 == "Data"{
                                                        spentOnData = dict2.value(forKey: "Amount") as? String
                                                    }else {
                                                        spentOnOther = dict2.value(forKey: "Amount") as? String
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
        
        setUpViewsSinceLastBill()
        checkConnection()
        
    }
    
    func setUpViewsSinceLastBill(){
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
        backButton.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 10).isActive = true
        backButton.addTarget(self, action: #selector(goToCurrentSpendsBills), for: .touchUpInside)
        
        let lblHeader = UILabel()
        scrollView.addSubview(lblHeader)
        lblHeader.translatesAutoresizingMaskIntoConstraints = false
        lblHeader.text = "Since last bill"
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
        
        darkView.addSubview(lblDate)
//        lblDate.text = "27 Nov 2018"
        lblDate.centerXAnchor.constraint(equalTo: darkView.centerXAnchor).isActive = true
        lblDate.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 20).isActive = true
        
        darkView.addSubview(lblAmtSpent)
//        lblAmtSpent.text = "GHS 491.6"
        lblAmtSpent.centerXAnchor.constraint(equalTo: darkView.centerXAnchor).isActive = true
        lblAmtSpent.topAnchor.constraint(equalTo: lblDate.bottomAnchor, constant: 10).isActive = true
        
        darkView.addSubview(lblPlanDesc)
//        lblPlanDesc.text = "Excluding in plan charges"
        lblPlanDesc.centerXAnchor.constraint(equalTo: darkView.centerXAnchor).isActive = true
        lblPlanDesc.topAnchor.constraint(equalTo: lblAmtSpent.bottomAnchor, constant: 10).isActive = true
        
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        darkView.addSubview(separator)
        separator.backgroundColor = UIColor.white
        separator.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        separator.topAnchor.constraint(equalTo: lblPlanDesc.bottomAnchor, constant: 20).isActive = true
        separator.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        
        darkView.addSubview(lblLastUpdated)
//        lblLastUpdated.text = "Last Updated 27 Nov 2018"
        lblLastUpdated.centerXAnchor.constraint(equalTo: darkView.centerXAnchor).isActive = true
        lblLastUpdated.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 10).isActive = true
        
        let collapseCardView = UIView()
        scrollView.addSubview(collapseCardView)
        collapseCardView.translatesAutoresizingMaskIntoConstraints = false
        collapseCardView.backgroundColor = UIColor.white
        collapseCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collapseCardView.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 20).isActive = true
        collapseCardView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        collapseCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
//        collapseCardView.layer.cornerRadius = 0.3
//        collapseCardView.layer.shadowOpacity = 0.3
//        collapseCardView.layer.shadowColor = UIColor.black.cgColor
//        collapseCardView.layer.shadowOffset = CGSize(width: 0, height: 5)
        
        let redView = UIImageView()
        collapseCardView.addSubview(redView)
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.backgroundColor = UIColor.vodaRed
        redView.leadingAnchor.constraint(equalTo: collapseCardView.leadingAnchor).isActive = true
        redView.topAnchor.constraint(equalTo: collapseCardView.topAnchor).isActive = true
        redView.widthAnchor.constraint(equalToConstant: 5).isActive = true
        redView.bottomAnchor.constraint(equalTo: collapseCardView.bottomAnchor).isActive = true
        
        let cardImage = UIImageView(image: #imageLiteral(resourceName: "default_profile"))
        collapseCardView.addSubview(cardImage)
        cardImage.translatesAutoresizingMaskIntoConstraints = false
        cardImage.leadingAnchor.constraint(equalTo: redView.trailingAnchor, constant: 20).isActive = true
        cardImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        cardImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        cardImage.topAnchor.constraint(equalTo: collapseCardView.topAnchor, constant: 20).isActive = true
        
        collapseCardView.addSubview(lblDisplayName)
        lblDisplayName.text = displayName
        lblDisplayName.leadingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: 10).isActive = true
        lblDisplayName.topAnchor.constraint(equalTo: collapseCardView.topAnchor, constant: 30).isActive = true
        lblDisplayName.trailingAnchor.constraint(equalTo: collapseCardView.trailingAnchor, constant: -10).isActive = true
        lblDisplayName.numberOfLines = 0
        lblDisplayName.lineBreakMode = .byWordWrapping
        
        collapseCardView.addSubview(lblMSISDN)
        lblMSISDN.text = msisdn
        lblMSISDN.leadingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: 10).isActive = true
        lblMSISDN.topAnchor.constraint(equalTo: lblDisplayName.bottomAnchor, constant: 5).isActive = true
        lblMSISDN.trailingAnchor.constraint(equalTo: collapseCardView.trailingAnchor, constant: -10).isActive = true
        lblMSISDN.numberOfLines = 0
        lblMSISDN.lineBreakMode = .byWordWrapping
        
        collapseCardView.addSubview(lblCardAmt)
        if let totalAmt = totalAmt {
            lblCardAmt.text = totalAmt
        }
        lblCardAmt.leadingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: 10).isActive = true
        lblCardAmt.topAnchor.constraint(equalTo: lblMSISDN.bottomAnchor, constant: 10).isActive = true
        lblCardAmt.trailingAnchor.constraint(equalTo: collapseCardView.trailingAnchor, constant: -40).isActive = true
        lblCardAmt.numberOfLines = 0
        lblCardAmt.lineBreakMode = .byWordWrapping
        
        collapseCardView.addSubview(lblCardDesc)
        if let planDesc = planDesc {
            lblCardDesc.text = planDesc
        }
        
        lblCardDesc.leadingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: 10).isActive = true
        lblCardDesc.topAnchor.constraint(equalTo: lblCardAmt.bottomAnchor, constant: 10).isActive = true
        lblCardDesc.trailingAnchor.constraint(equalTo: collapseCardView.trailingAnchor, constant: -10).isActive = true
        
        collapseCardView.addSubview(btnCollapse)
        let collapseImage = UIImage(named: "dropdown")
        let tintColour = collapseImage?.withRenderingMode(.alwaysTemplate)
        btnCollapse.setImage(tintColour, for: .normal)
        btnCollapse.tintColor = UIColor.vodaRed
        btnCollapse.topAnchor.constraint(equalTo: collapseCardView.topAnchor, constant: 70).isActive = true
        btnCollapse.trailingAnchor.constraint(equalTo: collapseCardView.trailingAnchor, constant: -20).isActive = true
        btnCollapse.widthAnchor.constraint(equalToConstant: 25).isActive = true
        btnCollapse.heightAnchor.constraint(equalToConstant: 15).isActive = true
        btnCollapse.addTarget(self, action: #selector(showBreakDown), for: .touchUpInside)
        
        scrollView.addSubview(collapsedView)
        collapsedView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collapsedView.topAnchor.constraint(equalTo: collapseCardView.bottomAnchor).isActive = true
        collapsedView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        collapsedViewHeight = collapsedView.heightAnchor.constraint(equalToConstant: 350)
        collapsedViewHeight.isActive = true
        collapsedView.isHidden = true
        
        collapsedView.addSubview(lblOutPlanCollapse)
        lblOutPlanCollapse.text = "Out of plan"
        lblOutPlanCollapse.leadingAnchor.constraint(equalTo: collapsedView.leadingAnchor, constant: 20).isActive = true
        lblOutPlanCollapse.topAnchor.constraint(equalTo: collapsedView.topAnchor, constant: 30).isActive = true
        lblOutPlanCollapse.trailingAnchor.constraint(equalTo: collapsedView.trailingAnchor, constant: -30).isActive = true
        lblOutPlanCollapse.numberOfLines = 0
        lblOutPlanCollapse.lineBreakMode = .byWordWrapping
        
        collapsedView.addSubview(lblOutPlanCollapseAmt)
        if let outPlanCollapseAmt = outPlanCollapseAmt {
            lblOutPlanCollapseAmt.text = outPlanCollapseAmt
        }
//        lblOutPlanCollapseAmt.text = "GHS 488"
        lblOutPlanCollapseAmt.trailingAnchor.constraint(equalTo: collapsedView.trailingAnchor, constant: -90).isActive = true
        lblOutPlanCollapseAmt.topAnchor.constraint(equalTo: collapsedView.topAnchor, constant: 30).isActive = true
        lblOutPlanCollapseAmt.numberOfLines = 0
        lblOutPlanCollapseAmt.lineBreakMode = .byWordWrapping
        
        collapsedView.addSubview(btnCollapseOutPlan)
        let collapseImage2 = UIImage(named: "dropdown")
        let tintColour2 = collapseImage2?.withRenderingMode(.alwaysTemplate)
        btnCollapseOutPlan.setImage(tintColour2, for: .normal)
        btnCollapseOutPlan.tintColor = UIColor.support_light_gray
        btnCollapseOutPlan.topAnchor.constraint(equalTo: collapsedView.topAnchor, constant: 30).isActive = true
        btnCollapseOutPlan.trailingAnchor.constraint(equalTo: collapsedView.trailingAnchor, constant: -20).isActive = true
        btnCollapseOutPlan.widthAnchor.constraint(equalToConstant: 20).isActive = true
        btnCollapseOutPlan.heightAnchor.constraint(equalToConstant: 10).isActive = true
        btnCollapseOutPlan.addTarget(self, action: #selector(showBreakDown2), for: .touchUpInside)
        
        let separator3 = UIView()
        collapsedView.addSubview(separator3)
        separator3.translatesAutoresizingMaskIntoConstraints = false
        separator3.backgroundColor = UIColor.black
        separator3.leadingAnchor.constraint(equalTo: collapsedView.leadingAnchor).isActive = true
        separator3Top = separator3.topAnchor.constraint(equalTo: lblOutPlanCollapse.bottomAnchor, constant: 20)
        separator3Top.isActive = true
        separator3.trailingAnchor.constraint(equalTo: collapsedView.trailingAnchor).isActive = true
        separator3.heightAnchor.constraint(equalToConstant: 0.2).isActive = true
        
        //calls details
        collapsedView.addSubview(callsView)
        callsView.leadingAnchor.constraint(equalTo: collapsedView.leadingAnchor, constant: 2).isActive = true
        callsView.topAnchor.constraint(equalTo: lblOutPlanCollapse.bottomAnchor, constant: 20).isActive = true
        callsView.trailingAnchor.constraint(equalTo: collapsedView.trailingAnchor, constant: -2).isActive = true
        
        
        callsView.addSubview(lblCallsAmt)
        lblCallsAmt.translatesAutoresizingMaskIntoConstraints = false
        if let spentOnCall = spentOnCall {
            lblCallsAmt.text = spentOnCall
        }
//        lblCallsAmt.text = "GHS 376.18"
        lblCallsAmt.textColor = UIColor.black
        lblCallsAmt.topAnchor.constraint(equalTo: callsView.topAnchor, constant: 20).isActive = true
        lblCallsAmt.trailingAnchor.constraint(equalTo: callsView.trailingAnchor, constant: -10).isActive = true
        lblCallsAmt.font = UIFont(name: String.defaultFontB, size: 17)
        lblCallsAmt.numberOfLines = 0
        lblCallsAmt.lineBreakMode = .byWordWrapping
        
        let lblCalls = UILabel()
        callsView.addSubview(lblCalls)
        lblCalls.translatesAutoresizingMaskIntoConstraints = false
        lblCalls.text = "Calls"
        lblCalls.font = UIFont(name: String.defaultFontR, size: 16)
        lblCalls.textColor = UIColor.black
        lblCalls.leadingAnchor.constraint(equalTo: callsView.leadingAnchor, constant: 20).isActive = true
        lblCalls.topAnchor.constraint(equalTo: callsView.topAnchor, constant: 20).isActive = true
        lblCalls.numberOfLines = 0
        lblCalls.lineBreakMode = .byWordWrapping
        
        //Data details
        collapsedView.addSubview(DataView)
        DataView.leadingAnchor.constraint(equalTo: collapsedView.leadingAnchor, constant: 2).isActive = true
        DataView.topAnchor.constraint(equalTo: callsView.bottomAnchor, constant: 1).isActive = true
        DataView.trailingAnchor.constraint(equalTo: collapsedView.trailingAnchor, constant: -2).isActive = true
        
        
        DataView.addSubview(lblDataAmt)
        lblDataAmt.translatesAutoresizingMaskIntoConstraints = false
        if let spentOnData = spentOnData{
            lblDataAmt.text = spentOnData
        }
//        lblDataAmt.text = "GHS 81.49"
        lblDataAmt.textColor = UIColor.black
        lblDataAmt.topAnchor.constraint(equalTo: DataView.topAnchor, constant: 20).isActive = true
        lblDataAmt.trailingAnchor.constraint(equalTo: DataView.trailingAnchor, constant: -10).isActive = true
        lblDataAmt.font = UIFont(name: String.defaultFontB, size: 17)
        lblDataAmt.numberOfLines = 0
        lblDataAmt.lineBreakMode = .byWordWrapping
        
        let lblData = UILabel()
        DataView.addSubview(lblData)
        lblData.translatesAutoresizingMaskIntoConstraints = false
        lblData.text = "Data"
        lblData.font = UIFont(name: String.defaultFontR, size: 16)
        lblData.textColor = UIColor.black
        lblData.leadingAnchor.constraint(equalTo: DataView.leadingAnchor, constant: 20).isActive = true
        lblData.topAnchor.constraint(equalTo: DataView.topAnchor, constant: 20).isActive = true
        lblData.numberOfLines = 0
        lblData.lineBreakMode = .byWordWrapping
        
        //Texts details
        collapsedView.addSubview(textsView)
        textsView.leadingAnchor.constraint(equalTo: collapsedView.leadingAnchor, constant: 2).isActive = true
        textsView.topAnchor.constraint(equalTo: DataView.bottomAnchor, constant: 1).isActive = true
        textsView.trailingAnchor.constraint(equalTo: collapsedView.trailingAnchor, constant: -2).isActive = true
        
        
        textsView.addSubview(lblTextAmt)
        lblTextAmt.translatesAutoresizingMaskIntoConstraints = false
        if let spentOnTexts = spentOnTexts {
            lblTextAmt.text = spentOnTexts
        }
//        lblTextAmt.text = "GHS 30.33"
        lblTextAmt.textColor = UIColor.black
        lblTextAmt.topAnchor.constraint(equalTo: textsView.topAnchor, constant: 20).isActive = true
        lblTextAmt.trailingAnchor.constraint(equalTo: textsView.trailingAnchor, constant: -10).isActive = true
        lblTextAmt.font = UIFont(name: String.defaultFontB, size: 17)
        lblTextAmt.numberOfLines = 0
        lblTextAmt.lineBreakMode = .byWordWrapping
        
        let lblText = UILabel()
        textsView.addSubview(lblText)
        lblText.translatesAutoresizingMaskIntoConstraints = false
        lblText.text = "Texts"
        lblText.font = UIFont(name: String.defaultFontR, size: 16)
        lblText.textColor = UIColor.black
        lblText.leadingAnchor.constraint(equalTo: textsView.leadingAnchor, constant: 20).isActive = true
        lblText.topAnchor.constraint(equalTo: textsView.topAnchor, constant: 20).isActive = true
        lblText.numberOfLines = 0
        lblText.lineBreakMode = .byWordWrapping
        
        //Other details
        collapsedView.addSubview(otherView)
        otherView.leadingAnchor.constraint(equalTo: collapsedView.leadingAnchor, constant: 2).isActive = true
        otherView.topAnchor.constraint(equalTo: textsView.bottomAnchor, constant: 1).isActive = true
        otherView.trailingAnchor.constraint(equalTo: collapsedView.trailingAnchor, constant: -2).isActive = true
        
        
        otherView.addSubview(lblOtherAmt)
        lblOtherAmt.translatesAutoresizingMaskIntoConstraints = false
        if let spentOnOther = spentOnOther{
            lblOtherAmt.text = spentOnOther
        }
//        lblOtherAmt.text = "GHS 30.33"
        lblOtherAmt.textColor = UIColor.black
        lblOtherAmt.topAnchor.constraint(equalTo: otherView.topAnchor, constant: 20).isActive = true
        lblOtherAmt.trailingAnchor.constraint(equalTo: otherView.trailingAnchor, constant: -10).isActive = true
        lblOtherAmt.font = UIFont(name: String.defaultFontB, size: 17)
        lblOtherAmt.numberOfLines = 0
        lblOtherAmt.lineBreakMode = .byWordWrapping
        
        let lblOther = UILabel()
        otherView.addSubview(lblOther)
        lblOther.translatesAutoresizingMaskIntoConstraints = false
        lblOther.text = "Other"
        lblOther.font = UIFont(name: String.defaultFontR, size: 16)
        lblOther.textColor = UIColor.black
        lblOther.leadingAnchor.constraint(equalTo: otherView.leadingAnchor, constant: 20).isActive = true
        lblOther.topAnchor.constraint(equalTo: otherView.topAnchor, constant: 20).isActive = true
        lblOther.numberOfLines = 0
        lblOther.lineBreakMode = .byWordWrapping
        
        hideOutPlanDetails()
        
        collapsedView.addSubview(lblInPlanCollapse)
        lblInPlanCollapse.text = "In plan"
        lblInPlanCollapse.leadingAnchor.constraint(equalTo: collapsedView.leadingAnchor, constant: 20).isActive = true
        lblInPlanCollapse.topAnchor.constraint(equalTo: separator3.topAnchor, constant: 30).isActive = true
        lblInPlanCollapse.trailingAnchor.constraint(equalTo: collapsedView.trailingAnchor, constant: -30).isActive = true
        lblInPlanCollapse.numberOfLines = 0
        lblInPlanCollapse.lineBreakMode = .byWordWrapping
        
        collapsedView.addSubview(lblInPlanCollapseAmt)
        lblInPlanCollapseAmt.text = "..."
        lblInPlanCollapseAmt.trailingAnchor.constraint(equalTo: collapsedView.trailingAnchor, constant: -90).isActive = true
        lblInPlanCollapseAmt.topAnchor.constraint(equalTo: separator3.topAnchor, constant: 30).isActive = true
        lblInPlanCollapseAmt.numberOfLines = 0
        lblInPlanCollapseAmt.lineBreakMode = .byWordWrapping
        
        let separator4 = UIView()
        collapsedView.addSubview(separator4)
        separator4.translatesAutoresizingMaskIntoConstraints = false
        separator4.backgroundColor = UIColor.black
        separator4.leadingAnchor.constraint(equalTo: collapsedView.leadingAnchor).isActive = true
        separator4.topAnchor.constraint(equalTo: lblInPlanCollapseAmt.bottomAnchor, constant: 20).isActive = true
        separator4.trailingAnchor.constraint(equalTo: collapsedView.trailingAnchor).isActive = true
        separator4.heightAnchor.constraint(equalToConstant: 0.2).isActive = true
        
        let btnSeeItemSpend = UIButton()
        btnSeeItemSpend.translatesAutoresizingMaskIntoConstraints = false
        collapsedView.addSubview(btnSeeItemSpend)
        btnSeeItemSpend.leadingAnchor.constraint(equalTo: collapsedView.leadingAnchor, constant: 20).isActive = true
        btnSeeItemSpend.topAnchor.constraint(equalTo: separator4.bottomAnchor, constant: 30).isActive = true
        btnSeeItemSpend.trailingAnchor.constraint(equalTo: collapsedView.trailingAnchor, constant: -20).isActive = true
        btnSeeItemSpend.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnSeeItemSpend.setTitle("See itemised spend", for: .normal)
        btnSeeItemSpend.setTitleColor(UIColor.black, for: .normal)
        btnSeeItemSpend.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnSeeItemSpend.backgroundColor = UIColor.support_light_gray
        btnSeeItemSpend.addTarget(self, action: #selector(goToItemisedSpend), for: .touchUpInside)
        
        let btnSetConsumptionLimit = UIButton()
        btnSetConsumptionLimit.translatesAutoresizingMaskIntoConstraints = false
        collapsedView.addSubview(btnSetConsumptionLimit)
        btnSetConsumptionLimit.leadingAnchor.constraint(equalTo: collapsedView.leadingAnchor, constant: 20).isActive = true
        btnSetConsumptionLimit.topAnchor.constraint(equalTo: btnSeeItemSpend.bottomAnchor, constant: 10).isActive = true
        btnSetConsumptionLimit.trailingAnchor.constraint(equalTo: collapsedView.trailingAnchor, constant: -20).isActive = true
        btnSetConsumptionLimit.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnSetConsumptionLimit.setTitle("Set consumption limit", for: .normal)
        btnSetConsumptionLimit.setTitleColor(UIColor.black, for: .normal)
        btnSetConsumptionLimit.titleLabel?.font = UIFont(name: String.defaultFontR, size: 21)
        btnSetConsumptionLimit.backgroundColor = UIColor.support_light_gray
        btnSetConsumptionLimit.addTarget(self, action: #selector(goToSetConsumption), for: .touchUpInside)
        
        scrollView.contentSize.height = view.frame.height + 20
        
        
    }
    
    @objc func showBreakDown(){
        
        if isBreakDownShowing {
            UIView.animate(withDuration: 1) {
                self.btnCollapse.transform = self.btnCollapse.transform.rotated(by: CGFloat(Double.pi / -1))
                self.collapsedView.isHidden = true
                self.scrollView.contentSize.height = self.view.frame.height + 20
            }
        }else{
            UIView.animate(withDuration: 1) {
                self.btnCollapse.transform = self.btnCollapse.transform.rotated(by: CGFloat(Double.pi / -1))
                self.collapsedView.isHidden = false
                self.scrollView.contentSize.height = self.view.frame.height + 350
            }
        }
        isBreakDownShowing = !isBreakDownShowing
    }
    
    fileprivate func hideOutPlanDetails() {
        self.callsView.isHidden = true
        self.DataView.isHidden = true
        self.textsView.isHidden = true
        self.otherView.isHidden = true
    }
    
    fileprivate func displayOutPlanDetails() {
        self.callsView.isHidden = false
        self.DataView.isHidden = false
        self.textsView.isHidden = false
        self.otherView.isHidden = false
    }
    
    @objc func showBreakDown2(){
        if isOutPlanShowing {
            UIView.animate(withDuration: 1) {
                self.btnCollapseOutPlan.transform = self.btnCollapseOutPlan.transform.rotated(by: CGFloat(Double.pi / -1))
                self.separator3Top.constant = 20
                self.collapsedViewHeight.constant = 350
                self.hideOutPlanDetails()
            }
        }else{
            UIView.animate(withDuration: 1) {
                self.btnCollapseOutPlan.transform = self.btnCollapseOutPlan.transform.rotated(by: CGFloat(Double.pi / -1))
                
                self.separator3Top.constant = 270
                self.collapsedViewHeight.constant = 600
                self.displayOutPlanDetails()
            }
            
        }
        isOutPlanShowing = !isOutPlanShowing
    }

    @objc func goToCurrentSpendsBills(){
        let storyboard = UIStoryboard(name: "PostPaid", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "currentSpendsBills") as? currentSpendsBills else {return}
        moveTo.currSpend = totalAmt
        moveTo.excludeValue = planDesc
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToItemisedSpend(){
        let storyboard = UIStoryboard(name: "PostPaid", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "itemisedBill") as? itemisedBill else{return}
        moveTo.parsedDate = darkViewDate
        moveTo.displayName = displayName
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToSetConsumption(){
        let storyboard = UIStoryboard(name: "PostPaid", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "SetConsumptionLimit") as? SetConsumptionLimit else{return}
//        moveTo.parsedDate = darkViewDate
//        moveTo.displayName = displayName
        present(moveTo, animated: true, completion: nil)
    }
}
