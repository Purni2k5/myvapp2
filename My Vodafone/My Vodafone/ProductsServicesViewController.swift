//
//  ProductsServicesViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 12/06/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class ProductsServicesViewController: UIViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var addService: CardView!
    @IBOutlet weak var userPdts: CardView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Change the back button colour.
        let backButton = UIImage(named: "leftArrow")
        let tintedImage = backButton?.withRenderingMode(.alwaysTemplate)
        btnBack.setImage(tintedImage, for: .normal)
        btnBack.tintColor = UIColor.white
        
        //add gesture
        let gestureRec = UITapGestureRecognizer(target: self, action: #selector(self.goToAddServices))
        addService.addGestureRecognizer(gestureRec)
        
        let gestureRec2 = UITapGestureRecognizer(target: self, action: #selector(self.goToUserPdts))
        userPdts.addGestureRecognizer(gestureRec2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func goToAddServices(_sender: UITapGestureRecognizer){
        //        print("You just clicked")
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "AddServiceViewController")
        present(moveTo!, animated: true, completion: nil)
        
    }
    
    @objc func goToUserPdts(_sender: UITapGestureRecognizer){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "UserProductsViewController")
        present(moveTo!, animated: true, completion: nil)
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
