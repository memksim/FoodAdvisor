//
//  NewFoodUiState.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 04.02.2024.
//

import Foundation

struct NewFoodUiState {
    let editMode: NewFoodEditMode
    let categories: [CategoryUiModel]
    var imageUrls: [URL?]
    var foodName: String
    var bottomSheetVisible: Bool
    var recipe: String
}

extension NewFoodUiState {
    func copy(
        editMode: NewFoodEditMode? = nil,
        categories: [CategoryUiModel]? = nil,
        imageUrls: [URL?]? = nil,
        foodName: String? = nil,
        bottomSheetVisible: Bool? = nil,
        recipe: String? = nil
    ) -> NewFoodUiState {
        return NewFoodUiState(
            editMode: editMode ?? self.editMode,
            categories: categories ?? self.categories,
            imageUrls: imageUrls ?? self.imageUrls,
            foodName: foodName ?? self.foodName,
            bottomSheetVisible: bottomSheetVisible ?? self.bottomSheetVisible,
            recipe: recipe ?? self.recipe
        )
    }
}
