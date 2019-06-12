//
//  EventModels.swift
//  AboutTime
//
//  Created by curtis scott on 07/06/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import Foundation

// dict for event data

let historyEvents: [String:Int] = [  "Rio Olympics":2016,
                              "Ameican Reveluton": 1765,
                              "Protostant reformation":1517,
                              "Tearing Down of the Berlin Wall":1989,
                              "World War II":1939,
                              "Hitler Becomes German Chancellor":1933,
                              "Gutenberg's Printing Press":1440,
                              "The Life of Muhammad":570,
                              "Martin Luther King Jr.’s “I have a dream” speech":1963 ,
                              "Filming the MGM Lion.":1929,
                              "Wilbur Wright flies around the Statue of Liberty":1909,
                              "THE BLACK DEATH":1346,
                              "PAX ROMANA":-27,
                              "FALL OF CONSTANTINOPLE":1453,
                              "CIVIL WAR IN THE UNITED STATES":1861,
                              "MEDICAL REVOLUTION":1900,
                              "INDUSTRIAL AND TECHNOLOGICAL REVOLUTION ":1760,
                              "RENAISSANCE":1400,
                              "COLONIALISM":1600,
                              "OCTOBER REVOLUTION":1917,
                              "ASSASSINATION OF ARCHDUKE FERDINAND II":1914,
                              "FRENCH REVOLUTION":1789,
                              "Queen Victoria's Funeral":1901,
                              " Wright Brother's First Flight":1903,
                              "Emily Davison Throws Herself Under The Kings Horse":1913,
]




// event and round models


struct Event{
    let name:String
    let date:Int
}

struct Round{
    var eventsForRound:[Event] = []
}

class QuizManager {
    var currentRound = 1
    var events:[Event] = []
    var score = 0
    init() {
        for (key,value) in historyEvents{
            self.events.append(Event(name:key,date:value))
        }
    }
    
    func generateRound() -> Round {
        var rounds:[Event] = []
        shuffleEvents()
        for number in  0...3 {
            rounds.append(events[number])
        }
        
        return Round(eventsForRound: rounds)
    }
    
    //shuffles the events for the quiz
    func shuffleEvents() {
        var last = events.count - 1
        
        while(last > 0)
        {
            let rand = Int(arc4random_uniform(UInt32(last)))
            
            
            events.swapAt(last, rand)
            
            last -= 1
        }
    }
    
    //checks quiz answers
    func checkAnswers(firstAnswer one:String ,secondAnswer two:String ,thirdtAnswer third:String ,forthAnswer fourth:String) -> Bool{
        var correctOrder:[Int] = []
        let firstAnswer = checkDate(forEvent: one)
        let secondAnswer = checkDate(forEvent: two)
        let thridAnswer = checkDate(forEvent: third)
        let fourthAnswer = checkDate(forEvent: fourth)
        
        correctOrder.append(firstAnswer)
        correctOrder.append(secondAnswer)
        correctOrder.append(thridAnswer)
        correctOrder.append(fourthAnswer)
        
        correctOrder.sort()
        
        
        
        
        if firstAnswer == correctOrder[0] &&
            secondAnswer == correctOrder[1] &&
        thridAnswer == correctOrder[2] &&
        fourthAnswer == correctOrder[3] {
            return true
        } else {
            return false
        }
        
        
        
        
       
    }
    
    func checkDate(forEvent event:String)-> Int{
        guard let date = historyEvents[event] else {
            return 0
        }
        return date
    }
    
    

    
    
}
