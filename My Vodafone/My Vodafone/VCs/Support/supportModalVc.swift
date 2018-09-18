//
//  supportModalVc.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 20/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class supportModalVc: UIViewController {

    var supportSelected: String?
    var desc: String?
    var code: String?
    
    
    //create closure for darkView
    let darkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
        return view
    }()
    
    //close button
    let btnClose: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Label for selected support
    let lblSupportSel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name:String.defaultFontB, size: 30)
        return view
    }()
    
    //Description
    let lblDesc: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.font = UIFont(name:String.defaultFontB, size: 20)
        return view
    }()
    
    //Continue button
    let btnCont: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.vodaRed
        return view
    }()
    
    //Cancel button
    let btnCancel: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.grayButton
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.dark_background
        print(code)
        setUpViews()
    }
    
    func setUpViews(){
        view.addSubview(darkView)
        darkView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        darkView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        darkView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        darkView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        view.addSubview(btnClose)
        let close_image = UIImage(named: "ic_close")
        btnClose.setImage(close_image, for: .normal)
        btnClose.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnClose.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnClose.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 20).isActive = true
        btnClose.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -10).isActive = true
        btnClose.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        
        //selected support
        view.addSubview(lblSupportSel)
        lblSupportSel.text = supportSelected
        lblSupportSel.textAlignment = .center
        lblSupportSel.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        lblSupportSel.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 80).isActive = true
        lblSupportSel.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        
        //Description
        view.addSubview(lblDesc)
        lblDesc.text = desc
        lblDesc.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        lblDesc.topAnchor.constraint(equalTo: darkView.bottomAnchor, constant: 40).isActive = true
        lblDesc.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        lblDesc.textAlignment = .center
        lblDesc.numberOfLines = 0
        lblDesc.lineBreakMode = .byWordWrapping
        
        //Continue button
        view.addSubview(btnCont)
        btnCont.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnCont.setTitleColor(UIColor.white, for: .normal)
        btnCont.setTitle("Continue", for: .normal)
        btnCont.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        btnCont.topAnchor.constraint(equalTo: lblDesc.bottomAnchor, constant: 20).isActive = true
        btnCont.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        btnCont.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnCont.addTarget(self, action: #selector(dial), for: .touchUpInside)
        
        //Cancel button
        view.addSubview(btnCancel)
        btnCancel.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnCancel.setTitleColor(UIColor.white, for: .normal)
        btnCancel.setTitle("Cancel", for: .normal)
        btnCancel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        btnCancel.topAnchor.constraint(equalTo: btnCont.bottomAnchor, constant: 10).isActive = true
        btnCancel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        btnCancel.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnCancel.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
    }
    
    
    @objc func closeModal(){
        self.view.removeFromSuperview()
    
    }
    
    @objc func dial(){
    let ussdCode = code!
        if ussdCode.contains("https") || ussdCode.contains("http"){
            UIApplication.shared.open(URL(string: "\(ussdCode)")! as URL, options: [:], completionHandler: nil)
        }else if ussdCode.contains("info"){
            UIApplication.shared.open(URL(string: "mailto:\(ussdCode)")! as URL, options: [:], completionHandler: nil)
        }
        else{
            let url = URL(string: "telprompt://\(ussdCode)")
            UIApplication.shared.open(url!)

        }
    
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }

}
