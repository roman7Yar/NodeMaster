//
//  PopupView.swift
//  NodeMaster
//
//  Created by Roman Yarmoliuk on 13.06.2023.
//

import SwiftUI

struct CustomPopupView: View {
    @Binding var isShowingPopup: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(.black)
                .opacity(0.2)
            VStack {
                Text("You can't open this level yet!")
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding()
                
                Button {
                    isShowingPopup = false
                } label: {
                    ZStack {
                        Text("OK ")
                            .foregroundColor(.black)
                        RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)).stroke(style: .init(lineWidth: 3))
                            .foregroundColor(.black)
                            .frame(width: 64, height: 32)
                    }
                }
                .padding()
            }
            .background(Color.pink)
            .cornerRadius(10)
            .padding()
        }
        .onTapGesture {
            
        }
    }
}

