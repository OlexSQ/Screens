//
//  Screen+CoreDataProperties.swift
//  Screens
//
//  Created by Mac on 27.10.2022.
//
//

import Foundation
import CoreData


extension Screen {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Screen> {
        return NSFetchRequest<Screen>(entityName: "Screen")
    }

    @NSManaged public var name: String?
    @NSManaged public var numberOfViews: Int32

}

extension Screen : Identifiable {

}
