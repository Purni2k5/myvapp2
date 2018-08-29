//
//  OffersExtrasViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 29/06/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class OffersExtrasViewController: baseViewControllerM {
    
    @IBOutlet weak var lblOffersHeader: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var hamburger: UIButton!
    
    @IBOutlet weak var menuViewTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var cardRoundImages: UIImageView!
    @IBOutlet weak var imgDataBundle: UIImageView!
    @IBOutlet weak var imgVFX: UIImageView!
    @IBOutlet weak var imgIDDBundles: UIImageView!
    @IBOutlet weak var imgSettings: UIImageView!
    @IBOutlet weak var imgVCash: UIImageView!
    @IBOutlet weak var imgFBB: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    let asycURL = URL(string: String.userURL)
    let preferences = UserDefaults.standard
    
    //Offers UIVIEWS
    @IBOutlet weak var planCard: CardView!
    @IBOutlet weak var dataBundlesCard: CardView!
    @IBOutlet weak var vodafoneXCard: CardView!
    @IBOutlet weak var IDDBundlesCard: CardView!
    @IBOutlet weak var vodafoneCash: CardView!
    @IBOutlet weak var fixedBBCard: CardView!
    @IBOutlet weak var servicesCard: CardView!
    @IBOutlet weak var planDesc: UITextView!
    @IBOutlet weak var darkView: UIView!
    let headIconImage = UIImageView(image: #imageLiteral(resourceName: "ic_mobile"))
    let headImage = UIImageView(image: #imageLiteral(resourceName: "head_bg"))
    let bottomImage = UIImageView(image: #imageLiteral(resourceName: "bottom_bg"))
    
    var offerContent: String?
    var offerImage: String?
    var offerTitle: String?
    var suggestionLabel:String?
    var suggestionScreen: String?
    
    //create a closure for error view
    let errorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //create a closure label
    let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //create a closure for errorDate label
    let errorDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    var menuShowing = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // change header.
        changeHeader()
        //close button colour
        changeCloseBtnColour()
        
        //make card images round
        makeImageRound(image: cardRoundImages)
        makeImageRound(image: imgDataBundle)
        makeImageRound(image: imgVFX)
        makeImageRound(image: imgIDDBundles)
        makeImageRound(image: imgVCash)
        makeImageRound(image: imgVCash)
        makeImageRound(image: imgFBB)
        makeImageRound(image: imgSettings)
        
        btnBack.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
        hamburger.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        //change images to white
        changeImageToWhite()
        //Call gestures on all cards
        addGesturesToCards()
        let responseData = preferences.object(forKey: "responseData") as! NSDictionary
        let username = responseData["Username"] as! String
        let msisdn = responseData["Contact"] as! String
        
        
        let whiteUIView = UIView()
        scrollView.addSubview(whiteUIView)
        whiteUIView.translatesAutoresizingMaskIntoConstraints = false
        whiteUIView.backgroundColor = UIColor.white
        whiteUIView.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 100).isActive = true
        whiteUIView.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        whiteUIView.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        whiteUIView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        
        scrollView.addSubview(headImage)
        headImage.translatesAutoresizingMaskIntoConstraints = false
        headImage.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        headImage.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        headImage.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 40).isActive = true
        headImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
        headImage.contentMode = .scaleAspectFill
        
        scrollView.addSubview(headIconImage)
        headIconImage.translatesAutoresizingMaskIntoConstraints = false
        headIconImage.image = headIconImage.image?.withRenderingMode(.alwaysTemplate)
        headIconImage.tintColor = UIColor.white
        headIconImage.centerXAnchor.constraint(equalTo: headImage.centerXAnchor).isActive = true
        headIconImage.topAnchor.constraint(equalTo: headImage.topAnchor, constant: 5).isActive = true
        headIconImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        headIconImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        
        scrollView.addSubview(bottomImage)
        bottomImage.translatesAutoresizingMaskIntoConstraints = false
        
        bottomImage.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        bottomImage.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        bottomImage.bottomAnchor.constraint(equalTo: darkView.bottomAnchor, constant: -70).isActive = true
        
        bottomImage.contentMode = .scaleAspectFill
        
//        setUpViews()
        //Download offer details
        let request = NSMutableURLRequest(url: asycURL!)
        request.httpMethod = "POST"
        
        let postParameters: Dictionary<String, Any> = [
            "action":"offers",
            "msisdn":msisdn,
            "username":username
        ]
        
        //convert post parameters to json
        if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
            request.httpBody = postData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            //create a task to send reques
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                if error != nil {
                    print("error is:: \(error!.localizedDescription)")
                    return;
                }
                //parsing the response
                do {
                    // converting response to NSDictionary
                    let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    DispatchQueue.main.async {
                        if let parseJSON = myJSON{
                            var responseCode: Int!
                            var responseMessage: NSArray!
                            
                            //getting the json response
                            responseCode = parseJSON["RESPONSECODE"] as! Int?
                            responseMessage = parseJSON["RESPONSEMESSAGE"] as! NSArray?
                            
                            if responseCode == 0 {
                                for obj in responseMessage{
                                    if let dict = obj as? NSDictionary{
                                        self.offerContent = dict.value(forKey: "CONTENT") as? String
                                        self.offerTitle = dict.value(forKey: "TITLE") as? String
                                        self.suggestionLabel = dict.value(forKey: "SUGGESTION_LABEL") as? String
                                        self.suggestionScreen = dict.value(forKey: "SUGGESTION_SCREEN") as? String
                                        self.offerImage = dict.value(forKey: "IMAGE") as? String
                                        print("image:: \(self.offerImage!)")
                                        
                                        let lblTitle = UILabel()
                                        self.scrollView.addSubview(lblTitle)
                                        lblTitle.translatesAutoresizingMaskIntoConstraints = false
                                        lblTitle.textColor = UIColor.white
                                        lblTitle.text = self.offerTitle
                                        lblTitle.font = UIFont(name: String.defaultFontR, size: 20)
                                        lblTitle.topAnchor.constraint(equalTo: self.headIconImage.bottomAnchor, constant: 15).isActive = true
                                        lblTitle.centerXAnchor.constraint(equalTo: self.headImage.centerXAnchor).isActive = true
                                        
                                        let lblContent = UILabel()
                                        self.scrollView.addSubview(lblContent)
                                        lblContent.translatesAutoresizingMaskIntoConstraints = false
                                        lblContent.textColor = UIColor.white
                                        lblContent.text = self.offerContent
                                        lblContent.font = UIFont(name: String.defaultFontR, size: 15)
                                        lblContent.topAnchor.constraint(equalTo: self.bottomImage.topAnchor, constant: 15).isActive = true
                                        lblContent.leadingAnchor.constraint(equalTo: self.bottomImage.leadingAnchor, constant: 20).isActive = true
                                        lblContent.trailingAnchor.constraint(equalTo: self.bottomImage.trailingAnchor, constant: -20).isActive = true
                                        lblContent.numberOfLines = 0
                                        lblContent.lineBreakMode = .byWordWrapping
//                                        headImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
                                        /*let offerImageView = UIImageView()
                                        self.scrollView.addSubview(offerImageView)
                                        offerImageView.translatesAutoresizingMaskIntoConstraints = false
                                        offerImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
                                        offerImageView.widthAnchor.constraint(equalTo: self.darkView.widthAnchor).isActive = true
                                        offerImageView.topAnchor.constraint(equalTo: self.darkView.topAnchor, constant: 40).isActive = true
                                        offerImageView.sd_setImage(with: URL(string: "https://pixel.nymag.com/imgs/daily/vulture/2018/08/13/13-sabrina2.w432.h288.2x.jpg"), placeholderImage: UIImage(named: "ic_close"), options: [.continueInBackground, .progressiveDownload])*/
                                        
                                    }
                                }
                            }
                            
                            print(parseJSON)
                        }
                        }
                }catch{
                    print("catch:: \(error.localizedDescription)")
                }
                
            }
            task.resume()
        }
        
        print("Acchere:: \(AcctType)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Function to change header text
    func changeHeader(){
        lblOffersHeader.text = "Offers and Extras for you"
        lblOffersHeader.numberOfLines = 0
        lblOffersHeader.lineBreakMode = .byWordWrapping
    }
    //Function to change close btn colour
    func changeCloseBtnColour(){
        let close_image = UIImage(named: "new_close")
        let tintedImage = close_image?.withRenderingMode(.alwaysTemplate)
        btnClose.setImage(tintedImage, for: .normal)
        btnClose.tintColor = UIColor.white
        
        let back_image = UIImage(named: "leftArrow")
        let tintedImageB = back_image?.withRenderingMode(.alwaysTemplate)
        btnBack.setImage(tintedImageB, for: .normal)
        btnBack.tintColor = UIColor.white
        
        let btnMenu = UIImage(named: "hamburger")
        let tintedImageH = btnMenu?.withRenderingMode(.alwaysTemplate)
        hamburger.setImage(tintedImageH, for: .normal)
        hamburger.tintColor = UIColor.white
        
    }
    
    /*func setUpViews(){
        errorView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        errorView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        errorView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        errorView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        errorView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }*/
    
    //Function to make images round
    func makeImageRound(image:UIImageView){
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
//        image.layer.borderWidth = 2
    }
    
    //Function to change images to white
    @objc func changeImageToWhite(){
        let vfX = imgVFX.image?.withRenderingMode(.alwaysTemplate)
        imgVFX.image = vfX
        imgVFX.tintColor = UIColor.white
        
        let iddBundles = imgIDDBundles.image?.withRenderingMode(.alwaysTemplate)
        imgIDDBundles.image = iddBundles
        imgIDDBundles.tintColor = UIColor.white
        
        let vfcash = imgVCash.image?.withRenderingMode(.alwaysTemplate)
        imgVCash.image = vfcash
        imgVCash.tintColor = UIColor.white
        
        let ffB = imgFBB.image?.withRenderingMode(.alwaysTemplate)
        imgFBB.image = ffB
        imgFBB.tintColor = UIColor.white
        
        let settings = imgSettings.image?.withRenderingMode(.alwaysTemplate)
        imgSettings.image = settings
        imgSettings.tintColor = UIColor.white
    }
    //Function to add gestures to all offers
    func addGesturesToCards(){
        let planRec = UITapGestureRecognizer(target: self, action: #selector(self.goToPlans))
        planCard.addGestureRecognizer(planRec)
        
        let dataBundlesRec = UITapGestureRecognizer(target: self, action: #selector(self.goToDataBundles))
        dataBundlesCard.addGestureRecognizer(dataBundlesRec)
        
        let vodafoneXRec = UITapGestureRecognizer(target: self, action: #selector(self.goToVodafoneX))
        vodafoneXCard.addGestureRecognizer(vodafoneXRec)
        
        let iddBundlesRec = UITapGestureRecognizer(target: self, action: #selector(self.goToIDDBundles))
        IDDBundlesCard.addGestureRecognizer(iddBundlesRec)
        
        let vodafoneCashRec = UITapGestureRecognizer(target: self, action: #selector(self.goToVodafoneCash))
        vodafoneCash.addGestureRecognizer(vodafoneCashRec)
        
        let fbbRec = UITapGestureRecognizer(target: self, action: #selector(self.goToFBB))
        fixedBBCard.addGestureRecognizer(fbbRec)
        
        let servicesRec = UITapGestureRecognizer(target: self, action: #selector(self.goToServices))
        servicesCard.addGestureRecognizer(servicesRec)
    }
    
    
    //Function to go to plans view controller
    @objc func goToPlans(_sender: UITapGestureRecognizer){
        guard let moveTo = storyboard?.instantiateViewController(withIdentifier: "DisplayChosenOfferViewController") as? DisplayChosenOfferViewController else {return}
        moveTo.selectedOffer = "Plan"
//        let moveTo = storyboard?.instantiateViewController(withIdentifier: "DisplayChosenOfferViewController")
        present(moveTo, animated: true, completion: nil)
    }
    
    //Function to go to data bundles controller
    @objc func goToDataBundles(_sender: UITapGestureRecognizer){
        guard let moveTo = storyboard?.instantiateViewController(withIdentifier: "DisplayChosenOfferViewController") as? DisplayChosenOfferViewController else {return}
        moveTo.selectedOffer = "Data"
        present(moveTo, animated: true, completion: nil)
    }
    
    //Function to go to Vodafone X controller
    @objc func goToVodafoneX(_sender: UITapGestureRecognizer){
        guard let moveTo = storyboard?.instantiateViewController(withIdentifier: "DisplayChosenOfferViewController") as? DisplayChosenOfferViewController else {
            return
        }
        moveTo.selectedOffer = "Vodafone X"
        present(moveTo, animated: true, completion: nil)
    }
    
    //Function to go to IDD Bundles
    @objc func goToIDDBundles(_sender: UITapGestureRecognizer){
        guard let moveTo = storyboard?.instantiateViewController(withIdentifier: "DisplayChosenOfferViewController") as? DisplayChosenOfferViewController else {return}
        moveTo.selectedOffer = "IDD Bundles"
        present(moveTo, animated: true, completion: nil)
    }
    
    //Function to go to vodafone Cash
    @objc func goToVodafoneCash(_sender: UITapGestureRecognizer){
        guard let moveTo = storyboard?.instantiateViewController(withIdentifier: "DisplayChosenOfferViewController") as? DisplayChosenOfferViewController else {return}
        moveTo.selectedOffer = "Vodafone Cash"
        present(moveTo, animated: true, completion: nil)
    }
    
    //Function to go to fbb
    @objc func goToFBB(_sender: UITapGestureRecognizer){
        guard let moveTo = storyboard?.instantiateViewController(withIdentifier: "DisplayChosenOfferViewController") as? DisplayChosenOfferViewController else {return}
        moveTo.selectedOffer = "FBB"
        present(moveTo, animated: true, completion: nil)
    }
    
    //Function to go to Services
    @objc func goToServices(_sender: UITapGestureRecognizer){
        guard let moveTo = storyboard?.instantiateViewController(withIdentifier: "DisplayChosenOfferViewController") as? DisplayChosenOfferViewController else {return}
        moveTo.selectedOffer = "Services"
        present(moveTo, animated: true, completion: nil)
    }
    
    
    
    
    
}
