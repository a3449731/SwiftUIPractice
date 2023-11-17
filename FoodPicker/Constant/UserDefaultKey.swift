//
//  UserDefaultKey.swift
//  SwiftuIGrid
//
//  Created by 杨晓斌 on 2023/7/6.
//

import SwiftUI

// 为UserDefaults存储的属性。 配合AppStorage
extension UserDefaults {
    
    enum Key: String {
        case shouldDark
        case pickerUnit
        case pickerPage
        case foodList
    }
}

