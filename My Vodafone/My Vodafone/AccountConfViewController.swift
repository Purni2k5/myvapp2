//
//  AccountConfViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 10/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class AccountConfViewController: UIViewController {
    
    //create closure for image view
    let closureImage: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //create closure for motherView
    let motherView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    //create closure scroll view
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }

    //Setup views
    func setUpViews(){
        //background Image
        let backgroundImage = closureImage
        view.addSubview(backgroundImage)
        backgroundImage.image = UIImage(named: "morning_bg_")
        backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //mother view
        view.addSubview(motherView)
        motherView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        motherView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        motherView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        motherView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //scrollview
        motherView.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: motherView.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: motherView.safeTopAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: motherView.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: motherView.bottomAnchor).isActive = true
        
        
        //app logo
        let app_logo = UIImageView(image: #imageLiteral(resourceName: "voda_logo"))
        scrollView.addSubview(app_logo)
        app_logo.translatesAutoresizingMaskIntoConstraints = false
        app_logo.heightAnchor.constraint(equalToConstant: 48).isActive = true
        app_logo.widthAnchor.constraint(equalToConstant: 48).isActive = true
        app_logo.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10).isActive = true
        app_logo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        
        //Account confirmation label
        let accountLbl = UILabel()
        scrollView.addSubview(accountLbl)
        accountLbl.translatesAutoresizingMaskIntoConstraints = false
        accountLbl.text = "Account Confirmation"
        accountLbl.textColor = UIColor.white
        accountLbl.textAlignment = .center
        accountLbl.font = UIFont(name: String.defaultFontB, size: 32)
        accountLbl.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 20).isActive = true
        accountLbl.topAnchor.constraint(equalTo: app_logo.bottomAnchor, constant: 10).isActive = true
        accountLbl.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -30).isActive = true
        accountLbl.numberOfLines = 0
        accountLbl.lineBreakMode = .byWordWrapping
        
        //activity description
        let actDesc = UILabel()
        scrollView.addSubview(actDesc)
        actDesc.translatesAutoresizingMaskIntoConstraints = false
        actDesc.textAlignment = .center
        actDesc.textColor = UIColor.white
        actDesc.text = "Kindly enter the activation pin sent to your phone below"
        actDesc.font = UIFont(name: String.defaultFontR, size: 22)
        actDesc.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 30).isActive = true
        actDesc.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -30).isActive = true
        actDesc.topAnchor.constraint(equalTo: accountLbl.bottomAnchor, constant: 10).isActive = true
        actDesc.numberOfLines = 0
        actDesc.lineBreakMode = .byWordWrapping
        
        // View to hold inputs
        let darkView = UIView()
        scrollView.addSubview(darkView)
        darkView.translatesAutoresizingMaskIntoConstraints = false
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.70)
        darkView.isOpaque = false
        darkView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        darkView.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 20).isActive = true
        darkView.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -20).isActive = true
        darkView.topAnchor.constraint(equalTo: actDesc.bottomAnchor, constant: 30).isActive = true
        
        //confirm pin
        let lblConfirmPin = UILabel()
        scrollView.addSubview(lblConfirmPin)
        lblConfirmPin.translatesAutoresizingMaskIntoConstraints = false
        lblConfirmPin.text = "Confirm Pin"
        lblConfirmPin.textColor = UIColor.white
        lblConfirmPin.font = UIFont(name: String.defaultFontR, size: 20)
        lblConfirmPin.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        lblConfirmPin.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 20).isActive = true
        
        //txt otp
        let txtOTP = UITextField()
        scrollView.addSubview(txtOTP)
        txtOTP.translatesAutoresizingMaskIntoConstraints = false
        txtOTP.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtOTP.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        txtOTP.topAnchor.constraint(equalTo: lblConfirmPin.bottomAnchor, constant: 20).isActive = true
        txtOTP.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        txtOTP.backgroundColor = UIColor.white
        txtOTP.borderStyle = .roundedRect
        txtOTP.textAlignment = .center
        txtOTP.font = UIFont(name: String.defaultFontR, size: 17)
        txtOTP.keyboardType = .numberPad
        
        //confirm
        let confirmButton = UIButton()
        scrollView.addSubview(confirmButton)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.backgroundColor = UIColor.grayButton
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        confirmButton.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        confirmButton.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        confirmButton.topAnchor.constraint(equalTo: txtOTP.bottomAnchor, constant: 30).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        //cancel
        let cancelButton = UIButton()
        scrollView.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.backgroundColor = UIColor.gray
        cancelButton.setTitle("Go Back", for: .normal)
        cancelButton.setTitleColor(UIColor.black, for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        cancelButton.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        cancelButton.topAnchor.constraint(equalTo: confirmButton.bottomAnchor, constant: 10).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        cancelButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        scrollView.contentSize.height = (view.frame.size.height + accountLbl.frame.size.height + actDesc.frame.size.height + darkView.frame.size.height + lblConfirmPin.frame.size.height + txtOTP.frame.size.height + confirmButton.frame.size.height + cancelButton.frame.size.height)
    }
    
    
    
    //Function to go back
    @objc func goBack(){
        
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController")
        present(moveTo!, animated: true, completion: nil)
    }

}
