//
//  View+.swift
//  SwiftuIGrid
//
//  Created by 杨晓斌 on 2023/7/5.
//

import SwiftUI

extension View {
    // 自定义buttonStyle
    func mainButtonStyle(shape: ButtonBorderShape = .capsule) -> some View {
        buttonStyle(.borderedProminent)
            .buttonBorderShape(shape)
            .controlSize(.large)
    }
    
    // 圆角背景
    func roundedRectBackground(radius: CGFloat = 8, fill: some ShapeStyle = .bg) -> some View {
        background(RoundedRectangle(cornerRadius: radius).fill(fill))
    }
    
    // 我的sheet弹窗
    func mySheet(item: Binding<(some View & Identifiable)?>) -> some View {
        sheet(item: item) { result in
            result
        }
    }
    
    // MARK: 注释，打标Tag，配上markdown语法[](://)可在注释中跳转。
    
    /// 对其
    /// - Tag: 对其
    func alignment(to alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, alignment: alignment)
    }
    
    /// 为中心对齐提供的hleper方法
    /// Shortcut: [跳去实际的位置](x-source-tag://对其)
    func maxWidth() -> some View {
        alignment(to: .center)
    }
    
    /// 读取高度
    func readGeometry<key: PreferenceKey, Value>(key: key.Type, path: KeyPath<GeometryProxy, Value>) -> some View where key.Value == Value {
        overlay {
            GeometryReader { proxy in
                Color.clear
                    .preference(key: key, value: proxy[keyPath: path])
            }
        }
    }
}
