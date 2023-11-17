//
//  FoodForm.swift
//  SwiftuIGrid
//
//  Created by 杨晓斌 on 2023/7/4.
//

import SwiftUI

private enum MyField: Int {
    case title, image, calories, protein, fat, carb
}

// 为键盘做的拓展，节省代码行数
private extension TextField where Label == Text {
    // MARK: - 自定义键盘按钮功能，配合FocusState
    func focused(_ field: FocusState<MyField?>.Binding, equals this: MyField) -> some View {
        submitLabel(this == .carb ? .done : .next)
            .focused(field, equals: this)
            .onSubmit {
                field.wrappedValue = MyField(rawValue: this.rawValue + 1)
            }
    }
}

extension FoodListScrenn {
        
    struct FoodForm: View {
        @Environment(\.dismiss) var dismiss
        @FocusState private var field: MyField? // 哪一个栏位再编辑状态
        @State var food: Food
        
        // 保存食物信息，传递。看是修改还是新增
        var onSubmit: (Food) -> Void
        
        private var isNotValid: Bool {
            food.name.isEmpty || food.image.count > 2 || food.image.isEmpty
        }
        
        // 不能保存的提示
        private var invalidMessage: String? {
            if food.name.isEmpty { return "请输入名称" }
            if food.image.count > 2 { return "图片字数过多" }
            return .none
        }
        
        var body: some View {
            // MARK: NavigationStack - 配合ToolbarItemGroup使用，自定义键盘toolbar
            NavigationStack {
                VStack {
                    titleBar
                    
                    formView
                    
                    saveButton
                    
                }.background(.groupBg)
                    .scrollDismissesKeyboard(.interactively)
                    .toolbar(content: buildKeyboardTools)
            }
        }
    }
}


private extension FoodListScrenn.FoodForm {
    
    /// 头
    var titleBar: some View {
        HStack {
            Label(text: "编辑实物咨询", systemImage: .pencil)
                .font(.title.bold())
                .foregroundColor(.accentColor)
                .alignment(to: .leading)
            SFSymbol.xmark.body
                .font(.system(size: 30))
                .foregroundColor(.secondary)
                .onTapGesture {
                    dismiss()
                }
        }.padding([.horizontal, .top])
    }
    
    /// 表单
    var formView: some View {
        Form {
            LabeledContent("名称") {
                TextField("必填", text: $food.name)
                    .focused($field, equals: .title)
            }
            
            LabeledContent("图示") {
                TextField("必填", text: $food.image)
                    .focused($field, equals: .image)
            }
            
            buildNumberField(title: "热量", value: $food.calorie, filed: .calories, suffix: "大卡")
                
            
            buildNumberField(title: "蛋白质", value: $food.protein, filed: .protein)
            
            buildNumberField(title: "脂肪", value: $food.fat, filed: .fat)
            
            buildNumberField(title: "碳水", value: $food.carb, filed: .carb)
                
            
        }.formStyle(.automatic)
        .multilineTextAlignment(.trailing)
        .padding(.top, -16)
    }
    
    /// 保存按钮
    var saveButton: some View {
        Button {
            dismiss()
            onSubmit(food)
        } label: {
            Text(invalidMessage ?? "保存")
                .alignment()
        }.mainButtonStyle()
            .padding()
        // 指定条件下不可点击
            .disabled(isNotValid)
    }
    
    private func buildKeyboardTools() -> some ToolbarContent {
        /// 需要包在Navigation里面生效
        ToolbarItemGroup(placement: .keyboard) {
            Spacer()
            Button {
                goPreviousField()
            } label: {
                SFSymbol.up.body
            }
            
            Button {
                goNextField()
            } label: {
                SFSymbol.donw.body
            }
        }
    }
    
    
    private func buildNumberField(title: String, value: Binding<Double>, filed: MyField, suffix: String = "g") -> some View {
        LabeledContent(title) {
            HStack {
                TextField("", value: value, formatter: NumberFormatter())
                    .focused($field, equals: filed)
                    .keyboardType(.numbersAndPunctuation)
                Text(suffix)
            }
        }
    }
    
    // 自定义键盘toolbar
    private func goPreviousField() {
        guard let rawValue = field?.rawValue else { return }
        field = .init(rawValue: rawValue - 1)
    }
    
    private func goNextField() {
        guard let rawValue = field?.rawValue else { return }
        field = .init(rawValue: rawValue + 1)
    }
}


struct FoodForm_Previews: PreviewProvider {
    static var previews: some View {
        FoodListScrenn.FoodForm(food: Food.examples.first!, onSubmit: {_ in})
    }
}
