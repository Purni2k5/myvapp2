//
//  AddServiceViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 12/06/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class AddServiceViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var dropdown: UIPickerView!
    @IBOutlet weak var enterIDTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var serviceType: UITextField!
    @IBOutlet weak var chevDown: UIImageView!
    @IBOutlet weak var hamburger: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var menuTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var ic_home: UIImageView!
    @IBOutlet weak var ic_mobile: UIImageView!
    @IBOutlet weak var ic_ratings: UIImageView!
    @IBOutlet weak var ic_top_up: UIImageView!
    @IBOutlet weak var ic_travelling: UIImageView!
    @IBOutlet weak var ic_locator: UIImageView!
    @IBOutlet weak var ic_network: UIImageView!
    @IBOutlet weak var ic_message: UIImageView!
    @IBOutlet weak var ic_profile: UIImageView!
    @IBOutlet weak var ic_settings: UIImageView!
    @IBOutlet weak var ic_logout: UIImageView!
    
    @IBOutlet weak var ic_about: UIImageView!
    @IBOutlet weak var dropDown: UIButton!
    @IBOutlet weak var icMailTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnMessageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuViewHeightConstraint: NSLayoutConstraint!
    
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
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.serviceType.isHidden = false
        self.chevDown.isHidden = false
        self.dropdown.isHidden = true
        self.serviceType.text = self.list[row]
        
        enterIDTopConstraint.constant = 35
    }
    
    func textFieldDidBeginEditing(_ textfield: UITextField){
        
        
        
        if textfield == self.serviceType {
            self.dropdown.isHidden = false
            textfield.endEditing(true)
            
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //        print("try moving down")
        enterIDTopConstraint.constant = 100
        dropdown.isHidden = false
        //        serviceType.isHidden = true
        chevDown.isHidden = true
        return false
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = list[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.font: UIFont(name: "VodafoneRg-Regular", size: 16)!])
        pickerLabel.attributedText = myTitle
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 28.0
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
        let menu_image = UIImage(named: "hamburger")
        let tintedImage = menu_image?.withRenderingMode(.alwaysTemplate)
        hamburger.setImage(tintedImage, for: .normal)
        hamburger.tintColor = UIColor.white
        
        let close_image = UIImage(named: "new_close")
        let tintedImageC = close_image?.withRenderingMode(.alwaysTemplate)
        closeBtn.setImage(tintedImageC, for: .normal)
        closeBtn.tintColor = UIColor.white
    }
    //NB have also hooked up the close btn 
    @IBAction func showMenu(_ sender: Any) {
        if (menuShowing){
            menuTrailingConstraint.constant = -261
        }else{
            menuTrailingConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        menuShowing = !menuShowing
    }
    
    //change menu images to white colour
    @objc func changeMenuIconsToWhite(){
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
        
        let templateImageRoaming = ic_travelling.image?.withRenderingMode(.alwaysTemplate)
        ic_travelling.image = templateImageRoaming
        ic_travelling.tintColor = UIColor.white
        
       
        
        let templateImageMap = ic_locator.image?.withRenderingMode(.alwaysTemplate)
        ic_locator.image = templateImageMap
        ic_locator.tintColor = UIColor.white
        
        let templateImageNetwork = ic_network.image?.withRenderingMode(.alwaysTemplate)
        ic_network.image = templateImageNetwork
        ic_network.tintColor = UIColor.white
        
        let templateImageMessage = ic_message.image?.withRenderingMode(.alwaysTemplate)
        ic_message.image = templateImageMessage
        ic_message.tintColor = UIColor.white
        
        let templateImageProfile = ic_profile.image?.withRenderingMode(.alwaysTemplate)
        ic_profile.image = templateImageProfile
        ic_profile.tintColor = UIColor.white
        
        let templateImageSettings = ic_settings.image?.withRenderingMode(.alwaysTemplate)
        ic_settings.image = templateImageSettings
        ic_settings.tintColor = UIColor.white
        
        let templateImageAbout = ic_about.image?.withRenderingMode(.alwaysTemplate)
        ic_about.image = templateImageAbout
        ic_about.tintColor = UIColor.white
        
        let templateImageLogout = ic_logout.image?.withRenderingMode(.alwaysTemplate)
        ic_logout.image = templateImageLogout
        ic_logout.tintColor = UIColor.white
    }

}
