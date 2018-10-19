//
//  confirmShake.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 16/10/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class confirmShake: baseViewControllerM {
    
    var price: String?
    var desc: String?
    var name: String?
    var pid: String?
    
    var username: String?
    var msisdn: String?

    // back button
    let backButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblShakeHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.text = "Shake to confirm"
        return label
    }()
    
    let shakeImage: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "shake_hand"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let darkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.dark_background
        return view
    }()
    
    //create a closure for activity loader
    let activity_loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        view.color = UIColor.vodaRed
        view.hidesWhenStopped = true
        return view
    }()
    
    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    var shakeCount = 0
    
    var musicEffect: AVAudioPlayer = AVAudioPlayer()
    
    
    fileprivate func playWav() {
        let musicFile = Bundle.main.path(forResource: "shake", ofType: ".wav")
        
        do {
            try musicEffect = AVAudioPlayer(contentsOf: URL (fileURLWithPath: musicFile!))
            
        }catch{
            print(error)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.grayButton
        setUpViewShakeConfirmScreen()
        print("id:: \(pid)")
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        username = UserData["Username"] as? String
        msisdn = preference.object(forKey: "defaultMSISDN") as! String?
        
        playWav()
    }
    
    //Function to startIndicator
    func start_activity_loader(){
        activity_loader.isHidden = false
        activity_loader.hidesWhenStopped = true
        activity_loader.startAnimating()
    }
    
    //Function to stopIndicator
    func stop_activity_loader(){
        activity_loader.stopAnimating()
    }

    func setUpViewShakeConfirmScreen(){
        view.addSubview(backButton)
        let backImage = UIImage(named: "leftArrow")
        let backTint = backImage?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(backTint, for: .normal)
        backButton.tintColor = UIColor.white
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        backButton.addTarget(self, action: #selector(goToShakeList), for: .touchUpInside)
        
        view.addSubview(lblShakeHeader)
        lblShakeHeader.font = UIFont(name: String.defaultFontR, size: 25)
        lblShakeHeader.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 50).isActive = true
        lblShakeHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblShakeHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        lblShakeHeader.numberOfLines = 0
        lblShakeHeader.lineBreakMode = .byWordWrapping
        lblShakeHeader.textAlignment = .center
        
        let center = view.center
        
        let circularPath = UIBezierPath(arcCenter: .zero
            , radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.support_light_gray.cgColor
        trackLayer.lineWidth = 30
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = kCALineCapRound
        trackLayer.position = center
        view.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 30
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.position = center
        shapeLayer.strokeEnd = 0.01
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1   )
        view.layer.addSublayer(shapeLayer)
        
        view.addSubview(shakeImage)
        shakeImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        shakeImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        shakeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        shakeImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        shakeImage.center = view.center
        
        shakeImage.shakeView()
        
        view.addSubview(darkView)
        darkView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        darkView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        darkView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        darkView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        let lblShakeBundleName = UILabel()
        darkView.addSubview(lblShakeBundleName)
        lblShakeBundleName.translatesAutoresizingMaskIntoConstraints = false
        lblShakeBundleName.text = name
        lblShakeBundleName.font = UIFont(name: String.defaultFontR, size: 25)
        lblShakeBundleName.textColor = UIColor.white
        lblShakeBundleName.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        lblShakeBundleName.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 10).isActive = true
        lblShakeBundleName.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        lblShakeBundleName.textAlignment = .center
        lblShakeBundleName.numberOfLines = 0
        lblShakeBundleName.lineBreakMode = .byWordWrapping
        
        let separator = UIView()
        darkView.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor.vodaRed
        separator.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        separator.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        separator.topAnchor.constraint(equalTo: lblShakeBundleName.bottomAnchor, constant: 10).isActive = true
        separator.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        
        //Price
        let lblPrice = UILabel()
        darkView.addSubview(lblPrice)
        lblPrice.translatesAutoresizingMaskIntoConstraints = false
        lblPrice.textColor = UIColor.white
        lblPrice.font = UIFont(name: String.defaultFontB, size: 30)
        lblPrice.text = "GHS \(price ?? "")"
        lblPrice.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 20).isActive = true
        lblPrice.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        
        //Description
        let lblDesc = UILabel()
        darkView.addSubview(lblDesc)
        lblDesc.translatesAutoresizingMaskIntoConstraints = false
        lblDesc.text = desc
        lblDesc.font = UIFont(name: String.defaultFontR, size: 18)
        lblDesc.textColor = UIColor.white
        lblDesc.numberOfLines = 0
        lblDesc.lineBreakMode = .byWordWrapping
        lblDesc.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        lblDesc.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 20).isActive = true
        lblDesc.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -130).isActive = true
        
        view.addSubview(activity_loader)
        activity_loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity_loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        
        
        
        
        
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        
        if motion == .motionShake{
            print("Shake detected")
            shapeLayer.strokeEnd += 0.25
            musicEffect.play()
            shakeCount =  shakeCount + 1
            lblShakeHeader.text = "Keep going \nDon't give up"
            if shakeCount == 4{
                print("Stop shake")
                lblShakeHeader.text = "Buying your bundle"
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                
                if !CheckInternet.Connection(){
                    displayNoInternet()
                }else{
                    start_activity_loader()
                    
                    let async_call = URL(string: String.MVA_SHAKE_PROMOS)
                    let request = NSMutableURLRequest(url: async_call!)
                    
                    let postParameters = ["action":"ShakeBuyPackage","msisdn":msisdn!,"bundleid":pid!,"username":username!,"bundletoremove":"","os":getAppVersion()]
                    
                    request.httpMethod = "POST"
                    if let jsonParameters = try? JSONSerialization.data(withJSONObject: postParameters, options: .prettyPrinted) {
                        let theJSONText = String(data: jsonParameters,encoding: String.Encoding.utf8)
                        
                        let requestBody: Dictionary<String, Any> = [
                            "requestBody":encryptAsyncRequest(requestBody: theJSONText!.description)
                        ]
                        if let postData = (try? JSONSerialization.data(withJSONObject: requestBody, options: JSONSerialization.WritingOptions.prettyPrinted)){
                            request.httpBody = postData
                            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                            request.addValue("application/json", forHTTPHeaderField: "Accept")
                            var session = preference.object(forKey: UserDefaultsKeys.userSession.rawValue) as! String
                            session = session.replacingOccurrences(of: "-", with: "")
                            
                            request.addValue(session, forHTTPHeaderField: "session")
                            request.addValue(username!, forHTTPHeaderField: "username")
                            
                            let task = URLSession.shared.dataTask(with: request as URLRequest){
                                data, response, error in
                                if error != nil {
                                    DispatchQueue.main.async {
                                        self.stop_activity_loader()
                                        self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: error!.localizedDescription)
                                    }
                                    return;
                                }
                                
                                do {
                                    let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                                    if let parseJSON = myJSON {
                                        var responseBody: String?
                                        responseBody = parseJSON["responseBody"] as! String?
                                        
                                        let decrypt = self.decryptAsyncRequest(requestBody: responseBody!)
                                        
                                        let decryptedResponseBody = self.convertToNSDictionary(decrypt: decrypt)
                                        print(decryptedResponseBody)
                                        var responseCode: Int?
                                        responseCode = decryptedResponseBody["RESPONSECODE"] as! Int?
                                        DispatchQueue.main.async {
                                            if responseCode == 0 {
                                                let responseMessage = decryptedResponseBody["RESPONSEMESSAGE"] as! String?
                                                self.stop_activity_loader()
                                                self.shapeLayer.strokeEnd = 0
                                                //Go to dialog and display error message
                                                let storyboard = UIStoryboard(name: "Shake", bundle: nil)
                                                guard let moveTo = storyboard.instantiateViewController(withIdentifier: "ShakeDialog") as? ShakeDialog else { return }
                                                moveTo.responseCode = responseCode
                                                moveTo.responseMessage = responseMessage
                                                self.addChildViewController(moveTo)
                                                moveTo.view.frame = self.view.frame
                                                self.view.addSubview(moveTo.view)
                                                moveTo.didMove(toParentViewController: self)
                                                
                                            }else if responseCode == 1 {
                                                let responseMessage = decryptedResponseBody["RESPONSEMESSAGE"] as! String?
                                                let sessionID = decryptedResponseBody["SESSIONID"] as! String?
                                                let pid = decryptedResponseBody["BUNDLETOREMOVE"] as! String?
                                                self.stop_activity_loader()
                                                //Go to dialog and display successful message
                                                let storyboard = UIStoryboard(name: "Shake", bundle: nil)
                                                guard let moveTo = storyboard.instantiateViewController(withIdentifier: "ShakeDialog") as? ShakeDialog else { return }
                                                moveTo.responseCode = responseCode
                                                moveTo.responseMessage = responseMessage
                                                moveTo.pid = pid
                                                moveTo.sessionID = sessionID
                                                self.addChildViewController(moveTo)
                                                moveTo.view.frame = self.view.frame
                                                self.view.addSubview(moveTo.view)
                                                moveTo.didMove(toParentViewController: self)
                                            }else{
                                                let responseMessage = decryptedResponseBody["RESPONSEMESSAGE"] as! String?
                                                self.stop_activity_loader()
                                                self.shapeLayer.strokeEnd = 0
                                                //Go to dialog and display error message
                                                let storyboard = UIStoryboard(name: "Shake", bundle: nil)
                                                guard let moveTo = storyboard.instantiateViewController(withIdentifier: "ShakeDialog") as? ShakeDialog else { return }
                                                moveTo.responseCode = responseCode
                                                moveTo.responseMessage = responseMessage
                                                self.addChildViewController(moveTo)
                                                moveTo.view.frame = self.view.frame
                                                self.view.addSubview(moveTo.view)
                                                moveTo.didMove(toParentViewController: self)
                                            }
                                        }
                                    }
                                }catch {
                                    DispatchQueue.main.async {
                                        self.stop_activity_loader()
                                        self.shapeLayer.strokeEnd = 0
                                        self.toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "Sorry could not process data")
                                        print(error.localizedDescription)
                                    }
                                }
                            }
                            task.resume()
                        }
                    }
                }
                
                
            }
        }
        
    }
    
    @objc func goToShakeList(){
        let storyboard = UIStoryboard(name: "Shake", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "ShakeList")
        present(moveTo, animated: true, completion: nil)
    }
    
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
}
