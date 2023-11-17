//
//  SettingScreen.swift
//  SwiftuIGrid
//
//  Created by 杨晓斌 on 2023/7/6.
//

import SwiftUI


struct SettingScreen: View {
    // 颜色模式
//    @Environment(\.colorScheme) var mode: ColorScheme
    // 是否为深色,AppStorage是使用userdefault的持久化
    @AppStorage(.shouldDark) var shouldDark: Bool = false
    
    @AppStorage(.pickerUnit) private var pickerUnit: UnitEnum = .g
    @AppStorage(.pickerPage) private var pickerPage: HomeScreen.Tab = .setting
    
    @State private var confirmationDialog: SettingScreen.Dialog = .inactive
//    private var shouldShowDialog: Bool {
//        !(confirmationDialog == .inactive)
//    }
    
    private var shouldShowDialog: Binding<Bool> {
        Binding(
            get: {
                confirmationDialog != .inactive
            },
            set: {_ in
                confirmationDialog = .inactive
            })
    }
    
    var body: some View {
        Form {
            Section("基本设置") {
                themeToggle
                
                unitPicker
                
                pagePicker
            }
            
            Section("危险区域") {
                ForEach(Dialog.allCase) { item in
                    Button(item.rawValue) {
                        confirmationDialog = item
                    }.tint(Color(.label))
                }
            }
            .confirmationDialog(confirmationDialog.rawValue, isPresented: shouldShowDialog, titleVisibility: .visible) {
                
                Button("确定", role: .destructive, action: confirmationDialog.actionsss)
            } message: {
                Text(confirmationDialog.message)
            }

            
            Text(pickerUnit.rawValue)
            Text(pickerPage.rawValue)
        }
//        .environment(\.colorScheme, shouldDark ? .dark : .light)
    }
}


// MARK: - 提醒弹窗
private extension SettingScreen {
    // 弹窗
    enum Dialog: String, CaseIterable {
        case resetSettings = "重置设定"
        case resetFoodList = "重置食物记录"
        case inactive
        
        var message: String {
            switch self {
            case .resetSettings:
                return "将重置颜色，单位等设置 \n 次操作无法复原，确定进行吗"
            case .resetFoodList:
                return "将重置食物清单 \n 次操作无法复原，确定进行吗"
            case .inactive:
                return ""
            }
        }
        
        // 重置的方法
        func actionsss() {
            switch self {
            case .inactive: return
            case .resetFoodList:                
                UserDefaults.standard.removeObject(forKey: UserDefaults.Key.foodList.rawValue)
            case .resetSettings:
                // 重置设置里面的的
                let keys: [UserDefaults.Key] = [.pickerPage, .pickerUnit, .shouldDark]
                for key in keys {
                    UserDefaults.standard.removeObject(forKey: key.rawValue)
                }
                
                return
            }
        }
        
    }
}

extension SettingScreen.Dialog: Identifiable {
    var id: Self {self}
}

extension SettingScreen.Dialog {
    static let allCase: [SettingScreen.Dialog] = [.resetSettings, .resetFoodList]
}

// MARK: - 子View
private extension SettingScreen {
    
    /// 开关
    var themeToggle: some View {
        Toggle(isOn: $shouldDark) {
            Label(text: "深色模式", systemImage: .moon)
        }
        
    }
    
    /// 单位选择
    var unitPicker: some View {
        Picker(selection: $pickerUnit) {
            let units = UnitEnum.allCases
            ForEach(units, id: \.self) { item in
                Label(text: item.rawValue, systemImage: .unitSigh)
            }
        } label: {
            Label(text: "单位", systemImage: .unitSigh)
        }
    }
    
    
    /// 页面选择
    var pagePicker: some View {
        Picker(selection: $pickerPage) {
            Text("主页").tag(HomeScreen.Tab.picker)
            Text("列表").tag(HomeScreen.Tab.list)
            Text("设置").tag(HomeScreen.Tab.setting)
        } label: {
            Label(text: "启动画面", systemImage: .circle)
        }
    }
}

struct SettingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingScreen()
    }
}
