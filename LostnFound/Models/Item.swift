//
//  Item.swift
//  LostnFound
//
//  Created by გათი პეტრიაშვილი on 13-01-2016.
//  Copyright © 2016 Ioane Sharvadze. All rights reserved.
//

import Foundation

class Item {

    var name: String?
    var tags: Array<String?>
    var location: String?
    var id: Int?
    
    init(name: String?, tags: Array<String?>, location: String?) {
        self.name = name
        self.tags = tags
        self.location = location
        self.id = random()
    }
    

}
