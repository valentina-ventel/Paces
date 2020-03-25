//
//  SummaryMyRunViewController.swift
//  Paces
//
//  Created by Valentina Vențel on 25/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import MapKit

class SummaryViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var distanceValueLabel: UILabel!
    @IBOutlet weak var durationValueLabel: UILabel!
    var activity: Route!
    var formatter = FormatterModel()
    var locationsCoordinate2D = [CLLocationCoordinate2D]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        distanceValueLabel.text = formatter.distanceFormatter(distanceInMeters: activity.distance)
        durationValueLabel.text = formatter.durationFormatter(durationInSeconds: activity.duration)
        
        for location in activity.locations {
            let location2D = location.coordinate
            
            locationsCoordinate2D.append(location2D)
        }
        mapView.fitTo(locationsCoordinate2D, mapView)
    }
}
