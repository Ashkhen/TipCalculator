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
    
    let preferences = NSUserDefaults.standardUserDefaults()
    var karmaPoints = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "0.00"
        totalLabel.text = "0.00"
        karmaPoints = preferences.integerForKey("Karma")
        karmaPointsLabel.text = String(karmaPoints)
        billField.becomeFirstResponder()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmButtonClick(sender: AnyObject) {
        if billField != "" {
            preferences.setInteger(karmaPoints, forKey: "Karma")
            karmaPointsLabel.text = String(karmaPoints)
            karmaPointsLabel.frame = CGRectMake(300, 300, 0, 300)
            UIView.animateWithDuration(0.8, animations: { () -> Void in
                self.karmaPointsLabel.frame = CGRectMake(200, 10, 50, 100)
            })
            preferences.synchronize()
            view.endEditing(true)
        }
        
    }
    
    @IBAction func billFieldEditingChanged(sender: AnyObject) {
        if billField.text != "" {
            confirmButton.enabled = true
            calcTip()
        } else {
            confirmButton.enabled = false
        }
    }
    
    @IBAction func tipControlChanged(sender: AnyObject) {
        calcTip()
    }
    
    func calcTip() {
        let tipPercentages = [0.18, 0.2, 0.25]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        if tipPercentage == 0.18 {
            karmaPoints += 1
        } else if tipPercentage == 0.2 {
            karmaPoints += 5
        } else {
            karmaPoints += 10
        }
        
        if let billFieldString = billField.text, billAmount = Double(billFieldString) {
            let tip = billAmount * tipPercentage
            let total = billAmount + tip
            
            tipLabel.text = String(format: "$%.2f",tip)
            totalLabel.text = String(format: "$%.2f", total)
        }
    }
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

