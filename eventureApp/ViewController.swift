//
//  ViewController.swift
//  eventureApp
//
//  Created by Lucas Padden on 10/22/16.
//  Copyright © 2016 eventure-app. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {
    
    
    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var password: UITextField!
    
    
    
    
    @IBAction func login(_ sender: AnyObject) {
        
        // log in a already registered user
        FIRAuth.auth()?.signIn(withEmail: email.text!, password: password.text!) {
            (user, error) in
            if error != nil {
                print("Error logging user")
                print(error.debugDescription)
                return
            }
            print("Logged in \(user?.email)")
            self.email.text = ""
            self.password.text = ""
            
            
            // redirect to loggedInViewController
            
        }
        
            
        
        
    }
    
    // add to database
    var ref: FIRDatabaseReference = FIRDatabase.database().reference()
    
    
    @IBAction func register(_ sender: AnyObject) {
        
        // create a user with email and password fields
        FIRAuth.auth()?.createUser(withEmail: email.text!, password: password.text! ) {
            (user, error) in
            if error != nil {
                print("Error registering user")
                print(error.debugDescription)
                return
            }
            print("created a user with email: \(user?.email)")
            self.email.text = ""
            self.password.text = ""
            // get current user that just registered
            FIRAuth.auth()?.addStateDidChangeListener { auth, user in
                if let user = user {
                   
                    // add the user who just registered to the database.
                    let userID = user.uid
                    let userKey = self.ref.child("Users").child(userID)
                    userKey.child("email").setValue(user.email)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
      
    }
    



}

