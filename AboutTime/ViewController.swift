//
//  ViewController.swift
//  AboutTime
//
//  Created by curtis scott on 06/06/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // outlets

    @IBOutlet weak var choiceOne: UILabel!
    
    
    @IBOutlet weak var choiceTwo: UILabel!
  
    @IBOutlet weak var choiceThree: UILabel!
 
    @IBOutlet weak var choiceFour: UILabel!
    
  
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBOutlet weak var nextRoundButton: UIButton!
    
    @IBOutlet weak var downButtonFull: UIButton!
    
    @IBOutlet weak var upButtonHalf2: UIButton!
    
    @IBOutlet weak var downButtonHalf2: UIButton!
    
    
    @IBOutlet weak var upButtonHalf3: UIButton!
    
    @IBOutlet weak var downButtonHalf3: UIButton!
    
    @IBOutlet weak var upButtonFull: UIButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    
    //properties
    
    var quizManager = QuizManager()
    let vc = ScoreViewController()
    var timer = Timer()
    var seconds = 60
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        roundLabels()
        startNewGame()
        

    }
    
    //helpers
    
    func roundLabels(){
        choiceOne.layer.cornerRadius = 3
        choiceOne.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
        choiceTwo.layer.cornerRadius = 3
        choiceTwo.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
        choiceThree.layer.cornerRadius = 3
        choiceThree.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
        choiceFour.layer.cornerRadius = 3
        choiceFour.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
    }
    
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        seconds-=1
        timerLabel.text = String(seconds)
        
        if seconds == 0 && quizManager.currentRound > 6 {
            answerRound()
            
        } else if seconds == 0 {
         answerRound()
         
        }
    }
    // starts next round
    @IBAction func nextRoundButton(_ sender: UIButton) {
       newRound()
        
    }
    
    // switches answer options
    @IBAction func swtichButton(_ sender: UIButton) {
        if sender === downButtonFull {
           
            switchChoices(forAnswers: 12)
           
        }
        
        if sender === upButtonFull {
         switchChoices(forAnswers: 34)
            
            
            
        }
        
        if sender === upButtonHalf2 {
          switchChoices(forAnswers: 12)
            
            
        }
        if sender === downButtonHalf2 {
            
            switchChoices(forAnswers: 23)
            
        }
        if sender === upButtonHalf3 {
            switchChoices(forAnswers: 23)
            
            
        }
        if sender === downButtonHalf3 {
            switchChoices(forAnswers: 34)
            
            
        }
       
        
        
    }
    //when phone is shaked
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
           answerRound()
            
        }
    }
    
    
   
    
    
    func startNewGame(){
       quizManager.currentRound = 1
        self.nextRoundButton.isHidden = true
        displayQuestion()
        self.timerLabel.isHidden = false
        runTimer()
        
    }
    
    func newRound(){
        quizManager.currentRound += 1
        if quizManager.currentRound > 6{
            
            gameOver()
        }else {
            self.timerLabel.isHidden = false
            self.nextRoundButton.isHidden = true
            displayQuestion()
    
            runTimer()
        }
    }
    
    func gameOver(){
        finishGame()
        
    }
    
    func answerRound(){
        self.timerLabel.isHidden = true
        self.nextRoundButton.isHidden = false
        timer.invalidate()
        self.seconds = 60
        self.timerLabel.text = String(seconds)
        let response = quizManager.checkAnswers(firstAnswer: self.choiceOne.text!, secondAnswer: self.choiceTwo.text!, thirdtAnswer: self.choiceThree.text!, forthAnswer: self.choiceFour.text!)
        if response == true {
               quizManager.score += 1
            self.nextRoundButton.setBackgroundImage(UIImage(named: "next_round_success"), for: .normal)
        }else {
 
            self.nextRoundButton.setBackgroundImage(UIImage(named: "next_round_fail"), for: .normal)
        }
      
        
        
    }
    
    func finishGame(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ScoreViewController") as! ScoreViewController
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func displayQuestion(){
        let round = quizManager.generateRound()
        self.choiceOne.text = round.eventsForRound[0].name
        self.choiceTwo.text = round.eventsForRound[1].name
        self.choiceThree.text = round.eventsForRound[2].name
        self.choiceFour.text = round.eventsForRound[3].name
        
    }
    
    func switchChoices(forAnswers answer:Int){
        switch answer {
        case 12:
            let temp = self.choiceOne.text!
            let tempTwo = self.choiceTwo.text!
            self.choiceOne.text = tempTwo
            self.choiceTwo.text = temp
            break
        case 23:
            let temp = self.choiceTwo.text!
            let tempTwo = self.choiceThree.text!
            self.choiceTwo.text = tempTwo
            self.choiceThree.text = temp
            break
        case 34:
            let temp = self.choiceThree.text!
            let tempTwo = self.choiceFour.text!
            self.choiceThree.text = tempTwo
            self.choiceFour.text = temp
            break
            
        default:
            break
        }
    }
    


}

