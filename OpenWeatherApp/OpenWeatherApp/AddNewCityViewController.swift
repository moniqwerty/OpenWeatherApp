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
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var finishButton: UIButton!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let backButton: UIBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func finishButtonTapped(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
        parent.addNewCity(cityNameTextField.text!.stringByTrimmingCharactersInSet(
            NSCharacterSet.whitespaceAndNewlineCharacterSet()))
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
