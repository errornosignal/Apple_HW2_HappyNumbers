//
//  main.swift
//  Apple_HW2_HappyNumbers
//
//  Created by Reid Nolan on 9/19/17.
//  Copyright © 2017 Reid Nolan. All rights reserved.
//

import Foundation

//print program header
print("HW1-RightTriangle\n")

//get and validate user input
func validateIntInput(prompt: String) -> Int? {
    
    while(true) {
        print(prompt)
        let inputString = readLine()!
        
        if ((NumberFormatter().number(from: inputString)?.intValue) != nil){
            let intInput = Int(inputString)!
            
            if (inputString is Int) {
                
                let minValue = 1
                let maxValue = 200
            
                if intInput >= minValue {
                    if intInput <= maxValue {
                        return intInput;
                    }
                    else {
                        print("Error! Input is above '\(maxValue)' maximum value")
                    }
                }
                else {
                    print("Error! Input is below '\(minValue)' minimum value.")
                    }
            }
        }
            
        else {
            print("Error! Input is not a valid integer value from 1-200.")
        }
            
    }
}

func isStringAnInt(string: String) -> Bool {
    return Int(string) != nil
}

//set user input to variables
let userInt = validateIntInput(prompt: "Enter a positive integer from 1-200:")

print("\nuserInt = \(String(describing: userInt))\n")

