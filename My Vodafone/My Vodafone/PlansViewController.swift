//
//  PlansViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 04/07/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class PlansViewController: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var hamburger: UIButton!
    @IBOutlet weak var oneGH: UIImageView!
    @IBOutlet weak var twoGH: UIImageView!
    @IBOutlet weak var dblValueMonth: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Change btns Colour
        changeColourToWhite()
        //MAKE IMAGES ROUND
        makeImageRound(image: oneGH)
        makeImageRound(image: twoGH)
        makeImageRound(image: dblValueMonth)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Change imgae buttons colour to white
    func changeColourToWhite(){
        let back_image = UIImage(named: "leftArrow")
        let tintedBack = back_image?.withRenderingMode(.alwaysTemplate)
        btnBack.setImage(tintedBack, for: .normal)
        btnBack.tintColor = UIColor.white
        
        let menu_image = UIImage(named: "hamburger")
        let tintedMenu = menu_image?.withRenderingMode(.alwaysTemplate)
        hamburger.setImage(tintedMenu, for: .normal)
        hamburger.tintColor = UIColor.white
    }
    
    //Function to make images round
    func makeImageRound(image:UIImageView){
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
        //        image.layer.borderWidth = 2
    }
}
