//
//  EditCategoriesScreen.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 25.01.2024.
//

import SwiftUI

struct EditCategoriesScreen: View {
        
    let categories: [CategoryUiModel]
    @State private var searchedCategories: [CategoryUiModel]
    @State private var categoryTitle: String = ""
    @State private var editModeOn: Bool = false
    
    init(categories: [CategoryUiModel]) {
        self.categories = categories
        self._searchedCategories = State(initialValue: categories)
    }
    
    var body: some View {
        VStack {
            Button(
                action: {
                    editModeOn.toggle()
                },
                label: {
                    Text(editModeOn ? "Готово" : "Редактировать")
                        .foregroundStyle(.orange)
                }
            ).frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 18)
            SearchFieldView { categoryTitle in
                self.categoryTitle = categoryTitle
                if(categoryTitle.isEmpty) {
                    searchedCategories = categories
                } else {
                    searchedCategories.removeAll()
                    categories.forEach { category in
                        if(category.title.contains(categoryTitle)) {
                            searchedCategories.append(category)
                        }
                    }
                }
            }.padding(.init(top: 12, leading: 16, bottom: 0, trailing: 16))
            if(searchedCategories.isEmpty) {
                Button(
                    action: {
                        //todo
                    },
                    label: {
                        HStack {
                            Image(systemName: "plus")
                                .foregroundStyle(.gray)
                            Text(categories.isEmpty ? "Добавьте новую категорию" : "Добавить категорию \(categoryTitle)")
                                .foregroundStyle(.gray)
                        }.frame(maxWidth: .infinity, alignment: .leading)
                    }
                ).padding()
            }
            ScrollView {
                LazyVStack {
                    ForEach(searchedCategories, id: \.id) { category in
                        HStack {
                            Text(category.title)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            if(editModeOn){
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
                        if(searchedCategories.last != category) {
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
    EditCategoriesScreen(
        categories: mockCategories
    )
}
