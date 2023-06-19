//
//  CircleButton.swift
//  NodeMaster
//
//  Created by Roman Yarmoliuk on 18.06.2023.
//

import SwiftUI

struct CircleButton: View {
    let systemName: String
    let size: CGFloat
    
    var body: some View {
        ZStack {
            Image(systemName: systemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: size / 2)
                .foregroundColor(.white)
            Image(systemName: "circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: size)
                .foregroundColor(.red)
        }

    }
}

struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleButton(systemName: "home", size: 40)
    }
}
