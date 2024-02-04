//
//  FoodInfoScreen.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 05.01.2024.
//

import SwiftUI

struct FoodInfoScreen: View {
    
    @State private var editingModeOn = true
    @State private var index = 0
    @State private var stateFood: FoodUiModel
    @State private var sheetOpened = false
    @State private var categories: [CategoryUiModel]
    
    let food: FoodUiModel
    
    init(food: FoodUiModel, categories: [CategoryUiModel]) {
        self.food = food
        self._stateFood = State(initialValue: food)
        self._categories = State(initialValue: categories.map { category in
            return CategoryUiModel(
                id: category.id,
                title: category.title,
                selected: food.categories.contains(category)
            )
        })
    }
    
    var body: some View {
        VStack(){
            HStack {
                if(editingModeOn) {
                    TextField("Название блюда", text: $stateFood.name)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .font(.title)
                        .foregroundStyle(Color("TitleTextColor"))
                        .padding(.leading, 24)
                } else {
                    Text(stateFood.name)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .font(.title)
                        .foregroundStyle(Color("TitleTextColor"))
                    .padding(.leading, 24)
                }
                Button(action: {
                    editingModeOn.toggle()
                    index = 0
                }, label: {
                    Text(editingModeOn ? "Готово" : "Изменить")
                        .padding(.trailing, 24)
                        .foregroundStyle(.orange)
                })
            }
            if(editingModeOn) {
                Button(
                    action: {
                        sheetOpened.toggle()
                    },
                    label: {
                        HStack() {
                            Text(categories.toTitle())
                                .foregroundStyle(Color("TitleTextColor"))
                                .padding(.leading, 24)
                            Image(systemName: "pencil")
                                .foregroundStyle(.orange)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                })
            } else {
                Text(categories.toTitle())
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    .foregroundStyle(Color("TitleTextColor"))
                    .padding(.leading, 24)
            }
            HStack {
                if (stateFood.image_urls == nil || stateFood.image_urls?.isEmpty == false) {
                    PagingAsyncImagesView(
                        imagesUrlArray: stateFood.image_urls!,
                        editingModeOn: $editingModeOn,
                        index: $index,
                        onRemoveImage: { imageUrl in
                            if(imageUrl != nil) {
                                if let index = stateFood.image_urls?.firstIndex(of: imageUrl!) {
                                    print("on remove \(imageUrl!), index \(index)")
                                    stateFood.image_urls?.remove(at: index)
                                }
                            }
                        }
                    ).frame(maxHeight: 250)
                } else {
                    Image(systemName: "photo.badge.plus")
                        .font(.system(size: 100))
                        .frame(maxHeight: 250)
                }
            }
            Text("Рецепт")
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .foregroundStyle(Color("TitleTextColor"))
                .padding(.init(top: 36, leading: 24, bottom: 0, trailing: 0))
                .font(.title2)
            ScrollView {
                if(editingModeOn) {
                    TextField("Рецепт", text: $stateFood.recipe)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.init(top: 4, leading: 24, bottom: 0, trailing: 0))
                } else {
                    Text(stateFood.recipe)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.init(top: 4, leading: 24, bottom: 0, trailing: 0))
                }
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .topLeading)
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
    FoodInfoScreen(
        food: FoodUiModel(
            id: UUID(),
            name: "Спагенти",
            recipe: "Сварить спагенти",
            image_urls: [
            "https://img1.russianfood.com/dycontent/images_upl/554/big_553606.jpg",
            "https://img.freepik.com/free-photo/sausages-in-the-dough_2829-8405.jpg?w=2000&t=st=1704451812~exp=1704452412~hmac=4e3f2e1870c79d2db4cdb9abb4117ef53d319e84ac4bedfe8bd8554781222477",
            ],
            categories: [
                mockCategories[0],
                mockCategories[1]
            ]),
        categories: mockCategories
    )
}
