//
//  User+CoreDataProperties.swift
//  Kitchen
//
//  Created by Tecnologias iis on 03/02/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var address: String?
    @NSManaged public var email: String?
    @NSManaged public var name: String?

}

extension User : Identifiable {

}
