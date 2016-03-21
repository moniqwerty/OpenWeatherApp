//
//  CityRepository.swift
//  OpenWeatherApp
//
//  Created by Monika Markovska on 3/20/16.
//  Copyright © 2016 Monika Markovska. All rights reserved.
//

import Foundation

class CityRepository  {
    
    var cities = [City]()
    
    //Reads from data.plist for persisted cities. Returns an empty list if none are found
    func fetchCities() -> [City]{
        var citiesArray = [City]()
        if let array: [City] = NSKeyedUnarchiver.unarchiveObjectWithFile(getPath()) as? [City] {
            citiesArray = array
        }
        return citiesArray
    }
    
    //Persists all cities to data.plist
    func saveAll()
    {
        self.persistCities(self.cities)
    }
    
    //Persists an array of cities to data.plist
    func persistCities(citiesArray: [City]){
        
        NSKeyedArchiver.archiveRootObject(citiesArray, toFile: self.getPath())
    }
    
    //Returns path to data.plist
    private func getPath() -> String
    {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.AllDomainsMask, true)
        let path: AnyObject = paths[0]
        let arrPath = path.stringByAppendingString("/data.plist")
        return arrPath
    }
}