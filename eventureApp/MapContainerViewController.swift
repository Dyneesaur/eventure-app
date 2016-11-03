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
    
    
    

  
    override func viewDidAppear(_ animated: Bool) {
        
        let camera = GMSCameraPosition.camera(withLatitude: 40.7128, longitude: -74.0059, zoom: 13)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView
        
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0059)
        marker.title = "New York"
        marker.snippet = "United States"
        marker.map = mapView
        
        
        // pull event data from the database and place a marker on the map.
        var ref: FIRDatabaseReference!
        
        ref = FIRDatabase.database().reference()
        
        let eventHandler = ref.child("Events")
        
        var event_IDs: NSMutableArray = []
        var longArr: NSMutableArray = []
        var latArr: NSMutableArray = []
        
        let eventHandle = eventHandler.observe(FIRDataEventType.value, with: { (snapshot) in
            for event in snapshot.children {
                let _events = event as! FIRDataSnapshot
                let id = _events.key
                event_IDs.add(id)
            }
            
            for id in event_IDs {
                let locationHandler = eventHandler.child(id as! String)
                let locationHandle = locationHandler.observe(FIRDataEventType.value, with: { (snapshot) in
                    
                    let value = snapshot.value as? NSDictionary
                    
                    let longitude = value?["longitude"]
                    let latitude = value?["latitude"]
                    
                    longArr.add(longitude)
                    latArr.add(latitude)
                    
                    
                    for longitude in longArr {
                        for latitude in latArr {
                            
                            
                            var long = longitude as! Double
                            var lat = latitude as! Double
                            
                            
                            let newMarker = GMSMarker()
                            newMarker.position = CLLocationCoordinate2D(latitude: long, longitude: lat)
                            newMarker.title = "New York"
                            newMarker.snippet = "United States"
                            newMarker.map = mapView
                            
                            
                            
                        }
                    }
                    
                    
                    longArr = []
                    latArr = []
                    
                    
                    
                })
            }
            
        })
        
        
        
    }

}
