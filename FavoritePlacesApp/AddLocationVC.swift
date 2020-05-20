//
//  AddLocationVC.swift
//  FavoritePlacesApp
//
//  Created by Lauren Banawa on 5/19/20.
//  Copyright © 2020 Lauren Banawa. All rights reserved.
//

import UIKit

class AddLocationVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var locationNameText: UITextField!
    @IBOutlet weak var locationTypeText: UITextField!
    @IBOutlet weak var locationDescriptionText: UITextView!
    @IBOutlet weak var locationImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        locationImageView.addGestureRecognizer(gestureRecognizer)

        
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toMapVC", sender: nil)
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
