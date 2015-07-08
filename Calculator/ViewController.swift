//
//  ViewController.swift
//  Calculator
//
//  Created by Brad Gray on 7/6/15.
//  Copyright (c) 2015 Brad Gray. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var showNumber: UILabel!
    
    
    var userIsInTheMiddleOfTypingNumber = false
     var operandStack = Array<Double>()
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(showNumber.text!)!.doubleValue
            
        }
        set {
            showNumber.text = "\(newValue)"
            userIsInTheMiddleOfTypingNumber = false
            
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingNumber {
            enter()
        }
        switch operation {
        
            case "×":
                performOperation { $0 * $1 }

            
            case "÷":
                performOperation { $1 / $0}
        

            case "+":
            performOperation { $0 + $1 }

            case "−":
            performOperation { $1 - $0 }
            
        case "√": squareroot { sqrt($0) }
            

        default: break
        }
        
       
    }
    
    

@IBAction func touchButton(sender: UIButton) {
   let digit = sender.currentTitle!
  showNumber.text = showNumber.text! + digit
    
    if userIsInTheMiddleOfTypingNumber {
        showNumber.text = showNumber.text! + digit
        
    }else {
        showNumber.text = digit
        userIsInTheMiddleOfTypingNumber = true
    }
    
    }
    
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingNumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }

    func performOperation (operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    func squareroot (operation: (Double) ->Double) {
         if operandStack.count >= 2 {
       displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
}


