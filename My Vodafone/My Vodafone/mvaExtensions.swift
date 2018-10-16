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
    static let vodaRed = UIColor().colourFromHex("E60000")
    static let vodaIconColour = UIColor().colourFromHex("00B0CA")
    static let grayButton = UIColor().colourFromHex("4A4D4E")
    static let colour_red_voilet = UIColor().colourFromHex("9C2AA0")
    static let colour_red_voilet_30 = UIColor().colourFromHex("4D9C2AA0")
    static let dark_background = UIColor().colourFromHex("333333")
    static let support_white1 = UIColor().colourFromHex("F4F4F4")
    static let support_light_gray = UIColor().colourFromHex("CCCCCC")
    static let support_voilet = UIColor().colourFromHex("9C2AA0")
    static let support_dark_voilet = UIColor().colourFromHex("5E2750")
    static let support_dark_gray1 = UIColor().colourFromHex("999999")
    static let support_dark_gray2 = UIColor().colourFromHex("666666")
    static let dark_gray_60 = UIColor().colourFromHex("99333333")
    static let color_light_gray_30 = UIColor().colourFromHex("4D929292")
    static let support_yellow = UIColor().colourFromHex("FEC800")
    
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

extension String {
    static let defaultFontR = "VodafoneRg-Regular"
    static let defaultFontB = "VodafoneRg-Bold"
    static let offers = "https://myvodafoneappmw.vodafone.com.gh/MyVodafoneAPI/DBEnpoints"
    static let buyPackage = "https://myvodafoneappmw.vodafone.com.gh/MyVodafoneAPI/User"
    static let userSVC = "https://myvodafoneappmw.vodafone.com.gh/MyVodafoneAPI/UserSvc"
    static let userURL = "https://myvodafoneappmw.vodafone.com.gh/MyVodafoneAPI/User"
    
    /*Support URLs*/
    static let MVA_CUSTOMER_CENTER = "100";
    static let MVA_BUSINESS_SOLUTIONS = "080010000";
    static let MVA_WHATSAPP = "233501000300";
    static let MVA_SUPPORT = "http://support.vodafone.com.gh";
    static let MVA_FACEBOOK = "https://www.facebook.com/vodafoneghana";
    static let MVA_YOUTUBE = "https://www.youtube.com/playlist?list=PLmSKS7hb1xaTPBGcQ9DGgPxUdrcI8JVmP";
    static let MVA_TWITTER = "https://twitter.com/Askvodafonegh";
    static let MVA_SHOPURL = "http://vodafone.com.gh/vodafone-shop";
    static let MVA_BOOKINGURL = "http://appointmentbooking.vodafone.com.gh";
    static let MVA_FBBURL = "http://fbb.vodafone.com.gh/residential.php";
    static let MVA_FBBRELOCATIONURL = "http://fbb.vodafone.com.gh/relocation.php";
    static let MVA_PROFILEUPLOAD = "https://myvodafoneapp.vodafone.com.gh/voda_port/myvodafone/ProfilePic.php";
    static let MVA_SERVICEPICUPLOAD = "https://myvodafoneapp.vodafone.com.gh/voda_port/myvodafone/ServicePic.php";
    static let MVA_SPINGAME = "https://myvodafoneappmw.vodafone.com.gh/SpinAPI/index.jsp";
    static let MVA_SUPPPORT_EMAIL = "info.gh@vodafone.com";
    static let MVA_FBBMOVE = "https://myvodafoneappmw.vodafone.com.gh/MyVodafoneAPI/ProjectNkrumah";
    static let MVA_ROAMINGDISCOUNTS = "https://myvodafoneapp.vodafone.com.gh/voda_port/roaming/roamingdiscounts.html";
    static let MVA_ROAMINGFAQ = "https://myvodafoneapp.vodafone.com.gh/voda_port/roaming/roaming_faq.html";
    static let MVA_SHAKE_PROMOS = "https://myvodafoneappmw.vodafone.com.gh/MyVodafoneAPI/Promos";
}
