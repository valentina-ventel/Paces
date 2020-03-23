//
//  User.swift
//  Paces
//
//  Created by Valentina Vențel on 21/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit

class User {
    var firstName: String
    var lastName: String
    var height: Int
    var routes: [Route]
    
    init(firstName: String, lastName: String, height: Int, routes: [Route]) {
        self.firstName = firstName
        self.lastName = lastName
        self.height = height
        self.routes = routes
    }
}
