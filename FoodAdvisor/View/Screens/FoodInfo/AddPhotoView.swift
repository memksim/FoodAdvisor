//
//  AddPhotoView.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 10.01.2024.
//

import SwiftUI

struct AddPhotoView: View {
    var body: some View {
        Image(systemName: "plus")
            .foregroundStyle(.thinMaterial)
            .frame(width: 326, height: 227)
            .font(.system(size: 36))
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.gray)
            }.onTapGesture {
                print("tap")
            }
    }
}

#Preview {
    AddPhotoView()
}
