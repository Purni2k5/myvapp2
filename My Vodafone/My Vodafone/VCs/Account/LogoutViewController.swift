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

    
    @IBAction func btnYes(_ sender: Any) {
        preference.removeObject(forKey: UserDefaultsKeys.loginStatus.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.responseData.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.staffNumber.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.staffCreditData.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.Plan.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.Data.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.defaultMSISDN.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.RESPONSEMESSAGE.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.FBBLINKEDNUMBER.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.FBBACTKEY.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.FBBUSERID.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.BBPACKAGES.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.FBBUSERACCOUNT.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.DefaultService.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.accountBalance.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.accBalanceLabel.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.balanceLabel.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.ROAMINGS.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.ServiceList.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.userSubscriberSummary.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.isGaugeVisible.rawValue)
        preference.removeObject(forKey: UserDefaultsKeys.lastUpdate.rawValue)
        
        let Services = preference.object(forKey: UserDefaultsKeys.ServiceList.rawValue)
        if let array = Services as? NSArray {
            for obj in array {
                if let dict = obj as? NSDictionary {
                    
                    let displayNumber = dict.value(forKey: "primaryID") as! String
                    let userNumber = displayNumber.dropFirst(3)
                    let firstPin = "0\(userNumber)"
                    preference.removeObject(forKey: "\(firstPin)_topUpHistory")
                    preference.removeObject(forKey: "\(firstPin)_serviceBreakDown")
                }
            }
        }
        
        preference.removeObject(forKey: UserDefaultsKeys.ServiceList.rawValue)
        
        
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
