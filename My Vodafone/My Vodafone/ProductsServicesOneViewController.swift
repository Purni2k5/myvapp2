//
//  ProductsServicesOneViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 19/07/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class ProductsServicesOneViewController: UIViewController {
    @IBOutlet var superViews: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // change superviews colour
        superViews.backgroundColor = UIColor.grayBackground
        let scroller = UIScrollView()
        view.addSubview(scroller)
        scroller.translatesAutoresizingMaskIntoConstraints = false
        scroller.contentSize.height = 2000
        scroller.backgroundColor = UIColor.grayBackground
        
        scroller.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scroller.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scroller.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scroller.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
