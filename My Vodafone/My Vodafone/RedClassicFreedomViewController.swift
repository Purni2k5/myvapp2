//
//  RedClassicFreedomViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 10/07/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class RedClassicFreedomViewController: UIViewController {
    let preferences = UserDefaults.standard
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var txtTopUpNumber: UITextField!
    
    var defaultNumber: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        changeClose()
        let number = getDefaultNumber()
        txtTopUpNumber.text = number
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Change close btn colour
    func changeClose(){
        let close_image = UIImage(named: "new_close")
        let tintedImage = close_image?.withRenderingMode(.alwaysTemplate)
        btnClose.setImage(tintedImage, for: .normal)
        btnClose.tintColor = UIColor.white
    }
    
    //Function to get default number
    func getDefaultNumber()-> String{
        let userData = preferences.object(forKey: "responseData") as! NSDictionary
        defaultNumber = userData["Contact"] as? String
        return defaultNumber!
    }

}
