//
//  BackButton.swift
//  NodeMaster
//
//  Created by Roman Yarmoliuk on 18.06.2023.
//

import SwiftUI

struct BackButton: View {
    var body: some View {
        Image(systemName: "arrow.left")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 30)
            .foregroundColor(.white)
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
    }
}
