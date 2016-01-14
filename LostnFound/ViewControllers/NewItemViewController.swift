//
//  NetItemViewController.swift
//  LostnFound
//
//  Created by Ioane Sharvadze on 1/13/16.
//  Copyright © 2016 Ioane Sharvadze. All rights reserved.
//

import UIKit

class NewItemViewController : UITableViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var LostOrFound: UISegmentedControl!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var PlaceDescription: UILabel!
    @IBOutlet weak var Category: UIPickerView!
    @IBOutlet weak var Description: UITextView!
    
    
    let categories = ["Animals/Pets","Bags, Baggage, Luggage","Clothing/jewelery","Electronics","Jewelry","Other"]
    
    
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
        
    }
    
    @IBAction func PickPlace() {
        
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
