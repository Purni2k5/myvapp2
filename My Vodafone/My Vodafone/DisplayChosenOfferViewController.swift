//
//  DisplayChosenOfferViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 25/07/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class DisplayChosenOfferViewController: UIViewController {

    @IBOutlet var superView: UIView!
    
    //create closure for top Image
    let appBackImage: UIImageView = {
        let topImage = UIImageView(image: #imageLiteral(resourceName: "bg2"))
        topImage.translatesAutoresizingMaskIntoConstraints = false
        topImage.contentMode = .scaleAspectFill
        return topImage
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Change view's background colour
        superView.backgroundColor = UIColor.grayBackground
        setUpViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setUpViews(){
        //top Image
        superView.addSubview(appBackImage)
        appBackImage.PinTopImage(view: self.view)
        
    }

}

extension UIView {
    //for top image
    func PinTopImage(view: UIView){
        self.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *){
            print("yes 11")
        return safeAreaLayoutGuide.topAnchor
        }
        return topAnchor
    }
    
}
