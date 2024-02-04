//
//  FoodInfoScreen.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 05.01.2024.
//

import SwiftUI

struct FoodInfoScreen: View {
    
    @State private var viewModel: FoodInfoViewModel
    @State private var index = 0
    
    init(food: FoodUiModel) {
        viewModel = FoodInfoViewModel(food: food)
    }
    
    var body: some View {
        VStack(){
            HStack {
                if(viewModel.state.editingModeOn) {
                    TextField("Название блюда", text: $viewModel.state.food.name)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .font(.title)
                        .foregroundStyle(Color("TitleTextColor"))
                        .padding(.leading, 24)
                } else {
                    Text(viewModel.state.food.name)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .font(.title)
                        .foregroundStyle(Color("TitleTextColor"))
                    .padding(.leading, 24)
                }
                Button(action: {
                    viewModel.toggleEditingMode()
                    index = 0
                }, label: {
                    Text(viewModel.state.editingModeOn ? "Готово" : "Изменить")
                        .padding(.trailing, 24)
                        .foregroundStyle(.orange)
                })
            }
            if(viewModel.state.editingModeOn) {
                Button(
                    action: {
                        viewModel.toggleBottomSheetVisible()
                    },
                    label: {
                        HStack() {
                            Text(viewModel.state.categories.toTitle())
                                .foregroundStyle(Color("TitleTextColor"))
                                .padding(.leading, 24)
                            Image(systemName: "pencil")
                                .foregroundStyle(.orange)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                })
            } else {
                Text(viewModel.state.categories.toTitle())
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    .foregroundStyle(Color("TitleTextColor"))
                    .padding(.leading, 24)
            }
            HStack {
                if (viewModel.state.food.image_urls == nil || viewModel.state.food.image_urls?.isEmpty == false) {
                    PagingAsyncImagesView(
                        imagesUrlArray: viewModel.state.food.image_urls!,
                        editingModeOn: $viewModel.state.editingModeOn,
                        index: $index,
                        onRemoveImage: { imageUrl in
                            if(imageUrl != nil) {
                                viewModel.removeImage(imageUrl: imageUrl!)
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
                if(viewModel.state.editingModeOn) {
                    TextField("Рецепт", text: $viewModel.state.food.recipe)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.init(top: 4, leading: 24, bottom: 0, trailing: 0))
                } else {
                    Text(viewModel.state.food.recipe)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.init(top: 4, leading: 24, bottom: 0, trailing: 0))
                }
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .topLeading)
        .background(Color("SheetBackgroundColor"))
        .sheet(isPresented: $viewModel.state.bottomSheetVisible) {
            FilterBottomSheetView(
                categories: viewModel.state.categories,
                doOnApplyClicked: viewModel.updateSelectedCategories
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
            ])
    )
}
