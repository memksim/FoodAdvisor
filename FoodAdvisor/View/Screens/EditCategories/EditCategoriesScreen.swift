//
//  EditCategoriesScreen.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 25.01.2024.
//

import SwiftUI

struct EditCategoriesScreen: View {
        
    @State private var viewModel = EditCategoriesViewModel()
    
    var body: some View {
        VStack {
            Button(
                action: viewModel.toggleEditMode,
                label: {
                    Text(viewModel.state.editingModeOn ? "Готово" : "Редактировать")
                        .foregroundStyle(.orange)
                }
            ).frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 18)
            SearchFieldView(doOnSearchClicked: viewModel.searchButtonClicked)
                .padding(.init(top: 12, leading: 16, bottom: 0, trailing: 16))
            if(viewModel.state.categories.isEmpty) {
                Button(
                    action: {
                        //todo
                    },
                    label: {
                        HStack {
                            Image(systemName: "plus")
                                .foregroundStyle(.gray)
                            Text("Создать категорию \(viewModel.state.categoryTitle)")
                                .foregroundStyle(.gray)
                        }.frame(maxWidth: .infinity, alignment: .leading)
                    }
                ).padding()
            }
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.state.categories, id: \.id) { category in
                        HStack {
                            Text(category.title)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            if(viewModel.state.editingModeOn){
                                Button(
                                    action: {
                                        //todo delete item
                                    }, 
                                    label: {
                                        Image(systemName: "trash")
                                            .foregroundStyle(.red)
                                    }
                                )
                            }
                        }
                        if(viewModel.state.categories.last != category) {
                            Divider()
                        }
                    }
                }
            }.padding(.init(top: 8, leading: 16, bottom: 0, trailing: 16))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color("SheetBackgroundColor"))
    }
}

private struct SearchFieldView: View {
    
    @State private var categoryTitle: String = ""
    var doOnSearchClicked: (String) -> Void
    
    var body: some View {
        HStack {
            TextField("Найдите или создайте категорию", text: $categoryTitle)
            Button(
                action: {
                    if(!categoryTitle.isEmpty) {
                        doOnSearchClicked(categoryTitle)
                    }
                },
                label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(categoryTitle.isEmpty ? .gray : .orange)
                }
            )
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 16.0)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}

#Preview {
    EditCategoriesScreen()
}
