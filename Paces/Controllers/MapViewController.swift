//
//  MapViewController.swift
//  Paces
//
//  Created by Valentina Vențel on 07/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var startButton: UIButton!
    
    var locationManager = CLLocationManager()
    let regionMeters = 1000
   
    override func viewDidLoad() {
        let location = LocationManager(mapView: mapView,
                                       locationManager: locationManager,
                                       regionMeters: regionMeters)
        super.viewDidLoad()
        location.checkLocationServices()
        startButton.applyRoundCorner()
    }
    
}



