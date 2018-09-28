//
//  ViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 07/06/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webViewDataPermission: WKWebView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnOk: UIButton!
    
    let preference = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let appDomain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
        //Setting user data and preferences
        
        for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }*/
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        if preference.object(forKey: "firstTime") == nil {
            print("It is empty")
            let appDomain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: appDomain) 
            // load web content locally
            let url = Bundle.main.url(forResource: "data_permissions", withExtension: "html")
            webViewDataPermission.load(URLRequest(url: url!))
        }else{
            //if it is not empty check if it is false
            let firstTimeStatus:String = preference.object(forKey: "firstTime") as! String
//            let loginStatus: String = preference.object(forKey: "loginStatus") as! String
            print("first time: \(firstTimeStatus)")
            if firstTimeStatus == "No"{
                //check if login key exist
                if preference.object(forKey: "loginStatus") !=  nil {
                    let loginStatus: String = preference.object(forKey: "loginStatus") as! String
                    //if loginStatus exist check if it is yes take user to preferred home screen
                    print("is login: \(loginStatus)")
                    if loginStatus == "Yes" {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let moveTo = storyboard.instantiateViewController(withIdentifier: "homeVC")
                        present(moveTo, animated: true, completion: nil)
                    }else{
                        //if it is no move to login screen
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let moveTo = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                        present(moveTo, animated: true, completion: nil)
                    }
                }else{
                    //if login object is nil
                    print("login is nil")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let moveTo = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                    present(moveTo, animated: true, completion: nil)
                }
                
            }else{
                // if first time is yes
                let moveTo = storyboard?.instantiateViewController(withIdentifier: "ViewController")
                present(moveTo!, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func btnOkAction(_ sender: Any) {
        //set first time usage to false and some default user defaults
        preference.set("No", forKey: "firstTime")
        preference.set(true, forKey: UserDefaultsKeys.notificationEnabled.rawValue)
        preference.set(true, forKey: UserDefaultsKeys.privacyEnabled.rawValue)
        preference.set(true, forKey: UserDefaultsKeys.privateDataEnabled.rawValue)
        
//        preference.synchronize()
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        present(moveTo!, animated: true, completion: nil)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

