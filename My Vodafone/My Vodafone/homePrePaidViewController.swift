//
//  homePrePaidViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 11/06/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class homePrePaidViewController: UIViewController {
    
    @IBOutlet weak var menuViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var hamburger: UIButton!
    @IBOutlet weak var ic_close: UIButton!
    
    var menuShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // change button colours.
        changeMenuBtnColour()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func showMenu(_ sender: Any) {
        if(menuShowing){
            menuViewTrailingConstraint.constant = -261
        }else{
            menuViewTrailingConstraint.constant = 0
            hamburger.isHidden = true
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        menuShowing = !menuShowing
        
    }
    
   
    @IBAction func closeMenu(_ sender: Any) {
        //always set trailing constraint to -261 to close
        menuViewTrailingConstraint.constant = -261
        menuShowing = !menuShowing
        hamburger.isHidden = false
    }
    
    //set menu btn to white colour
    func changeMenuBtnColour(){
        let btnMenu = UIImage(named: "hamburger")
        let tintedImage = btnMenu?.withRenderingMode(.alwaysTemplate)
        hamburger.setImage(tintedImage, for: .normal)
        hamburger.tintColor = UIColor.white
        
        let btnClose = UIImage(named: "new_close")
        let closeTinted = btnClose?.withRenderingMode(.alwaysTemplate)
        ic_close.setImage(closeTinted, for: .normal)
        ic_close.tintColor = UIColor.white
        
    }

}
