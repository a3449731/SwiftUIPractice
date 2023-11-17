//
//  SheetEnum.swift
//  SwiftuIGrid
//
//  Created by 杨晓斌 on 2023/7/5.
//

import SwiftUI

extension FoodListScrenn {
    // MARK: - sheet弹窗的统一处理
    enum SheetEnum: View, Identifiable {
        
        case newFood((Food) -> Void)
        case editFood(Binding<Food>)
        case foodDetail(Food)
        
        // FIXME: 还是uuid，只是看起来更好理解
        var id: Food.ID {
            switch self {
            case .newFood(_): return UUID()
            case .editFood(let binding): return binding.wrappedValue.id
            case.foodDetail(let food): return food.id
            }
        }
        
        var body: some View {
            switch self {
            case .newFood(let submit):
                // 新增
                 FoodListScrenn.FoodForm(food: .new, onSubmit: submit)
            case .editFood(let food):
                // 修改
                FoodListScrenn.FoodForm(food: food.wrappedValue) { item in
                    food.wrappedValue = item
                }
            case .foodDetail(let food):
                FoodListScrenn.FoodDetailSheet(food: food)                    
            }
        }
    }
}
