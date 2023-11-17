//
//  FooodPickerView.swift
//  SwiftuIGrid
//
//  Created by 杨晓斌 on 2023/6/23.
//

import SwiftUI

struct FooodPickerView: View {
    @State private var selectedFood: Food?
    @State private var isShowFoodDtail: Bool = false
        
    
    let food: [Food] = Food.examples
        
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 30) {
                    
                    foodImage
                    
                    
                    Text("今天吃什么 ?").font(.largeTitle).bold()
                        
                    
                    selectedFoodInfoView
                    
                    // 空白，会拉伸填补。
                    Spacer().layoutPriority(1)
                    
                    selectFoodButton
                    
                    cancelButton
                    
                }
                .padding()
                .frame(maxWidth: .infinity, minHeight: proxy.size.height)
                .animation(.mySpring, value: isShowFoodDtail)
                .animation(.myEase, value: selectedFood)
                .mainButtonStyle()
            }.background(.bg2)
        }
        
    }
        
}

// MARK: - 子view
private extension FooodPickerView {
    var foodImage: some View {
        Group {
            if selectedFood != .none {
                Text(selectedFood!.image)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.7)
                    .lineLimit(1)
            } else {
                Image("dinner")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 250).border(.blue)
            }
        }.frame(height: 250).border(.blue)
    }
    
    @ViewBuilder var selectedFoodInfoView: some View {
        if selectedFood != .none {
            HStack {
                Text("选择了\(selectedFood?.name ?? "")")
                    .font(.largeTitle.bold())
                    .foregroundColor(Color.green)
                    .id(selectedFood!.name)
                    .transition(.myTransition)
                
                SFSymbol.circle.body                
                    .foregroundColor(.secondary)
                    .onTapGesture {
                        print("吃个屁")
//                        withAnimation {
                            isShowFoodDtail = !isShowFoodDtail
//                        }
                    }
            }
            
            VStack {
                if isShowFoodDtail {
                    FoodComponentView(selectedFood: selectedFood!)
//                        .transition(.asymmetric(
//                            insertion: .opacity.combined(with: .move(edge: .bottom)) ,
//                            removal: .opacity.combined(with: .move(edge: .top))))
                }
            }.clipped()
        }
    }
    
    var cancelButton: some View {
        Button() {
            withAnimation {
                selectedFood = .none
            }
            
        } label: {
            Text("重置")
                .font(.title.bold())
                .frame(width: 200)
                .padding([.top, .bottom] , 10)
        }.buttonStyle(.bordered)
    }
    
    var selectFoodButton: some View {
        Button {
            withAnimation {
                // shuffled打乱数组
                selectedFood = food.shuffled().first { $0 != selectedFood }
            }
        } label: {
            Text(selectedFood == .none ? "告诉我" : "换一个")
                .frame(width: 200)
                .transformEffect(.identity)
                .padding([.top, .bottom] , 10)
        }
        .font(.title.bold())
        .buttonStyle(.borderedProminent)
        .padding(.bottom, -15)
    }
}

extension FooodPickerView {
    init(selectedFood: Food) {
        _selectedFood = .init(wrappedValue: selectedFood)
    }
}

// 实物成分
struct FoodComponentView: View {
    var selectedFood: Food
    
    var body: some View {
        VStack {
            Text("热量 \(selectedFood.$calorie)")
                .font(.title2)
            
            Grid {
                GridRow {
                    Text("蛋白质")
                    Text("脂肪")
                    Text("碳水")
                }
                .padding([.leading, .trailing], 15)
                
                Divider().gridCellUnsizedAxes(.horizontal)
//                Divider().layoutPriority(1)
                
                GridRow {
                    Text(selectedFood.$carb)
                    Text(selectedFood.$fat)
                    Text(selectedFood.$protein)                    
                }
            }
            .padding()
            .background(.white).cornerRadius(20)
            
        }
    }
}

struct FooodPickerView_Previews: PreviewProvider {
    static var previews: some View {
        FooodPickerView(selectedFood: Food.examples.first!)
//        FooodPickerView(selectedFood: Food.examples.first!).previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (6th generation)"))
        
    }
}

struct aaaa {
    // 分发饼干
    func findContentChildren(_ g: [Int], _ s: [Int]) -> Int {
        let chirds = g.sorted()
        let foods = s.sorted()

        var count = 0
        var chirdIndex = 0
        var foodIndex = 0
        
        while chirdIndex < chirds.count, foodIndex < foods.count {
            if chirds[chirdIndex] <= foods[foodIndex] {
                count += 1
                chirdIndex += 1
                foodIndex += 1
            } else {
                foodIndex += 1
            }
        }
        
        return count
    }
    
    // 摆动序列
    func wiggleMaxLength(_ nums: [Int]) -> Int {
        if nums.count == 1 {
            return 1
        }
        if nums.count == 2 {
            if nums[0] != nums[1] {
                return 2
            } else {
                return 1
            }
        }
        
        
        // 下面就是大于3个元素的。
        var count = 1
        // 记录前一个与后一个的差值
//        var beforeResult = nums[1] - nums[0]
        // 假设前面还有一个元素，且和第一个元素等值，这样便利就能从下标0开始
        var beforeResult = 0
        var behindResult = 0
        
        
        // 计算差值
        for index in 0..<(nums.count-1) {
//            let preview = nums[index - 1]
            let current = nums[index]
            let next = nums[index + 1]
            
            // 计算出后一个 减 前一个
            behindResult = next - current
            
            if (beforeResult >= 0 && behindResult < 0) || (beforeResult <= 0 && behindResult > 0) {
                count += 1
             
                // *** 注意放在这里是有讲究的，剔除了 单调序列中的平坡对结果的影响 ***
                // 在进入下一次循环之前，把后一个给到前一个，避免重复计算
                beforeResult = behindResult
            }
        }
        return count
    }
}
