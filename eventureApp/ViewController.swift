//
//  ViewController.swift
//  eventureApp
//
//  Created by Lucas Padden on 10/22/16.
//  Copyright © 2016 eventure-app. All rights reserved.
//

import UIKit
import FirebaseAuth

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
            
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

