//
//  toppingUpViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 04/07/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class toppingUpViewController: UIViewController {

    let preference = UserDefaults.standard
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var txtTopUpNumber: UITextField!
    @IBOutlet weak var txtScratchNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // change close btn colour.
        changeColour()
        //get default number and load
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        let defaultNumber = UserData["Contact"] as! String
        
        txtTopUpNumber.text = defaultNumber
        
        
        print("default::\(defaultNumber)")
    }
    @IBAction func closeTopu(_ sender: Any) {
        let gotToTup = storyboard?.instantiateViewController(withIdentifier: "TopUpViewController")
        present(gotToTup!, animated: true, completion: nil)
    }
    
    //Function to complete transaction
    @IBAction func topUp(_ sender: Any) {
        //hide keyboard
        txtTopUpNumber.resignFirstResponder()
        txtScratchNumber.resignFirstResponder()
        let numberTopUp = txtTopUpNumber.text
        let scratchNumber = txtScratchNumber.text
        
        if numberTopUp == ""{
            print("empty entry 1")
        }else {
            if scratchNumber == "" {
                print("empty entry 2")
            }else{
                print("good to go")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //change close btn colour
    func changeColour(){
        let close_image = UIImage(named: "new_close")
        let tintedImage = close_image?.withRenderingMode(.alwaysTemplate)
        btnClose.setImage(tintedImage, for: .normal)
        btnClose.tintColor = UIColor.white
        
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
