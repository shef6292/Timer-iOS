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
    
    // The total accumulated time for this profile.
    var time = 0
    
    // Initializer.
    init() {
        name = nil
        image = nil
        time = 0
    }
    
}
