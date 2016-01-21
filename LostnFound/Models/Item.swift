//
//  Item.swift
//  LostnFound
//
//  Created by გათი პეტრიაშვილი on 13-01-2016.
//  Copyright © 2016 Ioane Sharvadze. All rights reserved.
//

import Foundation
import Parse

class Item : PFObject, PFSubclassing{
    
    @NSManaged var isLost: Bool
    @NSManaged var date: NSDate
    /** thats me, who created the item. */
    @NSManaged var creator: PFUser
    /**
     * The user who I will contact.
     * (If I lost , resolver is founder of item, If I found resolver is item owner)
     */
    @NSManaged var resolver: PFUser
    @NSManaged var radius: NSNumber
    @NSManaged var location: PFGeoPoint
    @NSManaged var category: NSString
    @NSManaged var locationAddress: NSString
    @NSManaged var additionalComment: NSString
    
    static func parseClassName() -> String {
        return "Item"
    }
    
    static func getQuery(queryLostItems : Bool) -> PFQuery? {
        return Item.query()?.whereKey("creator", equalTo: PFUser.currentUser()!)
            .whereKey("isLost", equalTo: queryLostItems)
    }
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
}
