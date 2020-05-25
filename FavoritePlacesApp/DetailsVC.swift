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

class DetailsVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
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
        detailsMapView.delegate = self
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
                        
                        // Objects
                        
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
                        
                        // Maps
                        
                        let location = CLLocationCoordinate2D(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
                        let span = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
                        let region = MKCoordinateRegion(center: location, span: span)
                        self.detailsMapView.setRegion(region, animated: true)
                        
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = location
                        annotation.title = self.detailsNameLabel.text!
                        annotation.subtitle = self.detailsTypeLabel.text!
                        self.detailsMapView.addAnnotation(annotation)
                        
                    }
                }
            }
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
        if pinView == nil {
            
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true // will show button
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        } else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // open navigation
        if self.chosenLongitude != 0.0 && self.chosenLatitude != 0.0 {
            let requestLocation = CLLocation(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
            
            // convert place names to coordinates and vice versa
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                if let placemark = placemarks{
                    
                    if placemark.count > 0 {
                        // description of chosen location
                        let mkPlaceMark = MKPlacemark(placemark: placemark[0])
                        let mapItem = MKMapItem(placemark: mkPlaceMark)
                        mapItem.name = self.detailsNameLabel.text
                        
                        // show user how to get to location -- default set to driving directions
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                        
                        mapItem.openInMaps(launchOptions: launchOptions)
                    }
                }
            }
            
        }
    }
    
}
