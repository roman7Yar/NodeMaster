//
//  GameManager.swift
//  NodeMaster
//
//  Created by Roman Yarmoliuk on 29.05.2023.
//

import Foundation
import SwiftUI

enum Skin: String, CaseIterable {
    case green, red, black, yellow, orange
    
    var color: Color {
        switch self {
        case .green:
            return .green
        case .red:
            return .red
        case .black:
            return .black
        case .yellow:
            return .yellow
        case .orange:
            return .orange
        }
    }
}

struct GameManager {
    
    private let levelKey = "level"
    private let levelsKey = "levels"
    private let starsKey = "stars"
    private let skinKey = "skin"
    private let skinsKey = "skins"

    private init() {
       
        var dict = [String: Bool]()
        
        Skin.allCases.forEach({ skin in
           if skin == Skin.green {
               dict[skin.rawValue] = true
           } else {
               dict[skin.rawValue] = false
           }
        })

        let levels = (1...50).map { level in
            return Level(level: level, stars: 0)
        }
      
        var dataToRegister = Data()
     
        do {
            let encoder = JSONEncoder()
            
            let data = try encoder.encode(levels)
          
            dataToRegister = data
        } catch {
            print("Unable to Encode Array of Data (\(error))")
        }
        
        UserDefaults.standard.register(defaults: [
            levelKey: 1,
            levelsKey: dataToRegister,
            starsKey: 0,
            skinKey: Skin.green.rawValue,
            skinsKey: dict
        ])
    }

    static var shared = GameManager()
    
    var level: Int {
            UserDefaults.standard.integer(forKey: levelKey)
    }
    
    var levels: [Level] {
        var levels = [Level]()
       
        if let data = UserDefaults.standard.data(forKey: "levels") {
            do {
                let decoder = JSONDecoder()
                
                let decodedData = try decoder.decode([Level].self, from: data)
                
                levels = decodedData
            } catch {
                print("Unable to Decode Data (\(error))")
            }
        }
        return levels
    }
    
    var stars: Int {
        get {
            return UserDefaults.standard.integer(forKey: starsKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: starsKey)
        }
    }
    
    var skin: String {
        get {
            UserDefaults.standard.string(forKey: skinKey) ?? Skin.green.rawValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: skinKey)
        }
    }
    
    var skins: [String: Bool] {
        get {
            return UserDefaults.standard.dictionary(forKey: skinsKey)! as! [String: Bool]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: skinsKey)
        }
    }

    func setLevel(_ level: Level) {
        var levels = self.levels
       
        if let index = levels.firstIndex(where: { $0.level == level.level }) {
            if levels[index].stars < level.stars {
                levels[index].stars = level.stars
            }
        }
      
        do {
            let encoder = JSONEncoder()
            
            let data = try encoder.encode(levels)
            
            UserDefaults.standard.set(data, forKey: levelsKey)
            
        } catch {
            print("Unable to Encode Array of Data (\(error))")
        }
    }
    
    func increeseLevel() {
        let newLevel = GameManager.shared.level + 1
       
        guard newLevel <= 50 else {
            return
        }
       
        UserDefaults.standard.set(newLevel, forKey: levelKey)
    }
     
    mutating func buySkin(_ skin: Skin) -> Bool{
        guard skins[skin.rawValue] == false else { return false }
        guard stars > 4 else { return false }
        
        skins[skin.rawValue] = true
        stars -= 5
        
        return true
    }
    
}

struct Level: Codable, Hashable {
    var level: Int
    var stars: Int
}
