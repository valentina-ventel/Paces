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

class NewRunViewController: UIViewController {
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var time: Timer!
    var seconds = 0
    var distance = Measurement(value: 0, unit: UnitLength.meters)
    var locationList: [CLLocation] = []
    let objectForm = ObjectForm()
    let regionMeters = 500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let location = LocationManager(mapView: mapView, locationManager: locationManager, regionMeters: regionMeters)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        location.checkLocationServices()
        
        objectForm.applyRoundCorner(stopButton)
        start()
    }
    
    @IBAction func stopTapp(_ sender: Any) {
        let alertController = UIAlertController(title: "End run?", message: "Do you wish to end your run?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Save", style: .default) { _ in
            self.stop()
            self.save()
            self.performSegue(withIdentifier: "stopRunSegue", sender: nil)
        })
        alertController.addAction(UIAlertAction(title: "Discard", style: .destructive) { _ in
            self.stop()
            _ = self.navigationController?.popToRootViewController(animated: true)
        })
        present(alertController, animated: true)
    }
}




