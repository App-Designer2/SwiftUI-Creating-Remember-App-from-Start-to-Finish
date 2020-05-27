//
//  Remmebers+CoreDataProperties.swift
//  Remember
//
//  Created by App-Designer2 . on 12.05.20.
//  Copyright © 2020 App-Designer2. All rights reserved.
//
//

import Foundation
import CoreData


extension Remmebers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Remmebers> {
        return NSFetchRequest<Remmebers>(entityName: "Remmebers")
    }

    @NSManaged public var names: String?
    @NSManaged public var imageD: Data?
    @NSManaged public var detail: String?
    @NSManaged public var date: String?
    @NSManaged public var favo: Int32
    @NSManaged public var loved: Bool

}
