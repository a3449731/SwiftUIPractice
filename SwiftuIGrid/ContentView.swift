//
//  ContentView.swift
//  SwiftuIGrid
//
//  Created by 杨晓斌 on 2023/6/21.
//

import SwiftUI

struct AnimalVote: Identifiable {
    let name: String
    let vote: Int
    let rate: Double
    
    var id: String {
        name
    }
    
    static let mockSet: [AnimalVote] = [
        .init(name: "🐱 毛", vote: 20, rate: 0.5),
        .init(name: "🦋 蝴蝶蝴蝶蝴蝶", vote: 20, rate: 0.8),
        .init(name: "🐨 狗", vote: 123131, rate: 0.5)]
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            
            Grid {
                ForEach(AnimalVote.mockSet) { item in
                    GridRow() {
                        Text(item.name)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .gridColumnAlignment(.center)
                            
                        Gauge(value: item.rate) {}
                        Text("\(item.vote)").gridColumnAlignment(.trailing)
                    }
                }
                
            }
        }
        .padding()
        .dynamicTypeSize(.xSmall ... .xxxLarge)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
