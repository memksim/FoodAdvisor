//
//  MainScreen.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 07.01.2024.
//

import SwiftUI

struct MainScreen: View {
    
    @State private var filterSheetOpened = false
    @State private var filteredFoods: [FoodUiModel] = []
    @State private var categories: [CategoryUiModel] = []
    @State private var searchedFoodName = ""
    
    private let foodOfDay: FoodUiModel?
    private let foods: [FoodUiModel]
    
    init(
        foods: [FoodUiModel],
        categories: [CategoryUiModel]
    ) {
        self.foodOfDay = foods.filter{ food in
            food.image_urls != nil && food.image_urls?.isEmpty == false
        }.randomElement()
        self._categories = State(initialValue: categories)
        self.foods = foods
    }
    
    var body: some View {
        VStack {
            if(foodOfDay != nil) {
                FoodOfDayView(imageUrl: foodOfDay!.image_urls![0])
                    .padding()
            }
            AllFoodLabelView(
                foodName: Binding(get: { self.searchedFoodName },
                set: { newValue in
                    print(searchedFoodName)
                    searchedFoodName = newValue
                    findFoodsByName()
                }),
                doOnFilterClick: {
                    filterSheetOpened.toggle()
                }, 
                doOnCloseSearchField: {
                    searchedFoodName = ""
                    findFoodsByName()
                }
            )
            ScrollView {
                LazyVStack {
                    ForEach(filteredFoods, id: \.id) { food in
                        Text(food.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Divider()
                    }
                }
            }
            .onAppear {
                filteredFoods = foods
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
        .background(Color("BackgroundColor").ignoresSafeArea(.all))
        .sheet(
            isPresented: $filterSheetOpened) {
                FilterBottomSheetView(
                    categories: categories
                ) { selectedCategories in
                    categories = selectedCategories
                    if(CategoryUiModel.checkAllCategoriesUnselected(categories)) {
                        filteredFoods = foods
                    } else {
                        filterFoods()
                    }
                }
                .presentationDetents([.height(250)])
                .presentationCornerRadius(25)
        }
    }
    
    private func filterFoods() {
        filteredFoods.removeAll()
        categories.forEach { category in
            foods.forEach { food in
                if (CategoryUiModel.contains(what: category, in: food.categories) && category.selected) {
                    print("\(food.name) --- \(category)")
                    filteredFoods.append(food)
                }
            }
        }
    }
    
    private func findFoodsByName() {
        if(searchedFoodName.isEmpty) {
            filteredFoods = foods
        } else {
            filteredFoods.removeAll()
            foods.forEach { food in
                if(food.name.contains(searchedFoodName)) {
                    filteredFoods.append(food)
                }
            }
        }
    }
}

let mockCategories = [
    CategoryUiModel(id: UUID(), title: "Обед", selected: false),
    CategoryUiModel(id: UUID(), title: "Ужин", selected: false),
    CategoryUiModel(id: UUID(), title: "Завтрак", selected: false),
    CategoryUiModel(id: UUID(), title: "Десерт", selected: false),
    CategoryUiModel(id: UUID(), title: "Закуска", selected: false)
]

let mockFoods = [
    FoodUiModel(
        id: UUID(),
        name: "Спагенти",
        recipe: "Сварить спагенти",
        image_urls: [
        "https://img1.russianfood.com/dycontent/images_upl/554/big_553606.jpg",
        "https://img.freepik.com/free-photo/sausages-in-the-dough_2829-8405.jpg?w=2000&t=st=1704451812~exp=1704452412~hmac=4e3f2e1870c79d2db4cdb9abb4117ef53d319e84ac4bedfe8bd8554781222477"],
        categories: [
            mockCategories[0]
        ]),
    FoodUiModel(
        id: UUID(),
        name: "Чизкейк",
        recipe: "Сделать чизкейк",
        image_urls: ["https://static.vkusnyblog.com/img3x4/uploads/2016/12/holodnyi-vishnevyi-chizkeik1.jpg"],
        categories: [
            mockCategories[3]
        ]),
    FoodUiModel(
        id: UUID(),
        name: "Пивные хрустяшки",
        recipe: "похрустеть",
        image_urls: ["https://static.vkusnyblog.com/img3x4/uploads/2016/12/holodnyi-vishnevyi-chizkeik1.jpg"],
        categories: [
            mockCategories[4]
        ]),
    FoodUiModel(
        id: UUID(),
        name: "Супчик",
        recipe: "похлюпать",
        image_urls: ["https://static.vkusnyblog.com/img3x4/uploads/2016/12/holodnyi-vishnevyi-chizkeik1.jpg"],
        categories: [
            mockCategories[0]
        ])
]

#Preview {
    MainScreen(
        foods: mockFoods,
        categories: mockCategories
    )
}
