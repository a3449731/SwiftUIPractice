//
//  LayoutViewTest.swift
//  SwiftuIGrid
//
//  Created by 杨晓斌 on 2023/6/22.
//

import SwiftUI

// 协议，接口
protocol UserDao {
    func insert()
    func update()
    func delete()
}

public class UserDaoImpl: UserDao {
    func insert() {
        
    }
    
    func update() {
        
    }
    
    func delete() {
        
    }
    
    
}

struct EqualSizeLayout: Layout {
    var hSpacing: CGFloat = 10
    var vSpacing: CGFloat = 10
        
    
    func findBigSize(subviews: Subviews) -> CGSize {
        let bigSize: CGSize = subviews.reduce(.zero) { maxSize, view in
            // 得到预计合适的大小
            let size = view.sizeThatFits(.unspecified)
            let maxWidth = max(maxSize.width, size.width)
            let maxHeight = max(maxSize.height, size.height)
            return .init(width: maxWidth, height: maxHeight)
        }
        return bigSize
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard let totalWidth = proposal.width, !subviews.isEmpty else { return .zero}
        
        // 为了找出所有subviews中的最大宽高
        let bigSize = findBigSize(subviews: subviews)
        
        // 宽度/最大宽度, 得到一排最多可以放几个
        let maxColumn = ((totalWidth + hSpacing) / (bigSize.width + hSpacing)).rounded(.down)
        // 有可能子view没有达到最大列数。 所以能有几列应该去最小值
        let column = min(maxColumn, CGFloat(subviews.count))
        
        // 计算宽度
        let resultWidth = (bigSize.width + hSpacing) * column - hSpacing
        // 然后算需要几行
        let rows = (CGFloat(subviews.count) / column).rounded(.up)
        // 计算高度
        let resultHeight = (bigSize.height + vSpacing) * rows - vSpacing
        print("需要几行\(rows), 几列\(column)")
        print("计算宽高\(resultWidth) \(resultHeight)")
        return CGSize(width: resultWidth, height: resultHeight)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        print("bounds宽高\(bounds)")
        let bigSize = findBigSize(subviews: subviews)
        let proposal = ProposedViewSize(bigSize)
        
        var x = bounds.minX
        var y = bounds.minY
        
        
        
        subviews.forEach { view in
            view.place(at: CGPoint(x: x, y: y), proposal: proposal)
            x += bigSize.width + hSpacing
            print("X: \(x), maxX: \(bounds.maxX)")
            if x >= bounds.maxX {
                y += bigSize.height + vSpacing
                x = bounds.minX
                
            }
        }
    }
    
    
}


struct TextsssButton: View {
    
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Button {
            
        } label: {
            Text(text).font(.title2.bold())
                .alignment()
        }.buttonStyle(.bordered)
    }
}

struct LayoutViewTest: View {
    let tags = ["WWDC22", "SwiftUI", "Swift", "Apple", "iPhone", "iPad", "iOS"]
    
    var body: some View {
        VStack {
            EqualSizeLayout(hSpacing: 10, vSpacing: 10) {
                ForEach(tags, id: \.self) { tag in
                        TextsssButton(tag)
                        TextsssButton(tag)
                        TextsssButton(tag)
                }
            }
        }
    }
}

struct LayoutViewTest_Previews: PreviewProvider {
    static var previews: some View {
        LayoutViewTest()
    }
}
