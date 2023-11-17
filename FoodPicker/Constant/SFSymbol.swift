//
//  SFSymbol.swift
//  SwiftuIGrid
//
//  Created by 杨晓斌 on 2023/7/5.
//

import SwiftUI

enum SFSymbol: String {
    
    case circle = "info.circle.fill"
    case fork = "fork.knife"
    case puls = "plus.circle.fill"
    case pencil = "pencil"
    
    case xmark = "xmark.circle.fill"
    case up = "chevron.up"
    case donw = "chevron.down"
    case globe = "globe"
    
    case moon = "moon.fill"
    case unitSigh = "numbersign"
    case house = "house.fill"
    case list = "list.bullet"
    case gear = "gearshape"
}

extension SFSymbol: View {
    var body: Image {
        Image(systemName: rawValue)
    }
    
    func resizable() -> Image {
        self.body.resizable()
    }
}


extension Label where Title == Text, Icon == Image {
    init(text: String, systemImage: SFSymbol) {
        self.init(text, systemImage: systemImage.rawValue)
    }
}
