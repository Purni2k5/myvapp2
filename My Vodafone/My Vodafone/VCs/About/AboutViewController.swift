//
//  AboutViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 18/06/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class AboutViewController: baseViewControllerM {
    
    @IBOutlet weak var hamburger: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblCopyRight: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var menuTrailingConstraint: NSLayoutConstraint!
     
    @IBOutlet weak var lblVersion: UILabel!
    @IBOutlet weak var ic_home: UIImageView!
    @IBOutlet weak var ic_mobile: UIImageView!
    @IBOutlet weak var ic_ratings: UIImageView!
    @IBOutlet weak var ic_top_up: UIImageView!
    @IBOutlet weak var ic_roaming: UIImageView!
    @IBOutlet weak var ic_locator: UIImageView!
    @IBOutlet weak var ic_network: UIImageView!
    @IBOutlet weak var dropdown: UIButton!
    @IBOutlet weak var ic_mail: UIImageView!
    @IBOutlet weak var ic_profile: UIImageView!
    @IBOutlet weak var ic_settings: UIImageView!
    @IBOutlet weak var ic_info: UIImageView!
    @IBOutlet weak var ic_logout: UIImageView!
    @IBOutlet weak var speedChecker: UIButton!
    @IBOutlet weak var networkU: UIButton!
    @IBOutlet weak var bbf: UIButton!
    @IBOutlet weak var networkCov: UIButton!
    
    
    @IBOutlet weak var icMailTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnMessageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuViewHeightConstraint: NSLayoutConstraint!
    
    
    
    var dropDownShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentYear = getCurrYear()
        lblCopyRight.text = "\u{00A9} \(currentYear) Vodafone Ghana."
        lblVersion.text = "Version: \(onlyAppVersion())"
        
        // change hamburger colour.
        changeButtonColours()
        
        //code to change image colours
        self.perform(#selector(changeMenuIconsToWhite), with: nil, afterDelay: 0)
    }

    //change back button colour
    func changeButtonColours(){
        let menu_image = UIImage(named: "hamburger")
        let tintedImage = menu_image?.withRenderingMode(.alwaysTemplate)
        hamburger.setImage(tintedImage, for: .normal)
        hamburger.tintColor = UIColor.white
        
        let back_btn = UIImage(named: "leftArrow")
        let tintedImageB = back_btn?.withRenderingMode(.alwaysTemplate)
        btnBack.setImage(tintedImageB, for: .normal)
        btnBack.tintColor = UIColor.white
        
        let close_image = UIImage(named: "new_close")
        let tintedImageC = close_image?.withRenderingMode(.alwaysTemplate)
        btnClose.setImage(tintedImageC, for: .normal)
        btnClose.tintColor = UIColor.white
        
        let chevronDown = UIImage(named: "chevDown")
        let tintedImageArrow = chevronDown?.withRenderingMode(.alwaysTemplate)
        dropdown.setImage(tintedImageArrow, for: .normal)
        dropdown.tintColor = UIColor.white
    }
    
    
    //function to get current year
    func getCurrYear()-> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        let currYear = dateFormatter.string(from: now)
        print("current year: \(currYear)")
        return currYear
    }
    
    //change menu images to white colour
    @objc func changeMenuIconsToWhite(){
        hamburger.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        let templateImageHome = ic_home.image?.withRenderingMode(.alwaysTemplate)
        ic_home.image = templateImageHome
        ic_home.tintColor = UIColor.white
        
        let templateImageMobile = ic_mobile.image?.withRenderingMode(.alwaysTemplate)
        ic_mobile.image = templateImageMobile
        ic_mobile.tintColor = UIColor.white
        
        let templateImageRatings = ic_ratings.image?.withRenderingMode(.alwaysTemplate)
        ic_ratings.image = templateImageRatings
        ic_ratings.tintColor = UIColor.white
        
        let templateImageTopUP = ic_top_up.image?.withRenderingMode(.alwaysTemplate)
        ic_top_up.image = templateImageTopUP
        ic_top_up.tintColor = UIColor.white
        
        let templateImageRoaming = ic_roaming.image?.withRenderingMode(.alwaysTemplate)
        ic_roaming.image = templateImageRoaming
        ic_roaming.tintColor = UIColor.white
        
        
        
        let templateImageMap = ic_locator.image?.withRenderingMode(.alwaysTemplate)
        ic_locator.image = templateImageMap
        ic_locator.tintColor = UIColor.white
        
        let templateImageNetwork = ic_network.image?.withRenderingMode(.alwaysTemplate)
        ic_network.image = templateImageNetwork
        ic_network.tintColor = UIColor.white
        
        let templateImageMessage = ic_mail.image?.withRenderingMode(.alwaysTemplate)
        ic_mail.image = templateImageMessage
        ic_mail.tintColor = UIColor.white
        
        let templateImageProfile = ic_profile.image?.withRenderingMode(.alwaysTemplate)
        ic_profile.image = templateImageProfile
        ic_profile.tintColor = UIColor.white
        
        let templateImageSettings = ic_settings.image?.withRenderingMode(.alwaysTemplate)
        ic_settings.image = templateImageSettings
        ic_settings.tintColor = UIColor.white
        
        let templateImageAbout = ic_info.image?.withRenderingMode(.alwaysTemplate)
        ic_info.image = templateImageAbout
        ic_info.tintColor = UIColor.white
        
        let templateImageLogout = ic_logout.image?.withRenderingMode(.alwaysTemplate)
        ic_logout.image = templateImageLogout
        ic_logout.tintColor = UIColor.white
    }
    
    @IBAction func showNetworks(_ sender: Any) {
//        print("clicked")
        if(dropDownShowing){
            print(dropDownShowing)
            //show all hidden network pdts
            speedChecker.isHidden = true
            networkU.isHidden = true
            bbf.isHidden = true
            networkCov.isHidden = true
            
            //Change constants of menu items under network menu
            icMailTopConstraint.constant = 13
            btnMessageTopConstraint.constant = 16
            menuViewHeightConstraint.constant = 660
            
            //now change chevron up to chevron down
            let chevronDown = UIImage(named: "chevDown")
            let tintedImage = chevronDown?.withRenderingMode(.alwaysTemplate)
            dropdown.setImage(tintedImage, for: .normal)
            dropdown.tintColor = UIColor.white
            
        }else{
            //show all hidden network pdts
            speedChecker.isHidden = false
            networkU.isHidden = false
            bbf.isHidden = false
            networkCov.isHidden = false
            
            //Change constants of menu items under network menu
            icMailTopConstraint.constant = 140
            btnMessageTopConstraint.constant = 143
            menuViewHeightConstraint.constant = 780
            
            //now change chevron down to chevron up
            let chevronUp = UIImage(named: "chevron_up")
            let tintedImage = chevronUp?.withRenderingMode(.alwaysTemplate)
            dropdown.setImage(tintedImage, for: .normal)
            dropdown.tintColor = UIColor.white
        }
        dropDownShowing = !dropDownShowing
    }
    

}
