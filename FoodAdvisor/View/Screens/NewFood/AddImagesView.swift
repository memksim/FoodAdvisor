//
//  AddImagesView.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 20.01.2024.
//

import SwiftUI

struct AddImagesView: View {
    
    @Binding var viewModel: NewFoodViewModel
    
    var body: some View {
        VStack() {
            if(viewModel.state.editMode != .view){
                Button(action: {
                    //todo
                }, label: {
                    HStack {
                        Image(systemName: "plus.circle")
                            .foregroundStyle(Color.accentColor)
                        Text("Добавить изображения")
                            .foregroundStyle(Color.accentColor)
                    }
                })
                .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                Text("Изображения")
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                if(!viewModel.state.imageUrls.isEmpty) {
                    LazyHStack {
                        ForEach(viewModel.state.imageUrls, id: \.self) { url in
                            AsyncImage(url: url) { image in
                                image.image?
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            }
                            .frame(width: 120, height: 90)
                            .cornerRadius(16)
                        }
                    }
                } else {
                    Image(systemName: "photo.badge.plus")
                        .frame(width: 120, height: 90)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundStyle(.gray)
                        )
                }
            }
        }
        .padding(.init(top: 24, leading: 24, bottom: 0, trailing: 0))
    }
}
