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
        
            // create a string for the google maps api.
            let baseUrl = "https://maps.googleapis.com/maps/api/geocode/json?"
            
            // store the api key
            let apikey = "AIzaSyCBbEHnpzqPwuD4FITiwVakMq2HjsBA5sw"
            
            // get the location from the text field.
            let parameterStr = self.locationText.text!
            
            // temporarilly store longitude and latitude with default values
            var longitude = 0.0
            var latitude = 0.0
            
            // search and replace in a string
            let replaceStr = parameterStr.replacingOccurrences(of: " ", with: "+")
            
            // create the finished string to send a request to.
            let urlStr = "\(baseUrl)address=\(replaceStr)&key=\(apikey)"
            
            // create a url.
            let url = URL(string: urlStr)
            
            // run this code on a background thread.
            DispatchQueue.global().async {
                
                // create a URLSession task to be completed.
                let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                    
                    if let data = data {
                        
                        
                        // get the geocoding data from google maps api as JSON
                        let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                        
                        // access the necessary longitude and latitude information
                        if let result = json["results"] as? NSArray {
                            if let geometry = (result[0] as! NSDictionary)["geometry"] {
                                if let location = geometry as? NSDictionary {
                                    if let loc = location["location"] as? NSDictionary {
                                        longitude = loc["lat"]! as! Double
                                        latitude = loc["lng"]! as! Double
                                        
                                        // run this code on the main thread.
                                        DispatchQueue.main.async {
                                            
                                            // create a reference to firebase database.
                                            let ref: FIRDatabaseReference = FIRDatabase.database().reference()
                                            
                                            // create an access point to add info to the database.
                                            let db = DBAccessObject(DBAccessObj: ref)
                                            
                                            // add the event to the database.
                                            db.addEventTreeStructure(eventRoot: "Events", title:
                                                self.titleText.text!, description: self.descriptionText.text!, avatar: "",Category: self.category.text!, chatChannel: 0, images: [], startDate: self.startDate.text!, endDate: self.endDate.text!, longitude: longitude, latitude: latitude)
                                            
                                            
                                            // reset the textfield's text back to blank.
                                            self.titleText.text = ""
                                            self.descriptionText.text = ""
                                            self.locationText.text = ""
                                            self.startDate.text = ""
                                            self.endDate.text = ""
                                            self.category.text = ""
                                            
                                            
                                        } // end DispatchQueue.main.async
                                        
                                    }
                                    
                                    
                                    
                                }
                                
                            }
                        }
                        
                        
                    }
                    
                    if let error = error {
                        print("the error is \(error)")
                    }
                    
                    
                    
                }) // end task

                // if the task is suspended resume it.
                task.resume()
            
            } // end of background thread.
            
            
        
        
    } // end of viewDidLoad().
} // end of class.


