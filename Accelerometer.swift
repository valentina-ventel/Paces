//
//  Accelerometer.swift
//  Paces
//
//  Created by Valentina Vențel on 03/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit

class Accelerometer: NSObject {
    var x: Double
    var y: Double
    var z: Double
    
    init(x: Double, y: Double, z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }
}
