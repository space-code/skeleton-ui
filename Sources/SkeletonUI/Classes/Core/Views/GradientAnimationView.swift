//
// skeleton-ui
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct GradientAnimationView: View {
    // MARK: Properties

    @Environment(\.layoutDirection)
    private var layoutDirection

    @State private var isAnimating = false

    private let gradient: Gradient
    private let animation: Animation

    private var startPoint: UnitPoint {
        if layoutDirection == .leftToRight {
            return isAnimating ? .topLeading : .bottomTrailing
        } else {
            return isAnimating ? .bottomTrailing : .topLeading
        }
    }

    private var endPoint: UnitPoint {
        if layoutDirection == .leftToRight {
            return isAnimating ? .bottomTrailing : .topLeading
        } else {
            return isAnimating ? .topLeading : .bottomTrailing
        }
    }

    // MARK: Initialization

    init(gradient: Gradient, animation: Animation) {
        self.gradient = gradient
        self.animation = animation
    }

    // MARK: View

    var body: some View {
        LinearGradient(gradient: gradient, startPoint: startPoint, endPoint: endPoint)
            .blendMode(.screen)
            .animation(animation, value: isAnimating)
            .onAppear { isAnimating = true }
    }
}
