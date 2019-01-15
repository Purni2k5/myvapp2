//
//  fleetPackages.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 15/01/2019.
//  Copyright © 2019 Chef Dennis Barimah. All rights reserved.
//

import UIKit
import WebKit

class fleetPackages: baseViewControllerM, WKNavigationDelegate {
    
    
    let btnClose: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //create a web view
    let fleetWebView: WKWebView = {
        let view = WKWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    //create activity loader closure
    let activity_loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        view.hidesWhenStopped = true
        view.color = UIColor.vodaRed
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpViewsFleet()
        start_activity_loader()
        fleetWebView.navigationDelegate = self
        if let url = URL(string: String.fleetPackages){
            fleetWebView.load(URLRequest(url: url))
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        stop_activity_loader()
        //        view.backgroundColor = UIColor.grayBackground
    }
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
    }
    
    //Function to startIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
        
    }
    
    func setUpViewsFleet(){
        
        
        view.addSubview(fleetWebView)
        fleetWebView.isOpaque = false
        fleetWebView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        fleetWebView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        fleetWebView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        fleetWebView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        fleetWebView.addSubview(btnClose)
        let menu_image = UIImage(named: "ic_close")
        let tintImage = menu_image?.withRenderingMode(.alwaysTemplate)
        btnClose.setImage(tintImage, for: .normal)
        btnClose.tintColor = UIColor.vodaRed
        btnClose.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnClose.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        btnClose.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        btnClose.topAnchor.constraint(equalTo: fleetWebView.topAnchor, constant: 20).isActive = true
        btnClose.addTarget(self, action: #selector(closeModalB), for: .touchUpInside)
        
        //activity loader
        view.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
}
