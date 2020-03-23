//
//  RLMUser.swift
//  Paces
//
//  Created by Valentina Vențel on 21/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import Foundation
import RealmSwift

class RLMUser: Object {
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var height = 0
    var routes = List<RLMRoute>()
}
