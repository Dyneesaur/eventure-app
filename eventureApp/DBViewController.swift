//
//  DBViewController.swift
//  eventureApp
//
//  Created by Lucas Padden on 10/22/16.
//  Copyright © 2016 eventure-app. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DBViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        // add data to the database and display it.
        
        let ref: FIRDatabaseReference = FIRDatabase.database().reference()
        
        // construct a DBAccessObject
        let db = DBAccessObject(DBAccessObj: ref)
        
        // add Event Tree structure to DB
        
        db.addEventTreeStructure(eventRoot: "Events", event: "eventOne", title: "Skate", description: "Skating in central park", avatar: "http://assets.fodors.com/destinations/1128/central-park-manhattan-new-york-city-new-york-usa_main.jpg", Category: "Recreational", chatChannel: 1, images: ["https://upload.wikimedia.org/wikipedia/commons/d/d9/Lower_Central_Park_Shot_5.JPG","https://upload.wikimedia.org/wikipedia/commons/0/05/Southwest_corner_of_Central_Park,_looking_east,_NYC.jpg","http://cpc.convio.net/images/fall-2015/conservatory-water.jpg"], dateCreated: "2016-10-22")
        
        
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
