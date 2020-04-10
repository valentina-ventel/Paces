//
//  DateOfTheLastActivity.swift
//  Paces
//
//  Created by Valentina Vențel on 06/04/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import Foundation
import RealmSwift

class RLMDateOfTheLastActivity: Object {
    @objc dynamic var date = Date()
    
    convenience required init(date: Date) {
        self.init()
        self.date = date
    }
}
