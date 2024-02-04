//
//  Router.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 04.02.2024.
//

import Foundation

final class Router: ObservableObject {
    
    static let instance = Router()
    
    @Published var path = [Route]()
    
    private init(){}
    
    func navigateToEditCategoriesScreen() {
        path.append(.editCategories)
    }
    
    func navigateToNewFoodScreen() {
        path.append(.newFood)
    }
    
    func navigateToFoodInfoScreen(food: FoodUiModel) {
        path.append(.foodInfo(food: food))
    }
    
    func navigateToMainScreen() {
        path.removeAll()
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
}

