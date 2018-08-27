//
//  yendiAgoroVc.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 27/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit
import WebKit

class yendiAgoroVc: UIViewController {

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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        setUpViews()
        let param = "https://myvodafoneappmw.vodafone.com.gh/SpinAPI/index.jsp?user=0202005321|0202005321"
//        let escapedParam = param.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        if let url = URL(string: param){
            print(url)
            yendiWebView.load(URLRequest(url: url))
        }else{
            print("still error")
        }
        
    }

    func setUpViews(){
        view.addSubview(btnMenu)
        let menu_image = UIImage(named: "menu")
        btnMenu.setImage(menu_image, for: .normal)
        btnMenu.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnMenu.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        btnMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        btnMenu.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 10).isActive = true
        
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
        yendiWebView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        yendiWebView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        yendiWebView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        yendiWebView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
    }
}
