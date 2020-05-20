//
//  MapVC.swift
//  FavoritePlacesApp
//
//  Created by Lauren Banawa on 5/19/20.
//  Copyright © 2020 Lauren Banawa. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "S A V E", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "< B A C K", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonClicked))
    }
    
    @objc func saveButtonClicked() {
        
    }
    
    @objc func backButtonClicked() {
        self.dismiss(animated: true, completion: nil) // dismiss current view controller
    }
    
}
