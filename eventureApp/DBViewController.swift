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
        //db.addEventTreeStructure(eventRoot: "Events",  title: "Skate", description: "Skating in central park", avatar: "http://assets.fodors.com/destinations/1128/central-park-manhattan-new-york-city-new-york-usa_main.jpg", Category: "Recreational", chatChannel: 1, images: ["https://upload.wikimedia.org/wikipedia/commons/d/d9/Lower_Central_Park_Shot_5.JPG","https://upload.wikimedia.org/wikipedia/commons/0/05/Southwest_corner_of_Central_Park,_looking_east,_NYC.jpg","http://cpc.convio.net/images/fall-2015/conservatory-water.jpg"], dateCreated: "2016-10-22")
        //db.addEventTreeStructure(eventRoot: "Events",  title: "Walking", description: "Walking in central park", avatar: "http://assets.fodors.com/destinations/1128/central-park-manhattan-new-york-city-new-york-usa_main.jpg", Category: "Recreational", chatChannel: 2, images: ["https://upload.wikimedia.org/wikipedia/commons/d/d9/Lower_Central_Park_Shot_5.JPG","https://upload.wikimedia.org/wikipedia/commons/0/05/Southwest_corner_of_Central_Park,_looking_east,_NYC.jpg","http://cpc.convio.net/images/fall-2015/conservatory-water.jpg"], dateCreated: "2016-10-22")
        
        //        db.addEventTreeStructure(eventRoot: "Events", title: "title", description: "desc", avatar: "https://upload.wikimedia.org/wikipedia/commons/d/d9/Lower_Central_Park_Shot_5.JPG", Category: "cat", chatChannel: 3, images: ["https://upload.wikimedia.org/wikipedia/commons/d/d9/Lower_Central_Park_Shot_5.JPG","https://upload.wikimedia.org/wikipedia/commons/0/05/Southwest_corner_of_Central_Park,_looking_east,_NYC.jpg","http://cpc.convio.net/images/fall-2015/conservatory-water.jpg"], dateCreated: "2016-10-25")
        //
        //        
    }
    
    
    
    
    
    
    
    @IBAction func showDataTapped(_ sender: AnyObject) {
        
        let ref: FIRDatabaseReference = FIRDatabase.database().reference()
        
        
        /* 
            these can definitely be made into a function so we don't have to retype the same code
            for the purpose of just showing data from the db I typed them all out separately.
         
         */
        
        let eventRef = ref.child("Events")
        
        
        
//        eventRef.observeSingleEvent(of: .value, with: {snapshot in
//            guard let data = snapshot.value as? [String: AnyObject] else {
//                return
//            }
//            
//            let swiftArray = Array(data.values)
//            let imgURL = NSURL(string: swiftArray[0]["avatar"] as! String)
//            let imgData = NSData(contentsOf: imgURL as! URL)
//            let img = UIImage(data: imgData as! Data)
//            let imgView = UIImageView(image: img)
//            
//            // give the img a frame
//            imgView.frame = CGRect(x: 140, y: 420, width: 100, height: 100)
//            self.view.addSubview(imgView)
//            
//            var stupidfuckinginteger = swiftArray[0]["chatChannel"]!
//            var stupidfuckingstring = String(describing: stupidfuckinginteger!)
//            
//            
//            let titleRef = ref.child("Events").child("title")
//            titleRef.observe(FIRDataEventType.value, with: {(snapshot) in
//                self.titleData.text = swiftArray[0]["title"] as! String
//            })
//            
//            let catRef = ref.child("Events").child("category")
//            catRef.observe(FIRDataEventType.value, with: {(snapshot) in
//                self.category.text = swiftArray[0]["category"] as! String
//            })
//            
//            let descRef = ref.child("Events").child("description")
//            descRef.observe(FIRDataEventType.value, with: {(snapshot) in
//                self.descriptionData.text = swiftArray[0]["description"] as! String
//            })
//            
//            let chanRef = ref.child("Events").child("chatChannel")
//            chanRef.observe(FIRDataEventType.value, with: {(snapshot) in
//                self.chatChannel.text = stupidfuckingstring
//            })
//            
//            let dateCreateRef = ref.child("Events").child("dateCreated")
//            dateCreateRef.observe(FIRDataEventType.value, with: {(snapshot) in
//                self.dateCreated.text = swiftArray[0]["dateCreated"] as! String
//            })
//            
//            
//        })
//        
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
    
    
    
    // test code for generating id's
   
    

}
