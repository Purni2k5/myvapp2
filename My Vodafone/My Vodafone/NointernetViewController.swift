//
//  NointernetViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 09/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class NointernetViewController: UIViewController {
    
    //create closure for close button
    let close_button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        
    }
    
    func setUpViews(){
        //Close button
        view.addSubview(close_button)
        let close_image = UIImage(named: "ic_close")
        close_button.setImage(close_image, for: .normal)
        close_button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        close_button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        close_button.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        close_button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        close_button.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        
        //Data permission label
        let lblDataPermission = UILabel()
        lblDataPermission.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lblDataPermission)
        lblDataPermission.text = "Data permission"
        lblDataPermission.font = UIFont(name: String.defaultFontR, size: 35)
        lblDataPermission.textColor = UIColor.white
        lblDataPermission.textAlignment = .center
        lblDataPermission.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        lblDataPermission.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        lblDataPermission.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        //info icon
        let info_image = UIImageView(image: #imageLiteral(resourceName: "ic_info"))
        info_image.image = info_image.image!.withRenderingMode(.alwaysTemplate)
        info_image.tintColor = UIColor.white
        view.addSubview(info_image)
        info_image.translatesAutoresizingMaskIntoConstraints = false
        info_image.topAnchor.constraint(equalTo: lblDataPermission.bottomAnchor, constant: 100).isActive = true
        info_image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        info_image.widthAnchor.constraint(equalToConstant: 83).isActive = true
        info_image.heightAnchor.constraint(equalToConstant: 83).isActive = true
        
        //Info Description
        let info_desc = UILabel()
        view.addSubview(info_desc)
        info_desc.translatesAutoresizingMaskIntoConstraints = false
        info_desc.text = "There is a problem with your internet \nconnection. Kindly check and retry..."
        info_desc.font = UIFont(name: String.defaultFontR, size: 22)
        info_desc.textColor = UIColor.white
        info_desc.textAlignment = .center
        info_desc.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        info_desc.topAnchor.constraint(equalTo: info_image.bottomAnchor, constant: 20).isActive = true
        info_desc.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        info_desc.numberOfLines = 0
        info_desc.lineBreakMode = .byWordWrapping
        
        //close button
        let cancelButton = UIButton()
        view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.backgroundColor = UIColor.grayButton
        cancelButton.setTitle("Close", for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        cancelButton.topAnchor.constraint(equalTo: info_desc.bottomAnchor, constant: 30).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        cancelButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
    }
    
    @objc func closeModal(){
        self.view.removeFromSuperview()
    }

    override var prefersStatusBarHidden: Bool{
        return true
    }
    

}
