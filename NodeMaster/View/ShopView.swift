//
//  ShopView.swift
//  NodeMaster
//
//  Created by Roman Yarmoliuk on 08.06.2023.
//

import SwiftUI

struct ShopView: View {
       
    @Binding var isPresented: Bool

    @State private var onFocus = 0
    @State private var selectedSkin = GameManager.shared.skin
    @State private var stars = GameManager.shared.stars

    let size = UIScreen.main.bounds.height * 0.7
    
    var body: some View {
        ZStack {
            SwiftUIWheelPicker($onFocus, items: Skin.allCases) { item in
                ZStack {
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(width: size / 2, height: size)
                        .cornerRadius(10)
                    Text("1")
                        .frame(width: 60, height: 60)
                        .background(item.color)
                    VStack {
                        Spacer()
                        Button {
                            if GameManager.shared.skins[item.rawValue]! {
//                                GameManager.shared.skins[item.rawValue] = false
                                selectedSkin = item.rawValue
                                GameManager.shared.skin = item.rawValue
                            } else if GameManager.shared.buySkin(item) {
                                selectedSkin = item.rawValue
                                GameManager.shared.skin = item.rawValue
                                stars = GameManager.shared.stars
                            }
                        } label: {
                            if GameManager.shared.skins[item.rawValue]! {
                                Text(selectedSkin == item.rawValue ? "selected" : "choose")
                                    .padding()
                            } else {
                                Text("buy(5 stars)")
                                    .padding()
                            }
                        }
                    }
                }
                .frame(width: size / 2, height: size)
            }
            .scrollScale(0.7)
            VStack {
                HStack {
                    backButton
                    Spacer()
                    HStack {
                        Text("\(stars)")
                            .font(.title3)
                            .foregroundColor(.white)
                        Image(systemName: "star.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30)
                            .foregroundColor(.white)
                    }
                }
                .frame(height: 32)
                .padding(8)
                Spacer()
            }
            .onAppear {
                stars = GameManager.shared.stars
            }
        }
    }
    private var backButton: some View {
        Button(action: {
            isPresented = false
        }) {
            BackButton()
        }
    }

}

