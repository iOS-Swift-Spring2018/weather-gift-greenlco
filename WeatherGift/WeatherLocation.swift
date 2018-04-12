//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Connor Greenleaf on 4/11/18.
//  Copyright © 2018 Connor Greenleaf. All rights reserved.
//

import Foundation

class WeatherLocation: Codable {
    
    var name = ""
    var coordinates = ""
    init(name: String, coordinates: String) {
        self.name = name
        self.coordinates = coordinates
    }
}
