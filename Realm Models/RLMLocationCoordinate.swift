//
//  LocationCoordinates.swift
//  Paces
//
//  Created by Valentina Vențel on 20/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import RealmSwift
import MapKit

class RLMLocationCoordinate: Object {
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0
    //@objc dynamic var date = Calendar.current
    //@objc dynamic var route: Run?
    
    var clLocationCoordinate2D: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude,
                                      longitude: longitude)
    }
    
    convenience required init(clLocationCoordinate2D: CLLocationCoordinate2D) {
        self.init()
        self.latitude = clLocationCoordinate2D.latitude
        self.longitude = clLocationCoordinate2D.longitude
    }
}
