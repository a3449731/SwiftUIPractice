//
//  FoodDetailSheet.swift
//  SwiftuIGrid
//
//  Created by 杨晓斌 on 2023/7/5.
//

import SwiftUI

// MARK: - 计算详情sheet高度的
private struct SheetSizePreference: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

extension FoodListScrenn {
    
    // 点击详情的
    struct FoodDetailSheet: View {
        
        @Environment(\.dynamicTypeSize) private var dynamicTypeSize
        @State private var sheetSize: CGSize = SheetSizePreference.defaultValue
        
        let food: Food
        
        var body: some View {
//            let food = foods.first!
            let shouldUseVstack = dynamicTypeSize >= .accessibility1 || food.image.count > 1
            
            AnyLayout.userVStack(if: shouldUseVstack, spacing: 30) {
    
                Text(food.image)
                    .font(.system(size: 100))
                    .minimumScaleFactor(0.7)
                    .lineLimit(1)
                
                Grid(verticalSpacing: 10) {
                    buildNutritionView(title: "热量", value: food.$calorie)
                    buildNutritionView(title: "蛋白质", value: food.$protein)
                    buildNutritionView(title: "脂肪", value: food.$fat)
                    buildNutritionView(title: "碳水", value: food.$carb)
                }.padding()
            }
            .padding()
            .maxWidth()
            .background(.groupBg2)
            // MARK: - 读取控件大小 配合sheet使用时
            .readGeometry(key: SheetSizePreference.self, path: \.size)
//            .overlay {
//                GeometryReader { proxy in
//                    Color.clear
//                        .preference(key: SheetSizePreference.self, value: proxy.size)
//                }
//            }
            // MARK: - 读取到控件大小
            .onPreferenceChange(SheetSizePreference.self, perform: { size in
                sheetSize = size
            })
            // MARK: - 设置弹出高度
            .presentationDetents([.height(sheetSize.height)])
        }
        
        
        func buildNutritionView(title: String, value: String) -> some View {
            GridRow {
                Text(title).gridColumnAlignment(.leading)
                Text(value).gridColumnAlignment(.trailing)
            }
        }
    }
}

struct FoodDetailSheet_Previews: PreviewProvider {
    static var previews: some View {
        FoodListScrenn.FoodDetailSheet(food: Food(name: "123", image: "2"))
    }
}
