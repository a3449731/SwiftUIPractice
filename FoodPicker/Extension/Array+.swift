//
//  Array+.swift
//  SwiftuIGrid
//
//  Created by 杨晓斌 on 2023/7/11.
//

import Foundation

/// 支持RawRepresentable协议，转为字符串，使得数组可以用上AppStorage的字符串存储
extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        // 解码
        guard let data = rawValue.data(using: .utf8),
            let array = try? JSONDecoder().decode(Self.self, from: data) else {
            return nil
        }
        self = array
    }

    // 编码
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let string = String(data: data, encoding: .utf8) else {
            return ""
        }
        return string
    }
}
