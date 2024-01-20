//
//  FoodUiModel.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 05.01.2024.
//

import Foundation

struct FoodUiModel: Identifiable, Hashable {
    
    let id: UUID
    var name: String
    var recipe: String
    var image_urls: [String]?
    var categories: [CategoryUiModel]
    
}


