//
//  HelpingFile.swift
//  Paces
//
//  Created by Valentina Vențel on 04/04/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import Foundation

// MARK: - Country codes
func twoDigitCountryCode(for fullCountryName : String) -> String {
    let locales : String = ""
    for localeCode in NSLocale.isoCountryCodes {
        let identifier = NSLocale(localeIdentifier: localeCode)
        let countryName = identifier.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)
        if fullCountryName.lowercased() == countryName?.lowercased() {
            return localeCode
        }
    }
    return locales
}

func flag(_ country:String) -> String {
    let base : UInt32 = 127397
    var s = ""
    for v in country.unicodeScalars {
        s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
    }
    return String(s)
}
