//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Saeid.mhd@gmail on 2/22/17.
//  Copyright © 2017 Saeid mohammadi. All rights reserved.
//

import Foundation


class CalculatorBrain
{
    
    private var accumulator = 0.0
    
    func setOperand(operrand: Double){
        
        accumulator = operrand
    }
    
//    var operation: Dictionary<String,Double> = [
//    "π": M_PI,
//    "e" : M_E
//    ]
    
    
    var operations: Dictionary<String,Operation> = [
    "π" : Operation.Constant(M_PI),
    "e" : Operation.Constant(M_E),
    "√" : Operation.UnaryOpoeration(sqrt),
    "cos": Operation.UnaryOpoeration(cos),
    // we use closour
    "×" : Operation.BinaryOperation({$0 * $1}),
    
    "∓" : Operation.UnaryOpoeration({-$0}),
    
    "+" : Operation.BinaryOperation({(op1:Double , op2:Double) -> Double in
        return op1+op2
        }
),
    "-" : Operation.BinaryOperation({(op1:Double , op2:Double) -> Double in
        return op1-op2
        }
),
    "÷" : Operation.BinaryOperation({(op1:Double , op2:Double) -> Double in
        return op1/op2
        }
),

    "=" : Operation.Equals
    
    
     ]
    
    enum Operation  {
        case Constant(Double)
        case UnaryOpoeration((Double)-> Double)
        case BinaryOperation ((Double,Double)->Double)
        case Equals 
    }
    
    
    func performOperation(symbol: String){
        
        if let operation = operations[symbol]{
            switch operation {
            
            case Operation.Constant(let Value):
                accumulator = Value
            
            case Operation.UnaryOpoeration(let function):
                accumulator = function(accumulator)
           
            case Operation.BinaryOperation(let function):
                executeBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function,firstOperand: accumulator)
                
            case Operation.Equals:
                 executeBinaryOperation()
               
             
            }
        }
    }
    
    private func executeBinaryOperation(){
    
        if pending != nil{
            accumulator = pending!.binaryFunction(pending!.firstOperand,accumulator)
            pending = nil
            
        }
    }
    private var pending:PendingBinaryOperationInfo?
    
    struct PendingBinaryOperationInfo {
        var binaryFunction: (Double,Double) ->Double
        var firstOperand: Double
    }
    
    var result: Double
        {
        
        get{
            
            return accumulator
        }
        
    }
    
        
        
//        if let constant  = operation[symbol]{
//            
//        accumulator = constant
//        
//        }
        
        
        
        
        
//        switch symbol {
//        case "π":
//            accumulator = M_PI
//        case "√":
//            accumulator = sqrt(accumulator )
//        default:
//            break
//        }
        
        
        
        
    
    
}
