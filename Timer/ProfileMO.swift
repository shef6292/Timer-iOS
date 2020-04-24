//
//  ProfileMO.swift
//  Timer
//
//  Created by Dillon Sheffield on 4/23/20.
//  Copyright © 2020 Dillon Sheffield. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ProfileMO {
    
    var profile_managed: NSManagedObject?
    
    var profiles: [NSManagedObject] = []
    
    var profile = Profile()
    /*
    // The name of the profile.
    var name: String?
    
    // The profile picture of the profile.
    var image: UIImage?
    
    // The total accumulated time for this profile.
    var time = 0
    */
    var appDelegate: AppDelegate!
    
    var managedContext: NSManagedObjectContext!
    
    var entity: NSEntityDescription!
    
    // Initializer.
    init() {
        
        
        
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        // 1
        managedContext =
        appDelegate.persistentContainer.viewContext
        
        // 2
        entity =
          NSEntityDescription.entity(forEntityName: "Profile",
                                     in: managedContext)!
        
        profile_managed = NSManagedObject(entity: entity,
                                          insertInto: managedContext)
        
    }
    
    func save() {
        
      // 1
        profile_managed!.setValue(profile.name, forKeyPath: "name")
        profile_managed!.setValue(profile.image?.pngData(), forKeyPath: "image")
        profile_managed!.setValue(profile.time, forKeyPath: "time")
        profile_managed!.setValue(profile.totalAccumulatedTime, forKeyPath: "totalAccumulatedTime")
        profile_managed!.setValue(profile.totalAccumulatedTime, forKeyPath: "dateLastOpened")
        profile_managed!.setValue(profile.resumeTimer, forKeyPath: "resumeTimer")
      
      // 2
      do {
        try managedContext.save()
        
        //profiles.append(profile_managed!)
        
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    
    
    
    func load(name: String) {
        //2
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "Profile")
        
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        //3
        do {
            
            profiles = try managedContext.fetch(fetchRequest)
            
            if let profile_managed = profiles.first {
                
                profile.name = profile_managed.value(forKeyPath: "name") as? String
                profile.image = UIImage(data: (profile_managed.value(forKeyPath: "image")) as! Data, scale: 1)
                profile.time = profile_managed.value(forKeyPath: "time") as! Int
                profile.totalAccumulatedTime = profile_managed.value(forKeyPath: "totalAccumulatedTime") as! Int
                profile.dateLastOpened = profile_managed.value(forKeyPath: "dateLastOpened") as! Int
                profile.resumeTimer = profile_managed.value(forKeyPath: "resumeTimer") as! Bool
            
            }
            
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
}

