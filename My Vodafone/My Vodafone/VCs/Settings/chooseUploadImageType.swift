//
//  chooseUploadImageType.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 08/01/2019.
//  Copyright © 2019 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class chooseUploadImageType: baseViewControllerM {
    
    let close_button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let bottomDarkViewC: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.color_light_gray_30
        return view
    }()
    
    let btnTakePhoto: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.grayButton
        btn.setTitle("Take a photo", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        return btn
    }()
    
    let choosePhoto: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.grayButton
        btn.setTitle("Choose an existing photo", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        return btn
    }()
    
    let restoreImage: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.grayButton
        btn.setTitle("Restore default image", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.70)
        setupViewsChooseUpload()
    }
    
    func setupViewsChooseUpload() {
        //Close button
        view.addSubview(close_button)
        let close_image = UIImage(named: "ic_close")
        close_button.setImage(close_image, for: .normal)
        close_button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        close_button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        close_button.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        close_button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        close_button.addTarget(self, action: #selector(closeModalB), for: .touchUpInside)
        
        view.addSubview(bottomDarkViewC)
        bottomDarkViewC.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomDarkViewC.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomDarkViewC.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomDarkViewC.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        bottomDarkViewC.addSubview(btnTakePhoto)
        btnTakePhoto.leadingAnchor.constraint(equalTo: bottomDarkViewC.leadingAnchor, constant: 20).isActive = true
        btnTakePhoto.topAnchor.constraint(equalTo: bottomDarkViewC.topAnchor, constant: 30).isActive = true
        btnTakePhoto.trailingAnchor.constraint(equalTo: bottomDarkViewC.trailingAnchor, constant: -20).isActive = true
        btnTakePhoto.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        bottomDarkViewC.addSubview(choosePhoto)
        choosePhoto.leadingAnchor.constraint(equalTo: bottomDarkViewC.leadingAnchor, constant: 20).isActive = true
        choosePhoto.topAnchor.constraint(equalTo: btnTakePhoto.bottomAnchor, constant: 10).isActive = true
        choosePhoto.trailingAnchor.constraint(equalTo: bottomDarkViewC.trailingAnchor, constant: -20).isActive = true
        choosePhoto.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        bottomDarkViewC.addSubview(restoreImage)
        restoreImage.leadingAnchor.constraint(equalTo: bottomDarkViewC.leadingAnchor, constant: 20).isActive = true
        restoreImage.topAnchor.constraint(equalTo: choosePhoto.bottomAnchor, constant: 10).isActive = true
        restoreImage.trailingAnchor.constraint(equalTo: bottomDarkViewC.trailingAnchor, constant: -20).isActive = true
        restoreImage.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }

}
