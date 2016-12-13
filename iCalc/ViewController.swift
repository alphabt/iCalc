//
//  ViewController.swift
//  iCalc
//
//  Created by Brian Tai on 12/12/16.
//  Copyright © 2016 Brian Tai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var userIsInTheMiddleOfTyping = false
    
    @IBOutlet weak var display: UILabel!
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text! = textCurrentlyInDisplay + digit
        } else {
            display.text! = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        userIsInTheMiddleOfTyping = false
        
        if let mathmethicalSymbol = sender.currentTitle {
            if mathmethicalSymbol == "π" {
                display.text = String(M_PI)
            }
        }
    }
}
