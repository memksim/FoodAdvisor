//
//  CategoryUiModel.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 05.01.2024.
//

import Foundation
import SwiftUI

struct CategoryUiModel: Identifiable, Hashable {
    let id: UUID
    var title: String
    var selected: Bool
}

extension CategoryUiModel {
    static func contains(
        what checked: CategoryUiModel,
        in categories: [CategoryUiModel]
    ) -> Bool {
        var result = false
        for category in categories {
            if(category.id == checked.id && category.title == checked.title) {
                result = true
                break
            }
        }
        return result
    }
    
    static func checkAllCategoriesUnselected(
        _ categories: [CategoryUiModel]
    ) -> Bool {
        var result = true
        for category in categories {
            if(category.selected) {
                result = false
                break
            }
        }
        return result
    }
    
}

extension [CategoryUiModel] {
    func selectedCategoriesCount() -> Int {
        var count = 0
        self.forEach{ category in
            if(category.selected) {
                count += 1
            }
        }
        return count
    }
    
    func toTitle() -> String {
        var result = ""
        if(!self.isEmpty) {
            self.forEach { category in
                if(category.selected) {
                    result.append("\(category.title)/")
                }
            }
            result.removeLast()
        } else {
            return "Нет выбранных категорий"
        }
        return result
    }
}
