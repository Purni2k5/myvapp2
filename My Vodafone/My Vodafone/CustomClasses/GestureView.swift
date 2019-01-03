//
//  GestureView.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 06/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import Foundation
import UIKit

class GesturesView: UIView {
    var offerVariable: String?
    var offerPrice: String?
    var offerDescription: String?
    var offerPID: String?
    var offerUSSD: String?
}

class ChangeFBBPlan: UIView {
    var planName: String?
    var planPID: String?
    var planID: String?
    var planPrice: String?
    var planUSSDURL: String?
}

class StaffDataAllocation: UIView {
    var msisdn: String?
    var displayAmt: String?
}

class UserDetailsCard: UIView {
    var msisdn: String?
    var displayName: String?
    var accountType: String?
    var userID: String?
    var accountNumber: String?
    var ID: String?
    var displayImageUrl: String?
}

class SingleVariable: UIView {
    var senderVariable: String?
}

class RadioButton: UIButton {
    var serviceID: String?
}

class ButtonUnsubscribe: UIButton {
    var plan: String?
    var msisdn: String?
    var expireData: String?
    var promotionID: String?
}

class ConfirmXShake: UIButton {
    var name: String?
    var desc: String?
    var price: String?
    var pid: String?
}

class made4MeVariables: UIView {
    var price: String?
    var volume: String?
    var name: String?
    var bundleid: String?
    var short: String?
    var currency: String?
    var validity: String?
    var long: String?
}

class previousSpendCards: UIView {
    var variableDictionary: NSDictionary?
}
