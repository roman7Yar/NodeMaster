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
                        MyButton(imageName: "house")
                    }
                    Button {
                        gameVM.isWin = nil
                        gameVM.level = winVM.level
                    } label: {
                        MyButton(imageName: "arrow.triangle.2.circlepath")
                    }
                    if winVM.level > 0 {
                        Button {
                            gameVM.isWin = nil
                            gameVM.level = winVM.level + 1
                        } label: {
                            MyButton(imageName: "chevron.forward")
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

struct MyButton: View {
    let imageName: String
    
    var body: some View {
        ZStack {
            Image(systemName: "circle")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.red)

            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 32)
                .foregroundColor(.white)
        }
    }
}
