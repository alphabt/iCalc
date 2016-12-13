//
//  ViewController.swift
//  iCalc
//
//  Created by Brian Tai on 12/12/16.
//  Copyright © 2016 Brian Tai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var brain = ICalcBrain()
    private var userIsInTheMiddleOfTyping = false
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBOutlet private weak var display: UILabel!
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text! = textCurrentlyInDisplay + digit
        } else {
            display.text! = digit
        }
        
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathmematicalSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathmematicalSymbol)
            displayValue = brain.result
        }
    }
    
    var savedProgram: ICalcBrain.PropertyList?
    
    @IBAction func save() {
        savedProgram = brain.program
        userIsInTheMiddleOfTyping = false
    }
    
    @IBAction func restore() {
        if savedProgram != nil {
            brain.program = savedProgram!
            displayValue = brain.result
            userIsInTheMiddleOfTyping = false
        }
    }
}
