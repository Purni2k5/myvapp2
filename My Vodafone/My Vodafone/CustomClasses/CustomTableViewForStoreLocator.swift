//
//  CustomTableViewForStoreLocator.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 25/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {
    var name: String?
    var mainImage: UIImage?
    var desc: String?
    var distance: String?
    
    var lblName: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var wifiImage: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var lblDesc: UILabel = {
        var lblDesc = UILabel()
        lblDesc.translatesAutoresizingMaskIntoConstraints = false
        return lblDesc
    }()
    
    var lblDistance: UILabel = {
        var lblDistance = UILabel()
        lblDistance.translatesAutoresizingMaskIntoConstraints = false
        return lblDistance
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(wifiImage)
        self.addSubview(lblName)
        self.addSubview(lblDistance)
        self.addSubview(lblDesc)
        
        
        //Constraint for image
        wifiImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        wifiImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        wifiImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        wifiImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //Constraints for Name
        lblName.leadingAnchor.constraint(equalTo: wifiImage.trailingAnchor, constant: 20).isActive = true
        lblName.topAnchor.constraint(equalTo: self.topAnchor, constant: 22).isActive = true
        lblName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
        lblName.font = UIFont(name: String.defaultFontB, size: 20)
        lblName.textColor = UIColor.black
        lblName.numberOfLines = 0
        lblName.lineBreakMode = .byWordWrapping
        
        //Constraints for distance
        lblDistance.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        lblDistance.topAnchor.constraint(equalTo: self.topAnchor, constant: 22).isActive = true
//        lblDistance.leadingAnchor.constraint(equalTo: lblName.trailingAnchor, constant: 3).isActive = true
        lblDistance.textColor = UIColor.gray
        lblDistance.font = UIFont(name: String.defaultFontR, size: 16)
        
        //Constraints for description
        lblDesc.leadingAnchor.constraint(equalTo: wifiImage.trailingAnchor, constant: 20).isActive = true
        lblDesc.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 10).isActive = true
        lblDesc.font = UIFont(name: String.defaultFontR, size: 16)
        lblDesc.textColor = UIColor.gray
        lblDesc.numberOfLines = 0
        lblDesc.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        lblDesc.lineBreakMode = .byWordWrapping
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let name = name{
            lblName.text = name
        }
        
        if let desc = desc {
            lblDesc.text = desc
        }
        
        if let distance = distance{
            lblDistance.text = distance
        }
        if let image = mainImage{
            wifiImage.image = image
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TopUpHistoryCells: UITableViewCell {
    var date: String?
    var mainIcon: UIImage?
    var dateTime: String?
    var amount: String?
    var topUpType: String?
    
    var lbldate: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var topUpIcon: UIImageView = {
        var topUpIcon = UIImageView()
        topUpIcon.translatesAutoresizingMaskIntoConstraints = false
        return topUpIcon
    }()
    
    var lblAmount: UILabel = {
        var lblAmount = UILabel()
        lblAmount.translatesAutoresizingMaskIntoConstraints = false
        return lblAmount
    }()
    
    var lblDateTime: UILabel = {
        var lblDateTime = UILabel()
        lblDateTime.translatesAutoresizingMaskIntoConstraints = false
        return lblDateTime
    }()
    
    var lblTopUpType: UILabel = {
        var lblTopUpType = UILabel()
        lblTopUpType.translatesAutoresizingMaskIntoConstraints = false
        return lblTopUpType
    }()
    
    var separator2: UIView = {
        var separator2 = UIView()
        separator2.translatesAutoresizingMaskIntoConstraints = false
        return separator2
    }()
    
    var separator3: UIView = {
        var separator3 = UIView()
        separator3.translatesAutoresizingMaskIntoConstraints = false
        return separator3
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(lbldate)
        self.addSubview(topUpIcon)
        self.addSubview(lblAmount)
        self.addSubview(lblDateTime)
        self.addSubview(lblTopUpType)
        self.addSubview(separator2)
        self.addSubview(separator3)
        
        //Constraints for date
        lbldate.translatesAutoresizingMaskIntoConstraints = false
        lbldate.font = UIFont(name: String.defaultFontB, size: 18)
        lbldate.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        lbldate.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        lbldate.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        //Constraints for separator2
//        separator2.translatesAutoresizingMaskIntoConstraints = false
//        separator2.backgroundColor = UIColor.gray.withAlphaComponent(0.10)
//        separator2.heightAnchor.constraint(equalToConstant: 2).isActive = true
//        separator2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
//        separator2.topAnchor.constraint(equalTo: lbldate.bottomAnchor, constant: 10).isActive = true
//        separator2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        topUpIcon.translatesAutoresizingMaskIntoConstraints = false
        topUpIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        topUpIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        topUpIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        topUpIcon.topAnchor.constraint(equalTo: lbldate.bottomAnchor, constant: 10).isActive = true
        
        lblDateTime.translatesAutoresizingMaskIntoConstraints = false
        lblDateTime.font = UIFont(name: String.defaultFontR, size: 15)
        lblDateTime.textColor = UIColor.black
        lblDateTime.leadingAnchor.constraint(equalTo: topUpIcon.trailingAnchor, constant: 10).isActive = true
        lblDateTime.topAnchor.constraint(equalTo: lbldate.bottomAnchor, constant: 25).isActive = true
        lblDateTime.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
        lblAmount.translatesAutoresizingMaskIntoConstraints = false
        lblAmount.textColor = UIColor.black
        lblAmount.font = UIFont(name: String.defaultFontB, size: 18)
        lblAmount.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        lblAmount.topAnchor.constraint(equalTo: lbldate.bottomAnchor, constant: 25).isActive = true
        
        lblTopUpType.translatesAutoresizingMaskIntoConstraints = false
        lblTopUpType.font = UIFont(name: String.defaultFontR, size: 14)
        lblTopUpType.textColor = UIColor.black
        lblTopUpType.leadingAnchor.constraint(equalTo: topUpIcon.trailingAnchor, constant: 10).isActive = true
        lblTopUpType.topAnchor.constraint(equalTo: lblDateTime.bottomAnchor, constant: 8).isActive = true
        lblTopUpType.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        lblTopUpType.numberOfLines = 0
        lblTopUpType.lineBreakMode = .byWordWrapping
        
//        separator3.translatesAutoresizingMaskIntoConstraints = false
//        separator3.backgroundColor = UIColor.gray.withAlphaComponent(0.10)
//        separator3.heightAnchor.constraint(equalToConstant: 2).isActive = true
//        separator3.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
//        separator3.topAnchor.constraint(equalTo: lblTopUpType.bottomAnchor, constant: 20).isActive = true
//        separator3.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let date = date{
            lbldate.text = date
        }
        
        if let dateTime = dateTime {
            lblDateTime.text = dateTime
        }
        
        if let amount = amount{
            lblAmount.text = amount
        }
        if let topUpType = topUpType{
            lblTopUpType.text = topUpType
        }
        if let image = mainIcon{
            topUpIcon.image = image
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
