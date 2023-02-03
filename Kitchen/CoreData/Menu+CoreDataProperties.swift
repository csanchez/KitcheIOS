//
//  Menu+CoreDataProperties.swift
//  Kitchen
//
//  Created by Tecnologias iis on 03/02/23.
//
//

import Foundation
import CoreData


extension Menu {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Menu> {
        return NSFetchRequest<Menu>(entityName: "Menu")
    }

    @NSManaged public var descripcion: String?
    @NSManaged public var name: String?

}

extension Menu : Identifiable {

}
