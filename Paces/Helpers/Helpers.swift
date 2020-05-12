//
//  HelpingFile.swift
//  Paces
//
//  Created by Valentina Vențel on 04/04/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

// MARK: - Country codes
func twoDigitCountryCode(for fullCountryName : String) -> String {
    let locales : String = ""
    for localeCode in NSLocale.isoCountryCodes {
        
        let identifier = NSLocale(localeIdentifier: "en_UK")
        let countryName = identifier.displayName(forKey: NSLocale.Key.countryCode,
                                                 value: localeCode)
        if fullCountryName.lowercased() == countryName?.lowercased() {
            return localeCode
        }
    }
    return locales
}

func flag(_ country: String) -> String {
    let base : UInt32 = 127397
    var s = ""
    for v in country.unicodeScalars {
        s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
    }
    
    return String(s)
}

func dateRoutesDictionary(from routes: [Route]) -> [Date:[Route]] {
    var dict = [Date:[Route]]()
    
    for activity in routes {
        //print("FROM \(activity.date)")
        let calendar = Calendar.current
        let year = calendar.component(.year, from: activity.date)
        let month = calendar.component(.month, from: activity.date)
        //print("Y \(year), M \(month)")
      
        let dateComponents = DateComponents(calendar: calendar,
                                            year: year,
                                            month: month,
                                            day: 1)
        
        let firstDay = calendar.date(from: dateComponents)!
        //print("  TO \(firstDay)")
        if dict[firstDay] == nil  {
            dict[firstDay] = [activity]
        } else {
            dict[firstDay]?.append(activity)
        }
    }
    return dict
}

func userData() -> Runner? {
    
    if let currentUser = Auth.auth().currentUser {
        let runner = Runner(username: currentUser.displayName!, email: currentUser.email!, uid: currentUser.uid)
        return runner
    }
    
    return nil
}
