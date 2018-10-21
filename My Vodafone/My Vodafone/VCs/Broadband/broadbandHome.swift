//
//  broadbandHome.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 19/10/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit
import FSPagerView

class broadbandHome: baseViewControllerM {
    
    var dService: String?
    var displayName: String?
    
    let progressLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let bgImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let motherViewBBHome: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let greetingsImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let adslView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.70)
        view.isOpaque = false
        return view
    }()
    
    let currentPlanView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.70)
        view.isOpaque = false
        return view
    }()
    
    let gaugeViewHolder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return view
    }()
    
    let lblBucketValue: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontB, size: 38)
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 0
        return view
    }()
    
    let lblActualValue: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontB, size: 24)
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 0
        return view
    }()
    
    let lblLeftOf: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.text = "left of"
        view.font = UIFont(name: String.defaultFontR, size: 23)
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 0
        return view
    }()
    
    let updateIcon: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblLastUpdate: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Last updated on ....."
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let services = preference.object(forKey: UserDefaultsKeys.ServiceList.rawValue)
        print(services)
        dService = preference.object(forKey: UserDefaultsKeys.defaultName.rawValue) as? String
        print(dService)
        if let serviceArray = services as? NSArray{
            var foundDefault = false
            for obj in serviceArray{
                print(foundDefault)
                if foundDefault == false{
                    if let dict = obj as? NSDictionary {
                        displayName = dict.value(forKey: "DisplayName") as? String
                        let id = dict.value(forKey: "ID") as? String
                        if id == dService{
                            displayName = dict.value(forKey: "DisplayName") as? String
                            foundDefault = true
                        }
                    }
                }
                
            }
        }
        setUpViewsBBHome()
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
       checkConnection()
    }
    
    func setUpViewsBBHome(){
        view.addSubview(bgImage)
        let timeOfDay = greetings()
        if timeOfDay == "morning"{
            bgImage.image = UIImage(named: "morning_bg_")
        }else if timeOfDay == "afternoon" {
            bgImage.image = UIImage(named: "bg_afternoon")
        }else{
            bgImage.image = UIImage(named: "evening_bg_")
        }
        
        bgImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bgImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bgImage.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        bgImage.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
        view.addSubview(motherView)
        motherView.backgroundColor = UIColor.clear
        motherView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        motherView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        motherView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        motherView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        motherView.addSubview(scrollView)
        scrollView.backgroundColor = UIColor.clear
        scrollView.leadingAnchor.constraint(equalTo: motherView.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: motherView.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: motherView.safeTopAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: motherView.safeBottomAnchor).isActive = true
        
        //app logo
        let app_logo = UIImageView(image: #imageLiteral(resourceName: "voda_logo"))
        scrollView.addSubview(app_logo)
        app_logo.translatesAutoresizingMaskIntoConstraints = false
        app_logo.heightAnchor.constraint(equalToConstant: 48).isActive = true
        app_logo.widthAnchor.constraint(equalToConstant: 48).isActive = true
        app_logo.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10).isActive = true
        app_logo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        
        //Menu image
        let vcHamburger = UIButton()
        vcHamburger.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(vcHamburger)
        let hamburgerImage = UIImage(named: "menu")
        vcHamburger.setImage(hamburgerImage, for: .normal)
        vcHamburger.widthAnchor.constraint(equalToConstant: 40).isActive = true
        vcHamburger.heightAnchor.constraint(equalToConstant: 40).isActive = true
        vcHamburger.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        vcHamburger.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -10).isActive = true
        vcHamburger.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        
        //Menu label
        let lblMenu = UILabel()
        scrollView.addSubview(lblMenu)
        lblMenu.translatesAutoresizingMaskIntoConstraints = false
        lblMenu.textColor = UIColor.white
        lblMenu.text = "MENU"
        lblMenu.font = UIFont(name: String.defaultFontR, size: 13)
        lblMenu.topAnchor.constraint(equalTo: vcHamburger.bottomAnchor, constant: -3).isActive = true
        lblMenu.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -14).isActive = true
        
        scrollView.addSubview(greetingsImage)
        greetingsImage.image = UIImage(named: "bubble2")
        greetingsImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        greetingsImage.topAnchor.constraint(equalTo: lblMenu.bottomAnchor, constant: 20).isActive = true
        greetingsImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        greetingsImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        let greetingsRed = UIImageView()
        greetingsImage.addSubview(greetingsRed)
        greetingsRed.translatesAutoresizingMaskIntoConstraints = false
        greetingsRed.backgroundColor = UIColor.vodaRed
        greetingsRed.widthAnchor.constraint(equalToConstant: 3).isActive = true
        greetingsRed.leadingAnchor.constraint(equalTo: greetingsImage.leadingAnchor, constant: 50).isActive = true
        greetingsRed.topAnchor.constraint(equalTo: greetingsImage.topAnchor, constant: 40).isActive = true
        greetingsRed.bottomAnchor.constraint(equalTo: greetingsImage.bottomAnchor, constant: -40).isActive = true
        
        let lblGreetings = UILabel()
        greetingsImage.addSubview(lblGreetings)
        lblGreetings.translatesAutoresizingMaskIntoConstraints = false
        lblGreetings.textColor = UIColor.white
        lblGreetings.font = UIFont(name: String.defaultFontR, size: 23)
        lblGreetings.text = "Good \(greetings())"
        lblGreetings.leadingAnchor.constraint(equalTo: greetingsRed.trailingAnchor, constant: 20).isActive = true
        lblGreetings.topAnchor.constraint(equalTo: greetingsImage.topAnchor, constant: 50).isActive = true
        lblGreetings.trailingAnchor.constraint(equalTo: greetingsImage.trailingAnchor, constant: -10).isActive = true
        lblGreetings.numberOfLines = 0
        lblGreetings.lineBreakMode = .byWordWrapping
        
        let lblWelcome = UILabel()
        greetingsImage.addSubview(lblWelcome)
        lblWelcome.translatesAutoresizingMaskIntoConstraints = false
        lblWelcome.textColor = UIColor.white
        lblWelcome.font = UIFont(name: String.defaultFontR, size: 13)
        lblWelcome.leadingAnchor.constraint(equalTo: greetingsRed.leadingAnchor, constant: 20).isActive = true
        lblWelcome.topAnchor.constraint(equalTo: lblGreetings.bottomAnchor, constant: 5).isActive = true
        lblWelcome.trailingAnchor.constraint(equalTo: greetingsImage.trailingAnchor, constant: -10).isActive = true
        lblWelcome.numberOfLines = 0
        lblWelcome.lineBreakMode = .byWordWrapping
        
        let normalText = "Welcome to "
        let boldText = "My Vodafone"
        let attributedString = NSMutableAttributedString(string:normalText)
        let attrs = [NSAttributedStringKey.font : UIFont(name: String.defaultFontB, size: 13)]
        let boldString = NSMutableAttributedString(string: boldText, attributes:attrs)
        attributedString.append(boldString)
        lblWelcome.attributedText = attributedString
        
        let fbbImage = UIImageView(image: #imageLiteral(resourceName: "fbb"))
        scrollView.addSubview(fbbImage)
        fbbImage.translatesAutoresizingMaskIntoConstraints = false
        fbbImage.heightAnchor.constraint(equalToConstant: 90).isActive = true
        fbbImage.widthAnchor.constraint(equalToConstant: 90).isActive = true
        fbbImage.topAnchor.constraint(equalTo: greetingsImage.bottomAnchor, constant: 30).isActive = true
        fbbImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        fbbImage.layer.cornerRadius = 45
        fbbImage.layer.borderColor = UIColor.white.cgColor
        fbbImage.layer.borderWidth = 2
        
        let lblFBBName = UILabel()
        scrollView.addSubview(lblFBBName)
        lblFBBName.translatesAutoresizingMaskIntoConstraints = false
        lblFBBName.textColor = UIColor.white
        lblFBBName.font = UIFont(name: String.defaultFontB, size: 21)
        lblFBBName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        lblFBBName.topAnchor.constraint(equalTo: fbbImage.bottomAnchor, constant: 15).isActive = true
        lblFBBName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 500).isActive = true
        lblFBBName.numberOfLines = 0
        lblFBBName.lineBreakMode = .byWordWrapping
        let defaultAccNameArr = displayName?.components(separatedBy: " ")
        
        displayName = defaultAccNameArr?[0]
        let phoneTextIndex = defaultAccNameArr!.count - 1
        let phoneText = defaultAccNameArr?[phoneTextIndex]
        lblFBBName.text = "\(displayName!)\n\t\(phoneText!)"
        
        scrollView.addSubview(adslView)
        adslView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        adslView.widthAnchor.constraint(equalToConstant: 175).isActive = true
        adslView.topAnchor.constraint(equalTo: greetingsImage.bottomAnchor, constant: 50).isActive = true
        adslView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        adslView.layer.cornerRadius = 33
        
        let btnTop = UIButton()
        adslView.addSubview(btnTop)
        btnTop.translatesAutoresizingMaskIntoConstraints = false
        btnTop.backgroundColor = UIColor.white
        btnTop.trailingAnchor.constraint(equalTo: adslView.trailingAnchor).isActive = true
        btnTop.topAnchor.constraint(equalTo: adslView.topAnchor).isActive = true
        btnTop.bottomAnchor.constraint(equalTo: adslView.bottomAnchor).isActive = true
        btnTop.widthAnchor.constraint(equalToConstant: 70).isActive = true
        btnTop.layer.cornerRadius = 35
        let topUpImage = UIImage(named: "top_up")
        btnTop.setImage(topUpImage, for: .normal)
        btnTop.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15)
        
        let lblADSL = UILabel()
        adslView.addSubview(lblADSL)
        lblADSL.translatesAutoresizingMaskIntoConstraints = false
        lblADSL.text = "ADSL Balance"
        lblADSL.textColor = UIColor.black
        lblADSL.font = UIFont(name: String.defaultFontR, size: 15)
        lblADSL.numberOfLines = 0
        lblADSL.lineBreakMode = .byWordWrapping
        lblADSL.leadingAnchor.constraint(equalTo: adslView.leadingAnchor, constant: 8).isActive = true
        lblADSL.topAnchor.constraint(equalTo: adslView.topAnchor, constant: 15).isActive = true
        lblADSL.trailingAnchor.constraint(equalTo: btnTop.leadingAnchor, constant: 4).isActive = true
        
        let lblADSLAmt = UILabel()
        adslView.addSubview(lblADSLAmt)
        lblADSLAmt.translatesAutoresizingMaskIntoConstraints = false
        lblADSLAmt.text = "GHS 1000"
        lblADSLAmt.textColor = UIColor.black
        lblADSLAmt.font = UIFont(name: String.defaultFontB, size: 23)
        lblADSLAmt.numberOfLines = 0
        lblADSLAmt.lineBreakMode = .byWordWrapping
        lblADSLAmt.leadingAnchor.constraint(equalTo: adslView.leadingAnchor, constant: 8).isActive = true
        lblADSLAmt.topAnchor.constraint(equalTo: lblADSL.bottomAnchor, constant: 8).isActive = true
        lblADSLAmt.trailingAnchor.constraint(equalTo: btnTop.leadingAnchor, constant: 4).isActive = true
        
        scrollView.addSubview(currentPlanView)
        currentPlanView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        currentPlanView.widthAnchor.constraint(equalToConstant: 155).isActive = true
        currentPlanView.topAnchor.constraint(equalTo: adslView.bottomAnchor, constant: 5).isActive = true
        currentPlanView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90).isActive = true
        currentPlanView.layer.cornerRadius = 28
        
        let btnCurrPlan = UIButton()
        currentPlanView.addSubview(btnCurrPlan)
        btnCurrPlan.translatesAutoresizingMaskIntoConstraints = false
        btnCurrPlan.backgroundColor = UIColor.white
        btnCurrPlan.trailingAnchor.constraint(equalTo: currentPlanView.trailingAnchor).isActive = true
        btnCurrPlan.topAnchor.constraint(equalTo: currentPlanView.topAnchor).isActive = true
        btnCurrPlan.bottomAnchor.constraint(equalTo: currentPlanView.bottomAnchor).isActive = true
        btnCurrPlan.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btnCurrPlan.layer.cornerRadius = 25
        let currPlanImage = UIImage(named: "sync")
        btnCurrPlan.setImage(currPlanImage, for: .normal)
        btnCurrPlan.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        
        let lblCurrPlan = UILabel()
        currentPlanView.addSubview(lblCurrPlan)
        lblCurrPlan.translatesAutoresizingMaskIntoConstraints = false
        lblCurrPlan.text = "Current Plan"
        lblCurrPlan.textColor = UIColor.black
        lblCurrPlan.font = UIFont(name: String.defaultFontR, size: 13)
        lblCurrPlan.numberOfLines = 0
        lblCurrPlan.lineBreakMode = .byWordWrapping
        lblCurrPlan.leadingAnchor.constraint(equalTo: currentPlanView.leadingAnchor, constant: 8).isActive = true
        lblCurrPlan.topAnchor.constraint(equalTo: currentPlanView.topAnchor, constant: 15).isActive = true
        lblCurrPlan.trailingAnchor.constraint(equalTo: btnCurrPlan.leadingAnchor, constant: 4).isActive = true
        
        let lblCurrPlanAmt = UILabel()
        currentPlanView.addSubview(lblCurrPlanAmt)
        lblCurrPlanAmt.translatesAutoresizingMaskIntoConstraints = false
        lblCurrPlanAmt.text = "VFGH Staff"
        lblCurrPlanAmt.textColor = UIColor.black
        lblCurrPlanAmt.font = UIFont(name: String.defaultFontB, size: 16)
        lblCurrPlanAmt.numberOfLines = 0
        lblCurrPlanAmt.lineBreakMode = .byWordWrapping
        lblCurrPlanAmt.leadingAnchor.constraint(equalTo: currentPlanView.leadingAnchor, constant: 8).isActive = true
        lblCurrPlanAmt.topAnchor.constraint(equalTo: lblCurrPlan.bottomAnchor, constant: 8).isActive = true
        lblCurrPlanAmt.trailingAnchor.constraint(equalTo: btnTop.leadingAnchor, constant: 4).isActive = true
        
        //Gauge view
        scrollView.addSubview(gaugeViewHolder)
        gaugeViewHolder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        gaugeViewHolder.topAnchor.constraint(equalTo: currentPlanView.bottomAnchor, constant: 30).isActive = true
        gaugeViewHolder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(updateIcon)
        let btnUpdateImage = UIImage(named: "progressarrow")
        updateIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        updateIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        updateIcon.topAnchor.constraint(equalTo: gaugeViewHolder.bottomAnchor, constant: 30).isActive = true
        updateIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 95).isActive = true
        updateIcon.setImage(btnUpdateImage, for: .normal)
        
        
        scrollView.contentSize.height = 1000
    }
    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let circularPath = UIBezierPath(arcCenter: .zero
            , radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.white.withAlphaComponent(0.20).cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = kCALineCapRound
        trackLayer.position = CGPoint(x: gaugeViewHolder.frame.size.width/2, y: gaugeViewHolder.frame.size.height/2)
        gaugeViewHolder.layer.addSublayer(trackLayer)
        
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = UIColor.white.cgColor
        progressLayer.lineWidth = 10
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = kCALineCapRound
        progressLayer.position = CGPoint(x: gaugeViewHolder.frame.size.width/2, y: gaugeViewHolder.frame.size.height/2)
        progressLayer.strokeEnd = 0.90
        progressLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1   )
        gaugeViewHolder.layer.addSublayer(progressLayer)
        
        gaugeViewHolder.addSubview(lblBucketValue)
        lblBucketValue.centerXAnchor.constraint(equalTo: gaugeViewHolder.centerXAnchor).isActive = true
        lblBucketValue.topAnchor.constraint(equalTo: gaugeViewHolder.topAnchor, constant: 50).isActive = true
        lblBucketValue.text = "200GB"
        
        gaugeViewHolder.addSubview(lblLeftOf)
        lblLeftOf.topAnchor.constraint(equalTo: lblBucketValue.bottomAnchor, constant: 20).isActive = true
        lblLeftOf.centerXAnchor.constraint(equalTo: gaugeViewHolder.centerXAnchor).isActive = true
        
        gaugeViewHolder.addSubview(lblActualValue)
        lblActualValue.topAnchor.constraint(equalTo: lblLeftOf.bottomAnchor, constant: 20).isActive = true
        lblActualValue.centerXAnchor.constraint(equalTo: gaugeViewHolder.centerXAnchor).isActive = true
        lblActualValue.text = "200GB"
        
    }
    


}
