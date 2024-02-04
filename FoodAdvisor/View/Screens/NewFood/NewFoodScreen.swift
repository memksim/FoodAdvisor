//
//  NewFoodScreen.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 20.01.2024.
//

import SwiftUI

struct NewFoodScreen: View {
    
    @State private var foodName = "Название блюда"
    @State private var imageUrls: [URL?] = []
    @State private var state: NewFoodScreenState = .insert
    @State private var categories: [CategoryUiModel] = []
    @State private var sheetOpened = false
    @State private var recipe = ""
    
    var body: some View {
        VStack {
            HStack {
                if(state == .edit || state == .insert) {
                    TextField("Название блюда", text: $foodName)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title)
                        .foregroundStyle(Color("TitleTextColor"))
                        .padding(.leading, 24)
                } else {
                    Text(foodName)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title)
                        .foregroundStyle(Color("TitleTextColor"))
                        .padding(.leading, 24)
                }
                Button(action: {
                    switch(state) {
                        case .edit : state = .view
                        case .insert : state = .view
                        case .view: state = .edit
                    }
                }, label: {
                    Text(state == .view ? "Изменить" : (state == .edit ? "Готово" : "Сохранить"))
                        .foregroundStyle(.orange)
                        .padding(.trailing, 24)
                })
            }
            if(state == .edit || state == .insert){
                Button(action: {
                    sheetOpened.toggle()
                }, label: {
                    HStack() {
                        Text(categories.toTitle())
                            .foregroundStyle(Color("TitleTextColor"))
                            .padding(.leading, 24)
                        Image(systemName: "pencil")
                            .foregroundStyle(.orange)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                })
                .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                Text(categories.toTitle())
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    .foregroundStyle(Color("TitleTextColor"))
                    .padding(.leading, 24)
            }
            AddImagesView(
                imagesUrls: $imageUrls,
                state: $state
            )
            Text("Рецепт")
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .foregroundStyle(Color("TitleTextColor"))
                .padding(.init(top: 36, leading: 24, bottom: 0, trailing: 0))
                .font(.title2)
            ScrollView {
                if(state == .edit || state == .insert) {
                    TextField("Рецепт", text: $recipe)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.init(top: 4, leading: 24, bottom: 0, trailing: 0))
                } else {
                    Text(recipe)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.init(top: 4, leading: 24, bottom: 0, trailing: 0))
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color("SheetBackgroundColor"))
        .sheet(isPresented: $sheetOpened) {
            FilterBottomSheetView(
                categories: categories,
                doOnApplyClicked: { selectedCategories in
                    if(selectedCategories.selectedCategoriesCount() != 0) {
                        self.categories = selectedCategories
                    }
                }
            )
            .presentationDetents([.height(250)])
            .presentationCornerRadius(25)
        }
    }
}

#Preview {
    NewFoodScreen()
}
