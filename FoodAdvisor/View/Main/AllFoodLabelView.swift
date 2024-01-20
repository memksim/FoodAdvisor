//
//  AllFoodLabelView.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 07.01.2024.
//

import SwiftUI

struct AllFoodLabelView: View {
    
    @Binding var foodName: String
    @State private var searchFieldVisible = false
    var doOnFilterClick: () -> Void
    var doOnCloseSearchField: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Text("Все блюда")
                    .font(.title2)
                    .foregroundStyle(Color("TitleTextColor"))
                Spacer()
                Button(action: {
                    searchFieldVisible.toggle()
                    if(!searchFieldVisible) {
                        doOnCloseSearchField()
                    }
                }, label: {
                    Image(
                        systemName: searchFieldVisible ? "xmark.circle"  : "magnifyingglass"
                    ).foregroundStyle(.gray)
                })
                Button(
                    action: doOnFilterClick,
                    label: {
                        Image(systemName: "line.3.horizontal.decrease")
                        .foregroundStyle(.gray)
                })
                .padding(.leading)
            }
            if(searchFieldVisible) {
                SearchFieldView(foodName: $foodName)
            }
        }.padding()
    }
}

private struct SearchFieldView: View {
    
    @Binding var foodName: String
    
    var body: some View {
        HStack {
            TextField("Название блюда", text: $foodName)
                .onSubmit() {
                    print("submit")
                }
        }
    }
}

