//
//  ViewController.swift
//  eventureAppV2
//
//  Created by Lucas Padden on 10/28/16.
//  Copyright © 2016 eventure-app. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, NSURLConnectionDelegate {
    
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func register(_ sender: AnyObject) {
        
        // url to send the request to
        let requestStr = "http://localhost:8789/eventure/api/v1.1/user/"
        
        // the information you want to send
        // this will most likely need to be parsed as JSON
        let parameters = [
            "username": username.text!,
            "password": password.text!
        ]
        
        // create base 64 login string
        let loginString = NSString(format: "%@:%@", username.text!, password.text!)
        let loginData = loginString.data(using: String.Encoding.utf8.rawValue)!
        let base64LoginString = loginData.base64EncodedString(options: .init(rawValue: 0))
        let authHeaderString = "Basic \(base64LoginString)"
        
        
        // create the http headers
        let headers = ["Authorization": authHeaderString]
        
        
        Alamofire.request(requestStr, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
                print(response)
            
            // show the status code
            if let status = response.response?.statusCode {
                switch(status) {
                case 200:
                    print("success registering user")
                default:
                    print("error with response status: \(status)")
                }
            }
        }
        
        // reset the text
        self.username.text = ""
        self.password.text = ""
        
    }
    

    
    @IBAction func login(_ sender: AnyObject) {
        
        // url to send the request to
        let requestStr = "http://localhost:8789/eventure/api/v1.1/user/"
        
        // the information you want to send
        // this will most likely need to be parsed as JSON
        let parameters = [
            "username": username.text!,
            "password": password.text!
        ]
        
        // create base 64 login string
        let loginString = NSString(format: "%@:%@", username.text!, password.text!)
        let loginData = loginString.data(using: String.Encoding.utf8.rawValue)!
        let base64LoginString = loginData.base64EncodedString(options: .init(rawValue: 0))
        let authHeaderString = "Basic \(base64LoginString)"
        
        
        // create the http headers
        let headers = ["Authorization": authHeaderString]
        
        // make get request for a user
        Alamofire.request(requestStr, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
                print(response)
            
            // get status code
            if let status = response.response?.statusCode {
                switch(status) {
                case 201:
                    print("success registering user")
                default:
                    print("error with response status: \(status)")
                }
            }
        
    }
        
        
        self.username.text = ""
        self.password.text = ""
        
}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // need to implement login/signup
        // the client should send an http request with a json body to the server to create(POST) a user
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

