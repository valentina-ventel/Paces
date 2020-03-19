//
//  StopAction.swift
//  Paces
//
//  Created by Valentina Vențel on 18/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit

extension NewRunViewController {
    func stop() {
        stopButton.isHidden = true
        
        locationManager.stopUpdatingLocation()
    }
    
    func save() {
    
    }
}
