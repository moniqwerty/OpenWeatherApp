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
    
    func fetchCities() -> [City]{
        var citiesArray = [City]()
        if let array: [City] = NSKeyedUnarchiver.unarchiveObjectWithFile(getPath()) as? [City] {
            citiesArray = array
        }
        return citiesArray
    }
    
    func saveAll()
    {
        self.persistCities(self.cities)
    }
    
    func persistCities(citiesArray: [City]){
        
        NSKeyedArchiver.archiveRootObject(citiesArray, toFile: self.getPath())
    }
    
    private func getPath() -> String
    {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.AllDomainsMask, true)
        let path: AnyObject = paths[0]
        let arrPath = path.stringByAppendingString("/array.plist")
        return arrPath
    }
}