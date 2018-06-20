//
//  SettingsViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 19/06/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnMenu: UIButton!
    
    @IBOutlet weak var termsCard: CardView!
    @IBOutlet weak var privacyCard: CardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // change image buttons colour.
        changeBtnColours()
        
        let goGestureTerms = UITapGestureRecognizer(target: self, action: #selector(self.goToTerms))
        termsCard.addGestureRecognizer(goGestureTerms)
        
        let goGesturePolicy = UITapGestureRecognizer(target: self, action: #selector(self.goToPrivacy))
        privacyCard.addGestureRecognizer(goGesturePolicy)
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
    
    //Function to change btns to white
    func changeBtnColours(){
        let back_image = UIImage(named: "leftArrow")
        let tintedImageB = back_image?.withRenderingMode(.alwaysTemplate)
        btnBack.setImage(tintedImageB, for: .normal)
        btnBack.tintColor = UIColor.white
        
        let hamburger_image = UIImage(named: "hamburger")
        let tintedImageH = hamburger_image?.withRenderingMode(.alwaysTemplate)
        btnMenu.setImage(tintedImageH, for: .normal)
        btnMenu.tintColor = UIColor.white
    }
    
    @objc func goToTerms(_sender: UITapGestureRecognizer){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "TermsConditionsViewController")
        present(moveTo!, animated: true, completion: nil)
    }
    
    @objc func goToPrivacy(_sender: UITapGestureRecognizer){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyViewController")
        present(moveTo!, animated: true, completion: nil)
    }

}
