//
//  iCalcBrain.swift
//  iCalc
//
//  Created by Brian Tai on 12/13/16.
//  Copyright © 2016 Brian Tai. All rights reserved.
//

import Foundation

class ICalcBrain {
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private struct PendingBinaryOperationInfo {
        var firstOperand: Double
        var binaryFunction: (Double, Double) -> Double
    }
    
    private var operations = [
        "π": Operation.constant(M_PI),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "×": Operation.binaryOperation{ $0 * $1 },
        "÷": Operation.binaryOperation{ $0 / $1 },
        "+": Operation.binaryOperation{ $0 + $1 },
        "−": Operation.binaryOperation{ $0 - $1 },
        "=": Operation.equals
    ]
    
    private var accumulator = 0.0
    private var pending: PendingBinaryOperationInfo?
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                accumulator = function(accumulator)
            case .binaryOperation(let function):
                executeBinaryOperation()
                pending = PendingBinaryOperationInfo(firstOperand: accumulator, binaryFunction: function)
            case .equals:
                executeBinaryOperation()
            }
        }
    }
    
    private func executeBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
}
