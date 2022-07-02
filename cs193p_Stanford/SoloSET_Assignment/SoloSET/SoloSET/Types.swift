//
//  Types.swift
//  SoloSET
//
//  Created by Adnan Boxwala on 25.06.22.
//

import SwiftUI

struct CardContent {
    let shape: FeatureShape
    let number: FeatureNumber
    let color: FeatureColor
    let shading: FeatureShading
}

enum FeatureShape: CaseIterable {
    case diamond
    case mycapsule
    case zapper
}

enum FeatureNumber: CaseIterable {
    case one
    case two
    case three
    
    func getNumber() -> Int {
        switch self {
        case .one:
            return 1
        case .two:
            return 2
        case .three:
            return 3
        }
    }
}

enum FeatureColor: CaseIterable {
    case green
    case purple
    case pink
    
    func getColor() -> Color {
        switch self {
        case .green:
            return Color.green
        case .purple:
            return Color.purple
        case .pink:
            return Color.pink
        }
    }
}

enum FeatureShading: CaseIterable {
    case solid
    case translucent
    case transparent
}
