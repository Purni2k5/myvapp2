//
//  OffersExtrasViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 29/06/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class OffersExtrasViewController: UIViewController {
    
    @IBOutlet weak var lblOffersHeader: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var hamburger: UIButton!
    
    @IBOutlet weak var menuViewTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var cardRoundImages: UIImageView!
    @IBOutlet weak var imgDataBundle: UIImageView!
    @IBOutlet weak var imgVFX: UIImageView!
    @IBOutlet weak var imgIDDBundles: UIImageView!
    @IBOutlet weak var imgSettings: UIImageView!
    @IBOutlet weak var imgVCash: UIImageView!
    @IBOutlet weak var imgFBB: UIImageView!
    
    var menuShowing = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // change header.
        changeHeader()
        //close button colour
        changeCloseBtnColour()
        
        //make card images round
        makeImageRound(image: cardRoundImages)
        makeImageRound(image: imgDataBundle)
        makeImageRound(image: imgVFX)
        makeImageRound(image: imgIDDBundles)
        makeImageRound(image: imgVCash)
        makeImageRound(image: imgVCash)
        makeImageRound(image: imgFBB)
        makeImageRound(image: imgSettings)
        
        //change images to white
        changeImageToWhite()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //show menu
    @IBAction func showMenu(_ sender: Any) {
        if (menuShowing){
            menuViewTrailingConstraint.constant = -261
        }else{
            menuViewTrailingConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            })
        menuShowing = !menuShowing
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //Function to change header text
    func changeHeader(){
        lblOffersHeader.text = "Offers and Extras \nfor you"
    }
    //Function to change close btn colour
    func changeCloseBtnColour(){
        let close_image = UIImage(named: "new_close")
        let tintedImage = close_image?.withRenderingMode(.alwaysTemplate)
        btnClose.setImage(tintedImage, for: .normal)
        btnClose.tintColor = UIColor.white
        
        let back_image = UIImage(named: "leftArrow")
        let tintedImageB = back_image?.withRenderingMode(.alwaysTemplate)
        btnBack.setImage(tintedImageB, for: .normal)
        btnBack.tintColor = UIColor.white
        
        let btnMenu = UIImage(named: "hamburger")
        let tintedImageH = btnMenu?.withRenderingMode(.alwaysTemplate)
        hamburger.setImage(tintedImageH, for: .normal)
        hamburger.tintColor = UIColor.white
        
        
    }
    
    //Function to make images round
    func makeImageRound(image:UIImageView){
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
//        image.layer.borderWidth = 2
    }
    
    //Function to change images to white
    @objc func changeImageToWhite(){
        let vfX = imgVFX.image?.withRenderingMode(.alwaysTemplate)
        imgVFX.image = vfX
        imgVFX.tintColor = UIColor.white
        
        let iddBundles = imgIDDBundles.image?.withRenderingMode(.alwaysTemplate)
        imgIDDBundles.image = iddBundles
        imgIDDBundles.tintColor = UIColor.white
        
        let vfcash = imgVCash.image?.withRenderingMode(.alwaysTemplate)
        imgVCash.image = vfcash
        imgVCash.tintColor = UIColor.white
        
        let ffB = imgFBB.image?.withRenderingMode(.alwaysTemplate)
        imgFBB.image = ffB
        imgFBB.tintColor = UIColor.white
        
        let settings = imgSettings.image?.withRenderingMode(.alwaysTemplate)
        imgSettings.image = settings
        imgSettings.tintColor = UIColor.white
    }
}
