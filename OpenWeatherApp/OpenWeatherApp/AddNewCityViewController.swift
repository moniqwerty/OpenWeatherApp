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
        var isValid = true
        if text.characters.count == 0
        {
            isValid = false
            let alert = UIAlertController(title: "Error", message: "City name cannot be empty", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            presentViewController(alert, animated: true, completion: nil)
            return isValid
        }
        
        let decimalCharacters = NSCharacterSet.decimalDigitCharacterSet()
        let decimalRange = cityNameTextField.text!.rangeOfCharacterFromSet(decimalCharacters, options: NSStringCompareOptions(), range: nil)
        if decimalRange != nil {
            isValid = false
            let alert = UIAlertController(title: "Error", message: "City name cannot contain numbers", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            presentViewController(alert, animated: true, completion: nil)
            return isValid
        }
        let symbols = NSCharacterSet.punctuationCharacterSet()
        let symbolsRange = cityNameTextField.text!.rangeOfCharacterFromSet(symbols, options: NSStringCompareOptions(), range: nil)
        if symbolsRange != nil {
            isValid = false
            let alert = UIAlertController(title: "Error", message: "City name cannot contain symbols", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            presentViewController(alert, animated: true, completion: nil)
            return isValid
        }
        let invalidCharacters = NSCharacterSet.alphanumericCharacterSet().invertedSet
        let invalidRange = cityNameTextField.text!.rangeOfCharacterFromSet(invalidCharacters, options: NSStringCompareOptions(), range: nil)
        if invalidRange != nil {
            isValid = false
            let alert = UIAlertController(title: "Error", message: "City name cannot contain ilegal characters", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            presentViewController(alert, animated: true, completion: nil)
            return isValid
        }
        return isValid
    }
    
    //Go back to previous screen
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
}
