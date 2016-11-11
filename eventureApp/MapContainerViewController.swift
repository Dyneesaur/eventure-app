//
//  MapContainerViewController.swift
//  eventureApp
//
//  Created by Lucas Padden on 11/2/16.
//  Copyright © 2016 eventure-app. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import FirebaseDatabase
import Firebase


class MapContainerViewController: UIViewController {
    
    
    override func viewDidLoad() {

            // set the orientation and view of the map.
            let camera = GMSCameraPosition.camera(withLatitude: 40.7128, longitude: -74.0059, zoom: 13)
            let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            mapView.isMyLocationEnabled = true
            self.view = mapView
            
            // reference to firebase database.
            var ref: FIRDatabaseReference!
            ref = FIRDatabase.database().reference()
            
            let eventHandler = ref.child("Events")
        
            
            // run this code on the main thread.
            DispatchQueue.main.async {
                
                // listen for changes in each event in the database.
                let eventHandle = eventHandler.observe(FIRDataEventType.value, with: { (snapshot) in
                    
                    // for each event in the database.
                    for event in snapshot.children {
                        
                        let _events = event as! FIRDataSnapshot
                        
                        // grab the id of the event.
                        let idhandle = eventHandler.child(_events.key)
                        
                        // listen on each one of those id's.
                        let idhandler = idhandle.observe(FIRDataEventType.value, with: { (snapshot) in
                            
                            
                            // store the values of marker info (title, desc, longitude, latitude)
                            let value = snapshot.value as? NSDictionary
                            let longitude = value?["longitude"] as! Double
                            let latitude = value?["latitude"] as! Double
                            let eventTitle = value?["title"] as! String
                            let eventDesc = value?["description"] as! String
                            
                            // create a new marker on map
                            let newMarker = GMSMarker()
                            newMarker.position = CLLocationCoordinate2D(latitude: longitude, longitude: latitude)
                            
                            // set the title and description of the event.
                            newMarker.title = eventTitle
                            newMarker.snippet = eventDesc
                            newMarker.map = mapView
                            
                        
                        }) // end id listener
                        
                    }
                
                    
                }) // end events listener
            
        } // end of DispatchQueue.main.async
        
    } // end of function
        
        
} // end of class.



