//
//  ColorView.swift
//  SwiftuIGrid
//
//  Created by 杨晓斌 on 2023/6/21.
//

import SwiftUI

struct ColorView: View {
    var color: Color
    
    init(color: Color) {
        self.color = color
    }
    
    var body: some View {
        Rectangle()
            .fill(color.gradient)
            .overlay {
                Text(color.description)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .shadow(radius: 5)
            }
            .alignment()
            
    }
}


struct GirdPracticeViewView: View {
    @State var isOn = false
    
    var body: some View {
        VStack {
            
            Grid {
                GridRow {
                    ColorView(color: .pink).gridCellColumns(2)
                    Grid {
                        ColorView(color: .blue)
                        ColorView(color: .purple)
                        ColorView(color: .brown)
                    }
                }
            }
            
            Grid {
                GridRow {
                    ColorView(color: .orange)
                    ColorView(color: .indigo)

                    Grid {
                        GridRow {
                            ColorView(color: .cyan)
                            ColorView(color: .yellow)
                        }
                        ColorView(color: .mint)
                        ColorView(color: .green)
                    }.gridCellColumns(2)
                }
            }
            
            

        }.background(.gray)
    }
}

struct GirdPracticeViewView_Previews: PreviewProvider {
    static var previews: some View {
        GirdPracticeViewView()
    }
}
