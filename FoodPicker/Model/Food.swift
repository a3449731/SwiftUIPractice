//
//  Food.swift
//  FoodPicker
//
//  Created by Jane Chao on 22/10/09.
//

import Foundation

struct Food: Equatable, Identifiable, Hashable {
    var id = UUID()
    var name: String
    @SuffixString("行") var sex: String = ""
    var image: String
    @Suffix("大卡") var calorie: Double = .zero
    @Suffix("g") var carb: Double = .zero
    @Suffix("g") var fat: Double = .zero
    @Suffix("g") var protein: Double = .zero
    
    static let examples = [
        Food(name: "漢堡", image: "🍔", calorie: 294, carb: 14, fat: 24, protein: 17),
        Food(name: "沙拉", image: "🥗", calorie: 89, carb: 20, fat: 0, protein: 1.8),
        Food(name: "披薩", image: "🍕", calorie: 266, carb: 33, fat: 10, protein: 11),
        Food(name: "義大利麵", image: "🍝", calorie: 339, carb: 74, fat: 1.1, protein: 12),
        Food(name: "雞腿便當", image: "🍗🍱", calorie: 191, carb: 19, fat: 8.1, protein: 11.7),
        Food(name: "刀削麵", image: "🍜", calorie: 256, carb: 56, fat: 1, protein: 8),
        Food(name: "火鍋", image: "🍲", calorie: 233, carb: 26.5, fat: 17, protein: 22),
        Food(name: "牛肉麵", image: "🐄🍜", calorie: 219, carb: 33, fat: 5, protein: 9),
        Food(name: "關東煮", image: "🥘", calorie: 80, carb: 4, fat: 4, protein: 6),
    ]
    
    static var new: Food { Food(name: "", image: "") }
    
    
    
    
}

extension Food: Codable {
    enum CodingKeys: CodingKey {
        case id
        case name
        case image
        case calorie
        case carb
        case fat
        case protein
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Food.CodingKeys> = try decoder.container(keyedBy: Food.CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: Food.CodingKeys.id)
        self.name = try container.decode(String.self, forKey: Food.CodingKeys.name)
        self.image = try container.decode(String.self, forKey: Food.CodingKeys.image)
        self._calorie = try container.decode(Suffix.self, forKey: Food.CodingKeys.calorie)
        self._carb = try container.decode(Suffix.self, forKey: Food.CodingKeys.carb)
        self._fat = try container.decode(Suffix.self, forKey: Food.CodingKeys.fat)
        self._protein = try container.decode(Suffix.self, forKey: Food.CodingKeys.protein)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Food.CodingKeys.self)
        
        try container.encode(self.id, forKey: Food.CodingKeys.id)
        try container.encode(self.name, forKey: Food.CodingKeys.name)
        try container.encode(self.image, forKey: Food.CodingKeys.image)
        try container.encode(self._calorie, forKey: Food.CodingKeys.calorie)
        try container.encode(self._carb, forKey: Food.CodingKeys.carb)
        try container.encode(self._fat, forKey: Food.CodingKeys.fat)
        try container.encode(self._protein, forKey: Food.CodingKeys.protein)
    }
}

