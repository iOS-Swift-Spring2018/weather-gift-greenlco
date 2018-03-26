//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Connor Greenleaf on 3/25/18.
//  Copyright © 2018 Connor Greenleaf. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherLocation {
    var name = ""
    var coordinates = ""
    var currentTemp = "--"
    
    func getWeather(completed: @escaping () -> ()) {
        
        let weatherURL = urlBase + urlAPIKEY + coordinates
        
        Alamofire.request(weatherURL).reponseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let temperature = json["currently"]["temperature"].double {
                print("***** tempertature inside getWeather = \(temperature)")
                    let roundedTemp = String(format: "%3.f", temperature)
                    self.currentTemp = roundedTemp + "°"
            } else {
                print("Could not return a temperature")
            }
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }
}
