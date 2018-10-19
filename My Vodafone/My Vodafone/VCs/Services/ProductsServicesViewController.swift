//
//  ProductsServicesViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 12/06/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class ProductsServicesViewController: UIViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var addService: CardView!
    @IBOutlet weak var userPdts: CardView!
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var scrollHeight: NSLayoutConstraint!
    
    
    let preference = UserDefaults.standard
    var displayImage = ""
    var displayName = ""
    var displayNumber = ""
    var username = ""
    
    @IBOutlet weak var motherView: UIView!
    
    let defaultFontR = "VodafoneRg-Regular"
    let defaultFontB = "VodafoneRg-Bold"
    
//    let cardImage: UIImageView = {
//       let image = UIImageView()
//        image.backgroundColor = UIColor.cardImageColour
//        return image
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Change the back button colour.
        let backButton = UIImage(named: "leftArrow")
        let tintedImage = backButton?.withRenderingMode(.alwaysTemplate)
        btnBack.setImage(tintedImage, for: .normal)
        btnBack.tintColor = UIColor.white
        btnBack.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
        
        let userData = preference.object(forKey: "responseData") as! NSDictionary
        username = userData["Username"] as! String
        
        //add gesture
        let gestureRec = UITapGestureRecognizer(target: self, action: #selector(self.goToAddServices))
        addService.addGestureRecognizer(gestureRec)
        
        let gestureRec2 = UITapGestureRecognizer(target: self, action: #selector(self.goToUserPdts))
        userPdts.addGestureRecognizer(gestureRec2)
        
        
        let Services = preference.object(forKey: UserDefaultsKeys.ServiceList.rawValue)
        if let array = Services as? NSArray {
            let totalServices = array.count
            print("Total Service:: \(totalServices)")
//            for obj in array {
//                if let dict = obj as? NSDictionary {
//                    // Now reference the data you need using:
//                    let id = dict.value(forKey: "DisplayName")
//                    let ServiceID = dict.value(forKey: "primaryID") as! String
//                    let DisplayImageUrl = dict.value(forKey: "DisplayImageUrl") as! String
//
//                    print(id)
//                    print(ServiceID)
//                    print("display Image:: \(DisplayImageUrl)")
//                }
//            }
            if totalServices == 1 {
                //Display only the default service
                for obj in array {
                    if let dict = obj as? NSDictionary {
                        // Now reference the data you need using:
                        displayName = dict.value(forKey: "DisplayName") as! String
                         displayNumber = dict.value(forKey: "primaryID") as! String
                         displayImage = dict.value(forKey: "DisplayImageUrl") as! String
                        
                        print("New:: \(displayName)")
                        print(displayNumber)
                        print("display Image:: \(displayImage)")
                    }
                }
                let onlyService = UserDetailsCard()
//                let margins = view.layoutMarginsGuide
                view.addSubview(onlyService)
                onlyService.translatesAutoresizingMaskIntoConstraints = false
                onlyService.backgroundColor = UIColor.white
                onlyService.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 20.0).isActive = true
                onlyService.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -20.0).isActive = true
                onlyService.topAnchor.constraint(equalTo: addService.bottomAnchor, constant: 22).isActive = true
                onlyService.heightAnchor.constraint(equalToConstant: 145).isActive = true
                onlyService.layer.cornerRadius = 2
                onlyService.layer.shadowOffset = CGSize(width: 0, height: 5)
                onlyService.layer.shadowColor = UIColor.black.cgColor
                onlyService.layer.shadowOpacity = 0.1
                onlyService.msisdn = displayNumber
                onlyService.displayName = displayName
                let touchRec = UITapGestureRecognizer(target: self, action: #selector(goToDetails(_sender:)))
                onlyService.addGestureRecognizer(touchRec)
                //image on left of uiview
                let colorImage = UIImageView()
                onlyService.addSubview(colorImage)
                colorImage.translatesAutoresizingMaskIntoConstraints = false
                colorImage.topAnchor.constraint(equalTo: onlyService.topAnchor, constant: 0).isActive = true
                colorImage.leadingAnchor.constraint(equalTo: onlyService.leadingAnchor, constant: 0).isActive = true
                onlyService.bottomAnchor.constraint(equalTo: colorImage.bottomAnchor, constant: 0).isActive = true
                colorImage.widthAnchor.constraint(equalToConstant: 12).isActive = true
                let colorForImage = UIColor(red: 0x00, green: 0x7E, blue: 0x92)
                colorImage.backgroundColor = colorForImage
                onlyService.bringSubview(toFront: colorImage)
                
                //adding the image
                let userImage = URL(string: displayImage)
                if userImage == nil{
                    print("Do this")
                    let default_image = UIImageView(image: #imageLiteral(resourceName: "default_profile"))
                    onlyService.addSubview(default_image)
                    default_image.translatesAutoresizingMaskIntoConstraints = false
                    default_image.leadingAnchor.constraint(equalTo: colorImage.trailingAnchor, constant: 10).isActive = true
                    default_image.topAnchor.constraint(equalTo: onlyService.topAnchor, constant: 25).isActive = true
                    default_image.widthAnchor.constraint(equalToConstant: 80).isActive = true
                    default_image.heightAnchor.constraint(equalToConstant: 80).isActive = true
                    //make image round
                    default_image.layer.cornerRadius = default_image.frame.size.width / 2
                    default_image.clipsToBounds = true
                    default_image.layer.borderWidth = 2
                    default_image.layer.borderColor = UIColor.white.cgColor
                    
                    //Add service name
                    let txtServiceName = UILabel()
                    onlyService.addSubview(txtServiceName)
                    txtServiceName.translatesAutoresizingMaskIntoConstraints = false
                    txtServiceName.text = displayName
                    txtServiceName.topAnchor.constraint(equalTo: onlyService.topAnchor, constant: 50).isActive = true
                    txtServiceName.leadingAnchor.constraint(equalTo: default_image.trailingAnchor, constant: 5).isActive = true
                    txtServiceName.font = UIFont(name: defaultFontR, size: 17)
                    //right arrow
                    let image_arrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
                    onlyService.addSubview(image_arrow)
                    image_arrow.translatesAutoresizingMaskIntoConstraints = false
                    image_arrow.trailingAnchor.constraint(equalTo: onlyService.trailingAnchor, constant: -10).isActive = true
                    image_arrow.topAnchor.constraint(equalTo: onlyService.topAnchor, constant: 50).isActive = true
                    image_arrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
                    image_arrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
                    
                    //Service Number
                    let txtServiceNumber = UILabel()
                    onlyService.addSubview(txtServiceNumber)
                    txtServiceNumber.translatesAutoresizingMaskIntoConstraints = false
                    var userNumber = displayNumber.dropFirst(3)
                    let firtPin = "0\(userNumber)"
                    print(firtPin)
                    txtServiceNumber.text = firtPin
                    txtServiceNumber.font = UIFont(name: defaultFontR, size: 17)
                    txtServiceNumber.topAnchor.constraint(equalTo: txtServiceName.bottomAnchor, constant: 8).isActive = true
                    txtServiceNumber.leadingAnchor.constraint(equalTo: default_image.trailingAnchor, constant: 5).isActive = true
                    
                    
                }else{
                    print("You are not empty:: \(userImage)")
                    //download image
                    /*let default_image = UIImageView()
                    default_image.image(data:userImage! as Data)
                    onlyService.addSubview(default_image)
                    default_image.translatesAutoresizingMaskIntoConstraints = false
                    default_image.leadingAnchor.constraint(equalTo: colorImage.trailingAnchor, constant: 10).isActive = true
                    default_image.topAnchor.constraint(equalTo: onlyService.topAnchor, constant: 25).isActive = true
                    default_image.widthAnchor.constraint(equalToConstant: 80).isActive = true
                    default_image.heightAnchor.constraint(equalToConstant: 80).isActive = true
                    //make image round
                    default_image.layer.cornerRadius = default_image.frame.size.width / 2
                    default_image.clipsToBounds = true
                    default_image.layer.borderWidth = 2
                    default_image.layer.borderColor = UIColor.white.cgColor */
                }
                
                
            }else{
                //Display list of services
                if let array = Services as? NSArray {
                    var countView = 0
                    var topAnchorConstraint: CGFloat = 22
                    for obj in array {
                        if let dict = obj as? NSDictionary {
                            countView = countView + 1
                            // Now reference the data you need using:
                            let serviceName = dict.value(forKey: "DisplayName") as! String
                            var ServiceID = dict.value(forKey: "primaryID") as! String
                            let DisplayImageUrl = dict.value(forKey: "DisplayImageUrl") as! String
                            
                            
                                let stringCountView = String(countView)
//                            print("int to string \(stringCountView)")
                                let service = UserDetailsCard()
                                view.addSubview(service)
                                scroller.addSubview(service)
                                service.translatesAutoresizingMaskIntoConstraints = false
                            
                                service.topAnchor.constraint(equalTo: addService.bottomAnchor, constant: topAnchorConstraint).isActive = true
                                service.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 20.0).isActive = true
                                service.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -20.0).isActive = true
                                service.backgroundColor = UIColor.white
                                service.heightAnchor.constraint(equalToConstant: 145).isActive = true
                                //transforming to cards
                                service.layer.cornerRadius = 2
                                service.layer.shadowOffset = CGSize(width: 0, height: 5)
                                service.layer.shadowColor = UIColor.black.cgColor
                                service.layer.shadowOpacity = 0.1
                            service.msisdn = ServiceID
                            service.displayName = serviceName
                            let touchRec = UITapGestureRecognizer(target: self, action: #selector(goToDetails(_sender:)))
                            service.addGestureRecognizer(touchRec)
                            
                            //add left image view
                            let cardImage = UIImageView()
                            service.addSubview(cardImage)
                            cardImage.backgroundColor = UIColor.cardImageColour
                            cardImage.translatesAutoresizingMaskIntoConstraints = false
                            cardImage.leadingAnchor.constraint(equalTo: service.leadingAnchor, constant: 0).isActive = true
                            cardImage.widthAnchor.constraint(equalToConstant: 12).isActive = true
                            cardImage.topAnchor.constraint(equalTo: service.topAnchor, constant: 0).isActive = true
                            cardImage.bottomAnchor.constraint(equalTo: service.bottomAnchor, constant: 0).isActive = true
                            //Adding display images
                            let dp = UIImageView(image: #imageLiteral(resourceName: "default_profile"))
                            service.addSubview(dp)
                            dp.translatesAutoresizingMaskIntoConstraints = false
                            dp.leadingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: 10).isActive = true
                            dp.topAnchor.constraint(equalTo: service.topAnchor, constant: 25).isActive = true
                            dp.widthAnchor.constraint(equalToConstant: 80).isActive = true
                            dp.heightAnchor.constraint(equalToConstant: 80).isActive = true
                            
                            //make image round
                            dp.layer.cornerRadius = dp.frame.size.width / 2
                            dp.clipsToBounds = true
                            dp.layer.borderWidth = 2
                            dp.layer.borderColor = UIColor.white.cgColor
                            
                            //Adding display name
                            let displayLblName = UILabel()
                            service.addSubview(displayLblName)
                            displayLblName.translatesAutoresizingMaskIntoConstraints = false
                            displayLblName.text = serviceName
                            displayLblName.font = UIFont(name: defaultFontR, size: 21)
                            displayLblName.leadingAnchor.constraint(equalTo: dp.trailingAnchor, constant: 8).isActive = true
                            displayLblName.topAnchor.constraint(equalTo: service.topAnchor, constant: 50).isActive = true
                            
                            //Adding service ID
                            let serviceLblID = UILabel()
                            service.addSubview(serviceLblID)
                            serviceLblID.translatesAutoresizingMaskIntoConstraints = false
                            let sNum = ServiceID.dropFirst(3)
                            ServiceID = "0\(sNum)"
                            serviceLblID.text = ServiceID
                            serviceLblID.font = UIFont(name: defaultFontR, size: 16)
                            serviceLblID.leadingAnchor.constraint(equalTo: dp.trailingAnchor, constant: 8).isActive = true
                            serviceLblID.topAnchor.constraint(equalTo: displayLblName.bottomAnchor, constant: 8).isActive = true
                            
                            //Adding right arrow
                            let rightArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
                            service.addSubview(rightArrow)
                            rightArrow.translatesAutoresizingMaskIntoConstraints = false
                            rightArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
                            rightArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
                            rightArrow.trailingAnchor.constraint(equalTo: service.trailingAnchor, constant: -25).isActive = true
                            rightArrow.topAnchor.constraint(equalTo: service.topAnchor, constant: 50).isActive = true
                                /*print("view:: \(countView)")
                                print(id)
                                print(ServiceID)
                                print("image is:: \(DisplayImageUrl)")*/
                                topAnchorConstraint = topAnchorConstraint + 165
                                scrollHeight.constant = topAnchorConstraint - 300
                            
                        }
                    }
                }
            }
        }
        if !CheckInternet.Connection(){
            toast(toast_img: UIImageView(image: #imageLiteral(resourceName: "info")), toast_message: "You're offline")
            
        }else{
            updateUserServices()
        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func goToAddServices(_sender: UITapGestureRecognizer){
        //        print("You just clicked")
        let storyboard = UIStoryboard(name: "ProductsServices", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "AddServiceViewController")
        present(moveTo, animated: true, completion: nil)
        
    }
    
    @objc func goToUserPdts(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "ProductsServices", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "UserProductsViewController")
        present(moveTo, animated: true, completion: nil)
    }
    

    @objc func goToHome(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "homeVC")
        present(moveTo, animated: true, completion: nil)
    }
    
    func appVersion() -> String {
        let systemVersion = UIDevice.current.systemVersion
        
        return systemVersion
    }
    
    //Function to update services
    func updateUserServices(){
        let postParameters: Dictionary<String, Any> = [
            "action":"getAccountServices",
            "username":username,
            "os":appVersion()
        ]
        let async_call = URL(string: String.oldUserSVC)
        let request = NSMutableURLRequest(url: async_call!)
        request.httpMethod = "POST"
        if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
            request.httpBody = postData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                if error != nil {
                    print("error is:: \(error!.localizedDescription)")
                    return;
                }
                do {
                    let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    if let parseJSON = myJSON{
                        var responseCode: Int?
                        
                        responseCode = parseJSON["RESPONSECODE"] as! Int?
                        if responseCode == 0 {
                            let responseData: NSDictionary?
                            let serviceList: NSArray?
                            responseData = parseJSON["RESPONSEDATA"] as! NSDictionary?
                            serviceList = responseData!["ServiceList"] as! NSArray?
                            self.preference.removeObject(forKey: UserDefaultsKeys.ServiceList.rawValue)
                            self.preference.set(serviceList!, forKey: UserDefaultsKeys.ServiceList.rawValue)
                            
                            DispatchQueue.main.async {
                                if let array = serviceList {
                                    var countView = 0
                                    var topAnchorConstraint: CGFloat = 22
                                    for obj in array {
                                        
                                        if let dict = obj as? NSDictionary {
                                            countView = countView + 1
                                            // Now reference the data you need using:
                                            let serviceName = dict.value(forKey: "DisplayName") as! String
                                            var ServiceID = dict.value(forKey: "primaryID") as! String
                                            let DisplayImageUrl = dict.value(forKey: "DisplayImageUrl") as! String
                                            
                                            
                    
                                            //                            print("int to string \(stringCountView)")
                                            let service = UserDetailsCard()
                                            self.view.addSubview(service)
                                            self.scroller.addSubview(service)
                                            service.translatesAutoresizingMaskIntoConstraints = false
                                            
                                            service.topAnchor.constraint(equalTo: self.addService.bottomAnchor, constant: topAnchorConstraint).isActive = true
                                            service.leadingAnchor.constraint(equalTo: self.motherView.leadingAnchor, constant: 20.0).isActive = true
                                            service.trailingAnchor.constraint(equalTo: self.motherView.trailingAnchor, constant: -20.0).isActive = true
                                            service.backgroundColor = UIColor.white
                                            service.heightAnchor.constraint(equalToConstant: 145).isActive = true
                                            //transforming to cards
                                            service.layer.cornerRadius = 2
                                            service.layer.shadowOffset = CGSize(width: 0, height: 5)
                                            service.layer.shadowColor = UIColor.black.cgColor
                                            service.layer.shadowOpacity = 0.1
                                            service.msisdn = ServiceID
                                            service.displayName = serviceName
                                            
                                            let touchRec = UITapGestureRecognizer(target: self, action: #selector(self.goToDetails(_sender:)))
                                            service.addGestureRecognizer(touchRec)
                                            
                                            //add left image view
                                            let cardImage = UIImageView()
                                            service.addSubview(cardImage)
                                            cardImage.backgroundColor = UIColor.cardImageColour
                                            cardImage.translatesAutoresizingMaskIntoConstraints = false
                                            cardImage.leadingAnchor.constraint(equalTo: service.leadingAnchor, constant: 0).isActive = true
                                            cardImage.widthAnchor.constraint(equalToConstant: 12).isActive = true
                                            cardImage.topAnchor.constraint(equalTo: service.topAnchor, constant: 0).isActive = true
                                            cardImage.bottomAnchor.constraint(equalTo: service.bottomAnchor, constant: 0).isActive = true
                                            //Adding display images
                                            let dp = UIImageView(image: #imageLiteral(resourceName: "default_profile"))
                                            service.addSubview(dp)
                                            dp.translatesAutoresizingMaskIntoConstraints = false
                                            dp.leadingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: 10).isActive = true
                                            dp.topAnchor.constraint(equalTo: service.topAnchor, constant: 25).isActive = true
                                            dp.widthAnchor.constraint(equalToConstant: 80).isActive = true
                                            dp.heightAnchor.constraint(equalToConstant: 80).isActive = true
                                            
                                            //make image round
                                            dp.layer.cornerRadius = dp.frame.size.width / 2
                                            dp.clipsToBounds = true
                                            dp.layer.borderWidth = 2
                                            dp.layer.borderColor = UIColor.white.cgColor
                                            
                                            //Adding display name
                                            let displayLblName = UILabel()
                                            service.addSubview(displayLblName)
                                            displayLblName.translatesAutoresizingMaskIntoConstraints = false
                                            displayLblName.text = serviceName
                                            displayLblName.font = UIFont(name: String.defaultFontR, size: 21)
                                            displayLblName.leadingAnchor.constraint(equalTo: dp.trailingAnchor, constant: 8).isActive = true
                                            displayLblName.topAnchor.constraint(equalTo: service.topAnchor, constant: 50).isActive = true
                                            
                                            //Adding service ID
                                            let serviceLblID = UILabel()
                                            service.addSubview(serviceLblID)
                                            serviceLblID.translatesAutoresizingMaskIntoConstraints = false
                                            let sNum = ServiceID.dropFirst(3)
                                            ServiceID = "0\(sNum)"
                                            serviceLblID.text = ServiceID
                                            serviceLblID.font = UIFont(name: String.defaultFontR, size: 16)
                                            serviceLblID.leadingAnchor.constraint(equalTo: dp.trailingAnchor, constant: 8).isActive = true
                                            serviceLblID.topAnchor.constraint(equalTo: displayLblName.bottomAnchor, constant: 8).isActive = true
                                            
                                            //Adding right arrow
                                            let rightArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
                                            service.addSubview(rightArrow)
                                            rightArrow.translatesAutoresizingMaskIntoConstraints = false
                                            rightArrow.widthAnchor.constraint(equalToConstant: 10).isActive = true
                                            rightArrow.heightAnchor.constraint(equalToConstant: 25).isActive = true
                                            rightArrow.trailingAnchor.constraint(equalTo: service.trailingAnchor, constant: -25).isActive = true
                                            rightArrow.topAnchor.constraint(equalTo: service.topAnchor, constant: 50).isActive = true
                                            /*print("view:: \(countView)")
                                             print(id)
                                             print(ServiceID)
                                             print("image is:: \(DisplayImageUrl)")*/
                                            topAnchorConstraint = topAnchorConstraint + 165
                                            self.scrollHeight.constant = topAnchorConstraint - 300
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    @objc func goToDetails(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "ProductsServices", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "userServiceDetails") as? userServiceDetails else {return}
        guard let gestureVariables = _sender.view as? UserDetailsCard else {return}
        moveTo.msisdn = gestureVariables.msisdn
        moveTo.displayName = gestureVariables.displayName
        present(moveTo, animated: true, completion: nil)
    }

}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
