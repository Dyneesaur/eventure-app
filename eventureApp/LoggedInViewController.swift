//
//  LoggedInViewController.swift
//  eventureApp
//
//  Created by Lucas Padden on 10/22/16.
//  Copyright © 2016 eventure-app. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoggedInViewController: UIViewController {
    
    @IBOutlet weak var email: UILabel!
    
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
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                // user is logged in
                self.email.text = "Currently signed in as " + user.email!
                return
            }
            
            print("No one signed in")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
