//
//  mvaExtensions.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 19/07/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static let grayBackground = UIColor().colourFromHex("EBEBEB")
    static let cardImageColour = UIColor().colourFromHex("007E92")
    
    func colourFromHex(_ hex: String) -> UIColor {
        //make sure nor spaces and new lines in our hex string
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        //whether or not has hash tag and remove
        if hexString.hasPrefix("#"){
            hexString.remove(at: hexString.startIndex)
        }
        
        //check if colour has six characters
        if  hexString.count != 6 {
            return UIColor.black
        }
        
        var rgb: UInt32 = 0
        Scanner(string: hexString).scanHexInt32(&rgb)
        
        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0, blue: CGFloat((rgb & 0x0000FF)) / 255.0, alpha: 1.0)
    }
}