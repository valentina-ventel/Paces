//
//  NewRunViewController.swift
//  Paces
//
//  Created by Valentina Vențel on 09/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import CoreData

class ActivityViewController: UIViewController {
    @IBOutlet weak var distanceValueLabel: UILabel!
    @IBOutlet weak var distanceUnitLabel: UILabel!
    @IBOutlet weak var timeValueLabel: UILabel!
    @IBOutlet weak var timeUnitLabel: UILabel!
    @IBOutlet weak var paceValueLabel: UILabel!
    @IBOutlet weak var paceUnitLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var timer: Timer!
    var durationInSeconds = Measurement(value: 0, unit:                                                    UnitDuration.seconds)
    var distanceInMeters = Measurement(value: 0,
                                       unit: UnitLength.meters)
    var seconds = 0
    var locationList = [CLLocation]()
    let regionMeters = 500
    var value = 1
    var date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let location = LocationManager(mapView: mapView,
                                       locationManager: locationManager,
                                       regionMeters: regionMeters)
    
        location.checkLocationServices()
        stopButton.applyRoundCorner()
        start()
    }
    
    @IBAction func stopTap(_ sender: Any) {
      // mapView.fitTo(locationList, mapView)
        let alertController = UIAlertController(title: "End run?",
                                                message: "Do you wish to end your run?",
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel))
        alertController.addAction(UIAlertAction(title: "Save",
                                                style: .default) { _ in
            self.stop()
            self.save()
            //self.performSegue(withIdentifier: "summarySegue",
             //                     sender: nil)
                                                    
        })
        alertController.addAction(UIAlertAction(title: "Discard",
                                                style: .destructive) { _ in
            self.stop()
            _ = self.navigationController?.popToRootViewController(animated: true)
        })
        present(alertController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SummaryViewController {
            let vc = segue.destination as? SummaryViewController
            let activity = Route(distance: distanceInMeters,
                                 duration: durationInSeconds,
                                 date: date,
                                 locations: locationList)
            vc?.activity = activity
        }
    }
    
}

extension UIViewController: MKMapViewDelegate {
    public func mapView(_ mapView: MKMapView,
               rendererFor overlay: MKOverlay) -> MKOverlayRenderer
  {
    guard let polyline = overlay as? MKPolyline else {
      return MKOverlayRenderer(overlay: overlay)
    }
    let renderer = MKPolylineRenderer(polyline: polyline)
    renderer.strokeColor = .red
    renderer.lineWidth = 3
    return renderer
  }
}
