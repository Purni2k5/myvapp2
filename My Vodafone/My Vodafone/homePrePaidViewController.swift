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
    @IBOutlet weak var dropdown: UIButton!
    @IBOutlet weak var speedCheck: UIButton!
    @IBOutlet weak var networkU: UIButton!
    @IBOutlet weak var bbFinder: UIButton!
    @IBOutlet weak var networkCov: UIButton!
    
    @IBOutlet weak var ic_home: UIImageView!
    @IBOutlet weak var ic_mobile: UIImageView!
    @IBOutlet weak var ic_ratings: UIImageView!
    @IBOutlet weak var ic_top_up: UIImageView!
    @IBOutlet weak var ic_roaming: UIImageView!
    @IBOutlet weak var call_icon: UIImageView!
    @IBOutlet weak var ic_location_marker: UIImageView!
    @IBOutlet weak var ic_network: UIImageView!
    @IBOutlet weak var ic_mail: UIImageView!
    @IBOutlet weak var ic_profile: UIImageView!
    @IBOutlet weak var ic_settings: UIImageView!
    @IBOutlet weak var ic_info: UIImageView!
    @IBOutlet weak var ic_logout: UIImageView!
    
    
    @IBOutlet weak var icMailTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnMessageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuViewHeightConstraint: NSLayoutConstraint!
    
    var menuShowing = false
    var dropDownShowing = false
    
    let preference = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // change button colours.
        changeMenuBtnColour()
        //code to change image colours
        self.perform(#selector(changeImageColorToWhite), with: nil, afterDelay: 0)
        
        //get any user default value
        let food = ["Rice", "Yam", "Coffee"]
        let loginStat = preference.object(forKey: "loginStatus")
        let responseData = preference.object(forKey: "responseData")
        
        
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        preference.set(food, forKey: "food")
        let sell = preference.object(forKey: "food")
        let defaultService = UserData["DefaultService"] as! String
        
        let Services = preference.object(forKey: "ServiceList")
        if let array = Services as? NSArray {
            for obj in array {
                if let dict = obj as? NSDictionary {
                    // Now reference the data you need using:
                    let id = dict.value(forKey: "DisplayName")
                    let ServiceID = dict.value(forKey: "ID") as! String
                    let AcctType = dict.value(forKey: "Type") as! String
                    
                    if(ServiceID == defaultService){
                        if(AcctType == "PHONE_MOBILE_PRE_P"){
                            print("prepaid")
                        }else if(AcctType == "PHONE_MOBILE_POST_P"){
                            print("postpaid")
                        }else if(AcctType == "PHONE_MOBILE_HYBRID"){
                            print("hybrid")
                        }else{
                            print("fbb")
                        }
                    }
                }
            }
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*Function to change image colours to white*/
    @objc func changeImageColorToWhite() {
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
        
        let templateImageCalls = call_icon.image?.withRenderingMode(.alwaysTemplate)
        call_icon.image = templateImageCalls
        call_icon.tintColor = UIColor.white
        
        let templateImageMap = ic_location_marker.image?.withRenderingMode(.alwaysTemplate)
        ic_location_marker.image = templateImageMap
        ic_location_marker.tintColor = UIColor.white
        
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
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        menuShowing = !menuShowing
        hamburger.isHidden = false
    }
    
    
    @IBAction func showNetworks(_ sender: Any) {
        if(dropDownShowing){
            print(dropDownShowing)
            //show all hidden network pdts
            speedCheck.isHidden = true
            networkU.isHidden = true
            bbFinder.isHidden = true
            networkCov.isHidden = true
            
            //Change constants of menu items under network menu
            icMailTopConstraint.constant = 10
            btnMessageTopConstraint.constant = 16
            menuViewHeightConstraint.constant = 646
            
            //now change chevron down to chevron up
            let chevronDown = UIImage(named: "chevDown")
            let tintedImage = chevronDown?.withRenderingMode(.alwaysTemplate)
            dropdown.setImage(tintedImage, for: .normal)
            dropdown.tintColor = UIColor.white
            
        }else{
            //show all hidden network pdts
            speedCheck.isHidden = false
            networkU.isHidden = false
            bbFinder.isHidden = false
            networkCov.isHidden = false
            
            //Change constants of menu items under network menu
            icMailTopConstraint.constant = 126
            btnMessageTopConstraint.constant = 133
            menuViewHeightConstraint.constant = 735
            
            //now change chevron down to chevron up
            let chevronUp = UIImage(named: "chevron_up")
            let tintedImage = chevronUp?.withRenderingMode(.alwaysTemplate)
            dropdown.setImage(tintedImage, for: .normal)
            dropdown.tintColor = UIColor.white
        }
        dropDownShowing = !dropDownShowing
    }
    
    
    @IBAction func btnHomeAction(_ sender: Any) {
        //always set trailing constraint to -261 to close
        menuViewTrailingConstraint.constant = -261
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
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
        
        let btnDropDown = UIImage(named: "chevDown")
        let chevTinted = btnDropDown?.withRenderingMode(.alwaysTemplate)
        dropdown.setImage(chevTinted, for: .normal)
        dropdown.tintColor = UIColor.white
        
    }

}
