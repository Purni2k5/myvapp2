//
//  supportVC.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 20/08/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class supportVC: UIViewController {

    
    //create a closure for background Image
    let backImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //create a motherView
    let motherView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    //create a scrollView
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    //create cardView
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    //create support header view
    let supportHView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.support_white1
        return view
    }()
    
    //support icon red
    let supportIcon = UIImageView(image: #imageLiteral(resourceName: "support_red"))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        checkConnection()
    }

    func setUpViews(){
        view.addSubview(backImage)
        backImage.image = UIImage(named: "morning_bg_")
        backImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backImage.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        backImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backImage.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
        view.addSubview(motherView)
        motherView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        motherView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        motherView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        motherView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
        motherView.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: motherView.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: motherView.safeTopAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: motherView.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: motherView.safeBottomAnchor).isActive = true
        scrollView.contentSize.height = 1310
        
        scrollView.addSubview(cardView)
        cardView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 25).isActive = true
        cardView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40).isActive = true
        cardView.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -25).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 1200).isActive = true
        cardView.layer.cornerRadius = 30
        
        scrollView.addSubview(supportHView)
        supportHView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        supportHView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        supportHView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 30).isActive = true
        supportHView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        scrollView.addSubview(supportIcon)
        supportIcon.translatesAutoresizingMaskIntoConstraints = false
        supportIcon.leadingAnchor.constraint(equalTo: supportHView.leadingAnchor, constant: 20).isActive = true
        supportIcon.widthAnchor.constraint(equalToConstant: 45).isActive = true
        supportIcon.heightAnchor.constraint(equalToConstant: 45).isActive = true
        supportIcon.topAnchor.constraint(equalTo: supportHView.topAnchor, constant: 20).isActive = true
        
        //Support label
        let lblSupport = UILabel()
        scrollView.addSubview(lblSupport)
        lblSupport.translatesAutoresizingMaskIntoConstraints = false
        lblSupport.textColor = UIColor.black
        lblSupport.font = UIFont(name: String.defaultFontR, size: 22)
        lblSupport.text = "Support"
        lblSupport.leadingAnchor.constraint(equalTo: supportIcon.trailingAnchor, constant: 10).isActive = true
        lblSupport.topAnchor.constraint(equalTo: supportHView.topAnchor, constant: 30).isActive = true
        
        //close button
        let btnClose = UIButton()
        scrollView.addSubview(btnClose)
        btnClose.translatesAutoresizingMaskIntoConstraints = false
        let close_image = UIImage(named: "close_black")
        btnClose.setImage(close_image, for: .normal)
        btnClose.trailingAnchor.constraint(equalTo: supportHView.trailingAnchor, constant: -10).isActive = true
        btnClose.topAnchor.constraint(equalTo: supportHView.topAnchor, constant: 30).isActive = true
        btnClose.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btnClose.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnClose.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        
        //dark gray to hold cards
        let darkGrayCard = UIView()
        scrollView.addSubview(darkGrayCard)
        darkGrayCard.translatesAutoresizingMaskIntoConstraints = false
        darkGrayCard.backgroundColor = UIColor.support_light_gray
        darkGrayCard.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        darkGrayCard.topAnchor.constraint(equalTo: supportHView.bottomAnchor, constant: 20).isActive = true
        darkGrayCard.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        darkGrayCard.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20).isActive = true
        
        // Talk to an agent
        let talkToAgent = UIView()
        scrollView.addSubview(talkToAgent)
        talkToAgent.translatesAutoresizingMaskIntoConstraints = false
        talkToAgent.backgroundColor = UIColor.white
        talkToAgent.leadingAnchor.constraint(equalTo: darkGrayCard.leadingAnchor, constant: 20).isActive = true
        talkToAgent.trailingAnchor.constraint(equalTo: darkGrayCard.trailingAnchor, constant: -20).isActive = true
        talkToAgent.topAnchor.constraint(equalTo: darkGrayCard.topAnchor, constant: 20).isActive = true
        talkToAgent.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        let talkRec = UITapGestureRecognizer(target: self, action: #selector(self.talkToAgent))
        talkToAgent.addGestureRecognizer(talkRec)
        
        // icon
        let talkToAgentIcon = UIImageView(image: #imageLiteral(resourceName: "ic_headset"))
        scrollView.addSubview(talkToAgentIcon)
        talkToAgentIcon.translatesAutoresizingMaskIntoConstraints = false
        talkToAgentIcon.widthAnchor.constraint(equalToConstant: 35).isActive = true
        talkToAgentIcon.heightAnchor.constraint(equalToConstant: 35).isActive = true
        talkToAgentIcon.leadingAnchor.constraint(equalTo: talkToAgent.leadingAnchor, constant: 10).isActive = true
        talkToAgentIcon.topAnchor.constraint(equalTo: talkToAgent.topAnchor, constant: 20).isActive = true
        
        //Label
        let lblTalkToAgent = UILabel()
        scrollView.addSubview(lblTalkToAgent)
        lblTalkToAgent.translatesAutoresizingMaskIntoConstraints = false
        lblTalkToAgent.text = "Talk to an agent"
        lblTalkToAgent.font = UIFont(name: String.defaultFontR, size: 18)
        lblTalkToAgent.textColor = UIColor.black
        lblTalkToAgent.leadingAnchor.constraint(equalTo: talkToAgentIcon.trailingAnchor, constant: 5).isActive = true
        lblTalkToAgent.topAnchor.constraint(equalTo: talkToAgent.topAnchor, constant: 30).isActive = true
        
        //arrow right
        let arrowRight = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        scrollView.addSubview(arrowRight)
        arrowRight.translatesAutoresizingMaskIntoConstraints = false
        arrowRight.widthAnchor.constraint(equalToConstant: 10).isActive = true
        arrowRight.heightAnchor.constraint(equalToConstant: 25).isActive = true
        arrowRight.topAnchor.constraint(equalTo: talkToAgent.topAnchor, constant: 30).isActive = true
        arrowRight.trailingAnchor.constraint(equalTo: talkToAgent.trailingAnchor, constant: -10).isActive = true
        
        // Business soln
        let businessSoln = UIView()
        scrollView.addSubview(businessSoln)
        businessSoln.translatesAutoresizingMaskIntoConstraints = false
        businessSoln.backgroundColor = UIColor.white
        businessSoln.leadingAnchor.constraint(equalTo: darkGrayCard.leadingAnchor, constant: 20).isActive = true
        businessSoln.trailingAnchor.constraint(equalTo: darkGrayCard.trailingAnchor, constant: -20).isActive = true
        businessSoln.topAnchor.constraint(equalTo: talkToAgent.bottomAnchor, constant: 20).isActive = true
        businessSoln.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        let businessRec = UITapGestureRecognizer(target: self, action: #selector(self.businessSolution(_sender:)))
        businessSoln.addGestureRecognizer(businessRec)
        
        // icon
        let businessSolnIcon = UIImageView(image: #imageLiteral(resourceName: "ic_transfer"))
        scrollView.addSubview(businessSolnIcon)
        businessSolnIcon.translatesAutoresizingMaskIntoConstraints = false
        businessSolnIcon.widthAnchor.constraint(equalToConstant: 35).isActive = true
        businessSolnIcon.heightAnchor.constraint(equalToConstant: 35).isActive = true
        businessSolnIcon.leadingAnchor.constraint(equalTo: businessSoln.leadingAnchor, constant: 10).isActive = true
        businessSolnIcon.topAnchor.constraint(equalTo: businessSoln.topAnchor, constant: 20).isActive = true
        
        //Label
        let lblbusinessSoln = UILabel()
        scrollView.addSubview(lblbusinessSoln)
        lblbusinessSoln.translatesAutoresizingMaskIntoConstraints = false
        lblbusinessSoln.text = " Business Solutions"
        lblbusinessSoln.numberOfLines = 0
        lblbusinessSoln.lineBreakMode = .byWordWrapping
        lblbusinessSoln.font = UIFont(name: String.defaultFontR, size: 18)
        lblbusinessSoln.textColor = UIColor.black
        lblbusinessSoln.leadingAnchor.constraint(equalTo: talkToAgentIcon.trailingAnchor, constant: 5).isActive = true
//        lblbusinessSoln.trailingAnchor.constraint(equalTo: businessarrowRight.leadingAnchor, constant: 10).isActive = true
        lblbusinessSoln.topAnchor.constraint(equalTo: businessSoln.topAnchor, constant: 30).isActive = true
        
        //arrow right
        let businessarrowRight = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        scrollView.addSubview(businessarrowRight)
        businessarrowRight.translatesAutoresizingMaskIntoConstraints = false
        businessarrowRight.widthAnchor.constraint(equalToConstant: 10).isActive = true
        businessarrowRight.heightAnchor.constraint(equalToConstant: 25).isActive = true
        businessarrowRight.topAnchor.constraint(equalTo: businessSoln.topAnchor, constant: 30).isActive = true
        businessarrowRight.trailingAnchor.constraint(equalTo: businessSoln.trailingAnchor, constant: -10).isActive = true
        
        // Send Mail
        let sendMail = UIView()
        scrollView.addSubview(sendMail)
        sendMail.translatesAutoresizingMaskIntoConstraints = false
        sendMail.backgroundColor = UIColor.white
        sendMail.leadingAnchor.constraint(equalTo: darkGrayCard.leadingAnchor, constant: 20).isActive = true
        sendMail.trailingAnchor.constraint(equalTo: darkGrayCard.trailingAnchor, constant: -20).isActive = true
        sendMail.topAnchor.constraint(equalTo: businessSoln.bottomAnchor, constant: 20).isActive = true
        sendMail.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        let sendMailRec = UITapGestureRecognizer(target: self, action: #selector(self.sendEmail(_sender:)))
        sendMail.addGestureRecognizer(sendMailRec)
        
        // icon
        let sendMailIcon = UIImageView(image: #imageLiteral(resourceName: "ic_email"))
        scrollView.addSubview(sendMailIcon)
        sendMailIcon.translatesAutoresizingMaskIntoConstraints = false
        sendMailIcon.widthAnchor.constraint(equalToConstant: 35).isActive = true
        sendMailIcon.heightAnchor.constraint(equalToConstant: 35).isActive = true
        sendMailIcon.leadingAnchor.constraint(equalTo: sendMail.leadingAnchor, constant: 10).isActive = true
        sendMailIcon.topAnchor.constraint(equalTo: sendMail.topAnchor, constant: 20).isActive = true
        
        //Label
        let lblsendEmail = UILabel()
        scrollView.addSubview(lblsendEmail)
        lblsendEmail.translatesAutoresizingMaskIntoConstraints = false
        lblsendEmail.text = "Send us an email"
        lblsendEmail.font = UIFont(name: String.defaultFontR, size: 18)
        lblsendEmail.textColor = UIColor.black
        lblsendEmail.leadingAnchor.constraint(equalTo: sendMailIcon.trailingAnchor, constant: 5).isActive = true
        lblsendEmail.topAnchor.constraint(equalTo: sendMail.topAnchor, constant: 30).isActive = true
        
        //arrow right
        let sendarrowRight = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        scrollView.addSubview(sendarrowRight)
        sendarrowRight.translatesAutoresizingMaskIntoConstraints = false
        sendarrowRight.widthAnchor.constraint(equalToConstant: 10).isActive = true
        sendarrowRight.heightAnchor.constraint(equalToConstant: 25).isActive = true
        sendarrowRight.topAnchor.constraint(equalTo: sendMail.topAnchor, constant: 30).isActive = true
        sendarrowRight.trailingAnchor.constraint(equalTo: sendMail.trailingAnchor, constant: -10).isActive = true
        
        // Facebook
        let facebook = UIView()
        scrollView.addSubview(facebook)
        facebook.translatesAutoresizingMaskIntoConstraints = false
        facebook.backgroundColor = UIColor.white
        facebook.leadingAnchor.constraint(equalTo: darkGrayCard.leadingAnchor, constant: 20).isActive = true
        facebook.trailingAnchor.constraint(equalTo: darkGrayCard.trailingAnchor, constant: -20).isActive = true
        facebook.topAnchor.constraint(equalTo: sendMail.bottomAnchor, constant: 20).isActive = true
        facebook.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        let facebookRec = UITapGestureRecognizer(target: self, action: #selector(self.openFacebook(_sender:)))
        facebook.addGestureRecognizer(facebookRec)
        
        // icon
        let facebookIcon = UIImageView(image: #imageLiteral(resourceName: "ic_facebook"))
        scrollView.addSubview(facebookIcon)
        facebookIcon.translatesAutoresizingMaskIntoConstraints = false
        facebookIcon.widthAnchor.constraint(equalToConstant: 35).isActive = true
        facebookIcon.heightAnchor.constraint(equalToConstant: 35).isActive = true
        facebookIcon.leadingAnchor.constraint(equalTo: facebook.leadingAnchor, constant: 10).isActive = true
        facebookIcon.topAnchor.constraint(equalTo: facebook.topAnchor, constant: 20).isActive = true
        
        //Label
        let lblFacebook = UILabel()
        scrollView.addSubview(lblFacebook)
        lblFacebook.translatesAutoresizingMaskIntoConstraints = false
        lblFacebook.text = "Facebook"
        lblFacebook.font = UIFont(name: String.defaultFontR, size: 18)
        lblFacebook.textColor = UIColor.black
        lblFacebook.leadingAnchor.constraint(equalTo: facebookIcon.trailingAnchor, constant: 5).isActive = true
        lblFacebook.topAnchor.constraint(equalTo: facebook.topAnchor, constant: 30).isActive = true
        
        //arrow right
        let facebookarrowRight = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        scrollView.addSubview(facebookarrowRight)
        facebookarrowRight.translatesAutoresizingMaskIntoConstraints = false
        facebookarrowRight.widthAnchor.constraint(equalToConstant: 10).isActive = true
        facebookarrowRight.heightAnchor.constraint(equalToConstant: 25).isActive = true
        facebookarrowRight.topAnchor.constraint(equalTo: facebook.topAnchor, constant: 30).isActive = true
        facebookarrowRight.trailingAnchor.constraint(equalTo: facebook.trailingAnchor, constant: -10).isActive = true
        
        // Twitter
        let twitter = UIView()
        scrollView.addSubview(twitter)
        twitter.translatesAutoresizingMaskIntoConstraints = false
        twitter.backgroundColor = UIColor.white
        twitter.leadingAnchor.constraint(equalTo: darkGrayCard.leadingAnchor, constant: 20).isActive = true
        twitter.trailingAnchor.constraint(equalTo: darkGrayCard.trailingAnchor, constant: -20).isActive = true
        twitter.topAnchor.constraint(equalTo: facebook.bottomAnchor, constant: 20).isActive = true
        twitter.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        let twitterRec = UITapGestureRecognizer(target: self, action: #selector(self.openTwitter(_sender:)))
        twitter.addGestureRecognizer(twitterRec)
        
        // icon
        let twitterIcon = UIImageView(image: #imageLiteral(resourceName: "ic_twitter"))
        scrollView.addSubview(twitterIcon)
        twitterIcon.translatesAutoresizingMaskIntoConstraints = false
        twitterIcon.widthAnchor.constraint(equalToConstant: 35).isActive = true
        twitterIcon.heightAnchor.constraint(equalToConstant: 35).isActive = true
        twitterIcon.leadingAnchor.constraint(equalTo: twitter.leadingAnchor, constant: 10).isActive = true
        twitterIcon.topAnchor.constraint(equalTo: twitter.topAnchor, constant: 20).isActive = true
        
        //Label
        let lblTwitter = UILabel()
        scrollView.addSubview(lblTwitter)
        lblTwitter.translatesAutoresizingMaskIntoConstraints = false
        lblTwitter.text = "Twitter"
        lblTwitter.font = UIFont(name: String.defaultFontR, size: 18)
        lblTwitter.textColor = UIColor.black
        lblTwitter.leadingAnchor.constraint(equalTo: twitterIcon.trailingAnchor, constant: 5).isActive = true
        lblTwitter.topAnchor.constraint(equalTo: twitter.topAnchor, constant: 30).isActive = true
        
        //arrow right
        let twitterarrowRight = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        scrollView.addSubview(twitterarrowRight)
        twitterarrowRight.translatesAutoresizingMaskIntoConstraints = false
        twitterarrowRight.widthAnchor.constraint(equalToConstant: 10).isActive = true
        twitterarrowRight.heightAnchor.constraint(equalToConstant: 25).isActive = true
        twitterarrowRight.topAnchor.constraint(equalTo: twitter.topAnchor, constant: 30).isActive = true
        twitterarrowRight.trailingAnchor.constraint(equalTo: twitter.trailingAnchor, constant: -10).isActive = true
        
        // Youtube
        let youtube = UIView()
        scrollView.addSubview(youtube)
        youtube.translatesAutoresizingMaskIntoConstraints = false
        youtube.backgroundColor = UIColor.white
        youtube.leadingAnchor.constraint(equalTo: darkGrayCard.leadingAnchor, constant: 20).isActive = true
        youtube.trailingAnchor.constraint(equalTo: darkGrayCard.trailingAnchor, constant: -20).isActive = true
        youtube.topAnchor.constraint(equalTo: twitter.bottomAnchor, constant: 20).isActive = true
        youtube.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        let youtubeRec = UITapGestureRecognizer(target: self, action: #selector(self.openYoutube(_sender:)))
        youtube.addGestureRecognizer(youtubeRec)
        
        // icon
        let youtubeIcon = UIImageView(image: #imageLiteral(resourceName: "ic_youtube"))
        scrollView.addSubview(youtubeIcon)
        youtubeIcon.translatesAutoresizingMaskIntoConstraints = false
        youtubeIcon.widthAnchor.constraint(equalToConstant: 35).isActive = true
        youtubeIcon.heightAnchor.constraint(equalToConstant: 35).isActive = true
        youtubeIcon.leadingAnchor.constraint(equalTo: youtube.leadingAnchor, constant: 10).isActive = true
        youtubeIcon.topAnchor.constraint(equalTo: youtube.topAnchor, constant: 20).isActive = true
        
        //Label
        let lblYoutube = UILabel()
        scrollView.addSubview(lblYoutube)
        lblYoutube.translatesAutoresizingMaskIntoConstraints = false
        lblYoutube.text = "Youtube"
        lblYoutube.font = UIFont(name: String.defaultFontR, size: 18)
        lblYoutube.textColor = UIColor.black
        lblYoutube.leadingAnchor.constraint(equalTo: youtubeIcon.trailingAnchor, constant: 5).isActive = true
        lblYoutube.topAnchor.constraint(equalTo: youtube.topAnchor, constant: 30).isActive = true
        
        //arrow right
        let youtubearrowRight = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        scrollView.addSubview(youtubearrowRight)
        youtubearrowRight.translatesAutoresizingMaskIntoConstraints = false
        youtubearrowRight.widthAnchor.constraint(equalToConstant: 10).isActive = true
        youtubearrowRight.heightAnchor.constraint(equalToConstant: 25).isActive = true
        youtubearrowRight.topAnchor.constraint(equalTo: youtube.topAnchor, constant: 30).isActive = true
        youtubearrowRight.trailingAnchor.constraint(equalTo: youtube.trailingAnchor, constant: -10).isActive = true
        
        // Online support
        let onlineSupport = UIView()
        scrollView.addSubview(onlineSupport)
        onlineSupport.translatesAutoresizingMaskIntoConstraints = false
        onlineSupport.backgroundColor = UIColor.white
        onlineSupport.leadingAnchor.constraint(equalTo: darkGrayCard.leadingAnchor, constant: 20).isActive = true
        onlineSupport.trailingAnchor.constraint(equalTo: darkGrayCard.trailingAnchor, constant: -20).isActive = true
        onlineSupport.topAnchor.constraint(equalTo: twitter.bottomAnchor, constant: 20).isActive = true
        onlineSupport.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        let onlineSupportRec = UITapGestureRecognizer(target: self, action: #selector(self.openSupport(_sender:)))
        onlineSupport.addGestureRecognizer(onlineSupportRec)
        
        // icon
        let onlineIcon = UIImageView(image: #imageLiteral(resourceName: "ic_online_support"))
        scrollView.addSubview(onlineIcon)
        onlineIcon.translatesAutoresizingMaskIntoConstraints = false
        onlineIcon.widthAnchor.constraint(equalToConstant: 35).isActive = true
        onlineIcon.heightAnchor.constraint(equalToConstant: 35).isActive = true
        onlineIcon.leadingAnchor.constraint(equalTo: onlineSupport.leadingAnchor, constant: 10).isActive = true
        onlineIcon.topAnchor.constraint(equalTo: onlineSupport.topAnchor, constant: 20).isActive = true
        
        //Label
        let lblOnline = UILabel()
        scrollView.addSubview(lblOnline)
        lblOnline.translatesAutoresizingMaskIntoConstraints = false
        lblOnline.text = "Online Support"
        lblOnline.font = UIFont(name: String.defaultFontR, size: 18)
        lblOnline.textColor = UIColor.black
        lblOnline.leadingAnchor.constraint(equalTo: onlineIcon.trailingAnchor, constant: 5).isActive = true
        lblOnline.topAnchor.constraint(equalTo: onlineSupport.topAnchor, constant: 30).isActive = true
        
        //arrow right
        let onlinearrowRight = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        scrollView.addSubview(onlinearrowRight)
        onlinearrowRight.translatesAutoresizingMaskIntoConstraints = false
        onlinearrowRight.widthAnchor.constraint(equalToConstant: 10).isActive = true
        onlinearrowRight.heightAnchor.constraint(equalToConstant: 25).isActive = true
        onlinearrowRight.topAnchor.constraint(equalTo: onlineSupport.topAnchor, constant: 30).isActive = true
        onlinearrowRight.trailingAnchor.constraint(equalTo: onlineSupport.trailingAnchor, constant: -10).isActive = true
        
        // Whatspp
        let whatsapp = UIView()
        scrollView.addSubview(whatsapp)
        whatsapp.translatesAutoresizingMaskIntoConstraints = false
        whatsapp.backgroundColor = UIColor.white
        whatsapp.leadingAnchor.constraint(equalTo: darkGrayCard.leadingAnchor, constant: 20).isActive = true
        whatsapp.trailingAnchor.constraint(equalTo: darkGrayCard.trailingAnchor, constant: -20).isActive = true
        whatsapp.topAnchor.constraint(equalTo: onlineSupport.bottomAnchor, constant: 20).isActive = true
        whatsapp.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        let whatsppRec = UITapGestureRecognizer(target: self, action: #selector(self.openWhatsapp(_sender:)))
        whatsapp.addGestureRecognizer(whatsppRec)
        
        // icon
        let whatsAppcon = UIImageView(image: #imageLiteral(resourceName: "ic_whatsapp"))
        scrollView.addSubview(whatsAppcon)
        whatsAppcon.translatesAutoresizingMaskIntoConstraints = false
        whatsAppcon.widthAnchor.constraint(equalToConstant: 35).isActive = true
        whatsAppcon.heightAnchor.constraint(equalToConstant: 35).isActive = true
        whatsAppcon.leadingAnchor.constraint(equalTo: whatsapp.leadingAnchor, constant: 10).isActive = true
        whatsAppcon.topAnchor.constraint(equalTo: whatsapp.topAnchor, constant: 20).isActive = true
        
        //Label
        let lblWhatsapp = UILabel()
        scrollView.addSubview(lblWhatsapp)
        lblWhatsapp.translatesAutoresizingMaskIntoConstraints = false
        lblWhatsapp.text = "Whatsapp Support"
        lblWhatsapp.font = UIFont(name: String.defaultFontR, size: 18)
        lblWhatsapp.textColor = UIColor.black
        lblWhatsapp.leadingAnchor.constraint(equalTo: whatsAppcon.trailingAnchor, constant: 5).isActive = true
        lblWhatsapp.topAnchor.constraint(equalTo: whatsapp.topAnchor, constant: 30).isActive = true
        
        //arrow right
        let whatsapparrowRight = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        scrollView.addSubview(whatsapparrowRight)
        whatsapparrowRight.translatesAutoresizingMaskIntoConstraints = false
        whatsapparrowRight.widthAnchor.constraint(equalToConstant: 10).isActive = true
        whatsapparrowRight.heightAnchor.constraint(equalToConstant: 25).isActive = true
        whatsapparrowRight.topAnchor.constraint(equalTo: whatsapp.topAnchor, constant: 30).isActive = true
        whatsapparrowRight.trailingAnchor.constraint(equalTo: whatsapp.trailingAnchor, constant: -10).isActive = true
        
        // Fault Rep
        let faultRep = UIView()
        scrollView.addSubview(faultRep)
        faultRep.translatesAutoresizingMaskIntoConstraints = false
        faultRep.backgroundColor = UIColor.white
        faultRep.leadingAnchor.constraint(equalTo: darkGrayCard.leadingAnchor, constant: 20).isActive = true
        faultRep.trailingAnchor.constraint(equalTo: darkGrayCard.trailingAnchor, constant: -20).isActive = true
        faultRep.topAnchor.constraint(equalTo: whatsapp.bottomAnchor, constant: 20).isActive = true
        faultRep.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        let faultRec = UITapGestureRecognizer(target: self, action: #selector(self.reportFault(_sender:)))
        faultRep.addGestureRecognizer(faultRec)
        
        // icon
        let faultIcon = UIImageView(image: #imageLiteral(resourceName: "ic_action_edit"))
        scrollView.addSubview(faultIcon)
        faultIcon.translatesAutoresizingMaskIntoConstraints = false
        faultIcon.widthAnchor.constraint(equalToConstant: 35).isActive = true
        faultIcon.heightAnchor.constraint(equalToConstant: 35).isActive = true
        faultIcon.leadingAnchor.constraint(equalTo: faultRep.leadingAnchor, constant: 10).isActive = true
        faultIcon.topAnchor.constraint(equalTo: faultRep.topAnchor, constant: 20).isActive = true
        
        //Label
        let lblFault = UILabel()
        scrollView.addSubview(lblFault)
        lblFault.translatesAutoresizingMaskIntoConstraints = false
        lblFault.text = "Report a fault or \nmake request"
        lblFault.numberOfLines = 0
        lblFault.lineBreakMode = .byWordWrapping
        lblFault.font = UIFont(name: String.defaultFontR, size: 18)
        lblFault.textColor = UIColor.black
        lblFault.leadingAnchor.constraint(equalTo: faultIcon.trailingAnchor, constant: 5).isActive = true
        lblFault.topAnchor.constraint(equalTo: faultRep.topAnchor, constant: 30).isActive = true
        
        //arrow right
        let faultarrowRight = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        scrollView.addSubview(faultarrowRight)
        faultarrowRight.translatesAutoresizingMaskIntoConstraints = false
        faultarrowRight.widthAnchor.constraint(equalToConstant: 10).isActive = true
        faultarrowRight.heightAnchor.constraint(equalToConstant: 25).isActive = true
        faultarrowRight.topAnchor.constraint(equalTo: faultRep.topAnchor, constant: 30).isActive = true
        faultarrowRight.trailingAnchor.constraint(equalTo: faultRep.trailingAnchor, constant: -10).isActive = true
        
        // Faults
        let faults = UIView()
        scrollView.addSubview(faults)
        faults.translatesAutoresizingMaskIntoConstraints = false
        faults.backgroundColor = UIColor.white
        faults.leadingAnchor.constraint(equalTo: darkGrayCard.leadingAnchor, constant: 20).isActive = true
        faults.trailingAnchor.constraint(equalTo: darkGrayCard.trailingAnchor, constant: -20).isActive = true
        faults.topAnchor.constraint(equalTo: faultRep.bottomAnchor, constant: 20).isActive = true
        faults.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        // icon
        let faultsIcon = UIImageView(image: #imageLiteral(resourceName: "ic_action__search"))
        scrollView.addSubview(faultsIcon)
        faultsIcon.translatesAutoresizingMaskIntoConstraints = false
        faultsIcon.widthAnchor.constraint(equalToConstant: 35).isActive = true
        faultsIcon.heightAnchor.constraint(equalToConstant: 35).isActive = true
        faultsIcon.leadingAnchor.constraint(equalTo: faults.leadingAnchor, constant: 10).isActive = true
        faultsIcon.topAnchor.constraint(equalTo: faults.topAnchor, constant: 20).isActive = true
        
        //Label
        let lblFaults = UILabel()
        scrollView.addSubview(lblFaults)
        lblFaults.translatesAutoresizingMaskIntoConstraints = false
        lblFaults.text = "My faults & requests"
        lblFaults.numberOfLines = 0
        lblFaults.lineBreakMode = .byWordWrapping
        lblFaults.font = UIFont(name: String.defaultFontR, size: 18)
        lblFaults.textColor = UIColor.black
        lblFaults.leadingAnchor.constraint(equalTo: faultIcon.trailingAnchor, constant: 5).isActive = true
        lblFaults.trailingAnchor.constraint(equalTo: faultarrowRight.leadingAnchor, constant: 10).isActive = true
        lblFaults.topAnchor.constraint(equalTo: faults.topAnchor, constant: 30).isActive = true
        
        //arrow right
        let faultsarrowRight = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        scrollView.addSubview(faultsarrowRight)
        faultsarrowRight.translatesAutoresizingMaskIntoConstraints = false
        faultsarrowRight.widthAnchor.constraint(equalToConstant: 10).isActive = true
        faultsarrowRight.heightAnchor.constraint(equalToConstant: 25).isActive = true
        faultsarrowRight.topAnchor.constraint(equalTo: faults.topAnchor, constant: 30).isActive = true
        faultsarrowRight.trailingAnchor.constraint(equalTo: faults.trailingAnchor, constant: -10).isActive = true
    }
    
    @objc func closeVC(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "homeVC")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func talkToAgent(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Support", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "supportModalVc") as? supportModalVc else {return}
        moveTo.supportSelected = "Talk to an agent"
        moveTo.desc = "This will call 100"
        moveTo.code = String.MVA_CUSTOMER_CENTER
        
        self.addChildViewController(moveTo)
        moveTo.view.frame = self.view.frame
        self.view.addSubview(moveTo.view)
        moveTo.didMove(toParentViewController: self)
    }
    
    @objc func businessSolution(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Support", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "supportModalVc") as? supportModalVc else {return}
        moveTo.supportSelected = "Business Solutions"
        moveTo.desc = "This will call 080010000"
        moveTo.code = String.MVA_BUSINESS_SOLUTIONS
        self.addChildViewController(moveTo)
        moveTo.view.frame = self.view.frame
        self.view.addSubview(moveTo.view)
        moveTo.didMove(toParentViewController: self)
    }
    
    @objc func sendEmail(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Support", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "supportModalVc") as? supportModalVc else {return}
        moveTo.supportSelected = "Send us an email"
        moveTo.desc = "This will open an email client"
        moveTo.code = String.MVA_SUPPPORT_EMAIL
        
        self.addChildViewController(moveTo)
        moveTo.view.frame = self.view.frame
        self.view.addSubview(moveTo.view)
        moveTo.didMove(toParentViewController: self)
    }
    
    @objc func openFacebook(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Support", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "supportModalVc") as? supportModalVc else {return}
        moveTo.supportSelected = "Facebook"
        moveTo.desc = "This will open facebook"
        moveTo.code = String.MVA_FACEBOOK
        
        self.addChildViewController(moveTo)
        moveTo.view.frame = self.view.frame
        self.view.addSubview(moveTo.view)
        moveTo.didMove(toParentViewController: self)
    }
    
    @objc func openTwitter(_sender: UITapGestureRecognizer){
        print("here")
        let storyboard = UIStoryboard(name: "Support", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "supportModalVc") as? supportModalVc else {return}
        moveTo.supportSelected = "Twitter"
        moveTo.desc = "This will open twitter"
        moveTo.code = String.MVA_TWITTER
        
        self.addChildViewController(moveTo)
        moveTo.view.frame = self.view.frame
        self.view.addSubview(moveTo.view)
        moveTo.didMove(toParentViewController: self)
    }
    
    @objc func openYoutube(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Support", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "supportModalVc") as? supportModalVc else {return}
        moveTo.supportSelected = "Youtube"
        moveTo.desc = "This will open youtube"
        moveTo.code = String.MVA_YOUTUBE
        
        self.addChildViewController(moveTo)
        moveTo.view.frame = self.view.frame
        self.view.addSubview(moveTo.view)
        moveTo.didMove(toParentViewController: self)
    }
    
    @objc func openSupport(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Support", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "supportModalVc") as? supportModalVc else {return}
        moveTo.supportSelected = "Online Support"
        moveTo.desc = "This will open Online Support"
        moveTo.code = String.MVA_SUPPORT
        
        self.addChildViewController(moveTo)
        moveTo.view.frame = self.view.frame
        self.view.addSubview(moveTo.view)
        moveTo.didMove(toParentViewController: self)
    }
    
    @objc func openWhatsapp(_sender: UITapGestureRecognizer){
        if let appURL = URL(string: "whatsapp://"){
            let canOpen = UIApplication.shared.canOpenURL(appURL)
            
            let appName = "whatsapp"
            let appScheme = "\(appName)://send?phone=\(String.MVA_WHATSAPP)"
            let appSchemeURL = URL(string: appScheme)
            
            if UIApplication.shared.canOpenURL(appSchemeURL! as URL){
                UIApplication.shared.open(appSchemeURL!, options: [:], completionHandler: nil)
            }else{
                toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Please install whatsapp on your phone")
            }
        }
    }
    
    @objc func reportFault(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Support", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "reportFaultVc")
        present(moveTo, animated: true, completion: nil)
    }
    
    @objc func faultsRequests(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Support", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "supportModalVc") as? supportModalVc else {return}
        moveTo.supportSelected = "Online Support"
        moveTo.desc = "This will open Online Support"
        moveTo.code = "+233501000300"
    }
    
}
