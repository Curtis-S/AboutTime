//
//  ScoreViewController.swift
//  AboutTime
//
//  Created by curtis scott on 09/06/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    // properties
    weak var delegate: ViewController?
    
    
    
    // outlets
    @IBOutlet weak var score: UILabel!
    
    @IBOutlet weak var playAgainButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        displayScore()
    }
    
    
    @IBAction func dismiss(_ sender: UIButton) {
        guard let controller = delegate else {
            return
        }
        dismiss(animated: true, completion: {
            controller.startNewGame()
        })
    }
    
    
    func displayScore() {
        if let controller = delegate {
            self.score.text = "\(controller.quizManager.score)/6"
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
