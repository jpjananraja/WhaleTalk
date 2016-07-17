//
//  Message+CoreDataProperties.swift
//  WhaleTalk
//
//  Created by Janan Rajaratnam on 6/21/16.
//  Copyright © 2016 Janan Rajaratnam. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Message {

    @NSManaged var text: String?
    @NSManaged var timestamp: NSDate?
    @NSManaged var chat: Chat?
    @NSManaged var sender: Contact?

}
