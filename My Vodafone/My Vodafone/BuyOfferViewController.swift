//
//  BuyOfferViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 03/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class BuyOfferViewController: UIViewController {
    
    var selectedOffer: String = ""
    var selectedOfferPrice: String = ""
    var selectedOfferDesc: String = ""
    
    //create a closure for scroll view
    let vcScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.dark_background
        scrollView.contentSize.height = 1500
        return scrollView
    }()
    
    //create closure for dark view
    let darkView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //create a closure for close button
    let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //create a closre for offer label
    let offerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationCapturesStatusBarAppearance = true
        
        view.addSubview(vcScrollView)
        setUpViews()

        // Do any additional setup after loading the view.
        print(selectedOfferDesc)
        print(selectedOfferPrice)
        print(selectedOffer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpViews(){
        //scrollView
        vcScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        vcScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        vcScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        vcScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //Dark view
        vcScrollView.addSubview(darkView)
        darkView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        darkView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        darkView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        darkView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        //Close button
        darkView.addSubview(closeButton)
        let close_image = UIImage(named: "ic_close")
        closeButton.setImage(close_image, for: .normal)
        closeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -10).isActive = true
        closeButton.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 10).isActive = true
        closeButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        
        //Offer Label
        darkView.addSubview(offerLabel)
        offerLabel.text = selectedOffer
        offerLabel.font = UIFont(name: String.defaultFontR, size: 22)
        offerLabel.textAlignment = .center
        offerLabel.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 95).isActive = true
        offerLabel.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        offerLabel.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
    }
    

    //Function to close modal
    @objc func closeModal(){
        self.view.removeFromSuperview()
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }
}
