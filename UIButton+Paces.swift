//
//  ObjectForm.swift
//  Paces
//
//  Created by Valentina Vențel on 19/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit

extension UIButton {
    func applyRoundCorner() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.masksToBounds = true
    }
}
