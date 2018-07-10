//
//  PlansViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 04/07/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class PlansViewController: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var hamburger: UIButton!
    @IBOutlet weak var oneGH: UIImageView!
    @IBOutlet weak var twoGH: UIImageView!
    @IBOutlet weak var dblValueMonth: UIImageView!
    @IBOutlet weak var redClassic: UIImageView!
    @IBOutlet weak var redClassicFreedom: UIImageView!
    @IBOutlet weak var redHotData: UIImageView!
    @IBOutlet weak var redHotFreedom: UIImageView!
    @IBOutlet weak var redHotVoice: UIImageView!
    @IBOutlet weak var redRushData: UIImageView!
    @IBOutlet weak var redRushFreedom: UIImageView!
    @IBOutlet weak var redRushVoice: UIImageView!
    @IBOutlet weak var redSuperData: UIImageView!
    @IBOutlet weak var redSuperFreedom: UIImageView!
    @IBOutlet weak var redSuperVoice: UIImageView!
    @IBOutlet weak var redLifeWeekly: UIImageView!
    @IBOutlet weak var supremeValueMonthly: UIImageView!
    @IBOutlet weak var vodafoneVIM: UIImageView!
    @IBOutlet weak var welcomePack: UIImageView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var menuTrailingConstraint: NSLayoutConstraint!
    
    //Plan cards View
    @IBOutlet weak var oneGHCard: CardView!
    @IBOutlet weak var twoGHCard: CardView!
    @IBOutlet weak var dblValueMonthCard: CardView!
    @IBOutlet weak var redClassiceDataCard: CardView!
    @IBOutlet weak var redClassicFreedomCard: CardView!
    @IBOutlet weak var redHotDataCard: CardView!
    @IBOutlet weak var redHotFreedomCard: UIView!
    @IBOutlet weak var redHotVoiceCard: CardView!
    @IBOutlet weak var redRushDataCard: CardView!
    @IBOutlet weak var redRushFreedomCard: CardView!
    @IBOutlet weak var redRushVoiceCard: CardView!
    @IBOutlet weak var redSuperDataCard: CardView!
    @IBOutlet weak var redSuperFreedomCard: CardView!
    @IBOutlet weak var redSuperVoiceCard: CardView!
    @IBOutlet weak var redLifeWeeklyCard: CardView!
    @IBOutlet weak var supremeValMonth: CardView!
    @IBOutlet weak var vodafoneVimCard: CardView!
    @IBOutlet weak var welcomePackCard: CardView!
    
    
    
    
    var menuShowing = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Change btns Colour
        changeColourToWhite()
        //MAKE IMAGES ROUND
        makeImageRound(image: oneGH)
        makeImageRound(image: twoGH)
        makeImageRound(image: dblValueMonth)
        makeImageRound(image: redClassic)
        makeImageRound(image: redClassicFreedom)
        makeImageRound(image: redHotData)
        makeImageRound(image: redHotFreedom)
        makeImageRound(image: redHotVoice)
        makeImageRound(image: redRushData)
        makeImageRound(image: redRushFreedom)
        makeImageRound(image: redRushVoice)
        makeImageRound(image: redSuperData)
        makeImageRound(image: redSuperFreedom)
        makeImageRound(image: redSuperVoice)
        makeImageRound(image: redLifeWeekly)
        makeImageRound(image: supremeValueMonthly)
        makeImageRound(image: vodafoneVIM)
        makeImageRound(image: welcomePack)
        
        //load gesture to cards
        addGestureToCards()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Change imgae buttons colour to white
    func changeColourToWhite(){
        let back_image = UIImage(named: "leftArrow")
        let tintedBack = back_image?.withRenderingMode(.alwaysTemplate)
        btnBack.setImage(tintedBack, for: .normal)
        btnBack.tintColor = UIColor.white
        
        let menu_image = UIImage(named: "hamburger")
        let tintedMenu = menu_image?.withRenderingMode(.alwaysTemplate)
        hamburger.setImage(tintedMenu, for: .normal)
        hamburger.tintColor = UIColor.white
        
        let close_image = UIImage(named: "new_close")
        let tintedClose = close_image?.withRenderingMode(.alwaysTemplate)
        btnClose.setImage(tintedClose, for: .normal)
        btnClose.tintColor = UIColor.white
    }
    
    //Function to show Menu
    @IBAction func showMenu(_ sender: Any) {
        if (menuShowing){
            menuTrailingConstraint.constant = -280
        }else{
            menuTrailingConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        menuShowing = !menuShowing
    }
    
    //Function to add tap gestures to cards
    func addGestureToCards(){
        let oneGHRec = UITapGestureRecognizer(target: self, action: #selector(self.goToOneGH))
        oneGHCard.addGestureRecognizer(oneGHRec)
        
        let twoGHRec = UITapGestureRecognizer(target: self, action: #selector(self.goToTwoGH))
        twoGHCard.addGestureRecognizer(twoGHRec)
        
        let dbleValueMonthlyRec = UITapGestureRecognizer(target: self, action: #selector(self.goToDbleValueMonthly))
        dblValueMonthCard.addGestureRecognizer(dbleValueMonthlyRec)
        
        let redClassicDataRec = UITapGestureRecognizer(target: self, action: #selector(self.goToRedClassicData))
        redClassiceDataCard.addGestureRecognizer(redClassicDataRec)
        
        let redClassicFreedomRec = UITapGestureRecognizer(target: self, action: #selector(self.goToRedClassicFreedom))
        redClassicFreedomCard.addGestureRecognizer(redClassicFreedomRec)
        
        let redHotDataRec = UITapGestureRecognizer(target: self, action: #selector(self.goToRedHotData))
        redHotDataCard.addGestureRecognizer(redHotDataRec)
        
        let redHotFreedomRec = UITapGestureRecognizer(target: self, action: #selector(self.goToRedHotFreedom))
        redHotFreedomCard.addGestureRecognizer(redHotFreedomRec)
        
        let redHotVoiceRec = UITapGestureRecognizer(target: self, action: #selector(self.goToRedHotVoice))
        redHotVoiceCard.addGestureRecognizer(redHotVoiceRec)
        
        let redRushDataRec = UITapGestureRecognizer(target: self, action: #selector(self.goToRedRushData))
        redRushDataCard.addGestureRecognizer(redRushDataRec)
        
        let redRushFreedomRec = UITapGestureRecognizer(target: self, action: #selector(self.goToRedRushFreedom))
        redRushFreedomCard.addGestureRecognizer(redRushFreedomRec)
        
        let redRushVoiceRec = UITapGestureRecognizer(target: self, action: #selector(self.goToRedRushVoice))
        redRushVoiceCard.addGestureRecognizer(redRushVoiceRec)
    }
    
    //Function to OneGH
    @objc func goToOneGH(_sender: UITapGestureRecognizer){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "OneGHPlanViewController")
        present(moveTo!, animated: true, completion: nil)
    }
    
    //Function to TwoGH
    @objc func goToTwoGH(_sender: UITapGestureRecognizer){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "TwoGHViewController")
        present(moveTo!, animated: true, completion: nil)
    }
    //Function to Double Value Monthly
    @objc func goToDbleValueMonthly(_sender: UITapGestureRecognizer){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "DbleValueMonthlyViewController")
        present(moveTo!, animated: true, completion: nil)
    }
    
    //Function to Red classic data
    @objc func goToRedClassicData(_sender: UITapGestureRecognizer){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "RedClassicDataViewController")
        present(moveTo!, animated: true, completion: nil)
    }
    
    //Function to Red classic freedom
    @objc func goToRedClassicFreedom(_sender: UITapGestureRecognizer){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "RedClassicFreedomViewController")
        present(moveTo!, animated: true, completion: nil)
    }
    //Function to Red Hot Data
    @objc func goToRedHotData(_sender: UITapGestureRecognizer){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "RedHotDataViewController")
        present(moveTo!, animated: true, completion: nil)
    }
    
    //Function to Red Hot Freedom
    @objc func goToRedHotFreedom(_sender: UITapGestureRecognizer){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "RedHotFreedomViewController")
        present(moveTo!, animated: true, completion: nil)
    }
    
    //Function to Red Hot Freedom
    @objc func goToRedHotVoice(_sender: UITapGestureRecognizer){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "RedHotVoiceViewController")
        present(moveTo!, animated: true, completion: nil)
    }
    
    //Function to Red Hot Freedom
    @objc func goToRedRushData(_sender: UITapGestureRecognizer){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "RedRushDataViewController")
        present(moveTo!, animated: true, completion: nil)
    }
    
    //Function to Red Hot Freedom
    @objc func goToRedRushFreedom(_sender: UITapGestureRecognizer){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "RedRushFreedomViewController")
        present(moveTo!, animated: true, completion: nil)
    }
    
    //Function to Red Hot Freedom
    @objc func goToRedRushVoice(_sender: UITapGestureRecognizer){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "RedRushVoiceViewController")
        present(moveTo!, animated: true, completion: nil)
    }
    
    
    
    //Function to make images round
    func makeImageRound(image:UIImageView){
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
        //        image.layer.borderWidth = 2
    }
}
