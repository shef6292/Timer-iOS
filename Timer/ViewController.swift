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
        
        // Enable and reveal the Stop Timer Button.
        stopTimerButton.isEnabled = true
        stopTimerButton.isHidden = false
        
        // Disable and hide the Start Timer Button.
        startTimerButton.isEnabled = false
        startTimerButton.isHidden = true
        
    }
    
    // Stop the timer.
    @IBAction func stopTimerButtonAction(_ sender: UIButton) {
        
        stopWatch.stop()
        
        timer.invalidate()
        
        // Disable and hide the Stop Timer Button.
        stopTimerButton.isEnabled = false
        stopTimerButton.isHidden = true
        
        // Enable and reveal the Start Timer Button.
        startTimerButton.isEnabled = true
        startTimerButton.isHidden = false
    }
    
}

