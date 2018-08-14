//
//  toppingUpViewController.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 04/07/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit

class toppingUpViewController: UIViewController {

    let preference = UserDefaults.standard
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var txtTopUpNumber: UITextField!
    @IBOutlet weak var txtScratchNumber: UITextField!
    @IBOutlet weak var errorDialog: UIImageView!
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var lblErrorMessage: UILabel!
    
    //contraints for labels
    @IBOutlet weak var lblMobileNoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var btnProceed: UIButton!
    
    //api urlhttp://testpay.vodafonecash.com.gh/MyVodafoneAPI/UserSvc
    let topUpUrl = URL(string: "https://myvodafoneappmw.vodafone.com.gh/MyVodafoneAPI/UserSvc")
    var username:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        indicator.isHidden = true

        // change close btn colour.
        changeColour()
        //get default number and load
        let UserData = preference.object(forKey: "responseData") as! NSDictionary
        let defaultNumber = UserData["Contact"] as! String
        username = UserData["Username"] as! String
        
        txtTopUpNumber.text = defaultNumber
        
        
        print("default::\(defaultNumber)")
        print("username::\(username)")
    }
    @IBAction func closeTopu(_ sender: Any) {
        let gotToTup = storyboard?.instantiateViewController(withIdentifier: "TopUpViewController")
        present(gotToTup!, animated: true, completion: nil)
    }
    
    //Function to complete transaction
    @IBAction func topUp(_ sender: Any) {
        //hide keyboard
        txtTopUpNumber.resignFirstResponder()
        txtScratchNumber.resignFirstResponder()
        let numberTopUp = txtTopUpNumber.text
        let scratchNumber = txtScratchNumber.text
        
        if numberTopUp == ""{
            errorDialog.isHidden = false
            errorImage.isHidden = false
            lblErrorMessage.isHidden = false
            lblErrorMessage.text = "Provide mobile number"
            lblMobileNoTopConstraint.constant = 68
            txtTopUpNumber.becomeFirstResponder()
        }else {
            errorDialog.isHidden = true
            errorImage.isHidden = true
            lblErrorMessage.isHidden = true
            lblMobileNoTopConstraint.constant = 20
            if scratchNumber == "" {
                errorDialog.isHidden = false
                errorImage.isHidden = false
                lblErrorMessage.isHidden = false
                lblErrorMessage.text = "Provide scratch card pin"
                lblMobileNoTopConstraint.constant = 68
                txtScratchNumber.becomeFirstResponder()
            }else{
                startAsyncLoader()
                //create nsurl request
                let request = NSMutableURLRequest(url: topUpUrl!)
                request.httpMethod = "POST"
                let postParameters: Dictionary<String, Any> = [
                    "action":"topUp",
                    "msisdn":numberTopUp!,
                    "pin":scratchNumber!,
                    "username":username
                ]
                if let postData = (try? JSONSerialization.data(withJSONObject: postParameters, options: JSONSerialization.WritingOptions.prettyPrinted)){
                    request.httpBody = postData
                    //creating task to send post data
                    let task = URLSession.shared.dataTask(with: request as URLRequest){
                        data, response, error in
                        if error != nil {
                            print("error is:: \(error!)")
                            return;
                        }
                        //parsing the response
                        do{
                            //converting response to NSDictionary
                            let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            //parsing the json
                            if let parseJSON = myJSON {
                                var responseCode: Int!
                                var responseMessage: String!
                                //getting the json response
//                                responseCode = parseJSON["RESPONSECODE"] as! Int?
//                                responseMessage = parseJSON["RESPONSEMESSAGE"] as! String
                                print("responseJSON:: \(parseJSON)")
                                DispatchQueue.main.async {
                                    self.stopAsyncLoader()
                                    
                                }
                            }
                            
                        }catch{
                            print(error)
                        }
                    }
                    task.resume()
                    
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //change close btn colour
    func changeColour(){
        let close_image = UIImage(named: "new_close")
        let tintedImage = close_image?.withRenderingMode(.alwaysTemplate)
        btnClose.setImage(tintedImage, for: .normal)
        btnClose.tintColor = UIColor.white
    }
    
    //Function to start indicator
    func startAsyncLoader(){
        indicator.isHidden = false
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        btnProceed.isHidden = true
    }
    
    //Function to stop Indicator
    func stopAsyncLoader(){
        indicator.isHidden = true
        indicator.stopAnimating()
        btnProceed.isHidden = false
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
