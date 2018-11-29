//
//  itemisedBill.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 29/11/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class itemisedBill: baseViewControllerM {

    var parsedDate: String?
    var displayName: String?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground

        setUpViewsItemisedBill()
        checkConnection()
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
        cardView.heightAnchor.constraint(equalToConstant: 600).isActive = true
        print(view.frame.height)
        scrollView.contentSize.height = view.frame.height + 20 + 350
        
        
    }
    
    @objc func goToSinceLastBill(){
        let storyboard = UIStoryboard(name: "PostPaid", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "SinceLastBill")
        present(moveTo, animated: true, completion: nil)
    }

}
