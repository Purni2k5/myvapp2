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
    var currSpend: String?
    var excludeValue: String?
    
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
    
    let lblYourPlanValue: UILabel = {
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
    let lblPrevSpend = UILabel()
    
    let firstMonthBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.support_voilet
        view.widthAnchor.constraint(equalToConstant: 12).isActive = true
        view.layer.cornerRadius = 7
        return view
    }()
    
    let secondMonthBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.support_voilet
        view.widthAnchor.constraint(equalToConstant: 12).isActive = true
        view.layer.cornerRadius = 7
        return view
    }()
    
    let thirdMonthBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.support_voilet
        view.widthAnchor.constraint(equalToConstant: 12).isActive = true
        view.layer.cornerRadius = 7
        return view
    }()
    
    let fourthMonthBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.support_voilet
        view.widthAnchor.constraint(equalToConstant: 12).isActive = true
        view.layer.cornerRadius = 7
        return view
    }()
    
    let fifthMonthBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.support_voilet
        view.widthAnchor.constraint(equalToConstant: 12).isActive = true
        view.layer.cornerRadius = 7
        return view
    }()
    
    let sixthMonthBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.support_voilet
        view.widthAnchor.constraint(equalToConstant: 12).isActive = true
        view.layer.cornerRadius = 7
        return view
    }()
    
    let yourPlanCircle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.support_blue
        view.widthAnchor.constraint(equalToConstant: 20).isActive = true
        view.heightAnchor.constraint(equalToConstant: 20).isActive = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let yourAvgCircle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.support_voilet
        view.widthAnchor.constraint(equalToConstant: 20).isActive = true
        view.heightAnchor.constraint(equalToConstant: 20).isActive = true
        view.layer.cornerRadius = 10
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
        
        
        
        darkView.addSubview(lblYInterval)
        lblYInterval.text = "GHS -- -- --"
        lblYInterval.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 10).isActive = true
        lblYInterval.topAnchor.constraint(equalTo: lblYEnd.bottomAnchor, constant: 90).isActive = true
        lblYInterval.numberOfLines = 0
        lblYInterval.lineBreakMode = .byWordWrapping
        
        
        
        darkView.addSubview(lblFirstMonth)
        lblFirstMonth.leadingAnchor.constraint(equalTo: lblYInterval.trailingAnchor, constant: 10).isActive = true
        lblFirstMonth.topAnchor.constraint(equalTo: lblYInterval.bottomAnchor, constant: 130).isActive = true
        lblFirstMonth.text = ""
        
        darkView.addSubview(lblSecondMonth)
        lblSecondMonth.leadingAnchor.constraint(equalTo: lblFirstMonth.trailingAnchor, constant: 30).isActive = true
        lblSecondMonth.topAnchor.constraint(equalTo: lblYInterval.bottomAnchor, constant: 130).isActive = true
        lblSecondMonth.text = ""
        
        darkView.addSubview(lblThirdMonth)
        lblThirdMonth.leadingAnchor.constraint(equalTo: lblSecondMonth.trailingAnchor, constant: 30).isActive = true
        lblThirdMonth.topAnchor.constraint(equalTo: lblYInterval.bottomAnchor, constant: 130).isActive = true
        lblThirdMonth.text = ""
        
        darkView.addSubview(lblFourthMonth)
        lblFourthMonth.leadingAnchor.constraint(equalTo: lblThirdMonth.trailingAnchor, constant: 30).isActive = true
        lblFourthMonth.topAnchor.constraint(equalTo: lblYInterval.bottomAnchor, constant: 130).isActive = true
        lblFourthMonth.text = ""
        
        darkView.addSubview(lblFifthMonth)
        lblFifthMonth.leadingAnchor.constraint(equalTo: lblFourthMonth.trailingAnchor, constant: 30).isActive = true
        lblFifthMonth.topAnchor.constraint(equalTo: lblYInterval.bottomAnchor, constant: 130).isActive = true
        lblFifthMonth.text = ""
        
        darkView.addSubview(lblSixthMonth)
        lblSixthMonth.leadingAnchor.constraint(equalTo: lblFifthMonth.trailingAnchor, constant: 30).isActive = true
        lblSixthMonth.topAnchor.constraint(equalTo: lblYInterval.bottomAnchor, constant: 130).isActive = true
        lblSixthMonth.text = ""
        
        darkView.addSubview(firstMonthBar)
        firstMonthBar.leadingAnchor.constraint(equalTo: lblFirstMonth.leadingAnchor, constant: 2).isActive = true
        firstMonthBar.heightAnchor.constraint(equalToConstant: 136).isActive = true
        firstMonthBar.bottomAnchor.constraint(equalTo: lblFirstMonth.topAnchor, constant: -5).isActive = true
        firstMonthBar.isOpaque = false
        
        darkView.addSubview(secondMonthBar)
        secondMonthBar.leadingAnchor.constraint(equalTo: lblSecondMonth.leadingAnchor, constant: 2).isActive = true
        secondMonthBar.heightAnchor.constraint(equalToConstant: 136).isActive = true
        secondMonthBar.bottomAnchor.constraint(equalTo: lblFirstMonth.topAnchor, constant: -5).isActive = true
        secondMonthBar.isOpaque = false
        
        darkView.addSubview(thirdMonthBar)
        thirdMonthBar.leadingAnchor.constraint(equalTo: lblThirdMonth.leadingAnchor, constant: 2).isActive = true
        thirdMonthBar.heightAnchor.constraint(equalToConstant: 136).isActive = true
        thirdMonthBar.bottomAnchor.constraint(equalTo: lblFirstMonth.topAnchor, constant: -5).isActive = true
        thirdMonthBar.isOpaque = false
        
        darkView.addSubview(fourthMonthBar)
        fourthMonthBar.leadingAnchor.constraint(equalTo: lblFourthMonth.leadingAnchor, constant: 2).isActive = true
        fourthMonthBar.heightAnchor.constraint(equalToConstant: 136).isActive = true
        fourthMonthBar.bottomAnchor.constraint(equalTo: lblFirstMonth.topAnchor, constant: -5).isActive = true
        fourthMonthBar.isOpaque = false
        
        darkView.addSubview(fifthMonthBar)
        fifthMonthBar.leadingAnchor.constraint(equalTo: lblFifthMonth.leadingAnchor, constant: 2).isActive = true
        fifthMonthBar.heightAnchor.constraint(equalToConstant: 136).isActive = true
        fifthMonthBar.bottomAnchor.constraint(equalTo: lblFirstMonth.topAnchor, constant: -5).isActive = true
        fifthMonthBar.isOpaque = false
        
        darkView.addSubview(sixthMonthBar)
        sixthMonthBar.leadingAnchor.constraint(equalTo: lblSixthMonth.leadingAnchor, constant: 2).isActive = true
        sixthMonthBar.heightAnchor.constraint(equalToConstant: 136).isActive = true
        sixthMonthBar.bottomAnchor.constraint(equalTo: lblFirstMonth.topAnchor, constant: -5).isActive = true
        sixthMonthBar.isOpaque = false
        
        darkView.addSubview(yEndView)
        yEndView.leadingAnchor.constraint(equalTo: lblYEnd.trailingAnchor, constant: 10).isActive = true
        yEndView.topAnchor.constraint(equalTo: lblAverage.bottomAnchor, constant: 38).isActive = true
        yEndView.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -15).isActive = true
        
        darkView.addSubview(yIntervalView)
        yIntervalView.leadingAnchor.constraint(equalTo: lblYInterval.trailingAnchor, constant: 10).isActive = true
        yIntervalView.topAnchor.constraint(equalTo: lblYEnd.bottomAnchor, constant: 98).isActive = true
        yIntervalView.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -15).isActive = true
        
        let separator1 = UIView()
        separator1.translatesAutoresizingMaskIntoConstraints = false
        darkView.addSubview(separator1)
        separator1.backgroundColor = UIColor.white
        separator1.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        separator1.leadingAnchor.constraint(equalTo: darkView.leadingAnchor).isActive = true
        separator1.trailingAnchor.constraint(equalTo: darkView.trailingAnchor).isActive = true
        separator1.topAnchor.constraint(equalTo: lblFirstMonth.bottomAnchor, constant: 10).isActive = true
        
        darkView.addSubview(yourPlanCircle)
        yourPlanCircle.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        yourPlanCircle.topAnchor.constraint(equalTo: separator1.bottomAnchor, constant: 10).isActive = true
        
        darkView.addSubview(lblYourPlan)
        lblYourPlan.text = "Your plan"
        lblYourPlan.leadingAnchor.constraint(equalTo: yourPlanCircle.trailingAnchor, constant: 10).isActive = true
        lblYourPlan.topAnchor.constraint(equalTo: separator1.bottomAnchor, constant: 16).isActive = true
        
        darkView.addSubview(lblYourPlanValue)
        lblYourPlanValue.text = "..."
        lblYourPlanValue.topAnchor.constraint(equalTo: separator1.bottomAnchor, constant: 16).isActive = true
        lblYourPlanValue.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -10).isActive = true
        
        let separator2 = UIView()
        separator2.translatesAutoresizingMaskIntoConstraints = false
        darkView.addSubview(separator2)
        separator2.backgroundColor = UIColor.white
        separator2.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        separator2.leadingAnchor.constraint(equalTo: darkView.leadingAnchor).isActive = true
        separator2.trailingAnchor.constraint(equalTo: darkView.trailingAnchor).isActive = true
        separator2.topAnchor.constraint(equalTo: lblYourPlan.bottomAnchor, constant: 10).isActive = true
        
        darkView.addSubview(yourAvgCircle)
        yourAvgCircle.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        yourAvgCircle.topAnchor.constraint(equalTo: separator2.bottomAnchor, constant: 10).isActive = true
        
        darkView.addSubview(lblAvgOutSpend)
        lblAvgOutSpend.text = "Average out of plan spend"
        lblAvgOutSpend.leadingAnchor.constraint(equalTo: yourAvgCircle.trailingAnchor, constant: 10).isActive = true
        lblAvgOutSpend.topAnchor.constraint(equalTo: separator2.bottomAnchor, constant: 16).isActive = true
        
        darkView.addSubview(lblAvgOutSpendValue)
        lblAvgOutSpendValue.text = "..."
        lblAvgOutSpendValue.topAnchor.constraint(equalTo: separator2.bottomAnchor, constant: 16).isActive = true
        lblAvgOutSpendValue.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -10).isActive = true
        
        let lblAllCurrSpend = UILabel()
        scrollView.addSubview(lblAllCurrSpend)
        lblAllCurrSpend.translatesAutoresizingMaskIntoConstraints = false
        lblAllCurrSpend.text = "All current spend"
        lblAllCurrSpend.textColor = UIColor.support_brown
        lblAllCurrSpend.font = UIFont(name: String.defaultFontR, size: 31)
        lblAllCurrSpend.numberOfLines = 0
        lblAllCurrSpend.lineBreakMode = .byWordWrapping
        lblAllCurrSpend.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 10).isActive = true
        lblAllCurrSpend.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
        
        let allSpendDarkView = UIView()
        scrollView.addSubview(allSpendDarkView)
        allSpendDarkView.translatesAutoresizingMaskIntoConstraints = false
        allSpendDarkView.backgroundColor = UIColor.black
        allSpendDarkView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 20).isActive = true
        allSpendDarkView.topAnchor.constraint(equalTo: lblAllCurrSpend.bottomAnchor, constant: 20).isActive = true
        allSpendDarkView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        allSpendDarkView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -20).isActive = true
        
        let redView = UIImageView()
        allSpendDarkView.addSubview(redView)
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.backgroundColor = UIColor.vodaRed
        redView.leadingAnchor.constraint(equalTo: allSpendDarkView.leadingAnchor).isActive = true
        redView.topAnchor.constraint(equalTo: allSpendDarkView.topAnchor).isActive = true
        redView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        redView.bottomAnchor.constraint(equalTo: allSpendDarkView.bottomAnchor).isActive = true
        
        let lblSinceLastBill = UILabel()
        allSpendDarkView.addSubview(lblSinceLastBill)
        lblSinceLastBill.translatesAutoresizingMaskIntoConstraints = false
        lblSinceLastBill.text = "Since last bill"
        lblSinceLastBill.textColor = UIColor.white
        lblSinceLastBill.leadingAnchor.constraint(equalTo: redView.trailingAnchor, constant: 20).isActive = true
        lblSinceLastBill.topAnchor.constraint(equalTo: allSpendDarkView.topAnchor, constant: 20).isActive = true
        lblSinceLastBill.numberOfLines = 0
        lblSinceLastBill.lineBreakMode = .byWordWrapping
        lblSinceLastBill.font = UIFont(name: String.defaultFontR, size: 16)
        
        let lblCurrSpendValue = UILabel()
        allSpendDarkView.addSubview(lblCurrSpendValue)
        lblCurrSpendValue.translatesAutoresizingMaskIntoConstraints = false
        lblCurrSpendValue.textColor = UIColor.white
        lblCurrSpendValue.font = UIFont(name: String.defaultFontR, size: 32)
        if let currSpend = currSpend {
            lblCurrSpendValue.text = currSpend
        }
        lblCurrSpendValue.leadingAnchor.constraint(equalTo: redView.trailingAnchor, constant: 20).isActive = true
        lblCurrSpendValue.topAnchor.constraint(equalTo: lblSinceLastBill.bottomAnchor, constant: 20).isActive = true
        lblCurrSpendValue.numberOfLines = 0
        lblCurrSpendValue.trailingAnchor.constraint(equalTo: allSpendDarkView.trailingAnchor, constant: -10).isActive = true
        lblCurrSpendValue.lineBreakMode = .byWordWrapping
        
        let lblExclude = UILabel()
        allSpendDarkView.addSubview(lblExclude)
        lblExclude.translatesAutoresizingMaskIntoConstraints = false
        lblExclude.textColor = UIColor.white
        lblExclude.font = UIFont(name: String.defaultFontR, size: 16)
        if let excludeValue = excludeValue{
            lblExclude.text = excludeValue
        }
        lblExclude.leadingAnchor.constraint(equalTo: redView.trailingAnchor, constant: 20).isActive = true
        lblExclude.topAnchor.constraint(equalTo: lblCurrSpendValue.bottomAnchor, constant: 30).isActive = true
        lblExclude.numberOfLines = 0
        lblExclude.trailingAnchor.constraint(equalTo: allSpendDarkView.trailingAnchor, constant: -10).isActive = true
        lblExclude.lineBreakMode = .byWordWrapping
        
        let rightArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        allSpendDarkView.addSubview(rightArrow)
        rightArrow.translatesAutoresizingMaskIntoConstraints = false
        rightArrow.topAnchor.constraint(equalTo: allSpendDarkView.topAnchor, constant: 60).isActive = true
        rightArrow.trailingAnchor.constraint(equalTo: allSpendDarkView.trailingAnchor, constant: -20).isActive = true
        rightArrow.widthAnchor.constraint(equalToConstant: 25).isActive = true
        rightArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        
        scrollView.addSubview(lblPrevSpend)
        lblPrevSpend.translatesAutoresizingMaskIntoConstraints = false
        lblPrevSpend.text = "Previous spend"
        lblPrevSpend.textColor = UIColor.support_brown
        lblPrevSpend.font = UIFont(name: String.defaultFontR, size: 31)
        lblPrevSpend.numberOfLines = 0
        lblPrevSpend.lineBreakMode = .byWordWrapping
        lblPrevSpend.topAnchor.constraint(equalTo: allSpendDarkView.bottomAnchor, constant: 30).isActive = true
        lblPrevSpend.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
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
                                        let avgoutOfPlanSpend = responseMessage["AverageOutOfPlanSpend"] as? String
                                        if let descWrapped = desc {
                                            self.lblAverage.text = descWrapped
                                        }
                                        
                                        if let avgOutWrapped = avgoutOfPlanSpend {
                                            self.lblAvgOutSpendValue.text = avgOutWrapped
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
                                            var monthCounter = 0
                                            var prevTopConstraint: CGFloat = 20
                                            for obj in array {
                                                if let dict = obj as? NSDictionary{
                                                    monthCounter = monthCounter + 1
                                                    let billMonth = dict.value(forKey: "BillMonth") as! String?
                                                    
                                                    if monthCounter == 6 {
                                                        if let billMonth = billMonth{
                                                            self.lblFirstMonth.text = billMonth
                                                        }
                                                    }
                                                    if monthCounter == 5 {
                                                        if let billMonth = billMonth{
                                                            self.lblSecondMonth.text = billMonth
                                                        }
                                                    }
                                                    if monthCounter == 4 {
                                                        if let billMonth = billMonth{
                                                            self.lblThirdMonth.text = billMonth
                                                        }
                                                    }
                                                    if monthCounter == 3 {
                                                        if let billMonth = billMonth{
                                                            self.lblFourthMonth.text = billMonth
                                                        }
                                                    }
                                                    if monthCounter == 2 {
                                                        if let billMonth = billMonth{
                                                            self.lblFifthMonth.text = billMonth
                                                        }
                                                    }
                                                    if monthCounter == 1 {
                                                        if let billMonth = billMonth{
                                                            self.lblSixthMonth.text = billMonth
                                                        }
                                                    }
                                                    let billAmt = dict.value(forKey: "Amount") as! String?
                                                    let billDate = dict.value(forKey: "BillDate") as! String?
                                                    let dueNote = dict.value(forKey: "DueNote") as! String?
                                                    
                                                    let previousSpendCard = UIView()
                                                    self.scrollView.addSubview(previousSpendCard)
                                                    previousSpendCard.translatesAutoresizingMaskIntoConstraints = false
                                                    previousSpendCard.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20).isActive = true
                                                    previousSpendCard.topAnchor.constraint(equalTo: self.lblPrevSpend.bottomAnchor, constant: prevTopConstraint).isActive = true
                                                    previousSpendCard.heightAnchor.constraint(equalToConstant: 130).isActive = true
                                                    previousSpendCard.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20).isActive = true
                                                    previousSpendCard.backgroundColor = UIColor.white
                                                    
                                                    
                                                    
                                                    prevTopConstraint = prevTopConstraint + 150
                                                    
                                                }
                                                
                                            }
                                            var viewHeight = self.view.frame.size.height
                                            
                                            print("array size \(array.count)")
                                            print("array size \(viewHeight)")
                                            let totalScrollHeight = prevTopConstraint + viewHeight + 60
                                            self.scrollView.contentSize.height = CGFloat(totalScrollHeight)
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
