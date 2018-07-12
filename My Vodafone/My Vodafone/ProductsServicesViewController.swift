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
    
    
    let preference = UserDefaults.standard
    var displayImage = ""
    var displayName = ""
    var displayNumber = ""
    
    @IBOutlet weak var motherView: UIView!
    
    let defaultFontR = "VodafoneRg-Regular"
    let defaultFontB = "VodafoneRg-Bold"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Change the back button colour.
        let backButton = UIImage(named: "leftArrow")
        let tintedImage = backButton?.withRenderingMode(.alwaysTemplate)
        btnBack.setImage(tintedImage, for: .normal)
        btnBack.tintColor = UIColor.white
        
        //add gesture
        let gestureRec = UITapGestureRecognizer(target: self, action: #selector(self.goToAddServices))
        addService.addGestureRecognizer(gestureRec)
        
        let gestureRec2 = UITapGestureRecognizer(target: self, action: #selector(self.goToUserPdts))
        userPdts.addGestureRecognizer(gestureRec2)
        
        
        let Services = preference.object(forKey: "ServiceList")
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
                let onlyService = UIView()
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
                //image on left of uiview
                let colorImage = UIImageView()
                onlyService.addSubview(colorImage)
                colorImage.translatesAutoresizingMaskIntoConstraints = false
                colorImage.topAnchor.constraint(equalTo: onlyService.topAnchor, constant: 0).isActive = true
                colorImage.leadingAnchor.constraint(equalTo: onlyService.leadingAnchor, constant: 0).isActive = true
                onlyService.bottomAnchor.constraint(equalTo: colorImage.bottomAnchor, constant: 0).isActive = true
                colorImage.widthAnchor.constraint(equalToConstant: 12).isActive = true
//                colorImage.frame = CGRect(x: 0, y: 0, width: 12, height: 145)
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
                    image_arrow.widthAnchor.constraint(equalToConstant: 15).isActive = true
                    image_arrow.heightAnchor.constraint(equalToConstant: 15).isActive = true
                    
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
                    var motherViewHeight: CGFloat = 1000
                    for obj in array {
                        if let dict = obj as? NSDictionary {
                            countView = countView + 1
                            // Now reference the data you need using:
                            let id = dict.value(forKey: "DisplayName")
                            let ServiceID = dict.value(forKey: "primaryID") as! String
                            let DisplayImageUrl = dict.value(forKey: "DisplayImageUrl") as! String
                            
                                print("you did this")
                                let stringCountView = String(countView)
                            print("int to string \(stringCountView)")
                                let service = UIView()
                                view.addSubview(service)
                                scroller.addSubview(service)
                                service.translatesAutoresizingMaskIntoConstraints = false
                            
                                service.topAnchor.constraint(equalTo: addService.bottomAnchor, constant: topAnchorConstraint).isActive = true
                                service.leadingAnchor.constraint(equalTo: motherView.leadingAnchor, constant: 20.0).isActive = true
                                service.trailingAnchor.constraint(equalTo: motherView.trailingAnchor, constant: -20.0).isActive = true
                                service.backgroundColor = UIColor.white
                                service.heightAnchor.constraint(equalToConstant: 145).isActive = true
                                print("view:: \(countView)")
                                print(id)
                                print(ServiceID)
                                print("image is:: \(DisplayImageUrl)")
                                topAnchorConstraint = topAnchorConstraint + 165
                            
                        }
                    }
                }
            }
        }
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func goToAddServices(_sender: UITapGestureRecognizer){
        //        print("You just clicked")
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "AddServiceViewController")
        present(moveTo!, animated: true, completion: nil)
        
    }
    
    @objc func goToUserPdts(_sender: UITapGestureRecognizer){
        let moveTo = storyboard?.instantiateViewController(withIdentifier: "UserProductsViewController")
        present(moveTo!, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
