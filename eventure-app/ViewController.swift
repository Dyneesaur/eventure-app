//
//  ViewController.swift
//  eventure-app
//
//  Created by Lucas Padden on 10/19/16.
//  Copyright © 2016 eventure-app. All rights reserved.
//

import UIKit
import FirebaseAuth



class ViewController: UIViewController {
    
    
    // username and password text fields
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    // login button
    
    @IBAction func login(_ sender: AnyObject) {
        
        // log in as an existing user
        FIRAuth.auth()?.signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            print("You logged in!")
            self.email.text = ""
            self.password.text = ""
        }
        
        
    }
    
    
    @IBAction func register(_ sender: AnyObject) {
        
        // create a new user with username and password
        FIRAuth.auth()?.createUser(withEmail: email.text!, password: password.text!) { (user, error) in
            
            // print user display name
            self.email.text = ""
            self.password.text = ""
        }
        
        
        
    }
    
    
    
    override func viewDidLoad() {
       
        
        
    }
    
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

