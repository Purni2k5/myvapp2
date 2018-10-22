//
//  AppExtensions.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 07/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // Line spacing attribute
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
}

extension UITextField {
    
    func borderBottomColour(){
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 3.0
        
    }
}

//This function is not working
extension UILabel {
    //MARK: StartBlink
    func startBlink() {
        self.alpha = 0
        UIView.animate(withDuration: 0.8,//Time duration
            delay:0.0,
            options:[.allowUserInteraction, .curveEaseInOut, .autoreverse, .repeat],
            animations: { self.alpha = 1 },
            completion: nil)
    }
    
    //MARK: StopBlink
    func stopBlink() {
        layer.removeAllAnimations()
        alpha = 1
    }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func getDeviceOS() -> String {
        let systemVersion = UIDevice.current.systemVersion
        
        return systemVersion
    }
    
    func toast(toast_img: UIImageView, toast_message: String){
        let messageUIView = UIView()
        let warningMessage = UILabel()
        messageUIView.alpha = 0
        warningMessage.alpha = 0
        toast_img.alpha = 0
        
        UIView.animate(withDuration: 2, animations: {
            //View to hold message
            
            self.view.addSubview(messageUIView)
            messageUIView.alpha = 0.85
            messageUIView.translatesAutoresizingMaskIntoConstraints = false
            messageUIView.backgroundColor = UIColor.black
            messageUIView.isOpaque = false
            messageUIView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
            messageUIView.bottomAnchor.constraint(equalTo: self.view.safeBottomAnchor, constant: 0).isActive = true
            messageUIView.heightAnchor.constraint(equalToConstant: 110).isActive = true
            
            // warning icon
            
            self.view.addSubview(toast_img)
            toast_img.translatesAutoresizingMaskIntoConstraints = false
            toast_img.leadingAnchor.constraint(equalTo: messageUIView.leadingAnchor, constant: 30).isActive = true
            toast_img.widthAnchor.constraint(equalToConstant: 20).isActive = true
            toast_img.heightAnchor.constraint(equalToConstant: 20).isActive = true
            toast_img.topAnchor.constraint(equalTo: messageUIView.topAnchor, constant: 40).isActive = true
            toast_img.alpha = 1
            
            //warning message
            
            self.view.addSubview(warningMessage)
            warningMessage.translatesAutoresizingMaskIntoConstraints = false
            warningMessage.textColor = UIColor.white
            warningMessage.font = UIFont(name: String.defaultFontR, size: 17)
            warningMessage.text = toast_message
            warningMessage.leadingAnchor.constraint(equalTo: toast_img.trailingAnchor, constant: 20).isActive = true
            warningMessage.trailingAnchor.constraint(equalTo: messageUIView.trailingAnchor, constant: -10).isActive = true
            warningMessage.topAnchor.constraint(equalTo: messageUIView.topAnchor, constant: 40).isActive = true
            warningMessage.numberOfLines = 0
            warningMessage.lineBreakMode = .byWordWrapping
            warningMessage.alpha = 1
        }, completion: { (true) in
            UIView.animate(withDuration: 3, delay: 3, animations: {
                messageUIView.alpha = 0
                warningMessage.alpha = 0
                toast_img.alpha = 0
            }, completion: nil)
        })
    }
    
    func checkConnection(){
        if !CheckInternet.Connection(){
            toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "You're offline")
            print("You dont have internet")
        }else{
            print("You have internet")
        }
    }
    
    enum UserDefaultsKeys: String {
        case loginStatus
        case responseData
        case staffNumber
        case staffCreditData
        case Plan
        case Data
        case defaultMSISDN
        case defaultName
        case RESPONSEMESSAGE
        case FBBLINKEDNUMBER
        case FBBACTKEY
        case FBBUSERID
        case BBPACKAGES
        case FBBUSERACCOUNT
        case DefaultService
        case accountBalance
        case accBalanceLabel
        case balanceLabel
        case ROAMINGS
        case touchIDEnabled
        case notificationEnabled
        case privacyEnabled
        case privateDataEnabled
        case ServiceList
        case userSubscriberSummary
        case isGaugeVisible
        case lastUpdate
        case shakeBundles
        case shakeBundlesOther
        case userSecret
        case userKey
        case userSession
        case requestKey
        case Made4MeBundles
        case adslBalance
        case BB_Plan
        case P_CURRENTVOL
        case TOTALINITIAL
        case P_ADVANCEPAYMENT
        case P_PLANNAME
        case BB_HOME_PERCENTAGE
        case BB_LastUpdate
        case hasRated
    }
    
    enum keyChainKeys: String {
        case secretPassword
        case secretUser
    }
}

extension StringProtocol {
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
    var firstCapitalized: String {
        guard let first = first else { return "" }
        return String(first).capitalized + dropFirst()
    }
}

extension UIImageView {
    func shakeView(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
}

extension UIScrollView {
    
    func resizeScrollViewContentSize() {
        
        var contentRect = CGRect.zero
        
        for view in self.subviews {
            
            contentRect = contentRect.union(view.frame)
            
        }
        
        self.contentSize.height = contentRect.size.height
        
    }
    
}

