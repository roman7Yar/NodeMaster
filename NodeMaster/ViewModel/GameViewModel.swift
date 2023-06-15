//
//  GameViewModel.swift
//  NodeMaster
//
//  Created by Roman Yarmoliuk on 29.05.2023.
//

import Foundation

class GameViewModel: ObservableObject {
    
    init() {}
    
    init(level: Int) {
        self.level = level
    }
   
    var level = GameManager.shared.level
    
    @Published var nextItemIndex: Int? = nil
    @Published var isWin: Bool? = nil
    
    var time: TimeInterval {
        switch level {
        case 0..<8: return 90
        case 8..<21: return 70
        case 21..<31: return 60
        case 31..<41: return 55
        case 41...maxLevel: return 50
        default: return 0
        }
    }
    
    var columns: Int {
        switch level {
        case 0: return 5
        case 1..<11: return 3
        default: return 4
        }
    }
    
    var items = [Int]()
    
    private var maxLevel = 50
    
    private var numberOfItems: Int {
        switch level {
        case 0: return 25
        case 1..<4: return 12
        case 4..<11: return 15
        case 11...maxLevel: return 20
        default: return 0
        }
    }
  
    func remove(_ item: Int) {
        guard !items.isEmpty else {
            return
        }
        
        let minValue = items.min()
        let index = items.firstIndex(of: minValue!)!
        
        if minValue == item {
            items.remove(at: index)
            SoundManager.shared.playSoundEffect(filename: .correct)
            VibrationManager.shared.vibrate(for: .correct)
        } else {
            nextItemIndex = minValue
            SoundManager.shared.playSoundEffect(filename: .wrong)
            VibrationManager.shared.vibrate(for: .wrong)
        }
    
        checkIsWin()
    }
    
    func getItems() {
        var randomArray: [Int] = []

        while randomArray.count < numberOfItems {
            
            let randomNumber = Int.random(in: 1...99)
            
            if !randomArray.contains(randomNumber) {
                randomArray.append(randomNumber)
            }
            
        }
        
        items = randomArray
    }
        
    private func checkIsWin() {
        if items.isEmpty && isWin == nil {
            isWin = true
        }
    }

}
