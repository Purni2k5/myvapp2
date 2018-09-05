//
//  fbbShareVc.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 04/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class fbbShareVc: baseViewControllerM, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    

    fileprivate var lblTransferTop1: NSLayoutConstraint?
    fileprivate var lblTransferTop2: NSLayoutConstraint?
    
    fileprivate var cardViewHeight1: NSLayoutConstraint?
    fileprivate var cardViewHeight2: NSLayoutConstraint?
    //closure for scroll view
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // top Image for
    let topImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // back button
    let backButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Menu button
    let btnMenu: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //create card view
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        var offerVariable: String?
        return view
    }()
    
    //create a closure for activity loader
    let activity_loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        view.hidesWhenStopped = true
        view.color = UIColor.vodaRed
        return view
    }()
    
    //Create a picker view
    func createPickerView(){
        let picker = UIPickerView()
        picker.delegate = self
        picker.tag = 1
        txtTransfer.inputView = picker
    }
    
    func createPickerViewDataUnits(){
        let picker = UIPickerView()
        picker.delegate = self
        picker.tag = 2
        txtDataUnit.inputView = picker
    }
    
    //Function to create a tool bar
    func createToolBar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(fbbShareVc.dismissKeyBoard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        txtTransfer.inputAccessoryView =  toolBar
        txtDataUnit.inputAccessoryView = toolBar
    }
    
    //Function to dismiss keyboard
    @objc func dismissKeyBoard(){
        view.endEditing(true)
    }
    
    let channelType = ["Fixed Broadband to Mobile", "Mobile to Fixed Broadband"]
    let dataUnititem = ["MB", "GB"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return channelType.count
        }else{
            return dataUnititem.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return channelType[row]
        }else{
            return dataUnititem[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            txtTransfer.text = channelType[row]
        }else{
            txtDataUnit.text = dataUnititem[row]
        }
        
    }
    
    var username: String?
    let txtTransfer = UITextField()
    let txtDataUnit = UITextField()
    let cheviDown = UIImageView()
    let chevi2Down = UIImageView()
    let btnMoveData = UIButton()
    var cardViewSize: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.grayBackground
        setUpViewsFbbShare()
        hideKeyboardWhenTappedAround()
        createPickerView()
        createPickerViewDataUnits()
        createToolBar()
        
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        username = UserData["Username"] as? String
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        cardViewSize = cardView.frame.size.height
        let topImageSize = topImage.frame.size.height
        if cardViewSize != 0.0 {
            scrollView.contentSize.height = topImageSize + cardViewSize!
        }
    }
    

    func setUpViewsFbbShare(){
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
        
        scrollView.addSubview(topImage)
        topImage.image = UIImage(named: "bg2")
        topImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        topImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImage.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        topImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        scrollView.addSubview(backButton)
        let backImage = UIImage(named: "leftArrow")
        let backTint = backImage?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(backTint, for: .normal)
        backButton.tintColor = UIColor.white
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 10).isActive = true
        backButton.addTarget(self, action: #selector(goToConfirm), for: .touchUpInside)
        
        scrollView.addSubview(btnMenu)
        let menuImage = UIImage(named: "menu")
        btnMenu.setImage(menuImage, for: .normal)
        btnMenu.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnMenu.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnMenu.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 10).isActive = true
        btnMenu.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -10).isActive = true
        btnMenu.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        
        //Menu label
        let lblMenu = UILabel()
        scrollView.addSubview(lblMenu)
        lblMenu.translatesAutoresizingMaskIntoConstraints = false
        lblMenu.textColor = UIColor.white
        lblMenu.text = "MENU"
        lblMenu.font = UIFont(name: String.defaultFontR, size: 13)
        lblMenu.topAnchor.constraint(equalTo: btnMenu.bottomAnchor, constant: -3).isActive = true
        lblMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14).isActive = true
        
        //Selected Offer
        let lblSelectedOffer = UILabel()
        scrollView.addSubview(lblSelectedOffer)
        lblSelectedOffer.translatesAutoresizingMaskIntoConstraints = false
        lblSelectedOffer.textColor = UIColor.white
        lblSelectedOffer.textAlignment = .center
        lblSelectedOffer.font = UIFont(name: String.defaultFontR, size: 31)
        lblSelectedOffer.text = "Fixed Broadband"
        lblSelectedOffer.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        lblSelectedOffer.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 70).isActive = true
        lblSelectedOffer.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        lblSelectedOffer.numberOfLines = 0
        lblSelectedOffer.lineBreakMode = .byWordWrapping
        
        scrollView.addSubview(cardView)
        cardView.layer.cornerRadius = 2
        cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.2
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cardView.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 20).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        cardViewHeight1 = cardView.heightAnchor.constraint(equalToConstant: 680)
        cardViewHeight2 = cardView.heightAnchor.constraint(equalToConstant: 880)
        cardViewHeight1?.isActive = true
        
        let lblTransferChannel = UILabel()
        scrollView.addSubview(lblTransferChannel)
        lblTransferChannel.translatesAutoresizingMaskIntoConstraints = false
        lblTransferChannel.text = "Transfer Channel"
        lblTransferChannel.font = UIFont(name: String.defaultFontR, size: 16)
        lblTransferChannel.textColor = UIColor.black
        lblTransferChannel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblTransferTop1 = lblTransferChannel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20)
        lblTransferTop2 = lblTransferChannel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 80)
        lblTransferTop1?.isActive = true
        
        scrollView.addSubview(txtTransfer)
        txtTransfer.translatesAutoresizingMaskIntoConstraints = false
        txtTransfer.font = UIFont(name: String.defaultFontR, size: 16)
        txtTransfer.backgroundColor = UIColor.white
        txtTransfer.borderStyle = .roundedRect
        txtTransfer.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtTransfer.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtTransfer.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtTransfer.topAnchor.constraint(equalTo: lblTransferChannel.bottomAnchor, constant: 10).isActive = true
//        txtTransfer.addTarget(self, action: #selector(checkTxtInputs), for: .editingChanged)
        
        txtTransfer.addSubview(cheviDown)
        cheviDown.translatesAutoresizingMaskIntoConstraints = false
        cheviDown.image = UIImage(named: "chevDown")
        cheviDown.widthAnchor.constraint(equalToConstant: 30).isActive = true
        cheviDown.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cheviDown.topAnchor.constraint(equalTo: txtTransfer.topAnchor, constant: 10).isActive = true
        cheviDown.trailingAnchor.constraint(equalTo: txtTransfer.trailingAnchor, constant: -10).isActive = true
        
        let lblInitialBB = UILabel()
        scrollView.addSubview(lblInitialBB)
        lblInitialBB.translatesAutoresizingMaskIntoConstraints = false
        lblInitialBB.text = "Initial Broadband Data"
        lblInitialBB.font = UIFont(name: String.defaultFontR, size: 16)
        lblInitialBB.textColor = UIColor.black
        lblInitialBB.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblInitialBB.topAnchor.constraint(equalTo: txtTransfer.bottomAnchor, constant: 25).isActive = true
        
        let txtInitialBB = UITextField()
        scrollView.addSubview(txtInitialBB)
        txtInitialBB.translatesAutoresizingMaskIntoConstraints = false
        txtInitialBB.font = UIFont(name: String.defaultFontR, size: 16)
        txtInitialBB.backgroundColor = UIColor.white
        txtInitialBB.borderStyle = .roundedRect
        txtInitialBB.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtInitialBB.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtInitialBB.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtInitialBB.topAnchor.constraint(equalTo: lblInitialBB.bottomAnchor, constant: 10).isActive = true
        
        let lblCurrentBB = UILabel()
        scrollView.addSubview(lblCurrentBB)
        lblCurrentBB.translatesAutoresizingMaskIntoConstraints = false
        lblCurrentBB.text = "Current Broadband Data"
        lblCurrentBB.font = UIFont(name: String.defaultFontR, size: 16)
        lblCurrentBB.textColor = UIColor.black
        lblCurrentBB.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblCurrentBB.topAnchor.constraint(equalTo: txtInitialBB.bottomAnchor, constant: 25).isActive = true
        
        let txtCurrentBB = UITextField()
        scrollView.addSubview(txtCurrentBB)
        txtCurrentBB.translatesAutoresizingMaskIntoConstraints = false
        txtCurrentBB.font = UIFont(name: String.defaultFontR, size: 16)
        txtCurrentBB.backgroundColor = UIColor.white
        txtCurrentBB.borderStyle = .roundedRect
        txtCurrentBB.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtCurrentBB.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtCurrentBB.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtCurrentBB.topAnchor.constraint(equalTo: lblCurrentBB.bottomAnchor, constant: 10).isActive = true
        
        let lblRemDays = UILabel()
        scrollView.addSubview(lblRemDays)
        lblRemDays.translatesAutoresizingMaskIntoConstraints = false
        lblRemDays.text = "Remaining Days"
        lblRemDays.font = UIFont(name: String.defaultFontR, size: 16)
        lblRemDays.textColor = UIColor.black
        lblRemDays.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblRemDays.topAnchor.constraint(equalTo: txtCurrentBB.bottomAnchor, constant: 25).isActive = true
        
        let txtRemDays = UITextField()
        scrollView.addSubview(txtRemDays)
        txtRemDays.translatesAutoresizingMaskIntoConstraints = false
        txtRemDays.font = UIFont(name: String.defaultFontR, size: 16)
        txtRemDays.backgroundColor = UIColor.white
        txtRemDays.borderStyle = .roundedRect
        txtRemDays.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtRemDays.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtRemDays.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtRemDays.topAnchor.constraint(equalTo: lblRemDays.bottomAnchor, constant: 10).isActive = true
        
        let lblBBRemMobile = UILabel()
        scrollView.addSubview(lblBBRemMobile)
        lblBBRemMobile.translatesAutoresizingMaskIntoConstraints = false
        lblBBRemMobile.text = "Broadband Data Remaining on Mobile"
        lblBBRemMobile.font = UIFont(name: String.defaultFontR, size: 16)
        lblBBRemMobile.textColor = UIColor.black
        lblBBRemMobile.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblBBRemMobile.topAnchor.constraint(equalTo: txtRemDays.bottomAnchor, constant: 25).isActive = true
        
        let txtBBRemMobile = UITextField()
        scrollView.addSubview(txtBBRemMobile)
        txtBBRemMobile.translatesAutoresizingMaskIntoConstraints = false
        txtBBRemMobile.font = UIFont(name: String.defaultFontR, size: 16)
        txtBBRemMobile.backgroundColor = UIColor.white
        txtBBRemMobile.borderStyle = .roundedRect
        txtBBRemMobile.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtBBRemMobile.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtBBRemMobile.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtBBRemMobile.topAnchor.constraint(equalTo: lblBBRemMobile.bottomAnchor, constant: 10).isActive = true
        
        let lblDataToMove = UILabel()
        scrollView.addSubview(lblDataToMove)
        lblDataToMove.translatesAutoresizingMaskIntoConstraints = false
        lblDataToMove.text = "Data to move"
        lblDataToMove.font = UIFont(name: String.defaultFontR, size: 16)
        lblDataToMove.textColor = UIColor.black
        lblDataToMove.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        lblDataToMove.topAnchor.constraint(equalTo: txtBBRemMobile.bottomAnchor, constant: 25).isActive = true
        
        let txtDataToMove = UITextField()
        scrollView.addSubview(txtDataToMove)
        txtDataToMove.translatesAutoresizingMaskIntoConstraints = false
        txtDataToMove.font = UIFont(name: String.defaultFontR, size: 16)
        txtDataToMove.backgroundColor = UIColor.white
        txtDataToMove.borderStyle = .roundedRect
        txtDataToMove.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        txtDataToMove.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -150).isActive = true
        txtDataToMove.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtDataToMove.topAnchor.constraint(equalTo: lblDataToMove.bottomAnchor, constant: 10).isActive = true
        
        
        scrollView.addSubview(txtDataUnit)
        txtDataUnit.translatesAutoresizingMaskIntoConstraints = false
        txtDataUnit.font = UIFont(name: String.defaultFontR, size: 16)
        txtDataUnit.backgroundColor = UIColor.white
        txtDataUnit.borderStyle = .roundedRect
        txtDataUnit.leadingAnchor.constraint(equalTo: txtDataToMove.trailingAnchor, constant: 10).isActive = true
        txtDataUnit.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        txtDataUnit.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txtDataUnit.topAnchor.constraint(equalTo: lblDataToMove.bottomAnchor, constant: 10).isActive = true
        
        txtDataUnit.addSubview(chevi2Down)
        chevi2Down.translatesAutoresizingMaskIntoConstraints = false
        chevi2Down.image = UIImage(named: "chevDown")
        chevi2Down.widthAnchor.constraint(equalToConstant: 30).isActive = true
        chevi2Down.heightAnchor.constraint(equalToConstant: 30).isActive = true
        chevi2Down.topAnchor.constraint(equalTo: txtDataUnit.topAnchor, constant: 10).isActive = true
        chevi2Down.trailingAnchor.constraint(equalTo: txtDataUnit.trailingAnchor, constant: -10).isActive = true
        
        scrollView.addSubview(btnMoveData)
        btnMoveData.translatesAutoresizingMaskIntoConstraints = false
        btnMoveData.backgroundColor = UIColor.vodaRed
        btnMoveData.setTitle("Move Data", for: .normal)
        btnMoveData.setTitleColor(UIColor.white, for: .normal)
        btnMoveData.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnMoveData.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        btnMoveData.topAnchor.constraint(equalTo: txtDataToMove.bottomAnchor, constant: 40).isActive = true
        btnMoveData.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        btnMoveData.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnMoveData.isEnabled = true
//        btnMoveData.addTarget(self, action: #selector(checkFBBMove), for: .touchUpInside)
        
        scrollView.contentSize.height = view.frame.size.height + 100
    }
    
    @objc func goToConfirm(){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "fbbMove")
        present(moveTo!, animated: true, completion: nil)
    }
}
