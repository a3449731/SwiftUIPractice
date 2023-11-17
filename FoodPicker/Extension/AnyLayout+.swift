//
//  AnyLayout+.swift
//  SwiftuIGrid
//
//  Created by 杨晓斌 on 2023/7/5.
//

import SwiftUI

extension AnyLayout {
    static func userVStack(if condition: Bool, spacing: CGFloat, @ViewBuilder content: @escaping () -> some View) -> some View {
        let layout = condition ? AnyLayout(VStackLayout(spacing: spacing)) : AnyLayout(HStackLayout(spacing: spacing))
        
        return layout(content)
    }
}
