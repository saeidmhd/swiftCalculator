//
//  ViewController.swift
//  Calculator
//
//  Created by Saeid.mhd@gmail on 2/21/17.
//  Copyright © 2017 Saeid mohammadi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    private var userIsInTheMiddleOfTypping = false
    
    @IBAction private func touchDigit(_ sender: UIButton)  {
        
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTypping {
            
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
            
        }else{
            
            display!.text = digit
        }
        userIsInTheMiddleOfTypping = true
    }
    
    private var displyValue: Double {
        
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    
    private var Brain = CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTypping {
            Brain.setOperand(operrand: displyValue)
            userIsInTheMiddleOfTypping  = false
        }
        
       let mathematicalSymbol = sender.currentTitle!
            
       Brain.performOperation(symbol: mathematicalSymbol)
            
        
        
        displyValue = Brain.result
        
        
    }
    
    
}

