//
//  TimeInterval+format.swift
//  WeatherGift
//
//  Created by Connor Greenleaf on 4/2/18.
//  Copyright © 2018 Connor Greenleaf. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    
    func format(timeZone: String, dateFormatter: DateFormatter) -> String {
        let usuableDate = Date(timeIntervalSince1970: self)
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        let dateString = dateFormatter.string(from: usuableDate)
        return dateString
    }
    
}
