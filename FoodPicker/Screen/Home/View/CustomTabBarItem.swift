//
//  CustomTabBarItem.swift
//  SwiftuIGrid
//
//  Created by 杨晓斌 on 2023/7/6.
//

import SwiftUI

struct CustomTabBarItem: View {
    let systemName: String
    let text: String
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Image(systemName: systemName)
                .foregroundColor(isSelected ? .red : .blue)
            
            Text(text)
                .foregroundColor(isSelected ? .red : .blue)
        }
    }
}

// 扩展自定义初始化方法
extension CustomTabBarItem {
    init(_ text: String, systemImage: SFSymbol, isSelected: Bool) {
        self.init(systemName: systemImage.rawValue, text: text, isSelected: isSelected)
    }
}

struct CustomTabBarItem_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarItem(systemName: "house", text: "你好", isSelected: true)
    }
}
