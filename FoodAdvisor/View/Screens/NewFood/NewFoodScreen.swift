//
//  NewFoodScreen.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 20.01.2024.
//

import SwiftUI

struct NewFoodScreen: View {
    
    @State private var viewModel = NewFoodViewModel()
    
    var body: some View {
        VStack {
            HStack {
                if(viewModel.state.editMode != .view) {
                    TextField("Название блюда", text: $viewModel.state.foodName)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title)
                        .foregroundStyle(Color("TitleTextColor"))
                        .padding(.leading, 24)
                } else {
                    Text(viewModel.state.foodName)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title)
                        .foregroundStyle(Color("TitleTextColor"))
                        .padding(.leading, 24)
                }
                Button(action: viewModel.changeEditMode, label: {
                    Text(viewModel.state.editMode == .view ? "Изменить" : (viewModel.state.editMode == .edit ? "Готово" : "Сохранить"))
                        .foregroundStyle(.orange)
                        .padding(.trailing, 24)
                })
            }
            if(viewModel.state.editMode != .view){
                Button(action: viewModel.toggleBottomSheetVisible, label: {
                    HStack() {
                        Text(viewModel.state.categories.toTitle())
                            .foregroundStyle(Color("TitleTextColor"))
                            .padding(.leading, 24)
                        Image(systemName: "pencil")
                            .foregroundStyle(.orange)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                })
                .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                Text(viewModel.state.categories.toTitle())
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    .foregroundStyle(Color("TitleTextColor"))
                    .padding(.leading, 24)
            }
            AddImagesView(viewModel: $viewModel)
            Text("Рецепт")
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .foregroundStyle(Color("TitleTextColor"))
                .padding(.init(top: 36, leading: 24, bottom: 0, trailing: 0))
                .font(.title2)
            ScrollView {
                if(viewModel.state.editMode != .view) {
                    TextField("Рецепт", text: $viewModel.state.recipe)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.init(top: 4, leading: 24, bottom: 0, trailing: 0))
                } else {
                    Text(viewModel.state.recipe)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.init(top: 4, leading: 24, bottom: 0, trailing: 0))
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
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
    NewFoodScreen()
}
