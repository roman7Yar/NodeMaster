//
//  ContentView.swift
//  NodeMaster
//
//  Created by Roman Yarmoliuk on 29.05.2023.
//

import SwiftUI

struct ContentView: View {
    
    var gameVM = GameViewModel()
    
    @State var isSoundOn = SoundManager.shared.sound
    
    @State private var showingGame = false
    @State private var showingRush = false
    @State private var showingLevels = false
    @State private var showingShop = false
    @State private var showingSettings = false

    init() {
        SoundManager.shared.playBackgroundMusic(filename: .bg)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundColor(.black)
                HStack {
                    VStack {
                        Button {
                            showingSettings = true
                        } label: {
                            CircleButton(systemName: "gearshape.fill", size: 40)
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .padding()
                HStack {
                    Image(systemName: "dice")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.white)
                    Spacer()
                    VStack(spacing: 16) {
                        Button {
                            showingGame = true
                        } label: {
                            MenuButton(title: "GAME")
                        }
                        Button {
                            showingRush = true
                        } label: {
                            MenuButton(title: "RUSH")
                        }
                        Button {
                            showingLevels = true
                        } label: {
                            MenuButton(title: "LEVELS")
                        }
                        Button {
                            showingShop = true
                        } label: {
                            MenuButton(title: "SHOP")
                        }
                        
                    }
                }
                .padding(.horizontal, 80)
            }
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $showingGame) {
                GameView(gameVM: gameVM, isPresented: $showingGame)
            }
            .fullScreenCover(isPresented: $showingRush) {
                RushView(isPresented: $showingRush, gameVM: GameViewModel(level: 0))
            }
            .fullScreenCover(isPresented: $showingLevels) {
                LevelsView(gameVM: gameVM, isPresented: $showingLevels)
            }
            .fullScreenCover(isPresented: $showingShop) {
                ShopView(isPresented: $showingShop)
            }
            .fullScreenCover(isPresented: $showingSettings) {
                SettingsView(isPresented: $showingSettings)
            }


            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


