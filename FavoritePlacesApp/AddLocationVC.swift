//
//  AddLocationVC.swift
//  FavoritePlacesApp
//
//  Created by Lauren Banawa on 5/19/20.
//  Copyright © 2020 Lauren Banawa. All rights reserved.
//

import UIKit


class AddLocationVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    @IBOutlet weak var locationNameText: UITextField!
    @IBOutlet weak var locationTypeText: UITextField!
    @IBOutlet weak var locationDescriptionText: UITextView!
    @IBOutlet weak var locationImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        locationImageView.addGestureRecognizer(gestureRecognizer)
        
        locationDescriptionText.text = "LOCATION"
        locationDescriptionText.textColor = UIColor.lightGray

        
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        if locationNameText.text != "" && locationTypeText.text != "" && locationDescriptionText.textColor == UIColor.lightGray {
            if let chosenImage = locationImageView.image {
                let locationModel = LocationModel.sharedInstance
                locationModel.locationName = locationNameText.text!
                locationModel.locationType = locationTypeText.text!
                locationModel.locationImage = chosenImage
                
                locationDescriptionText.text = nil
                locationDescriptionText.textColor = UIColor.darkGray
                
                
            }
            
            if locationDescriptionText.text.isEmpty {
                locationDescriptionText.text = "LOCATION NOTES"
                locationDescriptionText.textColor = UIColor.lightGray
            }
            
            
            self.performSegue(withIdentifier: "toMapVC", sender: nil)
            
        } else {
            let alert = UIAlertController(title: "Error", message: "Missing text entry!", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    @objc func chooseImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    // specify what will happen after user chooses image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        locationImageView.image =  info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
}
