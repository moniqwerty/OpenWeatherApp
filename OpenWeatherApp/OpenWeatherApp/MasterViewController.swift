//
//  MasterViewController.swift
//  OpenWeatherApp
//
//  Created by Monika Markovska on 3/18/16.
//  Copyright © 2016 Monika Markovska. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var cities = [City]()
    var weatherService: WeatherService?
        {
        get {
            let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
            
            return delegate?.weatherService
        }
    }
    var cityRepository: CityRepository?
        {
        get {
            let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
            return delegate?.cityRepository
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        self.cities = (self.cityRepository?.fetchCities())!

        for cityIteration in self.cities
        {
            self.weatherService?.weatherForCityName(cityIteration.cityName, completionClosure: {(city: City)  in
                cityIteration.cityName = city.cityName
                cityIteration.temperature = city.temperature
                cityIteration.weatherDescription = city.weatherDescription
                cityIteration.humidity = city.humidity
            })
        }
        self.refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)

    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        
        for cityIteration in self.cities
        {
            self.weatherService?.weatherForCityName(cityIteration.cityName, completionClosure: {(city: City)  in
                cityIteration.cityName = city.cityName
                cityIteration.temperature = city.temperature
                cityIteration.weatherDescription = city.weatherDescription
                cityIteration.humidity = city.humidity
            })
        }
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.cityRepository?.persistCities(cities)
        super.viewWillDisappear(animated)
    }

    func insertNewObject(sender: AnyObject) {
        performSegueWithIdentifier("addNewCity", sender: self)
    }

    func addNewCity(cityName: String){
        let city = City()
        city.cityName = cityName
        city.temperature = 0
        self.weatherService?.weatherForCityName(city.cityName, completionClosure: {(updatedCity: City)  in
            city.cityName = updatedCity.cityName
            city.temperature = updatedCity.temperature
            city.weatherDescription = updatedCity.weatherDescription
            city.humidity = updatedCity.humidity
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        })
        self.cities.append(city)
        self.cityRepository!.cities = self.cities
        self.tableView.reloadData()
    }
    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = cities[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        if segue.identifier == "addNewCity" {
            
            let controller = (segue.destinationViewController) as! AddNewCityViewController
            controller.parent = self
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = cities[indexPath.row]
        cell.textLabel!.text = String(format: "%@ %.0f°C",object.cityName, object.temperature!)
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            cities.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

