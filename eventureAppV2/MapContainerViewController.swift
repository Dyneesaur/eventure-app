//
//  MapContainerViewController.swift
//  eventureAppV2
//
//  Created by Lucas Padden on 10/29/16.
//  Copyright © 2016 eventure-app. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces


class MapContainerViewController: UIViewController {

    
    override func viewDidAppear(_ animated: Bool) {
        
        let camera = GMSCameraPosition.camera(withLatitude: 40.7128, longitude: -74.0059, zoom: 12)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0059)
        marker.title = "New York"
        marker.snippet = "United States"
        marker.map = mapView
        
    }
    

}
