//
//  NetItemViewController.swift
//  LostnFound
//
//  Created by Ioane Sharvadze on 1/13/16.
//  Copyright © 2016 Ioane Sharvadze. All rights reserved.
//

import UIKit
import MapKit
import Parse

class NewItemViewController : UITableViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var LostOrFound: UISegmentedControl!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var Category: UIPickerView!
    @IBOutlet weak var Description: UITextView!
    @IBOutlet weak var PickedPlace: UILabel!
    @IBOutlet weak var Radius: UITextField!
    
    let categories = ["Animals/Pets","Bags, Baggage, Luggage","Clothing/jewelery","Electronics","Jewelry","Other"]
    
    lazy var alert : UIAlertController = {
        var alert = UIAlertController(
            title: nil,
            message : nil,
            preferredStyle: UIAlertControllerStyle.Alert
        )
        alert.addAction(UIAlertAction(title: "Got it", style: UIAlertActionStyle.Cancel, handler: nil))
        return alert
    }()
    
    var placeCoord : CLLocationCoordinate2D? {
        didSet {
            placeCoord?.getAddress() { (addr) -> Void in
                self.PickedPlace.text = addr
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backBtn = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: Selector("backPressed"))
        self.navigationItem.leftBarButtonItem = backBtn
        
        Category.dataSource = self
        Category.delegate = self
        Category.selectRow(categories.count/2, inComponent: 0, animated: false)
    }
    
    func backPressed() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func checkFields() ->Bool {
        return true
    }
    
    
    @IBAction func Add() {
        var radius : Int?
        if let input = Radius.text {
            radius = Int(input)
        }
        if placeCoord != nil && radius != nil {
            // send data.
            let newItem = Item()
            newItem.isLost = true
            if LostOrFound.titleForSegmentAtIndex(LostOrFound.selectedSegmentIndex)?.lowercaseString == "found" {
                newItem.isLost = false
            }
            newItem.radius = radius!
            newItem.location = PFGeoPoint(latitude: placeCoord!.latitude, longitude: placeCoord!.latitude)
            if let address = PickedPlace.text {
                newItem.locationAddress = address
            }
            newItem.additionalComment = Description.text
            newItem.category = categories[Category.selectedRowInComponent(0)]
            newItem.creator = PFUser.currentUser()!
            newItem.date = DatePicker.date
            newItem.saveEventually()
            performSegueWithIdentifier("Added Item", sender: self)
        } else {
            // show error dialog
            alert.title = "Try Again"
            alert.message = "Please pick place and fill radius."
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func PlacePicked(sender : UIStoryboardSegue) {
        // dont delete this. // todo may need this one
    }
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - Delegates and data sources
    
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
}

