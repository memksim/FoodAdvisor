//
//  NewFoodViewModel.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 04.02.2024.
//

import Foundation

@Observable
class NewFoodViewModel {
    
    var state: NewFoodUiState = NewFoodUiState(
        editMode: .insert,
        categories: [],
        imageUrls: [],
        foodName: "",
        bottomSheetVisible: false,
        recipe: ""
    )
    
    private let categories: [CategoryUiModel] = []
    private let router = Router.instance
    
    func changeEditMode() {
        var editMode = state.editMode
        switch(state.editMode) {
            case .edit : editMode = .view
            case .insert : editMode = .view
            case .view: editMode = .edit
        }
        state = state.copy(editMode: editMode)
    }
    
    func toggleBottomSheetVisible() {
        state.bottomSheetVisible.toggle()
    }
    
    func updateSelectedCategories(selectedCategories: [CategoryUiModel]) {
        if(selectedCategories.count >= 1) {
            state = state.copy(categories: selectedCategories)
        }
    }
    
    func navigateToCategoriesSettingsScreen() {
        router.navigateToEditCategoriesScreen()
    }
    
}
