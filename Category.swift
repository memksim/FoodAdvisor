//
//  Category.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 04.01.2024.
//
//

import Foundation
import CoreData


public class Category: NSManagedObject, Identifiable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var title: String
    @NSManaged public var food: NSSet?

    
    @objc(addFoodObject:)
    @NSManaged public func addToFood(_ value: Food)

    @objc(removeFoodObject:)
    @NSManaged public func removeFromFood(_ value: Food)

    @objc(addFood:)
    @NSManaged public func addToFood(_ values: NSSet)

    @objc(removeFood:)
    @NSManaged public func removeFromFood(_ values: NSSet)
}
