//
//  HapticManager.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 11/09/22.
//

import SwiftUI

class HapticManager: ObservableObject {
    func haptic(type: UINotificationFeedbackGenerator.FeedbackType) {
        UINotificationFeedbackGenerator().notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}
