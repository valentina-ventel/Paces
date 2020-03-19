//
//  TestViewController.swift
//  Paces
//
//  Created by Valentina Vențel on 10/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class TestViewController: UIViewController {
    private var run: Run?
    var locationManager = CLLocationManager()
    var time: Timer!
    var seconds = 0
    var distance = Measurement(value: 0, unit: UnitLength.meters)
    var locationList: [CLLocation] = []
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func startTapp(_ sender: Any) {
        start()
    }
    
    func start() {
            startButton.isHidden = true
           // stopButtonOutlet.isHidden = false
    
            seconds = 0
    
            distance = Measurement(value: 0, unit: UnitLength.meters)
            locationList.removeAll()
            updateDisplay()
            time = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                self.eachSecond()
            }
            startLocationUpdates()
        }
    
        func updateDisplay() {
            distanceLabel.text = "\(distance)"
            timeLabel.text = "\(seconds)"
        }
    
        func eachSecond() {
            seconds += 1
            updateDisplay()
        }
    
        func startLocationUpdates() {
            locationManager.delegate = self
            locationManager.activityType = .fitness
            locationManager.distanceFilter = 10
            locationManager.startUpdatingLocation()
        }
}


extension TestViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for newLocation in locations {
            let howRecent = newLocation.timestamp.timeIntervalSinceNow
            guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10 else { continue }

            if let lastLocation = locationList.last {
                let delta = newLocation.distance(from: lastLocation)
                distance = distance + Measurement(value: delta, unit: UnitLength.meters)
                let coordinates = [lastLocation.coordinate, newLocation.coordinate]
                //mapView.add(MKPolyline(coordinates: coordinates, count: 2))
                let region = MKCoordinateRegion(center: newLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                //mapView.setregion(region, animated: true)
            }
            locationList.append(newLocation)
        }
    }
}
