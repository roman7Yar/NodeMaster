//
//  LevelsView.swift
//  NodeMaster
//
//  Created by Roman Yarmoliuk on 02.06.2023.
//

import SwiftUI

struct LevelsView: View {
    
    let gameVM: GameViewModel
    
    @Binding var isPresented: Bool
    
    @State private var levels = GameManager.shared.levels
    @State private var level = 1
    @State private var showingGame = false
    @State private var showingPopup = false

    let gridItems = [
        GridItem(.fixed(UIScreen.main.bounds.width / 6)),
        GridItem(.fixed(UIScreen.main.bounds.width / 6)),
        GridItem(.fixed(UIScreen.main.bounds.width / 6)),
        GridItem(.fixed(UIScreen.main.bounds.width / 6)),
        GridItem(.fixed(UIScreen.main.bounds.width / 6))
    ]
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(.black)
            VStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(.black)
                        .frame(height: 30)
                    HStack {
                        backButton
                            .padding(4)
                        Spacer()
                    }
                }
                ScrollView {
                    LazyVGrid(columns: gridItems) {
                        ForEach(levels, id: \.self) { level in
                            if level.level <= GameManager.shared.level {
                                Button {
                                    self.level = level.level
                                    showingGame = true
                                } label: {
                                    LevelView(level: level)
                                        .aspectRatio(1, contentMode: .fit)
                                }
                            } else {
                                Button {
                                    showingPopup = true
                                } label: {
                                    LevelView(level: level)
                                        .aspectRatio(1, contentMode: .fit)
                                        .opacity(0.7)
                                }
                            }
                        }
                    }
                }
            }
            if showingPopup {
                CustomPopupView(isShowingPopup: $showingPopup)
            }
        }
        .fullScreenCover(isPresented: $showingGame, content: {
            GameView(gameVM: GameViewModel(level: level), isPresented: $showingGame)
        })
        .onAppear {
            levels = GameManager.shared.levels
        }
    }
    private var backButton: some View {
        Button(action: {
            isPresented = false
        }) {
            Image(systemName: "arrow.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 30)
                .foregroundColor(.white)
        }
    }
}

struct LevelView: View {

    let level: Level
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    let size = geometry.size.width / 2
                    Text("\(level.level)")
                        .frame(width: size,
                               height: size)
                        .font(.title)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .clipShape(Circle())
                    Circle()
                        .stroke(style: .init(lineWidth: 3))
                        .frame(width: size,
                               height: size)
                        .foregroundColor(.red)
                        
                }
                    
                HStack(spacing: 4) {
                    let size = geometry.size.width / 5
                    StarView(isFill: level.stars > 0 ? true : false, size: size)
                    StarView(isFill: level.stars > 1 ? true : false, size: size)
                    StarView(isFill: level.stars > 2 ? true : false, size: size)
                }
            }
            .frame(width: geometry.size.width,
                   height: geometry.size.width)
            .cornerRadius(10)
            .padding()
        }
    }
}

struct StarView: View {
   
    var isFill: Bool
    var size: CGFloat
    
    var body: some View {
            ZStack {
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size * 0.9)
                    .foregroundColor(isFill ? .white : .clear)
                Image(systemName: "star")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size)
                    .foregroundColor(.red)
            }
    }
    
}
