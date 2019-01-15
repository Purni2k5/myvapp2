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
    
    //IOT Card
    let IOTCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.heightAnchor.constraint(equalToConstant: 106).isActive = true
        return view
    }()
    
//    var menuShowing = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // change header.
        changeHeader()
        //close button colour
        changeCloseBtnColour()
        let defaultMSISDN = preference.object(forKey: "defaultMSISDN")
        print("dd:: \(defaultMSISDN)")
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
        let msisdn = defaultMSISDN!
        
        
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
        
        setupViewsOffers()
        //Download offer details
        let request = NSMutableURLRequest(url: asycURL!)
        request.httpMethod = "POST"
        
        let postParameters: Dictionary<String, Any> = [
            "action":"offers",
            "msisdn":msisdn,
            "username":username,
            "os":getAppVersion()
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
                            print(parseJSON)
                            //getting the json response
                            responseCode = parseJSON["RESPONSECODE"] as! Int?
                            
                            
                            if responseCode == 0 {
                                responseMessage = parseJSON["RESPONSEMESSAGE"] as! NSArray?
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
                            
                        }
                        }
                }catch{
                    print("catch:: \(error.localizedDescription)")
                }
                
            }
            task.resume()
        }
        
        print("Acchere:: \(AcctType)")
        if AcctType == "PHONE_MOBILE_PRE_P" || AcctType == "BB_FIXED_PRE_P"{
            prePaidMenu()
        }else if AcctType == "PHONE_MOBILE_POST_P"{
            postPaidMenu()
        }
        else{
            prePaidMenu()
        }
        
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
        let storyboard = UIStoryboard(name: "OffersExtras", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "displayChosenOfferVc") as? displayChosenOfferVc else {return}
        moveTo.selectedOffer = "Plan"
//        let moveTo = storyboard?.instantiateViewController(withIdentifier: "DisplayChosenOfferViewController")
        present(moveTo, animated: true, completion: nil)
    }
    
    //Function to go to data bundles controller
    @objc func goToDataBundles(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "OffersExtras", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "displayChosenOfferVc") as? displayChosenOfferVc else {return}
        moveTo.selectedOffer = "Data"
        present(moveTo, animated: true, completion: nil)
    }
    
    //Function to go to Vodafone X controller
    @objc func goToVodafoneX(_sender: UITapGestureRecognizer){
        
        let storyboard = UIStoryboard(name: "OffersExtras", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "displayChosenOfferVc") as? displayChosenOfferVc else {
            return
        }
        moveTo.selectedOffer = "Vodafone X"
        present(moveTo, animated: true, completion: nil)
    }
    
    //Function to go to IDD Bundles
    @objc func goToIDDBundles(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "OffersExtras", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "displayChosenOfferVc") as? displayChosenOfferVc else {return}
        moveTo.selectedOffer = "IDD Bundles"
        present(moveTo, animated: true, completion: nil)
    }
    
    //Function to go to vodafone Cash
    @objc func goToVodafoneCash(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "OffersExtras", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "displayChosenOfferVc") as? displayChosenOfferVc else {return}
        moveTo.selectedOffer = "Vodafone Cash"
        present(moveTo, animated: true, completion: nil)
    }
    
    //Function to go to fbb
    @objc func goToFBB(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "OffersExtras", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "displayChosenOfferVc") as? displayChosenOfferVc else {return}
        moveTo.selectedOffer = "FBB"
        present(moveTo, animated: true, completion: nil)
    }
    
    //Function to go to Services
    @objc func goToServices(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "OffersExtras", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "displayChosenOfferVc") as? displayChosenOfferVc else {return}
        moveTo.selectedOffer = "Services"
        present(moveTo, animated: true, completion: nil)
    }
    
    //Function to go to IOT
    @objc func goToIOT(_sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "OffersExtras", bundle: nil)
        guard let moveTo = storyboard.instantiateViewController(withIdentifier: "displayChosenOfferVc") as? displayChosenOfferVc else {return}
        moveTo.selectedOffer = "Internet Of Things"
        present(moveTo, animated: true, completion: nil)
    }
    
    func setupViewsOffers(){
        scrollView.addSubview(IOTCard)
        IOTCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        IOTCard.topAnchor.constraint(equalTo: servicesCard.bottomAnchor, constant: 16).isActive = true
        IOTCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        IOTCard.layer.cornerRadius = 2
        IOTCard.layer.shadowOffset = CGSize(width: 0, height: 1)
        IOTCard.layer.shadowOpacity = 0.3
        IOTCard.layer.shadowColor = UIColor.black.cgColor
        
        let imageColour = UIImageView()
        imageColour.translatesAutoresizingMaskIntoConstraints = false
        IOTCard.addSubview(imageColour)
        imageColour.backgroundColor = UIColor.cardImageColour
        
        let roundImage = UIImageView()
        roundImage.translatesAutoresizingMaskIntoConstraints = false
        IOTCard.addSubview(roundImage)
        roundImage.backgroundColor = UIColor.vodaIconColour
        
        let lblIOT = UILabel()
        lblIOT.translatesAutoresizingMaskIntoConstraints = false
        IOTCard.addSubview(lblIOT)
        lblIOT.textColor = UIColor.black
        lblIOT.text = "IOT"
        lblIOT.numberOfLines = 0
        lblIOT.lineBreakMode = .byWordWrapping
        lblIOT.font = UIFont(name: String.defaultFontB, size: 21)
        
        let lblIOTDesc = UILabel()
        lblIOTDesc.translatesAutoresizingMaskIntoConstraints = false
        IOTCard.addSubview(lblIOTDesc)
        lblIOTDesc.textColor = UIColor.black
        lblIOTDesc.text = "Internet of Things"
        lblIOTDesc.numberOfLines = 0
        lblIOTDesc.lineBreakMode = .byWordWrapping
        lblIOTDesc.font = UIFont(name: String.defaultFontR, size: 15)
        
        let rightArrow = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        rightArrow.translatesAutoresizingMaskIntoConstraints = false
        IOTCard.addSubview(rightArrow)
        
        
        NSLayoutConstraint.activate([
            imageColour.leadingAnchor.constraint(equalTo: IOTCard.leadingAnchor),
            imageColour.topAnchor.constraint(equalTo: IOTCard.topAnchor),
            imageColour.widthAnchor.constraint(equalToConstant: 12),
            imageColour.bottomAnchor.constraint(equalTo: IOTCard.bottomAnchor),
            
            roundImage.leadingAnchor.constraint(equalTo: imageColour.trailingAnchor, constant: 19),
            roundImage.topAnchor.constraint(equalTo: IOTCard.topAnchor, constant: 28),
            roundImage.widthAnchor.constraint(equalToConstant: 50),
            roundImage.heightAnchor.constraint(equalToConstant: 50),
            
            lblIOT.leadingAnchor.constraint(equalTo: roundImage.trailingAnchor, constant: 10),
            lblIOT.topAnchor.constraint(equalTo: IOTCard.topAnchor, constant: 38),
            lblIOT.trailingAnchor.constraint(equalTo: IOTCard.trailingAnchor, constant: -10),
            
            lblIOTDesc.leadingAnchor.constraint(equalTo: roundImage.trailingAnchor, constant: 10),
            lblIOTDesc.topAnchor.constraint(equalTo: lblIOT.bottomAnchor, constant: 2.5),
            lblIOTDesc.trailingAnchor.constraint(equalTo: IOTCard.trailingAnchor, constant: -10),
            
            rightArrow.trailingAnchor.constraint(equalTo: IOTCard.trailingAnchor, constant: -9),
            rightArrow.topAnchor.constraint(equalTo: IOTCard.topAnchor, constant: 35),
            rightArrow.widthAnchor.constraint(equalToConstant: 10),
            rightArrow.heightAnchor.constraint(equalToConstant: 25)
            ])
        roundImage.layer.cornerRadius = 25
        let round_image = UIImage(named: "ic_settings")
        let tintColour = round_image?.withRenderingMode(.alwaysTemplate)
        roundImage.image = tintColour
        roundImage.tintColor = UIColor.white
        
        let iotRec = UITapGestureRecognizer(target: self, action: #selector(goToIOT(_sender:)))
        IOTCard.addGestureRecognizer(iotRec)
    }
    
}
