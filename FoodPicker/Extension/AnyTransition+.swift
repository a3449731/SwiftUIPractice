//
//  AnyTransition+.swift
//  SwiftuIGrid
//
//  Created by 杨晓斌 on 2023/7/5.
//


import SwiftUI

extension AnyTransition {
    static let moveUpwithOpcacity = Self.move(edge: .top).combined(with: .opacity)
    
    static let moveLeadingWithOpacity = Self.move(edge: .leading).combined(with: .opacity)
    
    static let myTransition = Self.asymmetric(
        insertion: .opacity
            .animation(.easeIn(duration: 0.5).delay(0.2)),
        removal: .opacity
            .animation(.easeIn(duration: 0.4)))
}
