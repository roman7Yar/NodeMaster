//
//  WinView.swift
//  NodeMaster
//
//  Created by Roman Yarmoliuk on 02.06.2023.
//

import SwiftUI

struct WinView: View {
    
    let winVM: WinViewModel
    let gameVM: GameViewModel
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(.black)
                .opacity(0.8)
            
            VStack {
                Text("WIN!")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                Text("Your time:")
                    .bold()
                    .font(.title)
                    .foregroundColor(.white)
              
                ZStack {
                    let size = CGSize(width: 200, height: 50)
                    Text(winVM.getWinTime())
                        .bold()
                        .frame(width: size.width, height: size.height)
                        .font(.title)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10)
                    Rectangle()
                        .stroke(style: .init(lineWidth: 2))
                        .frame(width: size.width, height: size.height)
                        .foregroundColor(.gray)
                        .cornerRadius(10)
                }
                HStack {
                    StarView(isFill: winVM.stars > 0 ? true : false, size: 60)
                    StarView(isFill: winVM.stars > 1 ? true : false, size: 60)
                    StarView(isFill: winVM.stars > 2 ? true : false, size: 60)
                }
                .padding()
                HStack(spacing: 40) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        CircleButton(systemName: "house", size: 50)
                    }
                    Button {
                        gameVM.isWin = nil
                        gameVM.level = winVM.level
                    } label: {
                        CircleButton(systemName: "arrow.triangle.2.circlepath", size: 50)
                    }
                    if winVM.level > 0 {
                        Button {
                            gameVM.isWin = nil
                            gameVM.level = winVM.level + 1
                        } label: {
                            CircleButton(systemName: "chevron.forward", size: 50)
                        }
                    }
                }
                .padding()
            }
        }
        .onDisappear {
            winVM.saveResult()
            winVM.unlockNextLevel()
            winVM.saveStars()
        }
    }
}

