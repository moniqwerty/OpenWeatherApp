//
//  City.swift
//  OpenWeatherApp
//
//  Created by Monika Markovska on 3/19/16.
//  Copyright © 2016 Monika Markovska. All rights reserved.
//

import Foundation

class City: NSObject, NSCoding{
    
    var cityName: String!
    var temperature: Double?
    var humidity: Double?
    var weatherDescription: String?
    
    func encodeWithCoder(aCoder: NSCoder) {
         aCoder.encodeObject(cityName, forKey:"cityName")
         aCoder.encodeObject(temperature, forKey:"temperature")
         aCoder.encodeObject(humidity, forKey:"humidity")
         aCoder.encodeObject(weatherDescription, forKey:"weatherDescription")
    }
    
    required init (coder aDecoder: NSCoder) {
        if let name = aDecoder.decodeObjectForKey("cityName") as? String{
            self.cityName = name
        } else {
            self.cityName = ""
        }
        if let temp = aDecoder.decodeObjectForKey("temperature") as? Double{
            self.temperature = temp
        } else {
            self.temperature = 0.0
        }
        if let hum = aDecoder.decodeObjectForKey("humidity") as? Double{
            self.humidity = hum
        } else {
            self.humidity = 0.0
        }
        if let desc = aDecoder.decodeObjectForKey("weatherDescription") as? String{
            self.weatherDescription = desc
        } else {
            self.weatherDescription = ""
        }
    }
    
    override init (){}
    
}