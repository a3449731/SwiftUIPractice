//
//  SufiixWrapper.swift
//  SwiftuIGrid
//
//  Created by 杨晓斌 on 2023/6/26.
//

import Foundation

@propertyWrapper struct Suffix: Equatable, Hashable {
    var wrappedValue: Double
    
    private let suffix: String
    
    init(wrappedValue: Double, _ suffix: String) {
        self.wrappedValue = wrappedValue
        self.suffix = suffix
        Measurement(value: 2, unit: UnitArea.acres)
    }
    
    var projectedValue: String {
        wrappedValue.formatted() + " \(suffix)"
    }
}

@propertyWrapper struct SuffixString<T: Equatable & Hashable>: Equatable, Hashable {
    var wrappedValue: T
    
    private let suffix: String
    
    init(wrappedValue: T, _ suffix: String) {
        self.wrappedValue = wrappedValue
        self.suffix = suffix
    }
    
    var projectedValue: String {
        return "\(wrappedValue)" + " \(suffix)"
    }
}


extension Suffix: Codable { }
