//
//  FilterBottomSheetView.swift
//  FoodAdvisor
//
//  Created by Максим Косенко on 07.01.2024.
//

import SwiftUI

struct FilterBottomSheetView: View {
    
    let title: String
    @State var categories: [CategoryUiModel]
    var doOnApplyClicked: (_ selectedCategories: [CategoryUiModel]) -> Void
    var doOnCategoriesSettingsClicked: () -> Void
    
    @State private var unselectAll: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack() {
            HStack {
                Text(title)
                    .foregroundStyle(Color("TitleTextColor"))
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button(action: {
                    doOnApplyClicked(categories)
                    dismiss()
                }, label: {
                    Text("Применить")
                        .foregroundStyle(.orange)
                })
            }
            .padding(.init(top: 24, leading: 12, bottom: 0, trailing: 12))
            GeometryReader { geometry in
                ScrollView {
                    FlexibleView (
                        availableWidth: geometry.size.width,
                        data: categories,
                        spacing: 15,
                        alignment: .leading
                    ) { item in
                        CategoryTitleView(
                            category: item
                        ){ category in
                            if let index = categories.firstIndex(of: item) {
                                categories[index] = category
                            }
                        }
                    }
                }
            }
            .padding(.init(top: 0, leading: 12, bottom: 0, trailing: 12))
            Button(action: {
                doOnCategoriesSettingsClicked()
                dismiss()
            }, label: {
                HStack {
                    Image(systemName: "gearshape")
                        .foregroundStyle(.gray)
                    
                }
            })
            .padding(.init(top: 0, leading: 16, bottom: 0, trailing: 12))
            .frame(maxWidth: .infinity, alignment: .leading)
                
        }
        .background(Color("SheetBackgroundColor"))
    }
}

private struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    let availableWidth: CGFloat
    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content
    @State var elementsSize: [Data.Element: CGSize] = [:]

    var body : some View {
        VStack(alignment: alignment, spacing: spacing) {
            ForEach(computeRows(), id: \.self) { rowElements in
                HStack(spacing: spacing) {
                    ForEach(rowElements, id: \.self) { element in
                        content(element)
                            .fixedSize()
                            .readSize { size in
                                elementsSize[element] = size
                            }
                    }
                }
            }
        }
    }

    func computeRows() -> [[Data.Element]] {
        var rows: [[Data.Element]] = [[]]
        var currentRow = 0
        var remainingWidth = availableWidth

        for element in data {
            let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]

            if remainingWidth - (elementSize.width + spacing) >= 0 {
                rows[currentRow].append(element)
            } else {
                currentRow = currentRow + 1
                rows.append([element])
                remainingWidth = availableWidth
            }

            remainingWidth = remainingWidth - (elementSize.width + spacing)
        }

        return rows
    }
}

private extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
          GeometryReader { geometryProxy in
            Color.clear
              .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
          }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

#Preview {
    FilterBottomSheetView(
        title: "Заголовок",
        categories: mockCategories,
        doOnApplyClicked: { _ in
            
        },
        doOnCategoriesSettingsClicked: {
            
        }
    )
}

