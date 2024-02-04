//
//  ImagesCarouselView.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 05.01.2024.
//

import SwiftUI

struct PagingAsyncImagesView: View {
    
    @Binding var editingModeOn: Bool
    @Binding var index: Int
    @State private var urls: Array<URL?>
    private var editingModeUrls: Array<URL?> = []
    private var onRemoveImage: (String?) -> Void
    
    init(
        imagesUrlArray: Array<String>,
        editingModeOn: Binding<Bool>,
        index: Binding<Int>,
        onRemoveImage: @escaping (String?) -> Void
    ) {
        self._editingModeOn = editingModeOn
        self._index = index
        self.urls = imagesUrlArray.map { stringUrl in
            URL(string: stringUrl)
        }
        self.editingModeUrls = imagesUrlArray.map { stringUrl in
            URL(string: stringUrl)
        }
        self.editingModeUrls.append(nil)
        self.onRemoveImage = onRemoveImage
    }
    
    var body: some View {
        PagingView(
            index: $index,
            maxIndex: editingModeOn ? editingModeUrls.count - 1 : urls.count - 1
        ) {
            ForEach(editingModeOn ? editingModeUrls : urls, id: \.self) { url in
                ZStack(alignment: .topTrailing) {
                    if(editingModeOn && url == nil) {
                        AddPhotoView()
                    } else {
                        AsyncImage(url: url) { image in
                            image.image?
                                .resizable()
                                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)

                        }
                        .frame(width: 326, height: 227)
                        .cornerRadius(16)
                        .padding()
                        if(editingModeOn) {
                            Button(action: {
                                onRemoveImage(url?.absoluteString)
                            }, label: {
                                Image(systemName: "minus.circle.fill")
                                    .font(.system(size: 30))
                                    .foregroundStyle(.red)
                                    .background(
                                        Circle()
                                            .foregroundStyle(.white)
                                    )
                            })
                        }
                    }
                }
            }
        }
        .frame(width: .infinity, height: 327)
    }
}

private struct PagingView<Content>: View where Content: View {

    @Binding var index: Int
    let maxIndex: Int
    let content: () -> Content

    @State private var offset = CGFloat.zero
    @State private var dragging = false

    init(index: Binding<Int>, maxIndex: Int, @ViewBuilder content: @escaping () -> Content) {
        self._index = index
        self.maxIndex = maxIndex
        self.content = content
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        self.content()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                    }
                }
                .content.offset(x: self.offset(in: geometry), y: 0)
                .frame(width: geometry.size.width, alignment: .leading)
                .gesture(
                    DragGesture().onChanged { value in
                        self.dragging = true
                        self.offset = -CGFloat(self.index) * geometry.size.width + value.translation.width
                    }
                        .onEnded { value in
                            let predictedEndOffset = -CGFloat(self.index) * geometry.size.width + value.predictedEndTranslation.width
                            let predictedIndex = Int(round(predictedEndOffset / -geometry.size.width))
                            self.index = self.clampedIndex(from: predictedIndex)
                            withAnimation(.easeOut) {
                                self.dragging = false
                            }
                        }
                )
                
            }
            .clipped()
            if(maxIndex > 0){
                PageControl(index: $index, maxIndex: maxIndex)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            }
        }
        
    }

    func offset(in geometry: GeometryProxy) -> CGFloat {
        if self.dragging {
            return max(min(self.offset, 0), -CGFloat(self.maxIndex) * geometry.size.width)
        } else {
            return -CGFloat(self.index) * geometry.size.width
        }
    }

    func clampedIndex(from predictedIndex: Int) -> Int {
        let newIndex = min(max(predictedIndex, self.index - 1), self.index + 1)
        guard newIndex >= 0 else { return 0 }
        guard newIndex <= maxIndex else { return maxIndex }
        return newIndex
    }
}

private struct PageControl: View {
    @Binding var index: Int
    let maxIndex: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0...maxIndex, id: \.self) { index in
                Circle()
                    .fill(index == self.index ? Color.white : Color.gray)
                    .frame(width: 8, height: 8)
            }
        }
        .padding(15)
    }
}

#Preview {
    @State var editMode = true
    @State var index = 0
    return PagingAsyncImagesView(
        imagesUrlArray: [
            "https://img1.russianfood.com/dycontent/images_upl/554/big_553606.jpg",
            "https://img.freepik.com/free-photo/sausages-in-the-dough_2829-8405.jpg?w=2000&t=st=1704451812~exp=1704452412~hmac=4e3f2e1870c79d2db4cdb9abb4117ef53d319e84ac4bedfe8bd8554781222477"
        ],
        editingModeOn: $editMode,
        index: $index,
        onRemoveImage: {_ in }
    )
}
