//
//  MainScreenViewModel.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 04.02.2024.
//

import Foundation

@Observable
class MainScreenViewModel {
    
    var state: MainScreenUiState = MainScreenUiState(
        foods: [],
        categories: [],
        foodOfDay: nil,
        searchedFoodName: "",
        filterBottomSheetVisible: false
    )
    
    private var foods: [FoodUiModel] = [] //todo load in init
    private var categories: [CategoryUiModel] = []
    private let router = Router.instance
    
    func navigateToNewFoodScreen() {
        router.navigateToNewFoodScreen()
    }
    
    func navigateToCategoriesSettingsScreen() {
        router.navigateToEditCategoriesScreen()
    }
    
    func showHideFilterBottomSheet() {
        state.filterBottomSheetVisible.toggle()
    }
    
    func filterFoodsByCatefories(categories: [CategoryUiModel]) {
        var filteredFoods: [FoodUiModel] = []
        if(categories.checkAllCategoriesUnselected()) {
            state = state.copy(foods: foods, categories: categories)
        } else {
            categories.forEach { category in
                foods.forEach { food in
                    if (CategoryUiModel.contains(what: category, in: food.categories) && category.selected) {
                        filteredFoods.append(food)
                    }
                }
            }
            state = state.copy(foods: filteredFoods, categories: categories)
        }
    }
    
    func findFoodsByName(foodName: String) {
        if(foodName.isEmpty) {
            state = state.copy(foods: self.foods, searchedFoodName: foodName)
        } else {
            var filteredFoods: [FoodUiModel] = []
            foods.forEach { food in
                if(food.name.contains(foodName)) {
                    filteredFoods.append(food)
                }
            }
            state = state.copy(foods: filteredFoods, searchedFoodName: foodName)
        }
    }
    
    private func loadData() {
        //todo
    }
    
}


