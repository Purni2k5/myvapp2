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
    
    //Offers UIVIEWS
    @IBOutlet weak var planCard: CardView!
    @IBOutlet weak var dataBundlesCard: CardView!
    @IBOutlet weak var vodafoneXCard: CardView!
    @IBOutlet weak var IDDBundlesCard: CardView!
    @IBOutlet weak var vodafoneCash: CardView!
    @IBOutlet weak var fixedBBCard: CardView!
    @IBOutlet weak var servicesCard: CardView!
    @IBOutlet weak var planDesc: UITextView!
    
    
    
    
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
        //Call gestures on all cards
        addGesturesToCards()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //show menu
    @IBAction func showMenu(_ sender: Any) {
        if (menuShowing){
            menuViewTrailingConstraint.constant = -280
        }else{
            menuViewTrailingConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            })
        menuShowing = !menuShowing
    }
    
    

    //Function to change header text
    func changeHeader(){
        lblOffersHeader.text = "Offers and Extras \nfor you"
        lblOffersHeader.numberOfLines = 0
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
    //Function to add gestures to all offers
    func addGesturesToCards(){
        let planRec = UITapGestureRecognizer(target: self, action: #selector(self.goToPlans))
        planCard.addGestureRecognizer(planRec)
        
        let dataBundlesRec = UITapGestureRecognizer(target: self, action: #selector(self.goToDataBundles))
        dataBundlesCard.addGestureRecognizer(dataBundlesRec)
        
        let vodafoneXRec = UITapGestureRecognizer(target: self, action: #selector(self.goToVodafoneX))
        vodafoneXCard.addGestureRecognizer(vodafoneXRec)
        
        let iddBundlesRec = UITapGestureRecognizer(target: self, action: #selector(self.goToIDDBundles))
        IDDBundlesCard.addGestureRecognizer(iddBundlesRec)
        
        let vodafoneCashRec = UITapGestureRecognizer(target: self, action: #selector(self.goToVodafoneCash))
        vodafoneCash.addGestureRecognizer(vodafoneCashRec)
        
        let fbbRec = UITapGestureRecognizer(target: self, action: #selector(self.goToFBB))
        fixedBBCard.addGestureRecognizer(fbbRec)
        
        let servicesRec = UITapGestureRecognizer(target: self, action: #selector(self.goToServices))
        servicesCard.addGestureRecognizer(servicesRec)
    }
    
    
    //Function to go to plans view controller
    @objc func goToPlans(_sender: UITapGestureRecognizer){
        guard let moveTo = storyboard?.instantiateViewController(withIdentifier: "DisplayChosenOfferViewController") as? DisplayChosenOfferViewController else {return}
        moveTo.selectedOffer = "Plan"
//        let moveTo = storyboard?.instantiateViewController(withIdentifier: "DisplayChosenOfferViewController")
        present(moveTo, animated: true, completion: nil)
    }
    
    //Function to go to data bundles controller
    @objc func goToDataBundles(_sender: UITapGestureRecognizer){
        guard let moveTo = storyboard?.instantiateViewController(withIdentifier: "DisplayChosenOfferViewController") as? DisplayChosenOfferViewController else {return}
        moveTo.selectedOffer = "Data Bundles"
        present(moveTo, animated: true, completion: nil)
    }
    
    //Function to go to Vodafone X controller
    @objc func goToVodafoneX(_sender: UITapGestureRecognizer){
        guard let moveTo = storyboard?.instantiateViewController(withIdentifier: "DisplayChosenOfferViewController") as? DisplayChosenOfferViewController else {
            return
        }
        moveTo.selectedOffer = "Vodafone X"
        present(moveTo, animated: true, completion: nil)
    }
    
    //Function to go to IDD Bundles
    @objc func goToIDDBundles(_sender: UITapGestureRecognizer){
        guard let moveTo = storyboard?.instantiateViewController(withIdentifier: "DisplayChosenOfferViewController") as? DisplayChosenOfferViewController else {return}
        moveTo.selectedOffer = "IDD Bundles"
        present(moveTo, animated: true, completion: nil)
    }
    
    //Function to go to vodafone Cash
    @objc func goToVodafoneCash(_sender: UITapGestureRecognizer){
        guard let moveTo = storyboard?.instantiateViewController(withIdentifier: "DisplayChosenOfferViewController") as? DisplayChosenOfferViewController else {return}
        moveTo.selectedOffer = "Vodafone Cash"
        present(moveTo, animated: true, completion: nil)
    }
    
    //Function to go to fbb
    @objc func goToFBB(_sender: UITapGestureRecognizer){
        guard let moveTo = storyboard?.instantiateViewController(withIdentifier: "DisplayChosenOfferViewController") as? DisplayChosenOfferViewController else {return}
        moveTo.selectedOffer = "Fixed Broadband"
        present(moveTo, animated: true, completion: nil)
    }
    
    //Function to go to Services
    @objc func goToServices(_sender: UITapGestureRecognizer){
        guard let moveTo = storyboard?.instantiateViewController(withIdentifier: "DisplayChosenOfferViewController") as? DisplayChosenOfferViewController else {return}
        moveTo.selectedOffer = "Services"
        present(moveTo, animated: true, completion: nil)
    }
    
    
    
    
    
}
