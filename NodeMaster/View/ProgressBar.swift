//
//  ProgressBar.swift
//  NodeMaster
//
//  Created by Roman Yarmoliuk on 30.05.2023.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var value: TimeInterval
    let maxValue: TimeInterval
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle().frame(width: min(CGFloat(value / maxValue)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemBlue))
                    .animation(.linear)
            }.cornerRadius(45.0)
        }
    }
}
