//
//  DisplayChosenOfferViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 25/07/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class DisplayChosenOfferViewController: UIViewController {

    @IBOutlet var superView: UIView!
    
    var selectedOffer: String?
    
    //create closure for top Image
    let appBackImage: UIImageView = {
        let topImage = UIImageView(image: #imageLiteral(resourceName: "bg2"))
        topImage.translatesAutoresizingMaskIntoConstraints = false
        topImage.contentMode = .scaleAspectFill
        return topImage
    }()
    
    //create closure for back button
    let viewButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(switchToController), for: .touchUpInside)
        return button
    }()
    
    //create closure for hamburger
    let hamburgerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //create closure for menu label
    let menuLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Menu"
        label.textColor = UIColor.white
        label.font = UIFont(name: String.defaultFontR, size: 12)
        return label
    }()
    
    //create closure for selected offer type
    let selectedOfferLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = UIFont(name: String.defaultFontB, size: 22)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Change view's background colour
        superView.backgroundColor = UIColor.grayBackground
        setUpViews()
        print("transfered:: \(selectedOffer)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setUpViews(){
        //top Image
        superView.addSubview(appBackImage)
        appBackImage.PinTopImage(view: self.view)
        
        //back button
        superView.addSubview(viewButton)
        let back_image = UIImage(named: "leftArrow")
        let tintedBackImage = back_image?.withRenderingMode(.alwaysTemplate)
        viewButton.setImage(tintedBackImage, for: .normal)
        viewButton.tintColor = UIColor.white
        viewButton.setImage(#imageLiteral(resourceName: "leftArrow"), for: .normal)
        viewButton.topAnchor.constraint(equalTo: appBackImage.topAnchor, constant: 20).isActive = true
        viewButton.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 8).isActive = true
        viewButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        viewButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        //hamburger
        superView.addSubview(hamburgerButton)
        let hamburger_image = UIImage(named: "hamburger")
        let tintHamImage = hamburger_image?.withRenderingMode(.alwaysTemplate)
        hamburgerButton.setImage(tintHamImage, for: .normal)
        hamburgerButton.tintColor = UIColor.white
        hamburgerButton.topAnchor.constraint(equalTo: appBackImage.topAnchor, constant: 20).isActive = true
        hamburgerButton.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -8).isActive = true
        hamburgerButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        hamburgerButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        //Menu Label
        superView.addSubview(menuLabel)
        menuLabel.topAnchor.constraint(equalTo: hamburgerButton.bottomAnchor, constant: -6).isActive = true
//        menuLabel.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 100).isActive = true
        menuLabel.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -15).isActive = true
        
        //Selected Offer type Label
        superView.addSubview(selectedOfferLabel)
        selectedOfferLabel.textAlignment = .center
        selectedOfferLabel.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 20).isActive = true
        selectedOfferLabel.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -20).isActive = true
        selectedOfferLabel.topAnchor.constraint(equalTo: superView.topAnchor, constant: 150).isActive = true
        selectedOfferLabel.text = selectedOffer
    }
    
    //Function to move back to offers view controller
    @objc func switchToController(){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "OffersExtrasViewController")
        present(moveTo!, animated: true, completion: nil)
    }

}

extension UIView {
    //for top image
    func PinTopImage(view: UIView){
        self.topAnchor.constraint(equalTo: (superview?.topAnchor)!, constant: 20).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *){
            print("yes 11")
        return safeAreaLayoutGuide.topAnchor
        }
        return topAnchor
    }
    
}
