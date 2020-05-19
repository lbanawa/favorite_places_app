//
//  PlacesVC.swift
//  FavoritePlacesApp
//
//  Created by Lauren Banawa on 5/19/20.
//  Copyright © 2020 Lauren Banawa. All rights reserved.
//

import UIKit

class PlacesVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
    }
    
    @objc func addButtonClicked(){
        // segue to add places view controller
    }
    

}
