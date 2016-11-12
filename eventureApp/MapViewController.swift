//
//  MapViewController.swift
//  eventureApp
//
//  Created by Lucas Padden on 10/25/16.
//  Copyright © 2016 eventure-app. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase
import FirebaseAuth
import FirebaseDatabase

class MapViewController: UIViewController {

    @IBOutlet weak var AddEventView: UIView!

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var myMapView: GMSMapView!
    
    @IBAction func addEvent(_ sender: AnyObject) {
        
        UIView.animate(withDuration: 1) {
            self.AddEventView.center = CGPoint(x: self.AddEventView.center.x + 500,y: self.AddEventView.center.y)
            
        }
        
    }
    
    override func viewDidLoad() {
        
        AddEventView.center = CGPoint(x: AddEventView.center.x - 500, y: AddEventView.center.y)
        
    }
    
    @IBAction func back(_ sender: AnyObject) {
        
        
        UIView.animate(withDuration: 1) {
            self.AddEventView.center = CGPoint(x: self.AddEventView.center.x - 500,y: self.AddEventView.center.y)
        }
        
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

