//
//  HomeScreen.swift
//  SwiftuIGrid
//
//  Created by 杨晓斌 on 2023/7/5.
//

import SwiftUI

struct HomeScreen: View {
    // 颜色模式，在设置页面进行设置的。
    @AppStorage(.shouldDark) var shouldDark: Bool = false
    
    // MARK: selection找的是对应的tag。  写id是无效的
    @State var type: Tab = {
        // 用UserDefaults读取
        /*
        let choose = UserDefaults.standard.string(forKey: UserDefaults.Key.pickerPage.rawValue) ?? ""
        let tab = Tab(rawValue: choose) ?? .picker
         */
        
        // 用AppStorage读取
        @AppStorage(.pickerPage) var tab: HomeScreen.Tab = .picker
        
        return tab
    }()
    
    var body: some View {
        NavigationStack {
            TabView(selection: $type) {
                // MARK: 用ForEach建立的内建了tag和id
                ForEach(Tab.allCases, id: \.self) { item in
                    item
                }
            }
            // MARK: - 能让present的也响应主题模式，不过需要再Navigation中生效
            .preferredColorScheme(shouldDark ? .dark : .light)
    //        .environment(\.colorScheme, shouldDark ? .dark : .light)
        }
    }
}

extension HomeScreen {
    enum Tab: String, CaseIterable, View {
        case picker, list, setting
        
        
        var body: some View {
            content.tabItem {
                tabLabel
            }
        }
        
        @ViewBuilder
        private var content: some View {
            switch self {
            case .picker: FooodPickerView()
            case .list: FoodListScrenn()
            case .setting: SettingScreen()
            }
        }
        
        private var tabLabel: some View {
            switch self {
            case .picker:
                return Label(text: "主页", systemImage: .house)
            case .list:
                return Label(text: "列表", systemImage: .list)
            case .setting:
                return Label(text: "设置", systemImage: .list)
            }
        }
    }
}


struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
