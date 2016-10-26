//
//  MapViewController.swift
//  eventureApp
//
//  Created by Lucas Padden on 10/25/16.
//  Copyright © 2016 eventure-app. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {


    
    @IBOutlet weak var myMapView: GMSMapView!
    
    
    override func viewDidLoad() {
        
        let camera = GMSCameraPosition.camera(withLatitude: 40.7128, longitude: -74.0059, zoom: 13)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        myMapView = mapView
        
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0059)
        marker.title = "New York"
        marker.snippet = "United States"
        marker.map = myMapView
        
    }
}

