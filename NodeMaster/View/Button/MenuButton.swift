//
//  MenuButton.swift
//  NodeMaster
//
//  Created by Roman Yarmoliuk on 18.06.2023.
//

import SwiftUI

struct MenuButton: View {
    let title: String
    
    var body: some View {
        Text(title)
            .foregroundColor(.white)
            .font(.largeTitle)
            .bold()
            .frame(width: 250)
            .padding(8)
            .background(Color.red)
            .cornerRadius(16)
    }
}

struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MenuButton(title: "Menu")
    }
}
