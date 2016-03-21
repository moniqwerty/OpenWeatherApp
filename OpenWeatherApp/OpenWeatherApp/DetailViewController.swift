//
//  DetailViewController.swift
//  OpenWeatherApp
//
//  Created by Monika Markovska on 3/18/16.
//  Copyright © 2016 Monika Markovska. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var weatherService: WeatherService?
        {
        //Get the weather service object from app delegate
        get {
            let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
            
            return delegate?.weatherService
        }
    }
    
    var detailItem: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Fetch current weather data from service
        self.weatherService?.weatherForCityName(self.detailItem!.cityName,completionClosure: {(city: City)  in
            dispatch_async(dispatch_get_main_queue()) {
                self.updateView(city)
            }
        })
        self.title = detailItem?.cityName
        self.updateView(self.detailItem!)
    }
    
    //Update the UI with the fetched data for City object
    func updateView(city: City)
    {
        detailItem=city
        self.detailDescriptionLabel.text = city.weatherDescription != nil ? city.weatherDescription : "N/A"
        self.humidityLabel.text = city.humidity != nil ? String(format:"Humidity:%.0f %%", (city.humidity)!) : "N/A"
        self.temperatureLabel.text = city.temperature != nil ? String(format:"Temperature: %.0f °C", (city.temperature)!): "N/A"
        self.title = detailItem?.cityName;
    }
}

