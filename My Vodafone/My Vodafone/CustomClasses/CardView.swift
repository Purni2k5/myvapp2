//
//  CardView.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 12/06/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

@IBDesignable class CardView: UIView {

    @IBInspectable var cornerRadiuss: CGFloat = 2
    @IBInspectable var shadowOffsetWidth: CGFloat = 0
    @IBInspectable var shadowOffsetHeight: CGFloat = 5
    @IBInspectable var shadowColour: UIColor = UIColor.black
    @IBInspectable var shadowOpacity: CGFloat = 0.1
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadiuss
        layer.shadowColor = shadowColour.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadiuss)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }
}
