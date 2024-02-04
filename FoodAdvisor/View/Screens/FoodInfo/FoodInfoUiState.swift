//
//  FoodInfoUiState.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 04.02.2024.
//

import Foundation

struct FoodInfoUiState {
    let categories: [CategoryUiModel]
    var food: FoodUiModel
    var bottomSheetVisible: Bool
    var editingModeOn: Bool
}

extension FoodInfoUiState {
    func copy(
        categories: [CategoryUiModel]? = nil,
        food: FoodUiModel? = nil,
        bottomSheetVisible: Bool? = nil,
        editingModeOn: Bool? = nil
    ) -> FoodInfoUiState {
        return FoodInfoUiState(
            categories: categories ?? self.categories,
            food: food ?? self.food,
            bottomSheetVisible: bottomSheetVisible ?? self.bottomSheetVisible,
            editingModeOn: editingModeOn ?? self.editingModeOn
        )
    }
}
