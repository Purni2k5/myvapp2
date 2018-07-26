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
//        label.font = UIFont
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Change view's background colour
        superView.backgroundColor = UIColor.grayBackground
        setUpViews()
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
