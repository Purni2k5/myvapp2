//
//  supportModalVc.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 20/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class supportModalVc: UIViewController {

    var supportSelected: String?
    var desc: String?
    var code: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.dark_background
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }

}
