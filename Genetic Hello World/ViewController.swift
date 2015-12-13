//
//  ViewController.swift
//  Genetic Hello World
//
//  Created by Malcolm MacArthur on 2015-12-09.
//  Copyright © 2015 Malcolm MacArthur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var Label_1: UILabel!
    @IBOutlet weak var Label_2: UILabel!
    @IBOutlet weak var Label_3: UILabel!
    @IBOutlet weak var Label_4: UILabel!
    @IBOutlet weak var Label_5: UILabel!
    @IBOutlet weak var Label_6: UILabel!
    @IBOutlet weak var Label_7: UILabel!
    @IBOutlet weak var Label_8: UILabel!
    @IBOutlet weak var Label_9: UILabel!
    @IBOutlet weak var Label_10: UILabel!
    @IBOutlet weak var lblGeneration: UILabel!
    
    var mmm: [String] = []
    
    
    var generation = 0
    var size = 0
    var goalletters: [String] = []
    var goalCapitals: [Bool] = []
    var goalnumeric: [Bool] = []
    var chromosomeFitness: [[Double]] =
    [
        [0,0],
        [0,1],
        [0,2],
        [0,3],
        [0,4],
        [0,5],
        [0,6],
        [0,7],
        [0,8],
        [0,9]
    ]
    var stringGoal: String = "HelloWorld"
    var chromosome: [[[String]]] =
    [
        [[""],[],[],[],[]],
        [[""],[],[],[],[]],
        [[""],[],[],[],[]],
        [[""],[],[],[],[]],
        [[""],[],[],[],[]],
        [[""],[],[],[],[]],
        [[""],[],[],[],[]],
        [[""],[],[],[],[]],
        [[""],[],[],[],[]],
        [[""],[],[],[],[]],
    ]//[[text],[letter,letter,letter],[capitals],[numeric],[letter fitness][][]....

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var charIndex: String.CharacterView.Index
        for var index = 0; index < stringGoal.characters.count; index++ {
            charIndex = stringGoal.startIndex.advancedBy(index)
            goalletters.append(String(stringGoal[charIndex]))
            
            if goalletters[index] == goalletters[index].lowercaseString {
                goalCapitals.append(false)
            } else {
                goalCapitals.append(true)
            }
            
            if Int(goalletters[index]) == nil {
                goalnumeric.append(false)
            } else {
                goalnumeric.append(true)
            }
        }
        
        //Create random population--------------------------
        size = stringGoal.characters.count
        for var index = 0; index < 10; index++ {
            for var index1 = 0; index1 < size; index1++ {
                chromosome[index][1].append("")
                chromosome[index][2].append("")
                chromosome[index][3].append("")
                chromosome[index][4].append("0")
            }
        }
        
        Label_1.text = randomAlphaNumericString(size)
        Label_2.text = randomAlphaNumericString(size)
        Label_3.text = randomAlphaNumericString(size)
        Label_4.text = randomAlphaNumericString(size)
        Label_5.text = randomAlphaNumericString(size)
        Label_6.text = randomAlphaNumericString(size)
        Label_7.text = randomAlphaNumericString(size)
        Label_8.text = randomAlphaNumericString(size)
        Label_9.text = randomAlphaNumericString(size)
        Label_10.text = randomAlphaNumericString(size)
        
        chromosome[0][0][0] = Label_1.text!
        chromosome[1][0][0] = Label_2.text!
        chromosome[2][0][0] = Label_3.text!
        chromosome[3][0][0] = Label_4.text!
        chromosome[4][0][0] = Label_5.text!
        chromosome[5][0][0] = Label_6.text!
        chromosome[6][0][0] = Label_7.text!
        chromosome[7][0][0] = Label_8.text!
        chromosome[8][0][0] = Label_9.text!
        chromosome[9][0][0] = Label_10.text!
        
        generation++
        lblGeneration.text = "Generation: \(generation)"
        
        var loopflag = false
        while loopflag == false {
            for var index = 0; index < 10; index++ {// array for the 10 labels
                for var index1 = 0; index1 < chromosome[index][0][0].characters.count; index1++ {// array of each letter in the text
                    //seperate data--------------------------------------------------
                    charIndex = chromosome[index][0][0].startIndex.advancedBy(index1)
                    chromosome[index][1][index1] = String(chromosome[index][0][0][charIndex])
                
                    if chromosome[index][1][index1] == chromosome[index][1][index1].lowercaseString {
                        chromosome[index][2][index1] = "true"
                    } else {
                        chromosome[index][2][index1] = "false"//going to use string true or false because I am restricted to strings
                    }
                    
                    if Int(chromosome[index][1][index1]) == nil {
                        chromosome[index][3][index1] = "false"
                    } else {
                        chromosome[index][3][index1] = "true"
                    }
                    
                    //Determine fitness-----------------------------------------------
                    if chromosome[index][1][index1] == goalletters[index1]{
                        chromosomeFitness[index][0] += 20
                        chromosome[index][4][index1] = String(Int(chromosome[index][4][index1])! + 20)
                    } else {
                        if chromosome[index][1][index1].lowercaseString == goalletters[index1].lowercaseString{//check if it is the letter
                            chromosomeFitness[index][0] += 10
                            chromosome[index][4][index1] = String(Int(chromosome[index][4][index1])! + 10)
                        }
                        
                        if chromosome[index][2][index1] == String(goalCapitals[index1]) { //check if they match in capitilization
                            chromosomeFitness[index][0] += 5
                            chromosome[index][4][index1] = String(Int(chromosome[index][4][index1])! + 5)
                        }
                        
                        if chromosome[index][3][index1] == String(goalnumeric[index1]) { //check if they match numericly
                            chromosomeFitness[index][0] += 5
                            chromosome[index][4][index1] = String(Int(chromosome[index][4][index1])! + 5)
                        }
                    }
                }
            }
        
            //compare fitness--------------------------------------------------
            chromosomeFitness = rankFromHighestToLowestNumber(chromosomeFitness)
            
            //start making children---------------------------------------------
            
            if generation >= 99 {
                
             for var index = 0; index < 10; index++ {
                    mmm.append(chromosome[index][0][0])
                }
            }
            //Elite children
            Label_1.text = chromosome[Int(chromosomeFitness[0][1])][0][0]
            Label_2.text = chromosome[Int(chromosomeFitness[1][1])][0][0]
            Label_3.text = chromosome[Int(chromosomeFitness[2][1])][0][0]
            
            //mutation of elite children
            var text = chromosome[Int(chromosomeFitness[0][1])][1]
            var randomChanges: [[String]] = [[String(arc4random_uniform(UInt32(size))), randomAlphaNumericString(1)],[String(arc4random_uniform(UInt32(size))), randomAlphaNumericString(1)],[String(arc4random_uniform(UInt32(size))), randomAlphaNumericString(1)],[String(arc4random_uniform(UInt32(size))), randomAlphaNumericString(1)],[String(arc4random_uniform(UInt32(size))), randomAlphaNumericString(1)]]
            text[Int(randomChanges[0][0])!] = randomChanges[0][1]
            text[Int(randomChanges[1][0])!] = randomChanges[1][1]
            text[Int(randomChanges[2][0])!] = randomChanges[2][1]
            text[Int(randomChanges[3][0])!] = randomChanges[3][1]
            text[Int(randomChanges[4][0])!] = randomChanges[4][1]
            var finalText = text.reduce("",combine:{$0 + $1})
            Label_4.text = finalText
            chromosome[3][0][0] = finalText
            
            text = chromosome[Int(chromosomeFitness[1][1])][1]
            randomChanges = [[String(arc4random_uniform(UInt32(size))), randomAlphaNumericString(1)],[String(arc4random_uniform(UInt32(size))), randomAlphaNumericString(1)],[String(arc4random_uniform(UInt32(size))), randomAlphaNumericString(1)],[String(arc4random_uniform(UInt32(size))), randomAlphaNumericString(1)],[String(arc4random_uniform(UInt32(size))), randomAlphaNumericString(1)]]
            text[Int(randomChanges[0][0])!] = randomChanges[0][1]
            text[Int(randomChanges[1][0])!] = randomChanges[1][1]
            text[Int(randomChanges[2][0])!] = randomChanges[2][1]
            text[Int(randomChanges[3][0])!] = randomChanges[3][1]
            text[Int(randomChanges[4][0])!] = randomChanges[4][1]
            finalText = text.reduce("",combine:{$0 + $1})
            Label_5.text = finalText
            chromosome[4][0][0] = finalText
            
            text = chromosome[Int(chromosomeFitness[2][1])][1]
            randomChanges = [[String(arc4random_uniform(UInt32(size))), randomAlphaNumericString(1)],[String(arc4random_uniform(UInt32(size))), randomAlphaNumericString(1)],[String(arc4random_uniform(UInt32(size))), randomAlphaNumericString(1)],[String(arc4random_uniform(UInt32(size))), randomAlphaNumericString(1)],[String(arc4random_uniform(UInt32(size))), randomAlphaNumericString(1)]]
            text[Int(randomChanges[0][0])!] = randomChanges[0][1]
            text[Int(randomChanges[1][0])!] = randomChanges[1][1]
            text[Int(randomChanges[2][0])!] = randomChanges[2][1]
            text[Int(randomChanges[3][0])!] = randomChanges[3][1]
            text[Int(randomChanges[4][0])!] = randomChanges[4][1]
            finalText = text.reduce("",combine:{$0 + $1})
            Label_6.text = finalText
            chromosome[5][0][0] = finalText
            
            //combine parents
            var firstParent = chromosome[Int(chromosomeFitness[0][1])]
            var secondParent = chromosome[Int(arc4random_uniform(3) + 3)]
            var loopFlag1 = false
            
            while loopFlag1 == false {
                if firstParent == secondParent{
                    secondParent = chromosome[Int(arc4random_uniform(10))]
                } else {
                    loopFlag1 = true
                }
            }
            
            text.removeAll()
            for var index = 0; index < size; index++ {
                if firstParent[4][index] >= secondParent[4][index]{
                    text.append(firstParent[1][index])
                } else {
                    text.append(secondParent[1][index])
                }
            }
            finalText = text.reduce("",combine:{$0 + $1})
            Label_7.text = finalText
            chromosome[6][0][0] = finalText
            
            firstParent = chromosome[Int(chromosomeFitness[1][1])]
            secondParent = chromosome[Int(arc4random_uniform(10))]
            loopFlag1 = false
            
            while loopFlag1 == false {
                if firstParent == secondParent{
                    secondParent = chromosome[Int(arc4random_uniform(10))]
                } else {
                    loopFlag1 = true
                }
            }
            
            text.removeAll()
            for var index = 0; index < size; index++ {
                if firstParent[4][index] >= secondParent[4][index]{
                    text.append(firstParent[1][index])
                } else {
                    text.append(secondParent[1][index])
                }
            }
            finalText = text.reduce("",combine:{$0 + $1})
            Label_8.text = finalText
            chromosome[7][0][0] = finalText
            
            firstParent = chromosome[Int(chromosomeFitness[2][1])]
            secondParent = chromosome[Int(arc4random_uniform(10))]
            loopFlag1 = false
            
            while loopFlag1 == false {
                if firstParent == secondParent{
                    secondParent = chromosome[Int(arc4random_uniform(10))]
                } else {
                    loopFlag1 = true
                }
            }
            
            text.removeAll()
            for var index = 0; index < size; index++ {
                if firstParent[4][index] >= secondParent[4][index]{
                    text.append(firstParent[1][index])
                } else {
                    text.append(secondParent[1][index])
                }
            }
            finalText = text.reduce("",combine:{$0 + $1})
            Label_9.text = finalText
            chromosome[8][0][0] = finalText
            
            firstParent = chromosome[Int(chromosomeFitness[0][1])]
            secondParent = chromosome[Int(arc4random_uniform(10))]
            loopFlag1 = false
            
            while loopFlag1 == false {
                if firstParent == secondParent{
                    secondParent = chromosome[Int(arc4random_uniform(10))]
                } else {
                    loopFlag1 = true
                }
            }
            
            text.removeAll()
            for var index = 0; index < size; index++ {
                if firstParent[4][index] >= secondParent[4][index]{
                    text.append(firstParent[1][index])
                } else {
                    text.append(secondParent[1][index])
                }
            }
            randomChanges = [[String(arc4random_uniform(UInt32(size))), randomAlphaNumericString(1)],[String(arc4random_uniform(UInt32(size))), randomAlphaNumericString(1)],[String(arc4random_uniform(UInt32(size))), randomAlphaNumericString(1)],[String(arc4random_uniform(UInt32(size))), randomAlphaNumericString(1)],[String(arc4random_uniform(UInt32(size))), randomAlphaNumericString(1)]]
            text[Int(randomChanges[0][0])!] = randomChanges[0][1]
            text[Int(randomChanges[1][0])!] = randomChanges[1][1]
            text[Int(randomChanges[2][0])!] = randomChanges[2][1]
            text[Int(randomChanges[3][0])!] = randomChanges[3][1]
            text[Int(randomChanges[4][0])!] = randomChanges[4][1]
            finalText = text.reduce("",combine:{$0 + $1})
            Label_10.text = finalText
            chromosome[9][0][0] = finalText
            
            //let mmm = chromosomeFitness
            chromosomeFitness = [[0,0],[0,1],[0,2],[0,3],[0,4],[0,5],[0,6],[0,7],[0,8],[0,9]]
            
            generation++
            lblGeneration.text = "Generation: \(generation)"
            
            if generation < 100{
                for var index = 0; index < 10; index++ {
                    for var index1 = 0; index1 < size; index1++ {
                        chromosome[index][4][index1] = "0"
                    }
                //print(chromosome[index][4])
                
                }
            } else {
                loopflag = true
                for var index = 0; index < 10; index++ {
                    print("\(index).\(chromosome[index][4])")
                    print("\(index).\(chromosome[index][0][0])")
                     print(" ")
                }
                print(mmm)
                
            }
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func randomAlphaNumericString(length: Int) -> String {
        
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedCharsCount = UInt32(allowedChars.characters.count)
        var randomString = ""
        
        for _ in (0..<length) {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let newCharacter = allowedChars[allowedChars.startIndex.advancedBy(randomNum)]
            randomString += String(newCharacter)
        }
        
        return randomString
    }
    
    func rankFromHighestToLowestNumber(numbers: [[Double]]) -> [[Double]] {
        var arrangedArray: [[Double]] = [[],[],[],[],[],[],[],[],[],[]]
        for var index = 0; index < 10; index++ {
            
            var rank = 0
            var loopflag1 = false
            
            for var index1 = 0; index1 < 10; index1++ {
                if index != index1 && numbers[index][0] < numbers[index1][0]{
                    rank++
                }
            }
            
            while loopflag1 == false {
                if arrangedArray[rank].isEmpty {
                    arrangedArray[rank] = numbers[index]
                    loopflag1 = true
                } else {
                    rank++
                }
            }
        }
        return arrangedArray
    }
}

