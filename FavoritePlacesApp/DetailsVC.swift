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
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromParse()
    }
    
    func getDataFromParse() {
        
        let query = PFQuery(className: "Places")
        // filter the results
        query.whereKey("objectId", equalTo: chosenLocationId)
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                
            } else {
                if objects != nil {
                    if objects!.count > 0 {
                        let chosenLocationObject = objects![0]
                        
                        if let locationName = chosenLocationObject.object(forKey: "name") as? String {
                            self.detailsNameLabel.text = locationName
                        }
                        
                        if let locationType = chosenLocationObject.object(forKey: "type") as? String {
                            self.detailsTypeLabel.text = locationType
                        }
                        
                        if let locationDescription = chosenLocationObject.object(forKey: "description") as? String {
                            self.detailsDescriptionTextView.text = locationDescription
                        }
                        
                        if let locationLatitude = chosenLocationObject.object(forKey: "latitude") as? String {
                            if let locationLatitudeDouble = Double(locationLatitude) {
                                self.chosenLatitude = locationLatitudeDouble
                            }
                        }
                        
                        if let locationLongitude = chosenLocationObject.object(forKey: "longitude") as? String {
                            if let locationLongitudeDouble = Double(locationLongitude) {
                                self.chosenLongitude = locationLongitudeDouble
                            }
                        }
                        
                        if let imageData = chosenLocationObject.object(forKey: "image") as? PFFileObject {
                            imageData.getDataInBackground { (data, error) in
                                if error == nil {
                                    if data != nil {
                                        self.detailsImageView.image = UIImage(data: data!)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    
}
