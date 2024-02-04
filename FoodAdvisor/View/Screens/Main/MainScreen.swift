//
//  MainScreen.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 07.01.2024.
//

import SwiftUI

struct MainScreen: View {
    
    @State private var viewModel = MainScreenViewModel()
    
    var body: some View {
        VStack {
            if(viewModel.state.foodOfDay != nil) {
                FoodOfDayView(imageUrl: viewModel.state.foodOfDay!.image_urls![0])
                    .padding()
            }
            AllFoodLabelView(
                foodName: Binding(get: { viewModel.state.searchedFoodName },
                set: { newValue in
                    viewModel.findFoodsByName(foodName: newValue)
                }),
                doOnFilterClick: {
                    viewModel.showHideFilterBottomSheet()
                },
                doOnCloseSearchField: {
                    viewModel.findFoodsByName(foodName: "")
                },
                doOnAddClick: {
                    
                }
            ).padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.state.foods, id: \.id) { food in
                        Text(food.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Divider()
                    }
                }
            }
            .padding(.init(top: 6, leading: 16, bottom: 16, trailing: 16))
        }
        .frame(maxWidth: .infinity, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
        .background(Color("BackgroundColor").ignoresSafeArea(.all))
        .sheet(
            isPresented: $viewModel.state.filterBottomSheetVisible) {
                FilterBottomSheetView(
                    categories: viewModel.state.categories
                ) { selectedCategories in
                    viewModel.filterFoodsByCatefories(categories: selectedCategories)
                }
                .presentationDetents([.height(250)])
                .presentationCornerRadius(25)
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
    MainScreen()
}
