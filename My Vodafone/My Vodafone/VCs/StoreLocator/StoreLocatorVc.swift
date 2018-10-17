//
//  StoreLocatorVc.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 21/09/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


struct CellData {
    let image: UIImage?
    let name: String?
    let distance: String?
    let desc: String?
}

class StoreLocatorVc: baseViewControllerM, MKMapViewDelegate {

    //closure for scroll view
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // top Image for
    let topImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // back button
    let backButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Menu button
    let btnMenu: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Store table
    let storeTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let txtSearch = UITextField()
    let btnSrch = UIButton()
    let btnGetLocation = UIButton()
    let currLocView = UIView()
    let lblCurrLoc = UILabel()
    let cardView = UIView()
    let btnListView = UIView()
    let btnMapView = UIView()
    let redView = UIView()
    
    let mapView = MKMapView()
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 20000
    var previousLocation: CLLocation?
    var latitude: Double?
    var longitude: Double?
    var displayLocation: String?
    
    fileprivate var redViewLeft1: NSLayoutConstraint?
    fileprivate var redViewLeft2: NSLayoutConstraint?
    fileprivate var redViewTop1: NSLayoutConstraint?
    fileprivate var redViewTop2: NSLayoutConstraint?
    fileprivate var redViewRight1: NSLayoutConstraint?
    fileprivate var redViewRight2: NSLayoutConstraint?
    
    var animalArray: [String] = ["Dog", "Cat", "Goat", "Sheep", "Rabbit", "Crocodile", "Lizard", "Monkey", "Cat", "Goat", "Sheep", "Rabbit", "Crocodile", "Lizard", "Monkey", "Cat", "Goat", "Sheep", "Rabbit", "Crocodile", "Lizard", "Monkey"]
    var cellID = "cellID"
    var locationData = [CellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayBackground
        setUpViewsLocator()
        mapView.delegate = self
        checkLocationServices()
        hideKeyboardWhenTappedAround()
        
//        locationData = [CellData.init(image: #imageLiteral(resourceName: "wifi"), name: "How", distance: "12km", desc: "Description")]
        
        if AcctType == "PHONE_MOBILE_PRE_P" {
            prePaidMenu()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let viewHeight = view.frame.size.height
        let cardViewHeight = view.frame.size.width
        print("width \(cardViewHeight)")
        scrollView.contentSize.height = viewHeight + 70
    }

    func setUpViewsLocator() {
        view.addSubview(scrollView)
        
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
        
        scrollView.addSubview(topImage)
        let timeOfDay = greetings()
        if timeOfDay == "morning"{
            topImage.image = UIImage(named: "bg2")
        }else if timeOfDay == "afternoon" {
            topImage.image = UIImage(named: "afternoon_bg")
        }else{
            topImage.image = UIImage(named: "evening_bg2")
        }
        topImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
        topImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImage.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        topImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        scrollView.addSubview(backButton)
        let backImage = UIImage(named: "leftArrow")
        let backTint = backImage?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(backTint, for: .normal)
        backButton.tintColor = UIColor.white
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 10).isActive = true
        backButton.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
        
        scrollView.addSubview(btnMenu)
        let menuImage = UIImage(named: "menu")
        btnMenu.setImage(menuImage, for: .normal)
        btnMenu.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnMenu.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnMenu.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 10).isActive = true
        btnMenu.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -10).isActive = true
        btnMenu.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        
        //Menu label
        let lblMenu = UILabel()
        scrollView.addSubview(lblMenu)
        lblMenu.translatesAutoresizingMaskIntoConstraints = false
        lblMenu.textColor = UIColor.white
        lblMenu.text = "MENU"
        lblMenu.font = UIFont(name: String.defaultFontR, size: 13)
        lblMenu.topAnchor.constraint(equalTo: btnMenu.bottomAnchor, constant: -3).isActive = true
        lblMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14).isActive = true
        
        //Selected Offer
        let lblSelectedOffer = UILabel()
        scrollView.addSubview(lblSelectedOffer)
        lblSelectedOffer.translatesAutoresizingMaskIntoConstraints = false
        lblSelectedOffer.textColor = UIColor.white
        lblSelectedOffer.textAlignment = .center
        lblSelectedOffer.font = UIFont(name: String.defaultFontR, size: 31)
        lblSelectedOffer.text = "Store Locator"
        lblSelectedOffer.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 20).isActive = true
        lblSelectedOffer.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 50).isActive = true
        lblSelectedOffer.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -20).isActive = true
        lblSelectedOffer.numberOfLines = 0
        lblSelectedOffer.lineBreakMode = .byWordWrapping
        
        let darkView = UIView()
        scrollView.addSubview(darkView)
        darkView.translatesAutoresizingMaskIntoConstraints = false
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        darkView.leadingAnchor.constraint(equalTo: topImage.leadingAnchor, constant: 10).isActive = true
        darkView.topAnchor.constraint(equalTo: lblSelectedOffer.bottomAnchor, constant: 1).isActive = true
        darkView.trailingAnchor.constraint(equalTo: topImage.trailingAnchor, constant: -10).isActive = true
        darkView.heightAnchor.constraint(equalToConstant: 155).isActive = true
        
        let lblDesc = UILabel()
        darkView.addSubview(lblDesc)
        lblDesc.translatesAutoresizingMaskIntoConstraints = false
        lblDesc.text = "Find the nearest vodafone agent"
        lblDesc.textColor = UIColor.white
        lblDesc.textAlignment = .center
        lblDesc.font = UIFont(name: String.defaultFontR, size: 17)
        lblDesc.numberOfLines = 0
        lblDesc.lineBreakMode = .byWordWrapping
        lblDesc.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 20).isActive = true
        lblDesc.topAnchor.constraint(equalTo: darkView.topAnchor, constant: 10).isActive = true
        lblDesc.trailingAnchor.constraint(equalTo: darkView.trailingAnchor, constant: -20).isActive = true
        
        darkView.addSubview(txtSearch)
        txtSearch.translatesAutoresizingMaskIntoConstraints = false
        txtSearch.backgroundColor = UIColor.white
        txtSearch.borderStyle = .roundedRect
        txtSearch.placeholder = "Type your location here"
        txtSearch.font = UIFont(name: String.defaultFontR, size: 20)
        txtSearch.leadingAnchor.constraint(equalTo: darkView.leadingAnchor, constant: 10).isActive = true
        txtSearch.topAnchor.constraint(equalTo: lblDesc.bottomAnchor, constant: 30).isActive = true
        txtSearch.widthAnchor.constraint(equalToConstant: 200).isActive = true
        txtSearch.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        darkView.addSubview(btnSrch)
        btnSrch.translatesAutoresizingMaskIntoConstraints = false
        let srchImage = UIImage(named: "ic_action__search")
        let tintImage = srchImage?.withRenderingMode(.alwaysTemplate)
        btnSrch.backgroundColor = UIColor.vodaRed
        btnSrch.isEnabled = false
        btnSrch.leadingAnchor.constraint(equalTo: txtSearch.trailingAnchor, constant: 10).isActive = true
        btnSrch.topAnchor.constraint(equalTo: lblDesc.bottomAnchor, constant: 30).isActive = true
        btnSrch.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btnSrch.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnSrch.setImage(tintImage, for: .normal)
        btnSrch.tintColor = UIColor.white
        btnSrch.imageEdgeInsets = UIEdgeInsetsMake(50, 50, 50, 50)
        
        darkView.addSubview(btnGetLocation)
        btnGetLocation.translatesAutoresizingMaskIntoConstraints = false
        btnGetLocation.backgroundColor = UIColor.grayButton
        let getLocImage = UIImage(named: "ic_location_marker")
        let getLocTint = getLocImage?.withRenderingMode(.alwaysTemplate)
        btnGetLocation.setImage(getLocTint, for: .normal)
        btnGetLocation.imageEdgeInsets = UIEdgeInsetsMake(40, 40, 40, 40)
        btnGetLocation.tintColor = UIColor.white
        btnGetLocation.leadingAnchor.constraint(equalTo: btnSrch.trailingAnchor, constant: 20).isActive = true
        btnGetLocation.topAnchor.constraint(equalTo: lblDesc.bottomAnchor, constant: 30).isActive = true
        btnGetLocation.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btnGetLocation.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnGetLocation.addTarget(self, action: #selector(btnGetStores), for: .touchUpInside)
        
        scrollView.addSubview(currLocView)
        currLocView.translatesAutoresizingMaskIntoConstraints = false
        currLocView.backgroundColor = UIColor.cardImageColour
        currLocView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        currLocView.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 10).isActive = true
        currLocView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        currLocView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        scrollView.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = UIColor.white
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cardView.topAnchor.constraint(equalTo: currLocView.bottomAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 320).isActive = true
        
        currLocView.addSubview(lblCurrLoc)
        lblCurrLoc.translatesAutoresizingMaskIntoConstraints = false
        lblCurrLoc.text = "Your location"
        lblCurrLoc.font = UIFont(name: String.defaultFontB, size: 20)
        lblCurrLoc.textColor = UIColor.white
        lblCurrLoc.textAlignment = .center
        lblCurrLoc.numberOfLines = 0
        lblCurrLoc.lineBreakMode = .byWordWrapping
        lblCurrLoc.leadingAnchor.constraint(equalTo: currLocView.leadingAnchor, constant: 5).isActive = true
        lblCurrLoc.topAnchor.constraint(equalTo: currLocView.topAnchor, constant: 10).isActive = true
        lblCurrLoc.trailingAnchor.constraint(equalTo: currLocView.trailingAnchor, constant: -5).isActive = true
        
        cardView.addSubview(btnListView)
        btnListView.translatesAutoresizingMaskIntoConstraints = false
        btnListView.backgroundColor = UIColor.white
        btnListView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        btnListView.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        btnListView.widthAnchor.constraint(equalToConstant: 187.5).isActive = true
        btnListView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnListView.layer.cornerRadius = 2
        btnListView.layer.shadowOffset = CGSize(width: 0, height: 5)
        btnListView.layer.shadowColor = UIColor.black.cgColor
        btnListView.layer.shadowOpacity = 0.2
        
        let listViewRec = UITapGestureRecognizer(target: self, action: #selector(switchToTableView(_sender:)))
        btnListView.addGestureRecognizer(listViewRec)
        
        let lblListView = UILabel()
        btnListView.addSubview(lblListView)
        lblListView.translatesAutoresizingMaskIntoConstraints = false
        lblListView.text = "List View"
        lblListView.textColor = UIColor.black
        lblListView.font = UIFont(name: String.defaultFontB, size: 20)
        lblListView.textAlignment = .center
        lblListView.centerXAnchor.constraint(equalTo: btnListView.centerXAnchor).isActive = true
        lblListView.centerYAnchor.constraint(equalTo: btnListView.centerYAnchor).isActive = true
        
        cardView.addSubview(btnMapView)
        btnMapView.translatesAutoresizingMaskIntoConstraints = false
        btnMapView.backgroundColor = UIColor.white
        btnMapView.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        btnMapView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        btnMapView.widthAnchor.constraint(equalToConstant: 187.5).isActive = true
        btnMapView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnMapView.layer.cornerRadius = 2
        btnMapView.layer.shadowOffset = CGSize(width: 0, height: 5)
        btnMapView.layer.shadowColor = UIColor.black.cgColor
        btnMapView.layer.shadowOpacity = 0.2
        
        let mapViewRec = UITapGestureRecognizer(target: self, action: #selector(switchToMap(_sender:)))
        btnMapView.addGestureRecognizer(mapViewRec)
        
        let lblMapView = UILabel()
        btnMapView.addSubview(lblMapView)
        lblMapView.translatesAutoresizingMaskIntoConstraints = false
        lblMapView.text = "Map View"
        lblMapView.textColor = UIColor.black
        lblMapView.font = UIFont(name: String.defaultFontB, size: 20)
        lblMapView.textAlignment = .center
        lblMapView.centerXAnchor.constraint(equalTo: btnMapView.centerXAnchor).isActive = true
        lblMapView.centerYAnchor.constraint(equalTo: btnMapView.centerYAnchor).isActive = true
        
        cardView.addSubview(redView)
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.backgroundColor = UIColor.red
        redView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        redViewLeft1 = redView.leadingAnchor.constraint(equalTo: btnListView.leadingAnchor)
        redViewLeft2 = redView.leadingAnchor.constraint(equalTo: btnMapView.leadingAnchor)
        redViewRight1 = redView.trailingAnchor.constraint(equalTo: btnListView.trailingAnchor)
        redViewRight2 = redView.trailingAnchor.constraint(equalTo: btnMapView.trailingAnchor)
        redViewTop1 = redView.topAnchor.constraint(equalTo: btnListView.bottomAnchor)
        redViewTop2 = redView.topAnchor.constraint(equalTo: btnMapView.bottomAnchor)
        redViewLeft1?.isActive = true
        redViewTop1?.isActive = true
        redViewRight1?.isActive = true
        
        cardView.addSubview(storeTableView)
        storeTableView.translatesAutoresizingMaskIntoConstraints = false
        storeTableView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        storeTableView.topAnchor.constraint(equalTo: redView.bottomAnchor).isActive = true
        storeTableView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        storeTableView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
        storeTableView.register(CustomCell.self, forCellReuseIdentifier: cellID)
        storeTableView.delegate = self
        storeTableView.dataSource = self
        
        cardView.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: redView.bottomAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
        mapView.isHidden = true
        
        let mapPin = UIImageView(image: #imageLiteral(resourceName: "mylocation"))
        mapView.addSubview(mapPin)
        mapPin.translatesAutoresizingMaskIntoConstraints = false
        mapPin.widthAnchor.constraint(equalToConstant: 40).isActive = true
        mapPin.heightAnchor.constraint(equalToConstant: 40).isActive = true
        mapPin.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
        mapPin.centerYAnchor.constraint(equalTo: mapView.centerYAnchor, constant: -20).isActive = true
        mapPin.contentMode = .scaleAspectFit
        
        
    }
    
    @objc func switchToMap(_sender: UITapGestureRecognizer){
        UIView.animate(withDuration: 1, animations: {
            
        }) { (true) in
            self.constraintToMap()
        }
    }
    
    @objc func switchToTableView(_sender: UITapGestureRecognizer){
        UIView.animate(withDuration: 1, animations: {
            
        }) { (true) in
            self.constraintToTableView()
        }
    }
    
    func constraintToMap(){
        self.mapView.isHidden = false
        //TODO hide table view
        self.redViewLeft1?.isActive = false
        self.redViewLeft2?.isActive = true
        self.redViewTop1?.isActive = false
        self.redViewTop2?.isActive = true
        self.redViewRight1?.isActive = false
        self.redViewRight2?.isActive = true
    }
    
    func constraintToTableView(){
        //TODO show table view
        self.mapView.isHidden = true
        self.redViewLeft2?.isActive = false
        self.redViewLeft1?.isActive = true
        self.redViewTop2?.isActive = false
        self.redViewTop1?.isActive = true
        self.redViewRight2?.isActive = false
        self.redViewRight1?.isActive = true
        self.storeTableView.isHidden = false
    }
    
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(location, regionInMeters, regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    
    func startTrackingUserLocation(){
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    func setUpLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            //set up our location manager
            setUpLocationManager()
            checkLocationAuthorization()
        }else{
            //show alert
            print("Location not enabled")
        }
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus(){
        case .authorizedWhenInUse:
            //Do Map Stuff
            startTrackingUserLocation()
        case .denied:
            //show alert instucting them how to turn on permissions
            break
        case .notDetermined:
            //request permission
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            //show alert letting them know what's up
            break
        case .authorizedAlways:
            break
        }
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    @objc func btnGetStores(){
        lblCurrLoc.text = ""
        for _ in locationData {
            locationData.remove(at: 0)
            let indexPath = IndexPath(item: 0, section: 0)
            storeTableView.deleteRows(at: [indexPath], with: .fade)
        }
        lblCurrLoc.text = displayLocation
        getStores(coordX: latitude!, coordY: longitude!)
    }
    
    func getStores(coordX: Double, coordY: Double){
        
        let async_call = URL(string: String.offers)
        let request = NSMutableURLRequest(url: async_call!)
        request.httpMethod = "POST"
        let postParameters: Dictionary<String, Any> = [
            "action":"shops",
            "option":"location",
            "lat":String(coordX),
            "long":String(coordY),
            "searchValue":"",
            "os":getAppVersion()
        ]
        
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
                    if let parseJSON = myJSON {
                        var responseCode: Int?
                        responseCode = parseJSON["RESPONSECODE"] as! Int?
                        if responseCode == 0 {
                            let responseMessage = parseJSON["RESPONSEMESSAGE"] as! NSArray?
                            if let array = responseMessage {
                                DispatchQueue.main.async {
                                    for obj in array{
                                        if let dict = obj as? NSDictionary {
                                            if let shopName = dict.value(forKey: "NAME") as? String, let shopLandMark = dict.value(forKey: "LANDMARK") as! String?, var shopDistance = dict.value(forKey: "DISTANCE") as! String?{
                                                shopDistance = "\(shopDistance) km"
                                                let shopLocation = CellData(image: #imageLiteral(resourceName: "wifi"), name: shopName, distance: shopDistance, desc: shopLandMark)
                                                self.locationData.append(shopLocation)
                                            }
                                            
                                            
                                        }
                                    }
                                    self.storeTableView.reloadData()
                                }
                            }
                        }else{
                            
                        }
                        print(parseJSON)
                    }
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
  
}

extension StoreLocatorVc: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegionMakeWithDistance(center, regionInMeters, regionInMeters)
        
        
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //
        checkLocationAuthorization()
    }
}

extension StoreLocatorVc {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        
        let geoCoder = CLGeocoder()
        
        guard center.distance(from: previousLocation!) > 50 else { return }
        
        previousLocation = center
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let strongSelf = self else { return }
            
            if let _ = error {
                //Show an alert
                return
            }
            
            guard let placemark = placemarks?.first else {
                //TODO Show alert informing the user
                return
            }
            
            let streetNumber = placemark.subLocality ?? ""
            let streetName = placemark.thoroughfare ?? ""
            let city = placemark.locality ?? ""
            let country = placemark.country ?? ""
            strongSelf.latitude = placemark.location?.coordinate.latitude ?? 0.0
            strongSelf.longitude = placemark.location?.coordinate.longitude ?? 0.0
            strongSelf.getStores(coordX: strongSelf.latitude!, coordY: strongSelf.longitude!)
            strongSelf.displayLocation = "Your location \n\(streetNumber) \(streetName), \(city), \(country)"
            DispatchQueue.main.async {
                strongSelf.lblCurrLoc.text = "Your location \n\(streetNumber) \(streetName), \(city), \(country)"
            }
        }
    }
}

extension StoreLocatorVc: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = storeTableView.dequeueReusableCell(withIdentifier: cellID) as! CustomCell
        cell.mainImage = locationData[indexPath.row].image
        cell.name = locationData[indexPath.row].name
        cell.distance = locationData[indexPath.row].distance
        cell.desc = locationData[indexPath.row].desc
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset.left = 30
        cell.separatorInset.right = 30
        cell.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "StoreLocator", bundle: nil)
        let moveTo = storyboard.instantiateViewController(withIdentifier: "GetDirectionToStore")
        present(moveTo, animated: true, completion: nil)
    }
    
    /*func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.locationData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }*/
}
