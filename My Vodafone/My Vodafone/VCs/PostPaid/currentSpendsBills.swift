//
//  currentSpendsBills.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 09/11/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class currentSpendsBills: baseViewControllerM {
    
    var y_end: String?
    var y_interval: String?
    var y_unit: String?
    
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
        view.font = UIFont(name: String.defaultFontR, size: 14)
        return view
    }()
    
    let lblYInterval: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name: String.defaultFontR, size: 14)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground

        setUpViewsCurrSp()
        checkConnection()
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
        scrollView.contentSize.height = 1000
        
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
        
        let lblAverage = UILabel()
        darkView.addSubview(lblAverage)
        lblAverage.translatesAutoresizingMaskIntoConstraints = false
        lblAverage.text = "Your average spend in the last six months:"
        lblAverage.textColor = UIColor.white
        lblAverage.textAlignment = .center
        lblAverage.font = UIFont(name: String.defaultFontR, size: 18)
        lblAverage.numberOfLines = 0
        lblAverage.lineBreakMode = .byWordWrapping
        lblAverage.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 50).isActive = true
        lblAverage.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 20).isActive = true
        lblAverage.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -50).isActive = true
        
        darkView.addSubview(lblYEnd)
        
        
    }
    @objc func goToPostHome(){
        let storyboard = UIStoryboard(name: "PostPaid", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "postPaidHome")
        present(moveTo, animated: true, completion: nil)
    }

}
