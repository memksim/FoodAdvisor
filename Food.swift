//
//  Food.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 04.01.2024.
//
//

import Foundation
import CoreData


public class Food: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Food> {
        return NSFetchRequest<Food>(entityName: "Food")
    }

    @NSManaged public var name: String
    @NSManaged public var recipe: String
    @NSManaged public var image_urls: String
    @NSManaged public var category: NSSet?
    
    @objc(addCategoryObject:)
    @NSManaged public func addToCategory(_ value: Category)

    @objc(removeCategoryObject:)
    @NSManaged public func removeFromCategory(_ value: Category)

    @objc(addCategory:)
    @NSManaged public func addToCategory(_ values: NSSet)

    @objc(removeCategory:)
    @NSManaged public func removeFromCategory(_ values: NSSet)
}

