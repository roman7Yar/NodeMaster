//
//  RushView.swift
//  NodeMaster
//
//  Created by Roman Yarmoliuk on 07.06.2023.
//

import SwiftUI

struct RushView: View {

    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    @Binding var isPresented: Bool
    
    @ObservedObject var gameVM: GameViewModel
    
    @State private var showingAlert = false
    @State private var time: TimeInterval = 20
        
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    ProgressBar(value: $time, maxValue: gameVM.time)
                        .frame(width: UIScreen.main.bounds.width / 2, height: 20)
                        .padding(.horizontal)
                    Text("\(time.formattedString())")
                        .foregroundColor(.white)
                }
                LazyVGrid(columns: gridItems()) {
                    ForEach(gameVM.items, id: \.self) { number in
                        Button {
                            gameVM.remove(number)
                        } label: {
                            Text("\(number)")
                                .frame(width: 50, height: 50)
                                .background(Skin(rawValue: GameManager.shared.skin)?.color)
                        }
                    }
                }
                .padding(.vertical)
            }
            VStack {
                HStack {
                    backButton
                    Spacer()
                    infoButton
                }
                Spacer()
            }
            .padding(8)
            if let isWin = gameVM.isWin {
                if isWin {
                    WinView(winVM: WinViewModel(level: 0, time: time),
                            gameVM: gameVM)
                    .onDisappear {
                        gameVM.getItems()
                        time = gameVM.time
                    }
                }
            }
        }
        .alert(isPresented: $showingAlert, content: {
            Alert(
                title: Text("Are you sure you want to leave the game?"),
                message: Text("Progress may be lost"),
                primaryButton: .default(Text("Yes"), action: {
                    isPresented = false
                }),
                secondaryButton: .cancel(Text("Cansel"), action: {
                    showingAlert = false
                })
            )
        })
        .onReceive(timer) { _ in
            
            if gameVM.isWin == nil && time <= 0 {
                gameVM.isWin = false
            } else if gameVM.isWin == nil {
                time -= 0.1
            }
        }
        .onAppear {
            gameVM.isWin = nil
            gameVM.getItems()
            time = gameVM.time
        }
        .onDisappear {
            gameVM.items = []
        }
    }
    
    private var backButton: some View {
        Button(action: {
            if gameVM.isWin == nil {
                showingAlert = true
            } else {
                isPresented = false
            }
        }) {
            Image(systemName: "arrow.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 30)
                .foregroundColor(.white)
        }
    }
    
    private var infoButton: some View {
        Button(action: {
            
        }) {
            ZStack {
                Image(systemName: "questionmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
                    .foregroundColor(.white)
                Image(systemName: "circle")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.red)
            }
        }
    }
  
    private func gridItems() -> [GridItem] {
        return Array(repeating: GridItem(.fixed(50), spacing: 10), count: gameVM.columns)
    }
}


