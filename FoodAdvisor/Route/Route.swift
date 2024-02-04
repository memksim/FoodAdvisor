//
//  Route.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 04.02.2024.
//

import Foundation

enum Route: Hashable {
    case foodInfo(food: FoodUiModel)
    case newFood
    case editCategories
    case main
}
