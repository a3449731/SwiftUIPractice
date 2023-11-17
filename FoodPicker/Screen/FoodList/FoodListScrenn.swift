//
//  FoodList2View.swift
//  SwiftuIGrid
//
//  Created by 杨晓斌 on 2023/7/3.
//

import SwiftUI

struct FoodListScrenn: View {
    // 在Array+里实现了rawValue的拓展
    @AppStorage(.foodList) private var foods = Food.examples
    @State private var selectedFood = Set<Food.ID>()
    
    // 是否在编辑状态
    @State var edit: EditMode = .inactive
         
    var isEditting: Bool {
        edit.isEditing
    }
    
    // 是否改弹出sheet，枚举监控，所有sheet的调配在这里面
    @State private var shouldSheet: SheetEnum?
    
    // 编辑的food
    @State private var editFood: Binding<Food>?
    
    var body: some View {
        VStack(alignment: .leading) {
            titleBar
            
            List($foods, id: \.id, editActions: .all, selection: $selectedFood, rowContent: buildFoodRow)
//            .border(.red)
            .listStyle(.plain)
//            .background(.groupBg2, in: RoundedRectangle(cornerRadius: 10))
            .background {
                // MARK: -  ignoreSafeArea 調整器
                RoundedRectangle(cornerRadius: 10).fill(.groupBg2)
                    .ignoresSafeArea(.container ,edges: .bottom)
            }
            .padding(.horizontal)
            
            
            
        }
        .environment(\.editMode, $edit)
        .background(.groupBg)
        .safeAreaInset(edge: .bottom, content: buildFloatButton)
        .mySheet(item: $shouldSheet)
    }
}



// MARK: - 子View
private extension FoodListScrenn {
    var titleBar: some View {
        HStack {
            Label {
                Text("实物清单")
            } icon: {
                SFSymbol.fork.body
            }
            .foregroundColor(.accentColor)
            .font(.title.bold())
            .alignment(to: .leading)
                                            
            
            EditButton()
                .buttonStyle(.bordered)
            
            addButton
            
        }.padding()
    }
    
    // +号按钮
    var addButton: some View {
        Button {
//            shouldShowFoodForm = true
            shouldSheet = .newFood({ food in
                foods.append(food)
            })
        } label: {
            SFSymbol.puls.body
                .font(.system(size: 40))
//                .padding()
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, Color.accentColor.gradient)
        }
    }
    
    var deleteButton: some View {
        Button {
            withAnimation {
                foods = foods.filter { !selectedFood.contains($0.id)}
            }
        } label: {
            Text("删除已选项目")
                .font(.title2.bold())
                .alignment(to: .center)
//                .frame(height: 50)
                
        }.mainButtonStyle(shape: .roundedRectangle(radius: 10))
        .padding(.horizontal, 50)
        
    }
    
    // 建立漂浮按钮
    func buildFloatButton() -> some View {
        
        ZStack {
            deleteButton
                .opacity(isEditting ? 1 : 0)
                .transition(.move(edge: .leading).combined(with: .opacity).animation(.easeInOut))
                .id(isEditting)
        }
    }
    
    func buildFoodRow(foodBinding: Binding<Food>) -> some View {
        let food = foodBinding.wrappedValue
        
        return HStack {
            Text(food.name)
                .font(.title3)
                .padding(.vertical, 10)
                .alignment(to: .leading)
                .contentShape(Rectangle()) // 加了这个可以让text形状拉满
                .onTapGesture {
                    if isEditting {
                        if selectedFood.contains(food.id) {
                            selectedFood.remove(food.id)
                        } else {
                            selectedFood.insert(food.id)
                        }
                        return
                    }
                    shouldSheet = .foodDetail(food)
                }
            if isEditting {
                SFSymbol.pencil.body
                    .foregroundColor(.accentColor).frame(alignment: .trailing)
                    .onTapGesture {
                        if isEditting == false {return}
                        shouldSheet = .editFood(foodBinding)
                    }
            }
        }.listRowBackground(Color.clear)
    }
}

struct FoodList2View_Previews: PreviewProvider {
    static var previews: some View {
        FoodListScrenn()
//            .environment(\.dynamicTypeSize, .accessibility2)
//            .environment(\.editMode, .constant(.active))
    }
}
