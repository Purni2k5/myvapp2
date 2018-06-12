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
    
    var list = ["","Fixed Broadband", "Mobile"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // change button colour.
        changeBackColour()
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

}
