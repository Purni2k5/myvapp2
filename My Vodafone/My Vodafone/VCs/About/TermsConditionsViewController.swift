//
//  TermsConditionsViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 18/06/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit
import WebKit

class TermsConditionsViewController: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var termsWebViewKit: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = Bundle.main.url(forResource: "terms_and_conditions", withExtension: "html")
        termsWebViewKit.load(URLRequest(url: url!))
        
        changeButtonColour()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func changeButtonColour(){
        let btn_image = UIImage(named: "leftArrow")
        let tintedImage = btn_image?.withRenderingMode(.alwaysTemplate)
        btnBack.setImage(tintedImage, for: .normal)
        btnBack.tintColor = UIColor.white
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
