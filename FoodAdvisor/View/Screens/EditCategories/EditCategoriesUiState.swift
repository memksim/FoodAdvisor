//
//  EditCategoriesUiState.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 04.02.2024.
//

import Foundation

struct EditCategoriesUiState {
    let categories: [CategoryUiModel]
    let categoryTitle: String
    var editingModeOn: Bool
}

extension EditCategoriesUiState {
    func copy(
        categories: [CategoryUiModel]? = nil,
        categoryTitle: String? = nil,
        editingModeOn: Bool? = nil
    ) -> EditCategoriesUiState {
        return EditCategoriesUiState(
            categories: categories ?? self.categories,
            categoryTitle: categoryTitle ?? self.categoryTitle,
            editingModeOn: editingModeOn ?? self.editingModeOn
        )
    }
}
