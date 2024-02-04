//
//  CategoryTitleView.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 05.01.2024.
//

import SwiftUI

struct CategoryTitleView: View {
    
    @State var category: CategoryUiModel
    var doOnSelect: (_ category: CategoryUiModel) -> Void
        
    var body: some View {
        Button(action: {
            category.selected.toggle()
            doOnSelect(category)
        }, label: {
            Text(category.title)
                .padding()
                .background(category.selected ? Color.orange : Color.gray)
                .fixedSize(horizontal: false, vertical: true)
                .clipShape(
                    RoundedRectangle(cornerRadius: 16)
                )
                .foregroundStyle(.white)
                .font(.footnote)
        })
    }
    
}

