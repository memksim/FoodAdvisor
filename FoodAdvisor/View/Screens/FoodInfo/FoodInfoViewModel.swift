//
//  FoodInfoViewModel.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 04.02.2024.
//

import Foundation

@Observable
class FoodInfoViewModel {
    
    var state: FoodInfoUiState
    
    private let food: FoodUiModel
    private let categories: [CategoryUiModel] = []
    private let router = Router.instance
    
    init(food: FoodUiModel) {
        self.food = food
        self.state = FoodInfoUiState(
            categories: [],
            food: food,
            bottomSheetVisible: false,
            editingModeOn: false
        )
    }
    
    func navigateToCategoriesSettingsScreen() {
        router.navigateToEditCategoriesScreen()
    }
    
    func toggleEditingMode() {
        state.editingModeOn.toggle()
    }
    
    func toggleBottomSheetVisible() {
        state.bottomSheetVisible.toggle()
    }
    
    func removeImage(imageUrl: String) {
        if let index = state.food.image_urls?.firstIndex(of: imageUrl) {
            state.food.image_urls?.remove(at: index)
        }
    }
    
    func updateSelectedCategories(selectedCategories: [CategoryUiModel]) {
        if(selectedCategories.count >= 1) {
            state = state.copy(categories: selectedCategories)
        }
    }
    
}
