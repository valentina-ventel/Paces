//
//  FormatterModel.swift
//  Paces
//
//  Created by Valentina Vențel on 24/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit

class FormatterModel: NSObject {
    func distanceFormatter(distanceInMeters: Measurement<UnitLength>) -> String {
        let distanceFormatter = MeasurementFormatter()
        distanceFormatter.unitOptions = .naturalScale
        
        return distanceFormatter.string(from: distanceInMeters)
    }
    
    func durationFormatter(durationInSeconds: Measurement<UnitDuration>) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [ .hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        return formatter.string(from: durationInSeconds.value)!
    }
    
    func dateFormatter(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        
        return formatter.string(from: date)
    }
}
