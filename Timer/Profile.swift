//
//  Profile.swift
//  Timer
//
//  Created by Dillon Sheffield on 4/23/20.
//  Copyright © 2020 Dillon Sheffield. All rights reserved.
//

import Foundation
import UIKit

class Profile {
    
    // The name of the profile.
    var name: String?
    
    // The profile picture of the profile.
    var image: UIImage?
    
    // The elapsed time for this session.
    var time = 0
    
    // The total accumulated time for this profile.
    var totalAccumulatedTime = 0
    
    // The date this app was last opened.
    var dateLastOpened = 0
    
    // State that determines if the user left the timer running.
    var resumeTimer: Bool
    
    // Initializer.
    init() {
        name = nil
        image = nil
        resumeTimer = false
    }
    
}
