//
//  simSwapModal.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 13/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit
import WebKit

class simSwapModal: baseViewControllerM {

    let grayTop: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        simSwapSetup()
    }

    override var prefersStatusBarHidden: Bool{
        return true
    }

    func simSwapSetup(){
        view.addSubview(grayTop)
        grayTop.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        grayTop.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        grayTop.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        grayTop.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        let btnClose = UIButton()
        grayTop.addSubview(btnClose)
        let close_image = UIImage(named: "ic_close")
        btnClose.setImage(close_image, for: .normal)
        btnClose.translatesAutoresizingMaskIntoConstraints = false
        btnClose.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnClose.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnClose.topAnchor.constraint(equalTo: grayTop.topAnchor, constant: 20).isActive = true
        btnClose.trailingAnchor.constraint(equalTo: grayTop.trailingAnchor, constant: -10).isActive = true
        btnClose.addTarget(self, action: #selector(closeModalB), for: .touchUpInside)
        
        let lblHeader = UILabel()
        grayTop.addSubview(lblHeader)
        lblHeader.translatesAutoresizingMaskIntoConstraints = false
        lblHeader.text = "Sim Swap"
        lblHeader.textColor = UIColor.white
        lblHeader.textAlignment = .center
        lblHeader.font = UIFont(name: String.defaultFontR, size: 31)
        lblHeader.leadingAnchor.constraint(equalTo: grayTop.leadingAnchor, constant: 20).isActive = true
        lblHeader.trailingAnchor.constraint(equalTo: grayTop.trailingAnchor, constant: -20).isActive = true
        lblHeader.topAnchor.constraint(equalTo: grayTop.topAnchor, constant: 90).isActive = true
        
        let webView = WKWebView()
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: grayTop.bottomAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
        let url = Bundle.main.url(forResource: "simswap", withExtension: "html")
        webView.load(URLRequest(url: url!))
        
        let btnProceed = UIButton()
        webView.addSubview(btnProceed)
        btnProceed.translatesAutoresizingMaskIntoConstraints = false
        btnProceed.backgroundColor = UIColor.vodaRed
        btnProceed.setTitle("Proceed", for: .normal)
        btnProceed.titleLabel?.font = UIFont(name: String.defaultFontR, size: 22)
        btnProceed.setTitleColor(UIColor.white, for: .normal)
        btnProceed.leadingAnchor.constraint(equalTo: webView.leadingAnchor, constant: 20).isActive = true
        btnProceed.trailingAnchor.constraint(equalTo: webView.trailingAnchor, constant: -20).isActive = true
        btnProceed.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        btnProceed.heightAnchor.constraint(equalToConstant: 55).isActive = true
        btnProceed.addTarget(self, action: #selector(goToSimSwapForm), for: .touchUpInside)
    }
    
    @objc func goToSimSwapForm(){
        let storyboard = UIStoryboard(name: "Services", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "simSwapForm")
        present(moveTo, animated: true, completion: nil)
    }
    
}
