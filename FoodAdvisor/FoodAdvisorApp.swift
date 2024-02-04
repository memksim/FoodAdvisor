//
//  FoodAdvisorApp.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 04.01.2024.
//

import SwiftUI

@main
struct FoodAdvisorApp: App {
    @ObservedObject var router = Router.instance
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                MainScreen()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                            case .foodInfo(let food): FoodInfoScreen(food: food)
                            case .newFood: NewFoodScreen()
                            case .editCategories: EditCategoriesScreen()
                            case .main: MainScreen()
                        }
                    }
            }
            ContentView()
        }
    }
}
