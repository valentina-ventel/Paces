//
//  RLMRunner.swift
//  Paces
//
//  Created by Valentina Vențel on 28/04/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class RLMRunner: Object {
    @objc dynamic var userName = ""
    @objc dynamic var dateOfBirthday = Date()
    @objc dynamic var height = Float()
    @objc dynamic var weight = Float()
    var routes = List<RLMRoute>()
    
    convenience required init(username: String, dateOfBirdthday: Date, height: Float, weight: Float, routes: [Route]) {
        self.init()
        self.userName = username
        self.dateOfBirthday = dateOfBirdthday
        self.height = height
        self.weight = weight
        
        let rlmRoutes = List<RLMRoute>()
        
        for route in routes {
            let rlmRoute = RLMRoute(route: route)
            rlmRoutes.append(rlmRoute)
        }
        self.routes = rlmRoutes
    }
}
