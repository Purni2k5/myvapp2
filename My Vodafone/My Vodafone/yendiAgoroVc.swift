//
//  yendiAgoroVc.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 27/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit
import WebKit

class yendiAgoroVc: baseViewControllerM, WKNavigationDelegate {

//    let preference = UserDefaults.standard
    //create a closure for hamburger
    let btnMenu: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //create a closure for refresh button
    let btnRefresh: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "progressarrow"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //create a web view
    let yendiWebView: WKWebView = {
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
        view.backgroundColor = UIColor.black
        setUpViewsYen()
        let userData = preference.object(forKey: "responseData") as! NSDictionary
        let defaultNumber = userData["Contact"] as! String
        let param = "?user=\(defaultNumber)|\(defaultNumber)"
        let escapedParam = param.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) //https://www.youtube.com/watch?v=OuG3K8vLWXg&pbjreload=10
        let fullURLString = "\(String.MVA_SPINGAME)\(escapedParam!)"
        start_activity_loader()
        yendiWebView.navigationDelegate = self
        if let url = URL(string: fullURLString){
            print(url)
            yendiWebView.load(URLRequest(url: url))
            
        }else{
            print("still error \(fullURLString)")
        }
        
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
        
    }
    
    func webView(_ webView: WKWebView,
        didFinish navigation: WKNavigation!) {
        stop_activity_loader()
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
    
    func setUpViewsYen(){
        view.addSubview(btnMenu)
        let menu_image = UIImage(named: "menu")
        btnMenu.setImage(menu_image, for: .normal)
        btnMenu.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnMenu.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        btnMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        btnMenu.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 10).isActive = true
        btnMenu.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        
        //Menu label
        let lblMenu = UILabel()
        view.addSubview(lblMenu)
        lblMenu.translatesAutoresizingMaskIntoConstraints = false
        lblMenu.textColor = UIColor.white
        lblMenu.text = "MENU"
        lblMenu.font = UIFont(name: String.defaultFontR, size: 13)
        lblMenu.topAnchor.constraint(equalTo: btnMenu.bottomAnchor, constant: 1).isActive = true
        lblMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -13).isActive = true
        
        view.addSubview(btnRefresh)
        btnRefresh.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btnRefresh.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnRefresh.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        btnRefresh.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 10).isActive = true
        
        view.addSubview(yendiWebView)
        yendiWebView.isOpaque = false
        yendiWebView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        yendiWebView.topAnchor.constraint(equalTo: lblMenu.bottomAnchor).isActive = true
        yendiWebView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        yendiWebView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        //activity loader
        view.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
