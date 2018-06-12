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
    override func viewDidLoad() {
        super.viewDidLoad()
        // load web content locally
        let url = Bundle.main.url(forResource: "data_permissions", withExtension: "html")
        webViewDataPermission.load(URLRequest(url: url!))
        
        /*for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

