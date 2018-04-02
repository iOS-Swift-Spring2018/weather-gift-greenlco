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
    
    // used ":" here instead of = because of difference between struct and var
    
    struct DailyForecast {
        var dailyMaxTemp: Double
        var dailyMinTemp: Double
        var dailyDate: Double
        var dailyIcon: String
        var dailySummary: String
      
        
    }
    
    var name = ""
    var coordinates = ""
    var currentTemp = "--"
    var dailySummary = ""
    var currentIcon = ""
    var currentTime = 0.0
    var timeZone = ""
    var dailyForecastArray = [DailyForecast]()
    
    func getWeather(completed: @escaping () -> ()) {
        
        let weatherURL = urlBase + urlApiKey + coordinates
        Alamofire.request(weatherURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let temperature = json["currently"]["temperature"].double {
                    let roundedTemp = String(format: "%3.f", temperature)
                    self.currentTemp = roundedTemp + "°"
            } else {
                print("Could not return a temperature")
            }
                if let summary = json["daily"]["summary"].string {
                    self.dailySummary = summary
                } else {
                    print("Could not return a temperature")
                }
                if let icon = json["currently"]["icon"].string {
                    self.currentIcon = icon
                } else {
                    print("Could not return an icon")
                }
                if let timeZone = json["timezone"].string {
                    self.timeZone = timeZone
                } else {
                    print("Could not return an timeZone")
                }
                if let time = json["currently"]["time"].double {
                    self.currentTime = time
                } else {
                    print("Could not return an time")
                }
                let dailyDataArray = json["daily"]["data"]
                self.dailyForecastArray = []
                for day in 1...dailyDataArray.count-1 {
                    let maxTemp = json["daily"]["data"][day]["temperatureHigh"].doubleValue
                    let minTemp = json["daily"]["data"][day]["temperatureLow"].doubleValue
                    let dateValue = json["daily"]["data"][day]["time"].doubleValue
                    let icon = json["daily"]["data"][day]["icon"].stringValue
                    let dailySummary = json["daily"]["data"][day]["summary"].stringValue
                    let newDailyForecast = DailyForecast(dailyMaxTemp: maxTemp, dailyMinTemp: minTemp, dailyDate: dateValue, dailyIcon: icon, dailySummary: dailySummary)
                    self.dailyForecastArray.append(newDailyForecast)


                }
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }
}

