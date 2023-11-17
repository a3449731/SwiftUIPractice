//
//  ShapeStyleView.swift
//  SwiftuIGrid
//
//  Created by 杨晓斌 on 2023/6/26.
//

import SwiftUI

struct ShapeStyleView: View {
    var body: some View {
        VStack {
            Circle().fill(.teal)
            Circle().fill(.teal.gradient)
            Circle().fill(.image(.init("dinner"), scale: 0.2))
            Circle().fill(.linearGradient(colors: [.pink, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing))
            LinearGradient(gradient: /*@START_MENU_TOKEN@*/Gradient(colors: [Color.red, Color.blue])/*@END_MENU_TOKEN@*/, startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
            
            Circle().fill(.yellow).overlay {
                Text("Hello")
                    .foregroundStyle(.linearGradient(colors: [.pink, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .background(Color.bg2.scaleEffect(x: 1.5, y: 1.3)).blur(radius: 1)
                
            }
            
            Text("hello").font(.system(size: 100).bold()).foregroundStyle(.linearGradient(colors: [.pink, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing))
            
        }
    }
}

struct ShapeStyleView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeStyleView()
    }
}
