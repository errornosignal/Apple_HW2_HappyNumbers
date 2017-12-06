//
//  main.swift
//  Apple_HW2_HappyNumbers
//
//  Created by Reid Nolan on 12/5/17.
//  Copyright © 2017 Reid Nolan. All rights reserved.
//

import Foundation

// print program header
print("HW2-HappyNumbers")
print("Type 'e' to exit")

//loop for geting int from user
func validateIntInput(prompt: String, min: Int,  max: Int) -> Int {
    while (true) {
        print(prompt);
        let inputString = readLine()!
        
        //allow program exit
        if (inputString.lowercased() == "e") {
            exit(5);
        }
        //check for input in range
        else if (Int(inputString) != nil && (Int(inputString)! >= min && Int(inputString)! <= max)) {
            let numberQty = Int(inputString)!;
            return numberQty;
        }
        //display error for bad input
        else {
            let errorString = String(format:"Error! Invalid input. Value must be %d-%d.", min, max)
            print(errorString);
        }
    }
}

//loop for geting yes/no decision from user
func validateYesNo(prompt: String) -> Bool {
    while (true) {
        print(prompt)
        let inputString = readLine()!;
        //allow program exit
        if(inputString.lowercased() == "e") {
            exit(6);
        }
        //(y)es = true
        else if (inputString.lowercased() == "y") {
            return true;
        }
        //(n)o = false
        else if (inputString.lowercased() == "n") {
            return false;
        }
        //display error for bad input
        else {
            print("Error! Invalid input. Response must be \"y\" or \"n\".");
        }
    }
}

//check if number isHappy
func isHappyNumber(_ number: Int) -> Bool {
    var newNumber = number
    var cycle = [Int]()
    
    while newNumber != 1 && !cycle.contains(newNumber) {
        cycle.append(newNumber)
        var m = 0
        while (newNumber > 0) {
            let d = newNumber % 10
            m += d * d
            newNumber = (newNumber - d) / 10
        }
        newNumber = m
    }
    return newNumber == 1
}

//check in number isPrime
func isPrime(_ number: Int) -> Bool {
    let newNumber = number
    return newNumber > 1 && !(2..<newNumber).contains { newNumber % $0 == 0 }
}

//main
while(true) {
    print()
    
    //get user input
    let numberQty: Int = validateIntInput(prompt: "Qty of numbers to count: ", min: 1, max: 200)
    let excludeNonPrime = validateYesNo(prompt: "\"Happy Prime\" numbers only?(y/n): ")
    
    //array to store numbers
    var happyNumbers: [(Int)] = [];
    
    //local variables
    var fileString: String = "";
    var found = 0
    var count = 0
    
    //determine status of numbers and append to array depending on happy-prime or just happy
    if excludeNonPrime {
        print("Happy Prime Numbers:")
        fileString += "Happy Prime Numbers:\n";
        while found != numberQty {
            if isHappyNumber(count) {
                if isPrime(count)
                {
                    happyNumbers.append(count)
                    found += 1
                }
            }
            else {/*doNothing()*/}
            count += 1
        }
    }
    else {
        print("Happy Numbers:")
        fileString += "Happy Numbers:\n";
        while found != numberQty {
            if isHappyNumber(count) {
                happyNumbers.append(count)
                found += 1
            }
            else {/*doNothing()*/}
            count += 1
        }
    }
    
    //append numbers to string for printing
    for happyNumber in happyNumbers {
        print(happyNumber);
        fileString += "\(happyNumber) \n";
    }

    //print to file
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    {
        let fileName = "Happy.txt";
        let path = dir.appendingPathComponent(fileName)
        
        do {
            try fileString.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            let messageString = String(format:"Results written to ~/Documents/%@.", fileName)
            print(messageString)
            print("Type 'e' to exit")
        }
        catch {
            let messageString = String(format:"Could not write to %@ in ~/Documents.", fileName)
            print(messageString)
            print("Type 'e' to exit")
        }
    }
}
