//
//  EditCategoriesViewModel.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 04.02.2024.
//

import Foundation

@Observable
class EditCategoriesViewModel {
    
    var state: EditCategoriesUiState = EditCategoriesUiState(categories: [], categoryTitle: "", editingModeOn: false)
    
    private var categories: [CategoryUiModel] = []//todo load
    
    func toggleEditMode() {
        state.editingModeOn.toggle()
    }
    
    func searchButtonClicked(categoryTitle: String) {
        if(categoryTitle.isEmpty) {
            state = state.copy(categories: self.categories, categoryTitle: categoryTitle)
        } else {
            var searchedCategories: [CategoryUiModel] = []
            categories.forEach { category in
                if(category.title.contains(categoryTitle)) {
                    searchedCategories.append(category)
                }
            }
            state = state.copy(categories: searchedCategories, categoryTitle: categoryTitle)
        }
    }
    
}
