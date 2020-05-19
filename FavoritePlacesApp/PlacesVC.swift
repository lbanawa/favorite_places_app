//
//  PlacesVC.swift
//  FavoritePlacesApp
//
//  Created by Lauren Banawa on 5/19/20.
//  Copyright © 2020 Lauren Banawa. All rights reserved.
//

import UIKit
import Parse

class PlacesVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "L O G O U T", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutButtonClicked))
        
    }
    
    @objc func addButtonClicked() {
        // segue to add places view controller
    }
    
    @objc func logoutButtonClicked() {
        // logout with block so that if you lose internet connection you can show the error to the user
        PFUser.logOutInBackground { (error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                self.performSegue(withIdentifier: "toSignInVC", sender: nil)
            }
        }
    }
    

}
