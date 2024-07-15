//
//  Country.swift
//  JPCountryPicker
//
//  Created by Jaykar Parmar on 11/07/24.
//

import Foundation
import SwiftUI

struct Country: Codable, Identifiable, Hashable {
    var id = UUID() // To uniquely identify each country
    var name: String?
    var dialCode: String?
    var code: String?
    var flag: String?
    var phoneFormat: String?
    var phoneNumberDigit: Int?

    init(id: UUID = UUID(), name: String? = nil, dialCode: String? = nil, code: String? = nil, flag: String? = nil, phoneFormat: String? = nil, phoneNumberDigit: Int? = nil) {
        self.id = id
        self.name = name
        self.dialCode = dialCode
        self.code = code
        self.flag = flag
        self.phoneFormat = phoneFormat
        self.phoneNumberDigit = phoneNumberDigit
    }
    
    private enum CodingKeys: String, CodingKey {
        case name, dialCode, code, flag, phoneFormat, phoneNumberDigit
    }
}

func loadJSON<T: Decodable>(filename: String) -> T {
    guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
        fatalError("Failed to locate \(filename) in bundle.")
    }
    
    guard let data = try? Data(contentsOf: url) else {
        fatalError("Failed to load \(filename) from bundle.")
    }
    
    let decoder = JSONDecoder()
    guard let loaded = try? decoder.decode(T.self, from: data) else {
        fatalError("Failed to decode \(filename) from bundle.")
    }
    
    return loaded
}

func currentCountry(countries: [Country]) -> Country? {
    let localIdentifier = Locale.current.identifier //returns identifier of your telephones country/region settings
    
    let locale = NSLocale(localeIdentifier: localIdentifier)
    if let countryCode = locale.object(forKey: .countryCode) as? String {
        return countryFromCountryCode(countryCode: countryCode.uppercased(), countries: countries)
    }
    return nil
}

func countryFromCountryCode(countryCode: String, countries: [Country]) -> Country? {
    for country in countries {
        if countryCode == country.code {
            return country
        }
    }
    return nil
}
