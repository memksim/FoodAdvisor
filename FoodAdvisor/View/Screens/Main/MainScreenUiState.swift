//
//  MainScreenUiState.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 04.02.2024.
//

import Foundation

struct MainScreenUiState {
    let foods: [FoodUiModel]
    let categories: [CategoryUiModel]
    let foodOfDay: FoodUiModel?
    let searchedFoodName: String
    var filterBottomSheetVisible: Bool
}

extension MainScreenUiState {
    func copy(
        foods: [FoodUiModel]? = nil,
        categories: [CategoryUiModel]? = nil,
        foodOfDay: FoodUiModel? = nil,
        searchedFoodName: String? = nil,
        filterBottomSheetVisible: Bool? = nil
    ) -> MainScreenUiState {
        return MainScreenUiState(
            foods: foods ?? self.foods,
            categories: categories ?? self.categories,
            foodOfDay: foodOfDay ?? self.foodOfDay,
            searchedFoodName: searchedFoodName ?? self.searchedFoodName,
            filterBottomSheetVisible: filterBottomSheetVisible ?? self.filterBottomSheetVisible
        )
    }
}
