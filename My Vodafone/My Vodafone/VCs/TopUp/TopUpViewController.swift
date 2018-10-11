//
//  TopUpViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 01/07/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class TopUpViewController: baseViewControllerM {
    
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var goTopUp: CardView!
    @IBOutlet weak var bg2View: UIImageView!
    @IBOutlet weak var topUpHistory: CardView!
    
    var displayAmt: String?
    var msisdn: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // change image buttons colours
        changeBtnImageColour()
        
        
        msisdn = preference.object(forKey: "defaultMSISDN") as! String?
        checkIfStaff()
        
        //add gesture
        let gestureRec = UITapGestureRecognizer(target: self, action: #selector(self.showTopUp))
        goTopUp.addGestureRecognizer(gestureRec)
        //Adding gesture
        let historyRec = UITapGestureRecognizer.init(target: self, action: #selector(goToHistory))
        topUpHistory.addGestureRecognizer(historyRec)
        
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
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
        btnBack.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
        
        let btnMenu = UIButton()
        view.addSubview(btnMenu)
        btnMenu.translatesAutoresizingMaskIntoConstraints = false
        let menuImage = UIImage(named: "menu")
        btnMenu.setImage(menuImage, for: .normal)
        btnMenu.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnMenu.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnMenu.topAnchor.constraint(equalTo: bg2View.topAnchor, constant: 25).isActive = true
        btnMenu.trailingAnchor.constraint(equalTo: bg2View.trailingAnchor, constant: -10).isActive = true
        btnMenu.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        
        //Menu label
        let lblMenu = UILabel()
        view.addSubview(lblMenu)
        lblMenu.translatesAutoresizingMaskIntoConstraints = false
        lblMenu.textColor = UIColor.white
        lblMenu.text = "MENU"
        lblMenu.font = UIFont(name: String.defaultFontR, size: 13)
        lblMenu.topAnchor.constraint(equalTo: btnMenu.bottomAnchor, constant: -3).isActive = true
        lblMenu.trailingAnchor.constraint(equalTo: bg2View.trailingAnchor, constant: -14).isActive = true
    }
    
    func checkIfStaff(){
        if let staffStatus = preference.object(forKey: "staffNumber") as? Bool {
            print("staff status:: \(staffStatus)")
            let creditAllocationData = preference.object(forKey: "staffCreditData") as? NSDictionary
            let displayHead = creditAllocationData!["displayHeadLabel"] as! String?
            let displayDetails = creditAllocationData!["displayLabel"] as! String?
            displayAmt = creditAllocationData!["displayAmount"] as! String?
            
            let allocationCard = StaffDataAllocation()
            allocationCard.msisdn = msisdn!
            allocationCard.displayAmt = displayAmt!
            view.addSubview(allocationCard)
            allocationCard.translatesAutoresizingMaskIntoConstraints = false
            allocationCard.backgroundColor = UIColor.white
            allocationCard.heightAnchor.constraint(equalToConstant: 106).isActive = true
            allocationCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            allocationCard.topAnchor.constraint(equalTo: topUpHistory.bottomAnchor, constant: 20).isActive = true
            allocationCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            
            allocationCard.layer.cornerRadius = 2
            allocationCard.layer.shadowColor = UIColor.black.cgColor
            allocationCard.layer.shadowOffset = CGSize(width: 0, height: 5)
            allocationCard.layer.shadowOpacity = 0.2
            
            //left image with colour
            let leftImageColour = UIImageView()
            allocationCard.addSubview(leftImageColour)
            leftImageColour.translatesAutoresizingMaskIntoConstraints = false
            leftImageColour.backgroundColor = UIColor.cardImageColour
            leftImageColour.leadingAnchor.constraint(equalTo: allocationCard.leadingAnchor).isActive = true
            leftImageColour.topAnchor.constraint(equalTo: allocationCard.topAnchor).isActive = true
            leftImageColour.widthAnchor.constraint(equalToConstant: 12).isActive = true
            leftImageColour.bottomAnchor.constraint(equalTo: allocationCard.bottomAnchor).isActive = true
            
            let lblDisplayHead = UILabel()
            allocationCard.addSubview(lblDisplayHead)
            lblDisplayHead.translatesAutoresizingMaskIntoConstraints = false
            lblDisplayHead.font = UIFont(name: String.defaultFontR, size: 22)
            lblDisplayHead.text = displayHead!
            lblDisplayHead.textColor = UIColor.black
            lblDisplayHead.numberOfLines = 0
            lblDisplayHead.lineBreakMode = .byWordWrapping
            lblDisplayHead.leadingAnchor.constraint(equalTo: leftImageColour.trailingAnchor, constant: 19).isActive = true
            lblDisplayHead.topAnchor.constraint(equalTo: allocationCard.topAnchor, constant: 21).isActive = true
            lblDisplayHead.trailingAnchor.constraint(equalTo: allocationCard.trailingAnchor, constant: -5).isActive = true
            
            let lblDisplayDetails = UILabel()
            allocationCard.addSubview(lblDisplayDetails)
            lblDisplayDetails.translatesAutoresizingMaskIntoConstraints = false
            lblDisplayDetails.font = UIFont(name: String.defaultFontR, size: 16)
            lblDisplayDetails.text = displayDetails!
            lblDisplayDetails.textColor = UIColor.black
            lblDisplayDetails.numberOfLines = 0
            lblDisplayDetails.lineBreakMode = .byWordWrapping
            lblDisplayDetails.leadingAnchor.constraint(equalTo: leftImageColour.trailingAnchor, constant: 19).isActive = true
            lblDisplayDetails.topAnchor.constraint(equalTo: lblDisplayHead.bottomAnchor, constant: 10).isActive = true
            lblDisplayDetails.trailingAnchor.constraint(equalTo: allocationCard.trailingAnchor, constant: -5).isActive = true
            
            //adding right arrow
            let rightArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
            allocationCard.addSubview(rightArrow)
            rightArrow.translatesAutoresizingMaskIntoConstraints = false
            rightArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
            rightArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
            rightArrow.topAnchor.constraint(equalTo: allocationCard.topAnchor, constant: 57).isActive = true
            rightArrow.trailingAnchor.constraint(equalTo: allocationCard.trailingAnchor, constant: -9).isActive = true
            
            //Adding gesture
            let touchRec = UITapGestureRecognizer.init(target: self, action: #selector(goToRedeeming(_sender:)))
            allocationCard.addGestureRecognizer(touchRec)
        }else{
            
        }
        
    }
    
    @objc func goToHistory(){
        let storyboard = UIStoryboard(name: "TopUp", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "TopUpHistory")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func goToRedeeming(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "TopUp", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "staffCreditRedeeming") as? staffCreditRedeeming else {return}
        moveTo.msisdn = msisdn!
        moveTo.displayAmt = displayAmt!
        
        self.addChildViewController(moveTo)
        moveTo.view.frame = self.view.frame
        self.view.addSubview(moveTo.view)
        moveTo.didMove(toParentViewController: self)
    }
    
    @objc func showTopUp(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "TopUp", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "toppingUpViewController")
//        present(moveTo!, animated: true, completion: nil)
        self.addChildViewController(moveTo)
        moveTo.view.frame = self.view.frame
        self.view.addSubview(moveTo.view)
        moveTo.didMove(toParentViewController: self)
    }
}
