//
//  ObjectForm.swift
//  Paces
//
//  Created by Valentina Vențel on 19/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit

class ObjectForm: NSObject {
    func applyRoundCorner(_ object: AnyObject) {
        object.layer.cornerRadius = object.frame.size.width / 2
        object.layer.masksToBounds = true
    }
}
