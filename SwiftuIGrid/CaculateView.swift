//
//  CaculateView.swift
//  SwiftuIGrid
//
//  Created by 杨晓斌 on 2023/6/21.
//

import SwiftUI

struct TextButton: View {
    var text: String
    
    init(text: String) {
        self.text = text
    }    
    
    var body: some View {
        Button {
            
        } label: {
            Text(text)
                .alignment()
        }.buttonStyle(.bordered)
    }
}

struct CaculateView: View {
    let caculatorInput = [
        ["AC", "+/-", "%", "--"],
        ["7", "8", "9", "x"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]
        
    var body: some View {
        VStack {
            Text("0")
                .foregroundColor(.white)
                .padding()
                .alignment(to: .trailing)
                .background(RoundedRectangle(cornerRadius: 8).foregroundStyle(.gray.gradient.opacity(0.4)))
            
            Grid {
                ForEach(caculatorInput.dropLast(), id: \.self) { row in
                    GridRow {
                        ForEach(row, id: \.self) { item in
                            TextButton(text: item)
                        }
                    }
                }
                
                GridRow {
                    TextButton(text: "0").gridCellColumns(2)
//                        .gridColumnAlignment(.leading)
//                        .gridCellAnchor(.leading)
                    TextButton(text: ".")
//                        .gridCellAnchor(.bottomLeading)
//                        .gridColumnAlignment(.leading)
                    TextButton(text: "=")

                }
            }
        }.padding(.horizontal)
        
    }
}

struct CaculateView_Previews: PreviewProvider {
    static var previews: some View {
        CaculateView()
    }
}
