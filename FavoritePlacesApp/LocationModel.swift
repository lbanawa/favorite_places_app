//
//  LocationModel.swift
//  FavoritePlacesApp
//
//  Created by Lauren Banawa on 5/20/20.
//  Copyright © 2020 Lauren Banawa. All rights reserved.
//

import Foundation
import UIKit

class LocationModel {
    
    // create the only instance of this class
    // can only change variables in this single instance
    static let sharedInstance = LocationModel()
    
    var locationName = ""
    var locationType = ""
    var locationDescription = ""
    var locationImage = UIImage()
    
    private init(){}
    
    
}
