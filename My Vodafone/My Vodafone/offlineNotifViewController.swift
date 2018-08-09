//
//  offlineNotifViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 09/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class offlineNotifViewController: UIViewController {
    var ussdCode:String?
    
    //create closure for scrollview
    lazy var scrollView: UIScrollView = {
       let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = UIColor.clear
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.dark_background
        view.addSubview(scrollView)
        setUpScrollView()
        modalPresentationCapturesStatusBarAppearance = true
        print("here too:: \(ussdCode)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpScrollView(){
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //darkView
        let darkView = UIView()
        darkView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(darkView)
        darkView.backgroundColor = UIColor.black
        darkView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        darkView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        darkView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        
        //close button
        let closeButton = UIButton()
        scrollView.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        let close_image = UIImage(named: "ic_close")
        closeButton.setImage(close_image, for: .normal)
        closeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 10).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -10).isActive = true
        closeButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        
        //Offline label
        let offlineLble = UILabel()
        scrollView.addSubview(offlineLble)
        offlineLble.translatesAutoresizingMaskIntoConstraints = false
        offlineLble.text = "You're offline"
        offlineLble.font = UIFont(name: String.defaultFontR, size: 30)
        offlineLble.textAlignment = .center
        offlineLble.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 90).isActive = true
        offlineLble.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        offlineLble.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        offlineLble.textColor = UIColor.white
        
        //warning icon
        let warning_image = UIImageView(image: #imageLiteral(resourceName: "warning"))
        scrollView.addSubview(warning_image)
        warning_image.translatesAutoresizingMaskIntoConstraints = false
        warning_image.widthAnchor.constraint(equalToConstant: 137).isActive = true
        warning_image.heightAnchor.constraint(equalToConstant: 137).isActive = true
        warning_image.topAnchor.constraint(equalTo: darkView.bottomAnchor, constant: 2).isActive = true
        warning_image.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        //No internet label
        let errorLbl = UILabel()
        scrollView.addSubview(errorLbl)
        errorLbl.translatesAutoresizingMaskIntoConstraints = false
        errorLbl.numberOfLines = 0
        errorLbl.lineBreakMode = .byWordWrapping
        errorLbl.textColor = UIColor.white
        errorLbl.font = UIFont(name: String.defaultFontR, size: 22)
        errorLbl.text = "Sorry, you currently don't have data connection, your Bundle purchase request will go through USSD. \n \nIn App promotions won't be applied."
        errorLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        errorLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        errorLbl.topAnchor.constraint(equalTo: warning_image.bottomAnchor, constant: 30).isActive = true
        errorLbl.textAlignment = .center
        
        //Dial button
        let dialButton = UIButton()
        scrollView.addSubview(dialButton)
        dialButton.translatesAutoresizingMaskIntoConstraints = false
        dialButton.setTitle("Dial USSD", for: .normal)
        dialButton.backgroundColor = UIColor.vodaRed
        dialButton.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        dialButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        dialButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        dialButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        dialButton.topAnchor.constraint(equalTo: errorLbl.bottomAnchor, constant: 30).isActive = true
        dialButton.addTarget(self, action: #selector(dialUSSD), for: .touchUpInside)
        
        //Cancel button
        let cancelButton = UIButton()
        scrollView.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.backgroundColor = UIColor.grayButton
        cancelButton.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        cancelButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        cancelButton.topAnchor.constraint(equalTo: dialButton.bottomAnchor, constant: 20).isActive = true
        cancelButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        
        scrollView.contentSize.height = (view.frame.size.height + darkView.frame.size.height + warning_image.frame.size.height + errorLbl.frame.size.height + dialButton.frame.size.height + cancelButton.frame.size.height)
    }
    
    //Function make USSD call
    @objc func dialUSSD(){
        let ussdCode = self.ussdCode
        let url = URL(string: "telprompt://\(ussdCode!)")
        UIApplication.shared.open(url!)
    }
    
    @objc func closeModal(){
        self.view.removeFromSuperview()
    }

    override var prefersStatusBarHidden: Bool{
        return true
    }
}
