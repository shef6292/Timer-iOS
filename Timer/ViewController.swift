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
    let profileMO = ProfileMO()
    var profile: Profile!
    
    // Variables.
    var timer = Timer()
    
    // References to storyboard.
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var startTimerButton: UIButton!
    @IBOutlet weak var stopTimerButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    //------------- Functions -------------//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profile = profileMO.profile
        
        // Do any additional setup after loading the view.
        stopTimerButton.isEnabled = false
        stopTimerButton.isHidden = true
        
        nameLabel.isHidden = true
        nameLabel.isEnabled = false
        profilePictureImageView.isHidden = true
        profilePictureImageView.isUserInteractionEnabled = false
        
        // In the case that a profile does not exist for the
        // current user, show the ViewController for them to
        // create a new profile.
        if profile.name == nil {
            
            // Show the create profile view controller.
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "Create_Profile", sender: self)
            }
            
            
        } else {
            nameLabel.text = profile.name
            profilePictureImageView.image = profile.image
            
            // maybe animate?
            nameLabel.isHidden = false
            nameLabel.isEnabled = true
            profilePictureImageView.isHidden = false
            profilePictureImageView.isUserInteractionEnabled = true
        }
        
    }
    
    // Start the timer.
    @IBAction func startTimerButtonAction(_ sender: UIButton) {
        
        if profile.name != nil {
            nameLabel.text = profile.name
            profilePictureImageView.image = profile.image
            
            // maybe animate?
            nameLabel.isHidden = false
            nameLabel.isEnabled = true
            profilePictureImageView.isHidden = false
            profilePictureImageView.isUserInteractionEnabled = true
        }
        
        stopWatch.start()
        
        
        // Calculate the difference in time from the date last opened up to now.
        if profile.resumeTimer == true {
            
            if profile.dateLastOpened == 0 {
                profile.dateLastOpened = Int(stopWatch.startTime)
            }
            
            profile.time = Int(Int(stopWatch.startTime) - profile.dateLastOpened)
            profile.totalAccumulatedTime += profile.time
            profile.dateLastOpened = Int(stopWatch.startTime)
            
            stopWatch.elapsedTime += profile.time
            stopWatch.counter = Double(stopWatch.elapsedTime)
        }
        
        // Update the label every second.
        timer = Timer.scheduledTimer(withTimeInterval: incrementBy, repeats: true, block: {_ in
            
            self.timeLabel.text = self.stopWatch.getElapsedTime()
            
            if self.profile.name != nil {
                self.profileMO.saveProfile()
            }
            
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
        
        
        profile.dateLastOpened = Int(stopWatch.startTime)
        profile.resumeTimer = true
        
        profileMO.saveProfile()
        
    }
    
    // Stop the timer.
    @IBAction func stopTimerButtonAction(_ sender: UIButton) {
        
        // If the timer has already been stopped (button has already been pressed once),
        // then reset the timer.
        if stopTimerButton.currentTitle == "Reset Timer" {
            
            profile.totalAccumulatedTime += stopWatch.elapsedTime
            profile.resumeTimer = false
            profile.time = 0
            profile.dateLastOpened = 1
            profileMO.saveProfile()
            
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
            profile.time = stopWatch.stop()
            profile.dateLastOpened = 0
            timer.invalidate()
            
            
            profile.dateLastOpened = Int(stopWatch.stopTime)
            profile.resumeTimer = false
            
            profileMO.saveProfile()
            
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
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Create_Profile" {
            let createProfileVC = segue.destination as! CreateProfileViewController
            createProfileVC.profile = self.profile
            createProfileVC.profileMO = self.profileMO
        }
    }
    
}

