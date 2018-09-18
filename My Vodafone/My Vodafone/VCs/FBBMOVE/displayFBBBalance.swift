//
//  displayFBBBalance.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 31/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class displayFBBBalance: UIViewController {
    
    var accNo: String?
    var phoneNo: String?
    var serviceNo: String?
    var status: String?
    var unusedData: String?
    var cashInAccount: String?
    var plan: String?
    //closure for scroll view
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //dark view
    let darkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.dark_background
        setUpVeiwsFBBBalance()
    }

    func setUpVeiwsFBBBalance(){
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.contentSize.height = 800
        
        view.addSubview(darkView)
        darkView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        darkView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        darkView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        darkView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        //close button
        let btnClose = UIButton()
        btnClose.translatesAutoresizingMaskIntoConstraints = false
        darkView.addSubview(btnClose)
        let closeImage = UIImage(named: "ic_close")
        btnClose.setImage(closeImage, for: .normal)
        btnClose.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnClose.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnClose.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 20).isActive = true
        btnClose.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -10).isActive = true
        btnClose.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        
        //Title
        let lblTitle = UILabel()
        darkView.addSubview(lblTitle)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.textColor = UIColor.white
        lblTitle.text = "Fixed Broadband"
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont(name: String.defaultFontR, size: 31)
        lblTitle.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        lblTitle.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 80).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: 20).isActive = true
        
        //Account details
        let lblAccNo = UILabel()
        scrollView.addSubview(lblAccNo)
        lblAccNo.translatesAutoresizingMaskIntoConstraints = false
        lblAccNo.textColor = UIColor.white
        lblAccNo.textAlignment = .center
        lblAccNo.font = UIFont(name: String.defaultFontR, size: 20)
        lblAccNo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        lblAccNo.topAnchor.constraint(equalTo: darkView.bottomAnchor, constant: 20).isActive = true
        lblAccNo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        lblAccNo.numberOfLines = 0
        lblAccNo.lineBreakMode = .byWordWrapping
        if let accNo = accNo{
            lblAccNo.text = "Account Number: \(accNo)"
        }
        
        
        let lblPhoneNo = UILabel()
        scrollView.addSubview(lblPhoneNo)
        lblPhoneNo.translatesAutoresizingMaskIntoConstraints = false
        lblPhoneNo.textColor = UIColor.white
        lblPhoneNo.textAlignment = .center
        lblPhoneNo.font = UIFont(name: String.defaultFontR, size: 20)
        lblPhoneNo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        lblPhoneNo.topAnchor.constraint(equalTo: lblAccNo.bottomAnchor, constant: 3).isActive = true
        lblPhoneNo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        lblPhoneNo.numberOfLines = 0
        lblPhoneNo.lineBreakMode = .byWordWrapping
        if let phoneNo = phoneNo{
            lblPhoneNo.text = "Phone Number: \(phoneNo)"
        }
        
        
        let lblServiceNo = UILabel()
        scrollView.addSubview(lblServiceNo)
        lblServiceNo.translatesAutoresizingMaskIntoConstraints = false
        lblServiceNo.textColor = UIColor.white
        lblServiceNo.textAlignment = .center
        lblServiceNo.font = UIFont(name: String.defaultFontR, size: 20)
        lblServiceNo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        lblServiceNo.topAnchor.constraint(equalTo: lblPhoneNo.bottomAnchor, constant: 3).isActive = true
        lblServiceNo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        lblServiceNo.numberOfLines = 0
        lblServiceNo.lineBreakMode = .byWordWrapping
        if let serviceNo = serviceNo{
            lblServiceNo.text = "Phone Number: \(serviceNo)"
        }
        
        
        let lblStatus = UILabel()
        scrollView.addSubview(lblStatus)
        lblStatus.translatesAutoresizingMaskIntoConstraints = false
        lblStatus.textColor = UIColor.white
        lblStatus.textAlignment = .center
        lblStatus.font = UIFont(name: String.defaultFontR, size: 20)
        lblStatus.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        lblStatus.topAnchor.constraint(equalTo: lblServiceNo.bottomAnchor, constant: 3).isActive = true
        lblStatus.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        lblStatus.numberOfLines = 0
        lblStatus.lineBreakMode = .byWordWrapping
        if let status = status{
            lblStatus.text = "Status: \(status)"
        }
        
        
        let lblUnsedData = UILabel()
        scrollView.addSubview(lblUnsedData)
        lblUnsedData.translatesAutoresizingMaskIntoConstraints = false
        lblUnsedData.textColor = UIColor.white
        lblUnsedData.textAlignment = .center
        lblUnsedData.font = UIFont(name: String.defaultFontR, size: 20)
        lblUnsedData.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        lblUnsedData.topAnchor.constraint(equalTo: lblStatus.bottomAnchor, constant: 3).isActive = true
        lblUnsedData.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        lblUnsedData.numberOfLines = 0
        lblUnsedData.lineBreakMode = .byWordWrapping
        if let unusedData = unusedData{
            lblUnsedData.text = "Unused Data: \(unusedData) GB"
        }
        
        
        let lblCashInAcc = UILabel()
        scrollView.addSubview(lblCashInAcc)
        lblCashInAcc.translatesAutoresizingMaskIntoConstraints = false
        lblCashInAcc.textColor = UIColor.white
        lblCashInAcc.textAlignment = .center
        lblCashInAcc.font = UIFont(name: String.defaultFontR, size: 20)
        lblCashInAcc.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        lblCashInAcc.topAnchor.constraint(equalTo: lblUnsedData.bottomAnchor, constant: 3).isActive = true
        lblCashInAcc.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        lblCashInAcc.numberOfLines = 0
        lblCashInAcc.lineBreakMode = .byWordWrapping
        
        if let cashInAccount = cashInAccount{
            lblCashInAcc.text = "Cash in Account: GHS \(cashInAccount)"
        }
        
        let lblPlan = UILabel()
        scrollView.addSubview(lblPlan)
        lblPlan.translatesAutoresizingMaskIntoConstraints = false
        lblPlan.textColor = UIColor.white
        lblPlan.textAlignment = .center
        lblPlan.font = UIFont(name: String.defaultFontR, size: 20)
        lblPlan.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        lblPlan.topAnchor.constraint(equalTo: lblCashInAcc.bottomAnchor, constant: 3).isActive = true
        lblPlan.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        lblPlan.numberOfLines = 0
        lblPlan.lineBreakMode = .byWordWrapping
        if let plan = plan{
            lblPlan.text = "Plan: \(plan)"
        }
        
        // cancel button
        let btnCancel = UIButton()
        scrollView.addSubview(btnCancel)
        btnCancel.translatesAutoresizingMaskIntoConstraints = false
        btnCancel.backgroundColor = UIColor.grayButton
        btnCancel.setTitle("Cancel", for: .normal)
        btnCancel.setTitleColor(UIColor.white, for: .normal)
        btnCancel.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnCancel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        btnCancel.topAnchor.constraint(equalTo: lblPlan.bottomAnchor, constant: 20).isActive = true
        btnCancel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        btnCancel.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnCancel.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func closeModal(){
        self.view.removeFromSuperview()
    }

}
