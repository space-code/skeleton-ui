//
// skeleton-ui
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// A view that animates a gradient with a specified direction.
struct GradientAnimationView: View {
    // MARK: Properties

    @Environment(\.layoutDirection)
    private var layoutDirection

    /// Indicates whether the animation is in progress.
    @State private var isAnimating = false

    /// The gradient applied to the view.
    private let gradient: Gradient

    /// The animation applied to the view.
    private let animation: Animation

    /// The starting point of the gradient based on layout direction.
    private var startPoint: UnitPoint {
        if layoutDirection == .leftToRight {
            return isAnimating ? .topLeading : .bottomTrailing
        } else {
            return isAnimating ? .bottomTrailing : .topLeading
        }
    }

    /// The ending point of the gradient based on layout direction.
    private var endPoint: UnitPoint {
        if layoutDirection == .leftToRight {
            return isAnimating ? .bottomTrailing : .topLeading
        } else {
            return isAnimating ? .topLeading : .bottomTrailing
        }
    }

    // MARK: Initialization

    /// Creates a new `GradientAnimationView` instance.
    ///
    /// - Parameters:
    ///   - gradient: The gradient applied to the view.
    ///   - animation: The animation applied to the view.
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
