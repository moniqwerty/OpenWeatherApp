//
//  WeatherService.swift
//  OpenWeatherApp
//
//  Created by Monika Markovska on 3/20/16.
//  Copyright © 2016 Monika Markovska. All rights reserved.
//

import Foundation

class WeatherService{
    
    //Fethes weather data for a given city name. Returns a City object to a given completion block
    func weatherForCityName(cityName :String, completionClosure:(City)->()){
        let city = City()
        city.cityName = cityName
        
        let url : NSString = URL_BASE+cityName+API_KEY
        let urlStr : NSString = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let searchURL : NSURL = NSURL(string: urlStr as String)!
        let task = NSURLSession.sharedSession().dataTaskWithURL(searchURL){ (data, response, error) in
            do {
                let JSON = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions(rawValue: 0))
                guard let JSONDictionary :NSDictionary = JSON as? NSDictionary else {
                    NSLog("Not a dictionary")
                    return
                }
                if let main = JSONDictionary["main"] as? NSDictionary
                {
                    if let temp = main["temp"] as? Double
                    {
                        city.temperature = temp
                    }
                    if let humidity = main["humidity"] as? Double
                    {
                        city.humidity = humidity
                    }
                }
                if let weather = JSONDictionary["weather"] as? NSArray
                {
                    if let description = weather[0]["description"] as? String
                    {
                        city.weatherDescription = description
                    }
                }
                if let name = JSONDictionary["name"] as? String
                {
                    city.cityName = name;
                }
                completionClosure(city)
            }
            catch let JSONError as NSError {
                NSLog("%@",JSONError)
                return
            }
        }
        task.resume()
    }
}