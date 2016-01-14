//
//  PlacePickerViewController.swift
//  LostnFound
//
//  Created by Ioane Sharvadze on 1/14/16.
//  Copyright © 2016 Ioane Sharvadze. All rights reserved.
//

import UIKit
import MapKit

class PlacePickerViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var chosenCoord : CLLocationCoordinate2D?
    
    
    lazy var alert : UIAlertController = {
        var alert = UIAlertController(
            title: "Note",
            message : "Long press to Pick Place",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        alert.addAction(UIAlertAction(title: "Got it", style: UIAlertActionStyle.Cancel, handler: nil))
        return alert
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pick Place"
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        mapView.delegate = self
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func addDoneButton() {
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: Selector("donePressed"))
        self.navigationItem.rightBarButtonItem = doneBtn
    }
    
    func donePressed() {
        performSegueWithIdentifier("place picked", sender: self)
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        mapView.setRegion(region, animated: true)
    }

    @IBAction func LongPress(sender: UILongPressGestureRecognizer) {
        if chosenCoord != nil {
            return
        }
        if sender.state == UIGestureRecognizerState.Ended {
            let touchPoint = sender.locationInView(mapView)
            chosenCoord = mapView.convertPoint(touchPoint, toCoordinateFromView: mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = chosenCoord!
            mapView.addAnnotation(annotation)
            addDoneButton()
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "dropped pin")
        annotationView.draggable = true
        return annotationView
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, didChangeDragState newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        chosenCoord = view.annotation?.coordinate
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dest = segue.destinationViewController as? NewItemViewController {
            dest.placeCoord = chosenCoord
        }
    }


}

extension CLLocationCoordinate2D {
    
    func getAddress(callback : (String?) -> Void) {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            let dict = placemarks?[0].addressDictionary
            
            var addr = ""
            if let country = dict?["Country"] {
                addr += country as! String
            }

            if let city = dict?["City"] {
                addr += "," + (city as! String)
            }
            callback(addr)
        })
    }

}
