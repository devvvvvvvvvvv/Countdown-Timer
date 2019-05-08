//
//  ViewController.swift
//  Countdown Timer Functionality
//
//  Created by Devon Dodgson on 5/8/19.
//  Copyright © 2019 Devon Dodgson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startPauseButton: UIButton!
    
    var timerOn = false
    var currentTime = 0
    var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerLabel.text = String("00:00")
        
    }

    @IBAction func setTimer(_ sender: UITapGestureRecognizer) {

        if timerOn == false && currentTime == 0 {
            pauseTimer()
        }
    }

    @IBAction func resetButtonPressed(_ sender: Any) {
        resetTimer()
    }

    @IBAction func startButtonPressed(_ sender: Any) {

        if timerOn == false && currentTime > 0 {
            updatePauseUI()
            runTimer()
        } else if currentTime > 0 {
            pauseTimer()
        }
    
    }
    
    //Handles PAUSE feature
    func pauseTimer() {
        
        timer.invalidate()
        updateStartUI()
        
    }
   
    
    //Updates UILabel to display sender minute selection in seconds
    func chosenTime(timerLength: Int) {
        
        currentTime = timerLength * 60
        timerLabel.text = String(currentTime)
        formatTime()
        
    }
    
    //Sets timer length to sender's chosen timer from alert.
    func formatTime() {
        
        let minutes = currentTime / 60 % 60
        let seconds = currentTime % 60
        let format = String(format:"%02i:%02i", minutes, seconds)
        
        self.timerLabel.text = format
    }
    
    //Updates Start/Pause button to "PAUSE" state (text/color changes)
    func updatePauseUI() {
        timerOn = true
        startPauseButton.backgroundColor = UIColor(red: 0.3608, green: 0.2863, blue: 0.4706, alpha: 1.0)
        startPauseButton.setTitle("PAUSE", for: .normal)
    }
    
    //Updates Start/Pause button to "START" state (text/color changes)
    func updateStartUI() {
        timerOn = false
        startPauseButton.backgroundColor = UIColor(red: 0, green: 0.7647, blue: 1, alpha: 1.0) /* #00c3ff */
        startPauseButton.setTitle("START", for: .normal)
    }
    
    //Reset feature
    func resetTimer() {
        timer.invalidate()
        timerOn = false
        timerLabel.text = String("00:00")
        updateStartUI()
    }
    
    //Handles Running timer
    func runTimer() {
        
        if timerLabel.text != "00:00" {
            
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats:true, block: { (timer) in
                self.currentTime -= 1
                self.formatTime()
                
                if self.currentTime == 0 {
                    self.resetTimer()
                }
            })
            
        }
    }
}

