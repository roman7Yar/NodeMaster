//
//  WinViewModel.swift
//  NodeMaster
//
//  Created by Roman Yarmoliuk on 06.06.2023.
//

import SwiftUI

class WinViewModel: ObservableObject {
   
    let level: Int
    let time: TimeInterval
    
    var stars: Int {
        switch level {
        case 0..<8: return getStars(goalTime: 90, resultTime: time)
        case 8...50: return getStars(goalTime: 60, resultTime: time)
        default: return 0
        }
    }
    
    init(level: Int, time: TimeInterval) {
        self.level = level
        self.time = time
    }
    
    func saveResult() {
        GameManager.shared.setLevel(Level(level: level, stars: stars))
    }

    func getWinTime() -> String {
        return "\(time.formattedString())"
    }
    
    func unlockNextLevel() {
        if level == GameManager.shared.level {
            GameManager.shared.increeseLevel()
        }
    }
    
    func saveStars() {
        GameManager.shared.stars += stars
    }
   
    private func getStars(goalTime: TimeInterval, resultTime: TimeInterval) -> Int {
       
        let percent = resultTime / goalTime
        
        switch percent {
        case 0.0..<0.30: return 1
        case 0.30...0.50: return 2
        default: return 3
        }
    }
    
}
