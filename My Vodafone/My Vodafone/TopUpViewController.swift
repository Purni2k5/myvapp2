//
//  TopUpViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 01/07/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class TopUpViewController: baseViewControllerM {
    
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var goTopUp: CardView!
    @IBOutlet weak var bg2View: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // change image buttons colours
        changeBtnImageColour()
        
        //add gesture
        let gestureRec = UITapGestureRecognizer(target: self, action: #selector(self.showTopUp))
        goTopUp.addGestureRecognizer(gestureRec)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Function to change button image colours
    func changeBtnImageColour(){
        let btnImageBack = UIImage(named: "leftArrow")
        let tintedImage = btnImageBack?.withRenderingMode(.alwaysTemplate)
        btnBack.setImage(tintedImage, for: .normal)
        btnBack.tintColor = UIColor.white
        btnBack.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
        
        let btnMenu = UIButton()
        view.addSubview(btnMenu)
        btnMenu.translatesAutoresizingMaskIntoConstraints = false
        let menuImage = UIImage(named: "menu")
        btnMenu.setImage(menuImage, for: .normal)
        btnMenu.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnMenu.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnMenu.topAnchor.constraint(equalTo: bg2View.topAnchor, constant: 25).isActive = true
        btnMenu.trailingAnchor.constraint(equalTo: bg2View.trailingAnchor, constant: -10).isActive = true
        btnMenu.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        
        //Menu label
        let lblMenu = UILabel()
        view.addSubview(lblMenu)
        lblMenu.translatesAutoresizingMaskIntoConstraints = false
        lblMenu.textColor = UIColor.white
        lblMenu.text = "MENU"
        lblMenu.font = UIFont(name: String.defaultFontR, size: 13)
        lblMenu.topAnchor.constraint(equalTo: btnMenu.bottomAnchor, constant: -3).isActive = true
        lblMenu.trailingAnchor.constraint(equalTo: bg2View.trailingAnchor, constant: -14).isActive = true
    }
    
    @objc func showTopUp(_sender: UITapGestureRecognizer){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "toppingUpViewController")
//        present(moveTo!, animated: true, completion: nil)
        self.addChildViewController(moveTo!)
        moveTo!.view.frame = self.view.frame
        self.view.addSubview(moveTo!.view)
        moveTo!.didMove(toParentViewController: self)
    }
}
