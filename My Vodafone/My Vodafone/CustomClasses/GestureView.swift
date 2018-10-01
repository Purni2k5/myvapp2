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
}

class SingleVariable: UIView {
    var senderVariable: String?
}

class RadioButton: UIButton {
    var serviceID: String?
}
