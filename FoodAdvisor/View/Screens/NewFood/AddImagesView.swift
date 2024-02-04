//
//  AddImagesView.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 20.01.2024.
//

import SwiftUI

struct AddImagesView: View {
    
    @Binding var imagesUrls: [URL?]
    @Binding var state: NewFoodScreenState
    
    var body: some View {
        VStack() {
            if(state == .edit || state == .insert){
                Button(action: {
                    //todo
                }, label: {
                    HStack {
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.orange)
                        Text("Добавить изображения")
                            .foregroundStyle(.orange)
                    }
                })
                .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                Text("Изображения")
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                if(!imagesUrls.isEmpty) {
                    LazyHStack {
                        ForEach(imagesUrls, id: \.self) { url in
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
        .frame(width: .infinity, height: 120)
        .padding(.init(top: 24, leading: 24, bottom: 0, trailing: 0))
    }
}

#Preview {
    @State var state: NewFoodScreenState = .view
    
    @State var imageUrls: [URL?] = []
    return AddImagesView(
        imagesUrls: $imageUrls,
        state: $state
    )
}
