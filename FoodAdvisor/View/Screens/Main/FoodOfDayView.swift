//
//  FoodOfDayView.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 07.01.2024.
//

import SwiftUI

struct FoodOfDayView: View {
    let imageUrl: String
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image.image?
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            }
            .frame(width: .infinity, height: 250)
            .cornerRadius(16)
            Text("Блюдо дня")
                .font(.bold(.title)())
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, maxHeight: 220, alignment: .bottomLeading)
                .padding(.leading, 16)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
    }
}

#Preview {
    FoodOfDayView(
        imageUrl: "https://img.freepik.com/free-photo/sausages-in-the-dough_2829-8405.jpg?w=2000&t=st=1704451812~exp=1704452412~hmac=4e3f2e1870c79d2db4cdb9abb4117ef53d319e84ac4bedfe8bd8554781222477"
    )
}
