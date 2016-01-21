//
//  FoundTableViewController.swift
//  LostnFound
//
//  Created by გათი პეტრიაშვილი on 12-01-2016.
//  Copyright © 2016 Ioane Sharvadze. All rights reserved.
//

import UIKit

class FoundTableViewController: UITableViewController {
    
    var foundItems = [] {
        didSet {
            // when new items are fetched reload data.
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queryItems()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        //self.navigationItem.leftBarButtonItem = self.editButtonItem()
        let addNew = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: Selector("btnAddNewLostItem"))
        self.navigationItem.rightBarButtonItem = addNew
        
        self.refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func btnAddNewLostItem() {
        let newItemViewController = self.storyboard?.instantiateViewControllerWithIdentifier("New Item Nav")
        self.presentViewController(newItemViewController!, animated: true, completion: nil)
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        queryItems()
        refreshControl.endRefreshing()
    }
    
    func queryItems() {
        Item.getQuery(false)?.findObjectsInBackgroundWithBlock { [unowned self]
            (objects, error) in
            if let objects = objects {
                self.foundItems = objects
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        queryItems()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1 // სატესტოდ
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foundItems.count // სატესტოდ
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("foundItem", forIndexPath: indexPath)
        
        // Configure the cell...
        let foundItem = foundItems[indexPath.row] as! Item
        cell.textLabel?.text = foundItem.category as String
        cell.detailTextLabel?.text = foundItem.locationAddress as String
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
