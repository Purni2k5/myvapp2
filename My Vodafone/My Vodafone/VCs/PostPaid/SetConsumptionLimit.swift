//
//  SetComsumptionLimit.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 05/12/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class SetConsumptionLimit: baseViewControllerM {

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
    
    let lblDate: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 15)
        return view
    }()
    
    let cardViewConsumption: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let cardViewForm: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let lblCardViewConHeader: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.black
        return view
    }()
    
    let txtIDType: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 45).isActive = true
        view.font = UIFont(name: String.defaultFontR, size: 15)
        view.borderStyle = .roundedRect
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let txtIDNo: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 45).isActive = true
        view.font = UIFont(name: String.defaultFontR, size: 15)
        view.borderStyle = .roundedRect
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let txtLimitAmt: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 45).isActive = true
        view.font = UIFont(name: String.defaultFontR, size: 15)
        view.borderStyle = .roundedRect
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let txtStrtDate: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 45).isActive = true
        view.font = UIFont(name: String.defaultFontR, size: 15)
        view.borderStyle = .roundedRect
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let txtendDate: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 45).isActive = true
        view.font = UIFont(name: String.defaultFontR, size: 15)
        view.borderStyle = .roundedRect
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let txtaltNo: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 45).isActive = true
        view.font = UIFont(name: String.defaultFontR, size: 15)
        view.borderStyle = .roundedRect
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let btnSubmit: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.grayButton
        view.setTitle("Submit", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        view.heightAnchor.constraint(equalToConstant: 55).isActive = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground

        setUpViewsSetConsumption()
        hideKeyboardWhenTappedAround()
        checkConnection()
    }
    
    func setUpViewsSetConsumption(){
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
        topImage.heightAnchor.constraint(equalToConstant: 170).isActive = true
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
        backButton.addTarget(self, action: #selector(goToBack), for: .touchUpInside)
        
        let lblHeader = UILabel()
        scrollView.addSubview(lblHeader)
        lblHeader.translatesAutoresizingMaskIntoConstraints = false
        lblHeader.text = "Consumption Limit"
        lblHeader.textColor = UIColor.white
        lblHeader.font = UIFont(name: String.defaultFontR, size: 31)
        lblHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblHeader.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 50).isActive = true
        lblHeader.numberOfLines = 0
        lblHeader.lineBreakMode = .byWordWrapping
        
        scrollView.addSubview(cardViewConsumption)
        cardViewConsumption.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cardViewConsumption.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 20).isActive = true
        cardViewConsumption.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        cardViewConsumption.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        let redView = UIImageView()
        cardViewConsumption.addSubview(redView)
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.backgroundColor = UIColor.red
        redView.widthAnchor.constraint(equalToConstant: 5).isActive = true
        redView.leadingAnchor.constraint(equalTo: cardViewConsumption.leadingAnchor).isActive = true
        redView.topAnchor.constraint(equalTo: cardViewConsumption.topAnchor).isActive = true
        redView.bottomAnchor.constraint(equalTo: cardViewConsumption.bottomAnchor).isActive = true
        
        let profileImage = UIImageView(image: #imageLiteral(resourceName: "default_profile"))
        cardViewConsumption.addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.leadingAnchor.constraint(equalTo: redView.trailingAnchor, constant: 20).isActive = true
        profileImage.topAnchor.constraint(equalTo: cardViewConsumption.topAnchor, constant: 20).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        cardViewConsumption.addSubview(lblCardViewConHeader)
        lblCardViewConHeader.text = "Your current consumption limit"
        lblCardViewConHeader.font = UIFont(name: String.defaultFontR, size: 18)
        lblCardViewConHeader.numberOfLines = 0
        lblCardViewConHeader.lineBreakMode = .byWordWrapping
        lblCardViewConHeader.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10).isActive = true
        lblCardViewConHeader.topAnchor.constraint(equalTo: cardViewConsumption.topAnchor, constant: 20).isActive = true
        lblCardViewConHeader.trailingAnchor.constraint(equalTo: cardViewConsumption.trailingAnchor, constant: -10).isActive = true
        
        let lblFrmHeader = UILabel()
        lblFrmHeader.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(lblFrmHeader)
        lblFrmHeader.textColor = UIColor.support_voilet
        lblFrmHeader.text = "Set Consumption Limit"
        lblFrmHeader.font = UIFont(name: String.defaultFontR, size: 31)
        lblFrmHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblFrmHeader.topAnchor.constraint(equalTo: cardViewConsumption.bottomAnchor, constant: 30).isActive = true
        lblFrmHeader.numberOfLines = 0
        lblFrmHeader.lineBreakMode = .byWordWrapping
        
        scrollView.addSubview(cardViewForm)
        cardViewForm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cardViewForm.topAnchor.constraint(equalTo: lblFrmHeader.bottomAnchor, constant: 20).isActive = true
        cardViewForm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        cardViewForm.heightAnchor.constraint(equalToConstant: 700).isActive = true
        
        let lblIDType = UILabel()
        cardViewForm.addSubview(lblIDType)
        lblIDType.translatesAutoresizingMaskIntoConstraints = false
        lblIDType.text = "ID Type"
        lblIDType.textColor = UIColor.black
        lblIDType.font = UIFont(name: String.defaultFontR, size: 15)
        lblIDType.numberOfLines = 0
        lblIDType.lineBreakMode = .byWordWrapping
        lblIDType.leadingAnchor.constraint(equalTo: cardViewForm.leadingAnchor, constant: 20).isActive = true
        lblIDType.topAnchor.constraint(equalTo: cardViewForm.topAnchor, constant: 30).isActive = true
        lblIDType.trailingAnchor.constraint(equalTo: cardViewForm.trailingAnchor, constant: -20).isActive = true
        
        cardViewForm.addSubview(txtIDType)
        txtIDType.leadingAnchor.constraint(equalTo: cardViewForm.leadingAnchor, constant: 20).isActive = true
        txtIDType.topAnchor.constraint(equalTo: lblIDType.bottomAnchor, constant: 10).isActive = true
        txtIDType.trailingAnchor.constraint(equalTo: cardViewForm.trailingAnchor, constant: -20).isActive = true
        
        let dropDownImage = UIImageView()
        txtIDType.addSubview(dropDownImage)
        dropDownImage.translatesAutoresizingMaskIntoConstraints = false
        let dropImage = UIImage(named: "dropdown")
        dropDownImage.image = dropImage?.withRenderingMode(.alwaysTemplate)
        dropDownImage.tintColor = UIColor.black
        dropDownImage.topAnchor.constraint(equalTo: txtIDType.topAnchor, constant: 20).isActive = true
        dropDownImage.trailingAnchor.constraint(equalTo: txtIDType.trailingAnchor, constant: -20).isActive = true
        dropDownImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        dropDownImage.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        
        scrollView.contentSize.height = view.frame.height + 640
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    @objc func goToBack(){
        let storyboard = UIStoryboard(name: "PostPaid", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "SinceLastBill")
        present(moveTo, animated: true, completion: nil)
    
    }

}
