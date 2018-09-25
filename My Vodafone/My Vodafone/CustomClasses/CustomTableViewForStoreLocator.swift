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
