//
//  EventsProfileViewController.swift
//  eventureApp
//
//  Created by Marco Roveto on 11/8/16.
//  Copyright © 2016 eventure-app. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EventsProfileViewController: UIViewController {
    
    @IBOutlet var eventTitle: UILabel!
    @IBOutlet var eventDescription: UILabel!
    @IBOutlet var eventCategory: UILabel!
    
    var eventId: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //        FIRDatabase.database().reference().child("Events").child(
        
        //print(eventId)
        FIRDatabase.database().reference().child("Events").child(eventId).observe(.value, with: { (snapshot) in
            let dictionary = snapshot.value as? Dictionary<String, AnyObject>
            //print(dictionary)
            let eventTitle = dictionary?["title"] as? String
            self.eventTitle.text = eventTitle
            
            let eventDescription = dictionary?["description"] as? String
            self.eventDescription.text = eventDescription
            
            let eventCategory = dictionary?["category"] as? String
            self.eventCategory.text = eventCategory
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
