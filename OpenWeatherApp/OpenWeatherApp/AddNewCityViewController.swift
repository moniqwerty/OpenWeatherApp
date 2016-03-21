//
//  AddNewCityViewController.swift
//  OpenWeatherApp
//
//  Created by Monika Markovska on 3/18/16.
//  Copyright © 2016 Monika Markovska. All rights reserved.
//

import UIKit

class AddNewCityViewController: UIViewController {
    
    var parent: MasterViewController!
    
    @IBOutlet weak var cityNameTextField: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let backButton: UIBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    //Go back to previous screen and add a new city to the list
    @IBAction func finishButtonTapped(sender: AnyObject) {
        let text  = cityNameTextField.text!.stringByTrimmingCharactersInSet(
            NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if (self.isCityValid(text))
        {
            navigationController?.popViewControllerAnimated(true)
            parent.addNewCity(text)
        }
    }
    
    //Check if city name is valid
    func isCityValid (text: String) -> Bool
    {
        if text.characters.count == 0
        {
            let alert = UIAlertController(title: "Error", message: "City name cannot be empty", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            presentViewController(alert, animated: true, completion: nil)
            return false
        }
        
        return validateSet(NSCharacterSet.decimalDigitCharacterSet(), text: text, errorMessage: "City name cannot contain numbers") &&
            validateSet(NSCharacterSet.punctuationCharacterSet(), text: text, errorMessage:  "City name cannot contain symbols") &&
            validateSet(NSCharacterSet.alphanumericCharacterSet().invertedSet, text: text, errorMessage:  "City name cannot contain ilegal characters")
    }
    
    func validateSet (set: NSCharacterSet, text: String, errorMessage: String) -> Bool
    {
        let range = text.rangeOfCharacterFromSet(set, options: NSStringCompareOptions(), range: nil)
        if range != nil {
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            presentViewController(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    //Go back to previous screen
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
}
