//
//  TimeInterval+Extention.swift
//  NodeMaster
//
//  Created by Roman Yarmoliuk on 30.05.2023.
//

import Foundation

extension TimeInterval {
    func formattedString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad

        return formatter.string(from: self) ?? "00:00"
    }
}
