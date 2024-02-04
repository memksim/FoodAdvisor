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

// Расширения для категории

extension CategoryUiModel {
    // Проверяет наличие категории в массиве
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
    
}

// Расширения для массива категорий

extension [CategoryUiModel] {
    
    // Проверяет у всех ли элементов в массиве значение selected = false
    func checkAllCategoriesUnselected() -> Bool {
        if(self.first{ category in category.selected } == nil) {
            return true
        } else {
            return false
        }
    }
    
    // Возвращает кол-во элементов с полем selected = true
    func selectedCategoriesCount() -> Int {
        var count = 0
        self.forEach{ category in
            if(category.selected) {
                count += 1
            }
        }
        return count
    }
    
    // Приводит массив категорий к виду название1/название2/.../названиеN
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
