//
//  LogoutViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 19/06/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class LogoutViewController: UIViewController {
    @IBOutlet weak var btnClose: UIButton!
    let preference = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Change close button colour.
        let close_image = UIImage(named: "new_close")
        let tintedImage = close_image?.withRenderingMode(.alwaysTemplate)
        btnClose.setImage(tintedImage, for: .normal)
        btnClose.tintColor = UIColor.white
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
    
    @IBAction func btnYes(_ sender: Any) {
        preference.removeObject(forKey: "loginStatus")
        preference.removeObject(forKey: "responseData")
        preference.removeObject(forKey: "Plan")
        preference.removeObject(forKey: "Data")
        preference.removeObject(forKey: "RESPONSEMESSAGE")
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        present(moveTo!, animated: true, completion: nil)
    }
    
    @IBAction func closeModal(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
}
