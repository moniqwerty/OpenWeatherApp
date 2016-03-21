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
        navigationController?.popViewControllerAnimated(true)
        
        let text  = cityNameTextField.text!.stringByTrimmingCharactersInSet(
            NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if text.characters.count == 0
        {
            
        }
        else
        {
//            let try regex = NSRegularExpression(pattern: ".*[^A-Z].*", options: NSRegularExpressionOptions.CaseInsensitive)
//
//            if regex.firstMatchInString(text!, options: nil, range: NSMakeRange(0, text!.length)) != nil {
//                
            
//            }
        }
        let decimalCharacters = NSCharacterSet.decimalDigitCharacterSet()
        
        let decimalRange = cityNameTextField.text!.rangeOfCharacterFromSet(decimalCharacters, options: NSStringCompareOptions(), range: nil)
        
        if decimalRange != nil {
            
        }
        parent.addNewCity(text)
    }
    
    //Go back to previous screen
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
}
