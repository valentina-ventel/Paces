//
//  Location+CoreDataProperties.swift
//  Paces
//
//  Created by Valentina Vențel on 12/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var timeStemp: Date?
    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double
    @NSManaged public var run: Run?

}
