//
//  OneGHPlanViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 05/07/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class OneGHPlanViewController: UIViewController {

    @IBOutlet weak var btnClose: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // change btn colour
        changeCloseColour()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //change close btn colour
    func changeCloseColour(){
        let close_image = UIImage(named: "new_close")
        let tintedImage = close_image?.withRenderingMode(.alwaysTemplate)
        btnClose.setImage(tintedImage, for: .normal)
        btnClose.tintColor = UIColor.white
    }
    
    @IBAction func closeView(_ sender: Any) {
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "PlansViewController")
        present(moveTo!, animated: true, completion: nil)
    }
    
}
