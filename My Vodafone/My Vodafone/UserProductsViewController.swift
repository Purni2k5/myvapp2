//
//  UserProductsViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 12/06/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class UserProductsViewController: UIViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var userProfile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // make image round.
        makePicRound(image: userProfile)
        
        //change button colour
        changeBtnImageColour()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*Funtion to change button image colour*/
    func changeBtnImageColour() {
        let back_image = UIImage(named: "leftArrow")
        let tintedImage = back_image?.withRenderingMode(.alwaysTemplate)
        btnBack.setImage(tintedImage, for: .normal)
        btnBack.tintColor = UIColor.white
    }
    
    
    
    /*
     Function to make profile pic round
     */
    func makePicRound(image:UIImageView) {
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.white.cgColor
    }

}
