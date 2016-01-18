//
//  ViewController.swift
//  tips
//
//  Created by Ashkhen Sargsyan on 1/11/16.
//  Copyright © 2016 Ashkhen Sargsyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var karmaPointsLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    
    // Store and retrieve karma points from device
    let preferences = NSUserDefaults.standardUserDefaults()
    var karmaPoints = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipLabel.text = "0.00"
        totalLabel.text = "0.00"
        
        // Read initial value of karma points from disk and show it
        karmaPoints = preferences.integerForKey("Karma")
        karmaPointsLabel.text = String(karmaPoints)
        
        // Set focus on text field so keyboard comes up automatically on app launch
        billField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Runs when user clicks button
    @IBAction func confirmButtonClick(sender: AnyObject) {
        if billField.text != "" {
            // Saves class variable karma points into key named Karma
            preferences.setInteger(karmaPoints, forKey: "Karma")
            
            karmaPointsLabel.text = String(karmaPoints)
            karmaPointsLabel.frame = CGRectMake(300, 300, 0, 300)
            
            UIView.animateWithDuration(0.8, animations: { () -> Void in
                self.karmaPointsLabel.frame = CGRectMake(49, 50, 222, 58)
            })
            
            // Saves changes to disk
            preferences.synchronize()
           
            // Dismiss keyboard
            view.endEditing(true)
            
            // Disable button so can't be clicked again until 
            // edit textfield enables it again
            confirmButton.enabled = false
        }
        
    }
    
    // Runs when user edits billField
    @IBAction func billFieldEditingChanged(sender: AnyObject) {
        // If billField is not emply, enable the button and calculate tip
        if billField.text != "" {
            confirmButton.enabled = true
            calcTip()
        } else {
            // otherwise disable button if billField is blank
            confirmButton.enabled = false
        }
    }
    
    // Runs when user selects tip percentage and calculates tip
    @IBAction func tipControlChanged(sender: AnyObject) {
        calcTip()
    }
    
    // Calculate tip and display results
    func calcTip() {
        let tipPercentages = [0.18, 0.2, 0.25]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        // Read karma points from disk and set the label value
        karmaPoints = preferences.integerForKey("Karma")
        karmaPointsLabel.text = String(karmaPoints)
       
        // Increment karma points
        if tipPercentage == 0.18 {
            karmaPoints += 1
        } else if tipPercentage == 0.2 {
            karmaPoints += 5
        } else {
            karmaPoints += 10
        }
        
        // Unwrap billField.text (which is an optional), 
        // if successful, convert and unwrap results
        if let billFieldString = billField.text, billAmount = Double(billFieldString) {
            let tip = billAmount * tipPercentage
            let total = billAmount + tip
            
            // Format text to show only 2 decimal points
            tipLabel.text = String(format: "$%.2f",tip)
            totalLabel.text = String(format: "$%.2f", total)
        }
    }
    
    // Dismiss keybaord on tap anywhere inside view controller
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

