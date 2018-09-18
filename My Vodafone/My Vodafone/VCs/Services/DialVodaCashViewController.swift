//
//  DialVodaCashViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 01/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class DialVodaCashViewController: UIViewController {
    
    //create closure for dark view
    let darkView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        
        return view
    }()
    
    //create closure for close button
    let button: UIButton = {
        let button = UIButton()
        return button
    }()
    
    //create closure for labels
    let appLabels: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationCapturesStatusBarAppearance = true

        // setup views
        setUpViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Function to set up views
    func setUpViews(){
        //dark view
        view.addSubview(darkView)
        darkView.translatesAutoresizingMaskIntoConstraints = false
        darkView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        darkView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        darkView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        darkView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        //close button
        let closeButton = button
        darkView.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        let close_image = UIImage(named: "ic_close")
        closeButton.setImage(close_image, for: .normal)
        closeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 10).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -10).isActive = true
        closeButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        
        //Label header
        let vodaHeader = appLabels
        darkView.addSubview(vodaHeader)
        vodaHeader.text = "Vodafone Cash"
        vodaHeader.font = UIFont(name: String.defaultFontR, size: 29)
        vodaHeader.textAlignment = .center
        vodaHeader.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 95).isActive = true
        vodaHeader.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        vodaHeader.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        
        //Description label
        let descLabel = UILabel()
        view.addSubview(descLabel)
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.text = "This will call *110#"
        descLabel.textAlignment = .center
        descLabel.textColor = UIColor.white
        descLabel.font = UIFont(name: String.defaultFontR, size: 20)
        descLabel.topAnchor.constraint(equalTo: darkView.bottomAnchor, constant: 40).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        descLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        //Continue button
        let contButton = UIButton()
        view.addSubview(contButton)
        contButton.translatesAutoresizingMaskIntoConstraints = false
        contButton.setTitle("Continue", for: .normal)
        contButton.setTitleColor(UIColor.white, for: .normal)
        contButton.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        contButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        contButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        contButton.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 30).isActive = true
        contButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        contButton.backgroundColor = UIColor.red
        contButton.addTarget(self, action: #selector(dialUSSD), for: .touchUpInside)
        
        //Continue button
        let cancelButton = UIButton()
        view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor.white, for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        cancelButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        cancelButton.topAnchor.constraint(equalTo: contButton.bottomAnchor, constant: 20).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        cancelButton.backgroundColor = UIColor.grayButton
        cancelButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        
    }
    
    //Function to close modal
    @objc func closeModal(){
        self.view.removeFromSuperview()
    }
    
    //Function make USSD call
    @objc func dialUSSD(){
        let ussdCode = "*110#"
        let url = URL(string: "telprompt://\(ussdCode)")
        UIApplication.shared.open(url!)
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    

}


