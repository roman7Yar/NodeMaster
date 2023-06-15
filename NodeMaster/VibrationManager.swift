//
//  VibrationManager.swift
//  NodeMaster
//
//  Created by Roman Yarmoliuk on 13.06.2023.
//

import Foundation
import UIKit

class VibrationManager {
    
    static let shared = VibrationManager()
    
    private let vibrationKey = "vibration"

    private init() {}
   
    var vibration: Bool {
        get {
            return UserDefaults.standard.bool(forKey: vibrationKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: vibrationKey)
        }
    }
    
    func vibrate(for type: VibrationType) {
        guard vibration else { return }

        type.apply()
    }
    
    enum VibrationType {
        case correct, wrong
        
        func apply() {
            switch self {
            case .correct:
                selectionVibrate()
            case .wrong:
                vibrate(for: .error)
            }
        }
        
        private func selectionVibrate() {
            let selectionFidbackGenerator = UISelectionFeedbackGenerator()
            selectionFidbackGenerator.prepare()
            selectionFidbackGenerator.selectionChanged()
        }
        
        private func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
            let notificationGenerator = UINotificationFeedbackGenerator()
            notificationGenerator.prepare()
            notificationGenerator.notificationOccurred(type)
        }
    }
}
