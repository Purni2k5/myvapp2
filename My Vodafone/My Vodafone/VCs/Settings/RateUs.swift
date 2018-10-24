//
//  RateUs.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 23/10/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class RateUs: baseViewControllerM {

    //create closure for close button
    let close_button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let lblRateUs: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.textAlignment = .center
        view.font = UIFont(name: String.defaultFontR, size: 24)
        return view
    }()
    
    let lblRateUsDesc: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.textAlignment = .center
        view.font = UIFont(name: String.defaultFontR, size: 20)
        return view
    }()
    
    let btnOk: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.vodaRed
        view.setTitle("OK", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont(name: String.defaultFontR, size: 20)
        return view
    }()
    
    let btnLater: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray
        view.setTitle("MAYBE LATER", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont(name: String.defaultFontR, size: 20)
        return view
    }()
    
    var stackViewBtns = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.80)

        setUpViewsRateUs()
        
    }
    
    func setUpViewsRateUs(){
        //Close button
        view.addSubview(close_button)
        let close_image = UIImage(named: "ic_close")
        close_button.setImage(close_image, for: .normal)
        close_button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        close_button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        close_button.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 10).isActive = true
        close_button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        close_button.addTarget(self, action: #selector(closeModalB), for: .touchUpInside)
        
        view.addSubview(lblRateUs)
        lblRateUs.text = "Rate Us"
        lblRateUs.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        lblRateUs.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(lblRateUsDesc)
        lblRateUsDesc.text = "Enjoyed using the app? \n Rate us and let us have your comment and recommendations"
        lblRateUsDesc.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        lblRateUsDesc.topAnchor.constraint(equalTo: lblRateUs.bottomAnchor, constant: 30).isActive = true
        lblRateUsDesc.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        lblRateUsDesc.numberOfLines = 0
        lblRateUsDesc.lineBreakMode = .byWordWrapping
        
        view.addSubview(btnOk)
//        btnOk.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
//        btnOk.topAnchor.constraint(equalTo: lblRateUsDesc.bottomAnchor, constant: 40).isActive = true
//        btnOk.widthAnchor.constraint(equalToConstant: 150).isActive = true
        btnOk.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnOk.addTarget(self, action: #selector(openAppStore), for: .touchUpInside)
        
        view.addSubview(btnLater)
//        btnLater.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
//        btnLater.topAnchor.constraint(equalTo: lblRateUsDesc.bottomAnchor, constant: 40).isActive = true
//        btnLater.widthAnchor.constraint(equalToConstant: 150).isActive = true
        btnLater.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnLater.addTarget(self, action: #selector(closeModalB), for: .touchUpInside)
        
        stackViewBtns = UIStackView(arrangedSubviews: [btnOk, btnLater])
        stackViewBtns.translatesAutoresizingMaskIntoConstraints = false
        stackViewBtns.axis = .horizontal
        stackViewBtns.spacing = 20
        stackViewBtns.distribution = .fillEqually
        view.addSubview(stackViewBtns)
        stackViewBtns.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackViewBtns.topAnchor.constraint(equalTo: lblRateUsDesc.bottomAnchor, constant: 40).isActive = true
        stackViewBtns.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }

}
