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
        get {
            let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
            
            return delegate?.weatherService
        }
    }
    
    var detailItem: City?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weatherService?.weatherForCityName(self.detailItem!.cityName,completionClosure: {(city: City)  in
            dispatch_async(dispatch_get_main_queue()) {
                self.updateView(city)
            }
        })
        self.title = detailItem?.cityName
        // Do any additional setup after loading the view, typically from a nib.
        self.updateView(self.detailItem!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateView(city: City)
    {
        detailItem=city
        self.detailDescriptionLabel.text = city.description != nil ? city.description : "N/A"
        self.humidityLabel.text = city.humidity != nil ? String(format:"Humidity:%.0f %%", (city.humidity)!) : "N/A"
        self.temperatureLabel.text = city.temperature != nil ? String(format:"Temperature: %.0f °C", (city.temperature)!): "N/A"
        self.title = detailItem?.cityName;
    }
}

