//
//  DBViewController.swift
//  eventureApp
//
//  Created by Lucas Padden on 10/22/16.
//  Copyright © 2016 eventure-app. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


class DBViewController: UIViewController {

    @IBOutlet weak var category: UILabel!
    
    @IBOutlet weak var chatChannel: UILabel!
    
    @IBOutlet var dbData: UIView!
    
    
    @IBOutlet weak var titleData: UILabel!
    
    @IBOutlet weak var descriptionData: UILabel!
    
    
    @IBOutlet weak var eventNumber: UILabel!
    
    
    @IBOutlet weak var image: UILabel!
    
    
    @IBOutlet weak var dateCreated: UILabel!
    
    
    
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
        
        // seeds the db with data.
        //db.addEventTreeStructure(eventRoot: "Events", event: "eventOne", title: "Skate", description: "Skating in central park", avatar: "http://assets.fodors.com/destinations/1128/central-park-manhattan-new-york-city-new-york-usa_main.jpg", Category: "Recreational", chatChannel: 1, images: ["https://upload.wikimedia.org/wikipedia/commons/d/d9/Lower_Central_Park_Shot_5.JPG","https://upload.wikimedia.org/wikipedia/commons/0/05/Southwest_corner_of_Central_Park,_looking_east,_NYC.jpg","http://cpc.convio.net/images/fall-2015/conservatory-water.jpg"], dateCreated: "2016-10-22")
        
        
        
        
    }
    
    
    @IBAction func showDataTapped(_ sender: AnyObject) {
        
        let ref: FIRDatabaseReference = FIRDatabase.database().reference()
        
        
        let titleRef = ref.child("Events").child("eventOne").child("title")
        titleRef.observe(FIRDataEventType.value, with: {(snapshot) in
            self.titleData.text = snapshot.value as! String
        })
        
        let catRef = ref.child("Events").child("eventOne").child("category")
        catRef.observe(FIRDataEventType.value, with: {(snapshot) in
            self.category.text = snapshot.value as! String
        })
        
        let descRef = ref.child("Events").child("eventOne").child("description")
        descRef.observe(FIRDataEventType.value, with: {(snapshot) in
            self.descriptionData.text = snapshot.value as! String
        })
        
        let chanRef = ref.child("Events").child("eventOne").child("chatChannel")
        chanRef.observe(FIRDataEventType.value, with: {(snapshot) in
            self.chatChannel.text = String(describing: snapshot.value)
        })
        
        let dateCreateRef = ref.child("Events").child("eventOne").child("dateCreated")
        dateCreateRef.observe(FIRDataEventType.value, with: {(snapshot) in
            self.dateCreated.text = snapshot.value as! String
        })
        
        let imgRef = ref.child("Events").child("eventOne").child("avatar")
        imgRef.observe(FIRDataEventType.value, with: {(snapshot) in
            self.image.text = snapshot.value as! String
        })
        
    
    }
    
    
    @IBAction func logout(_ sender: AnyObject) {
        
        
        // log the currently signed in user out.
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in.
                // try to log user out
                do {
                    try FIRAuth.auth()?.signOut()
                }
                catch {
                    print("Error while signing out")
                }
                
            } else {
                // No user is signed in.
            }
        }
        
    }
    
    

}
