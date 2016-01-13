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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "0.00"
        totalLabel.text = "0.00"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        
        let tipPercentages = [0.18, 0.2, 0.25]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        if let billFieldString = billField.text, billAmount = Double(billFieldString) {
            let tip = billAmount * tipPercentage
            let total = billAmount + tip
            
            tipLabel.text = String(format: "$%f",tip)
            totalLabel.text = String(format: "$%.2f", total)
        }
    }
    
    @IBAction func OnTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

