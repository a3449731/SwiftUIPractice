//
//  SwiftuIGridApp.swift
//  SwiftuIGrid
//
//  Created by 杨晓斌 on 2023/6/21.
//

import SwiftUI

@main
struct SwiftuIGridApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
//            GirdPracticeViewView()
//            LayoutViewTest()
            HomeScreen().onAppear {
                search([1, 3], 0)
            }
            
//            FoodList2View.FoodForm(food: Food(name: "", image: "")) { _ in
                
//            }
        }
    }
    
    
    // MARK: - 力扣 33. 搜索旋转排序数组
    // 时间复杂度o(log n)， 又是有序。 二分法查找。
    // 与常规的二分不同的是。这个拆分之后是部分有序，要么左边有序，要么右边有序
    // 怎么判断有序呢。 nums[0] < num[二分], 那这部分就是有序
    // 那就在有序的部分中进行判断，看这个值是否在区间内。 在的话继续拆分这个区间。 不在的话拆分另一个区间
    func search(_ nums: [Int], _ target: Int) -> Int {
        var left = 0
        var right = nums.count - 1
        var middle = (left + right) / 2
        
        if left == right {
            return nums[left] == target ? left : -1
        }
        
        while left < right {
            // 如果找到结果
            if nums[middle] == target {
                return middle
            }
            
            let leftArray = nums[..<middle]
            let rightArray = nums[middle...]
            // 如果成立，那说明左边数组是有序的
            if let a = leftArray.first,
               let b = leftArray.last,
                a < b {
                // 判断是否在区别内
                if target >= leftArray.first! && target <= leftArray.last! {
                    right = middle - 1
                } else {
                    left = middle
                }
            } else {
                // 判断是否在区别内
                if target >= rightArray.first! && target <= rightArray.last! {
                    left = middle
                } else {
                    right = middle - 1
                }
            }
            
//            print(left, right, middle)
            middle = (left + right) / 2
        }

        return -1
    }
}
