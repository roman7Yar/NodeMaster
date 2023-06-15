//
//  GameView.swift
//  NodeMaster
//
//  Created by Roman Yarmoliuk on 29.05.2023.
//

import SwiftUI

struct GameView: View {
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @ObservedObject var gameVM: GameViewModel
    
    @Binding var isPresented: Bool

    @State private var showingAlert = false
    @State private var selectedElement = 0
    @State private var desiredIndex: Int? = nil
    @State private var barButtonHeight = CGFloat(30)
    @State private var time: TimeInterval = 20
    @State private var items: [Int]
   
    init(gameVM: GameViewModel, isPresented: Binding<Bool>) {
        self.gameVM = gameVM
        self._isPresented = isPresented
        self._time = State(initialValue: gameVM.time)
        self._items = State(initialValue: gameVM.items)
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(.black)
            
            HStack {
                LazyVGrid(columns: gridItems()) {
                    ForEach(gameVM.items, id: \.self) { number in
                        ZStack {
                            Text("\(number)")
                                .frame(width: 50, height: 50)
                                .background(Skin(rawValue: GameManager.shared.skin)?.color)
                            Rectangle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(number == desiredIndex ? Color.white : Color.clear)
                                .opacity(0.5)
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width / 3)
                .padding()
                
                VStack {
                    ZStack {
                        ProgressBar(value: $time, maxValue: gameVM.time)
                            .frame(width: UIScreen.main.bounds.width / 2, height: 20)
                            .padding(.horizontal)
                        Text("\(time.formattedString())")
                            .foregroundColor(.white)
                    }
                    ZStack {
                        SwiftUIWheelPicker($selectedElement, items: items) { item in
                            Text("\(item)")
                                .frame(width: 60, height: 60)
                                .background(Skin(rawValue: GameManager.shared.skin)?.color)
                                .padding(8)
                        }
                        .frame(width: UIScreen.main.bounds.width / 2, height: 40)
                        .padding(32)
                        Rectangle()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.clear)
                            .border(.white, width: 2)
                    }
                    Button {
                        gameVM.remove(items[selectedElement])
                        desiredIndex = gameVM.nextItemIndex
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            desiredIndex = nil
                        }
                    } label: {
                        Text("Select")
                            .font(.title2)
                            .padding(8)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }

                }
            }
            VStack {
                HStack {
                    backButton
                    Spacer()
                    infoButton
                }
                Spacer()
            }
            .padding(4)
            if let isWin = gameVM.isWin {
                if isWin {
                    WinView(winVM: WinViewModel(level: gameVM.level, time: time),
                            gameVM: gameVM)
                    .onDisappear {
                        gameVM.isWin = nil
                        gameVM.getItems()
                        items = gameVM.items
                        items.shuffle()
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
            items = gameVM.items
            items.shuffle()
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
                .frame(height: barButtonHeight)
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
    
    func gridItems() -> [GridItem] {
        return Array(repeating: GridItem(.fixed(50), spacing: 10), count: gameVM.columns)
    }
}
