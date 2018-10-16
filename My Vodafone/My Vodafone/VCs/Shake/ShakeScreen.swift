//
//  ShakeScreen.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 16/10/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit
import AVFoundation

class ShakeScreen: baseViewControllerM {

    // back button
    let backButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblShakeHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.text = "Shake your phone to Unlock \nspecial XTRAS!!!"
        return label
    }()
    
    let shakeImage: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "shakebg"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    var shakeCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.grayButton
        setUpViewShakeScreen()
    }
    
    func setUpViewShakeScreen(){
        view.addSubview(backButton)
        let backImage = UIImage(named: "leftArrow")
        let backTint = backImage?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(backTint, for: .normal)
        backButton.tintColor = UIColor.white
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        backButton.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
        
        view.addSubview(lblShakeHeader)
        lblShakeHeader.font = UIFont(name: String.defaultFontR, size: 25)
        lblShakeHeader.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 50).isActive = true
        lblShakeHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblShakeHeader.numberOfLines = 0
        lblShakeHeader.lineBreakMode = .byWordWrapping
        lblShakeHeader.textAlignment = .center
        
        let center = view.center
        
        let circularPath = UIBezierPath(arcCenter: .zero
            , radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.support_light_gray.cgColor
        trackLayer.lineWidth = 30
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = kCALineCapRound
        trackLayer.position = center
        view.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 30
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.position = center
        shapeLayer.strokeEnd = 0.01
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1   )
        view.layer.addSublayer(shapeLayer)
        
//        view.addSubview(shakeImage)
//        shakeImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        shakeImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        shakeImage.center = view.center
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        
        if motion == .motionShake{
            print("Shake detected")
            shapeLayer.strokeEnd += 0.25
            shakeCount =  shakeCount + 1
            lblShakeHeader.text = "That's it Shake it until you make it"
            if shakeCount == 4{
                print("Stop shake")
                lblShakeHeader.text = "Welcome to Shake on vodafone X"
            }
        }
        
    }
    
    
    override var prefersStatusBarHidden: Bool{
        return true
    }

}
