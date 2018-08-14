//
//  TopUpViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 01/07/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class TopUpViewController: UIViewController {
    
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var hamburger: UIButton!
    @IBOutlet weak var goTopUp: CardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // change image buttons colours
        changeBtnImageColour()
        
        //add gesture
        let gestureRec = UITapGestureRecognizer(target: self, action: #selector(self.showTopUp))
        goTopUp.addGestureRecognizer(gestureRec)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Function to change button image colours
    func changeBtnImageColour(){
        let btnImageBack = UIImage(named: "leftArrow")
        let tintedImage = btnImageBack?.withRenderingMode(.alwaysTemplate)
        btnBack.setImage(tintedImage, for: .normal)
        btnBack.tintColor = UIColor.white
        
        let btnMenu = UIImage(named: "hamburger")
        let tintedImageH = btnMenu?.withRenderingMode(.alwaysTemplate)
        hamburger.setImage(tintedImageH, for: .normal)
        hamburger.tintColor = UIColor.white
    }
    
    @objc func showTopUp(_sender: UITapGestureRecognizer){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "toppingUpViewController")
//        present(moveTo!, animated: true, completion: nil)
        self.addChildViewController(moveTo!)
        moveTo!.view.frame = self.view.frame
        self.view.addSubview(moveTo!.view)
        moveTo!.didMove(toParentViewController: self)
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
