//
//  File.swift
//  Paces
//
//  Created by Valentina Vențel on 23/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//
import UIKit
import Foundation
import MapKit
import CoreLocation

class LocationOfTheRunning: NSObject, MKMapViewDelegate {
    var mapView: MKMapView
    var locations: [CLLocationCoordinate2D]
    
    init(mapView: MKMapView, locations: [CLLocationCoordinate2D]) {
        self.mapView = mapView
        self.locations = locations
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            centerViewRunLocation()
        } else {
            print("Location services is not embeded!")
        }
    }
    
    func centerViewRunLocation() {
        let latitudes = locations.map { location -> Double in
            let location = location
            return location.latitude
        }
        
        let longitudes = locations.map { location -> Double in
            let location = location
            return location.longitude
        }
        
        let maxLat = latitudes.max()!
        let minLat = latitudes.min()!
        let maxLong = longitudes.max()!
        let minLong = longitudes.min()!
        
        let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) /                                  2, longitude: (minLong +                                       maxLong) / 2)
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    
}
