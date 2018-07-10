//
//  TwoGHViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 10/07/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class TwoGHViewController: UIViewController {
    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var txtTopUpNumber: UITextField!
    
    var defaultNumber:String?
    let preferences = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()

        //change close colour
        changeClose()
        //get default number
        let number = getDefaultNumber()
        txtTopUpNumber.text = number
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
        print("My num:: \(defaultNumber!)")
        return defaultNumber!
    }

}
