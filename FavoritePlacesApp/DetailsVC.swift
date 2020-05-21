//
//  DetailsVC.swift
//  FavoritePlacesApp
//
//  Created by Lauren Banawa on 5/19/20.
//  Copyright © 2020 Lauren Banawa. All rights reserved.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController {
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var detailsNameLabel: UILabel!
    @IBOutlet weak var detailsMapView: MKMapView!
    @IBOutlet weak var detailsTypeLabel: UILabel!
    @IBOutlet weak var detailsDescriptionTextView: UITextView!
    
    var chosenLocationId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = PFQuery(className: "Places")
        // filter the results
        query.whereKey("objectId", equalTo: chosenLocationId)
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                
            } else {
                print(objects)
            }
        }

        
    }
    

}
