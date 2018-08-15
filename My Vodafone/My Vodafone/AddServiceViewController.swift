//
//  AddServiceViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 12/06/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class AddServiceViewController: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    
    
    
    
    var list = ["","Fixed Broadband", "Mobile"]
    var menuShowing = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // change button colour.
        changeBackColour()
        changeMenuIconColour()
        //code to change image colours
        self.perform(#selector(changeMenuIconsToWhite), with: nil, afterDelay: 0)
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
   
    

    
    // change back button colour
    func changeBackColour(){
        let back_image = UIImage(named: "leftArrow")
        let tintedImage = back_image?.withRenderingMode(.alwaysTemplate)
        btnBack.setImage(tintedImage, for: .normal)
        btnBack.tintColor = UIColor.white
    }
    //change menu button icon colour
    func changeMenuIconColour(){
        
    }
    //NB have also hooked up the close btn 
   
    
    //change menu images to white colour
    @objc func changeMenuIconsToWhite(){
       
    }

}
