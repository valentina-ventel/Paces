//
//  StopAction.swift
//  Paces
//
//  Created by Valentina Vențel on 18/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import MapKit

extension ActivityViewController {
    func stop() {
        stopButton.isHidden = true
        locationManager.stopUpdatingLocation()
    }
    
    func save() {
        let route = Route(distance: distance, time: seconds, date: date, locations: locationList)
        
        DBManager.saveRun(rute: route)
    }
}
