//
//  StopWatch.swift
//  Timer
//
//  Created by Dillon Sheffield on 4/22/20.
//  Copyright © 2020 Dillon Sheffield. All rights reserved.
//

import Foundation

class StopWatch {
    
    // Constants.
    let incrementBy = 1.0
    
    // Variables.
    var timer = Timer()
    var counter = 0.0
    var hours = 0
    var minutes = 0
    var seconds = 0
    
    
    //------------- Functions -------------//
    
    // Start the timer.
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: incrementBy, repeats: true, block: {_ in
            
            self.counter += self.incrementBy
            
        })
    }
    
    // Stop the timer.
    func stop() {
        timer.invalidate()
        counter = 0.0
        hours = 0
        minutes = 0
        seconds = 0
    }
    
    // Return the elapsed time from when the timer began in a String format.
    func getElapsedTime() -> String {
        
        hours = Int(self.counter / 3600)
        minutes = Int(self.counter.truncatingRemainder(dividingBy: 3600) / 60)
        seconds = Int(self.counter.truncatingRemainder(dividingBy: 60))
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
}
