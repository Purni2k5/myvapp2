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
    @IBOutlet weak var redClassic: UIImageView!
    @IBOutlet weak var redClassicFreedom: UIImageView!
    @IBOutlet weak var redHotData: UIImageView!
    @IBOutlet weak var redHotFreedom: UIImageView!
    @IBOutlet weak var redHotVoice: UIImageView!
    @IBOutlet weak var redRushData: UIImageView!
    @IBOutlet weak var redRushFreedom: UIImageView!
    @IBOutlet weak var redRushVoice: UIImageView!
    @IBOutlet weak var redSuperData: UIImageView!
    @IBOutlet weak var redSuperFreedom: UIImageView!
    @IBOutlet weak var redSuperVoice: UIImageView!
    @IBOutlet weak var redLifeWeekly: UIImageView!
    @IBOutlet weak var supremeValueMonthly: UIImageView!
    @IBOutlet weak var vodafoneVIM: UIImageView!
    @IBOutlet weak var welcomePack: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Change btns Colour
        changeColourToWhite()
        //MAKE IMAGES ROUND
        makeImageRound(image: oneGH)
        makeImageRound(image: twoGH)
        makeImageRound(image: dblValueMonth)
        makeImageRound(image: redClassic)
        makeImageRound(image: redClassicFreedom)
        makeImageRound(image: redHotData)
        makeImageRound(image: redHotFreedom)
        makeImageRound(image: redHotVoice)
        makeImageRound(image: redRushData)
        makeImageRound(image: redRushFreedom)
        makeImageRound(image: redRushVoice)
        makeImageRound(image: redSuperData)
        makeImageRound(image: redSuperFreedom)
        makeImageRound(image: redSuperVoice)
        makeImageRound(image: redLifeWeekly)
        makeImageRound(image: supremeValueMonthly)
        makeImageRound(image: vodafoneVIM)
        makeImageRound(image: welcomePack)
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
