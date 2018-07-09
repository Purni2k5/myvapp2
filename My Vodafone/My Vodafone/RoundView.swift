//
//  RoundView.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 06/07/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

@IBDesignable class RoundView: UIView {
    
    @IBInspectable var divideNum: CGFloat = 2
    
    override func layoutSubviews() {
        layer.cornerRadius = frame.size.width / divideNum
        clipsToBounds = true
    }

}
