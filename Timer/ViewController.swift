//
//  ViewController.swift
//  Timer
//
//  Created by Dillon Sheffield on 4/22/20.
//  Copyright © 2020 Dillon Sheffield. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Constants.
    let stopWatch = StopWatch()
    let incrementBy = 1.0
    
    // Variables.
    var timer = Timer()
    
    // References to storyboard.
    @IBOutlet weak var startTimerButton: UIButton!
    @IBOutlet weak var stopTimerButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    //------------- Functions -------------//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        stopTimerButton.isEnabled = false
        stopTimerButton.isHidden = true
    }
    
    // Start the timer.
    @IBAction func startTimerButtonAction(_ sender: UIButton) {
        
        stopWatch.start()
        
        // Update the label every second.
        timer = Timer.scheduledTimer(withTimeInterval: incrementBy, repeats: true, block: {_ in
            
            self.timeLabel.text = self.stopWatch.getElapsedTime()
            
        })
        
        // If the timer has been resumed (timer was paused beforehand),
        // then change the stopTimerButton's title.
        if startTimerButton.currentTitle == "Resume Timer" {
            
            // Change the current title of the stopTimerButton
            // to allow the pausing of the timer.
            stopTimerButton.setTitle("Pause Timer", for: UIControl.State.normal)
        }
        
        // Enable and reveal the Stop Timer Button.
        stopTimerButton.isEnabled = true
        stopTimerButton.isHidden = false
        
        // Disable and hide the Start Timer Button.
        startTimerButton.isEnabled = false
        startTimerButton.isHidden = true
        
    }
    
    // Stop the timer.
    @IBAction func stopTimerButtonAction(_ sender: UIButton) {
        
        // If the timer has already been stopped (button has already been pressed once),
        // then reset the timer.
        if stopTimerButton.currentTitle == "Reset Timer" {
            
            // Reset the timer and update the time label.
            timeLabel.text = stopWatch.reset()
            
            // Change the text back to "Pause Timer".
            stopTimerButton.setTitle("Pause Timer", for: UIControl.State.normal)
            
            // Change the current title of the startTimerButton
            // to allow the start of the timer.
            startTimerButton.setTitle("Start Timer", for: UIControl.State.normal)
            
            // Disable and hide the Start Timer Button.
            stopTimerButton.isEnabled = false
            stopTimerButton.isHidden = true
            
        // Otherwise, pause the timer.
        } else {
            
            // Stop both timers.
            stopWatch.stop()
            timer.invalidate()
            
            // Change the current title of the stopTimerButton
            // to allow the resetting of the timer.
            stopTimerButton.setTitle("Reset Timer", for: UIControl.State.normal)
            
            // Change the current title of the startTimerButton
            // to allow resuming of the timer.
            startTimerButton.setTitle("Resume Timer", for: UIControl.State.normal)
        }
        
        // Enable and reveal the Start Timer Button.
        startTimerButton.isEnabled = true
        startTimerButton.isHidden = false
    }
    
}

