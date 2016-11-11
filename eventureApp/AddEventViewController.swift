//
//  AddEventViewController.swift
//  eventureApp
//
//  Created by Lucas Padden on 11/2/16.
//  Copyright © 2016 eventure-app. All rights reserved.
//

import UIKit
import FirebaseDatabase
import CoreLocation
import AddressBookUI
import GoogleMaps

class AddEventViewController: UIViewController {

    @IBOutlet weak var descriptionText: UITextField!
    
    @IBOutlet weak var titleText: UITextField!
    
    @IBOutlet weak var locationText: UITextField!
    
    
    @IBOutlet weak var startDate: UITextField!
    
    @IBOutlet weak var endDate: UITextField!
    
    
    @IBOutlet weak var category: UITextField!
    
    @IBAction func submit(_ sender: AnyObject) {
        
        OperationQueue.main.addOperation {
            
            let baseUrl = "https://maps.googleapis.com/maps/api/geocode/json?"
            
            let apikey = "AIzaSyCBbEHnpzqPwuD4FITiwVakMq2HjsBA5sw"
            
            let parameterStr = self.locationText.text!
            
            var longitude = 0.0
            var latitude = 0.0
            
            // search and replace in a string
            let replaceStr = parameterStr.replacingOccurrences(of: " ", with: "+")
            
            let urlStr = "\(baseUrl)address=\(replaceStr)&key=\(apikey)"
            print("url str is \(urlStr)")
            
            // make http request to url with address
            let url = URL(string: urlStr)
            print("url is \(url)")
            
            DispatchQueue.global().async {
                
                let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                    
                    if let data = data {
                        
                        
                        
                        let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                        
                        if let result = json["results"] as? NSArray {
                            if let geometry = (result[0] as! NSDictionary)["geometry"] {
                                if let location = geometry as? NSDictionary {
                                    if let loc = location["location"] as? NSDictionary {
                                        longitude = loc["lat"]! as! Double
                                        latitude = loc["lng"]! as! Double
                                        
                                        DispatchQueue.main.async {
                                            
                                            let ref: FIRDatabaseReference = FIRDatabase.database().reference()
                                            
                                            let db = DBAccessObject(DBAccessObj: ref)
                                            
                                            db.addEventTreeStructure(eventRoot: "Events", title:
                                                self.titleText.text!, description: self.descriptionText.text!, avatar: "",Category: self.category.text!, chatChannel: 0, images: [], startDate: self.startDate.text!, endDate: self.endDate.text!, longitude: longitude, latitude: latitude)
                                            
                                            
                                            self.titleText.text = ""
                                            self.descriptionText.text = ""
                                            self.locationText.text = ""
                                            self.startDate.text = ""
                                            self.endDate.text = ""
                                            self.category.text = ""
                                            
                                            
                                        }
                                        
                                    }
                                    
                                    
                                    
                                }
                                
                            }
                        }
                        
                        
                    }
                    
                    if let error = error {
                        print("the error is \(error)")
                    }
                    
                    
                    
                })

                
                task.resume()
            }
            
            
        }
        
    }
}


