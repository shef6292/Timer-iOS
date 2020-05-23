//
//  CreateProfileViewController.swift
//  Timer
//
//  Created by Dillon Sheffield on 4/23/20.
//  Copyright © 2020 Dillon Sheffield. All rights reserved.
//

import UIKit

class CreateProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var createProfileButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    var profile = Profile()
    
    var profileMO = ProfileMO()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Disable the create profile button so the user must
        // supply input.
        createProfileButton.isEnabled = false
        
        // Automatically display the keyboard and bind it to the nameTextField.
        nameTextField.becomeFirstResponder()
        
        // Set the return key type of the keyboard.
        nameTextField.returnKeyType = .done
        
        nameTextField.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textfield: UITextField) -> Bool {
        textfield.resignFirstResponder()
        
        if textfield.text != "" {
            createProfileButton.isEnabled = true
        } else {
            createProfileButton.isEnabled = false
        }
        
        return true
    }
    
    @IBAction func profilePictureImageViewTapHandler (propicImageView : UITapGestureRecognizer) {
        
        // If the user touches up inside.
        if propicImageView.state == .ended {
            
            
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
                
                imagePicker.delegate = self
                imagePicker.sourceType = .savedPhotosAlbum
                imagePicker.allowsEditing = true
                
                present(imagePicker, animated: true, completion: nil)
            }
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        profilePictureImageView.image = info[.originalImage] as! UIImage?
    }
    
    @IBAction func createProfileButtonAction(_ sender: UIButton) {
        
        profile.name = nameTextField.text
        profile.image = profilePictureImageView.image
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func loadProfileButtonAction(_ sender: UIButton) {
        
        profileMO.loadProfile(name: nameTextField.text!)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func deleteProfileButtonAction(_ sender: UIButton) {
        
        profileMO.deleteProfile(name: nameTextField.text!)
        
    }
}
