//
// skeleton-ui
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// <#Description#>
struct GradientAnimationView: View {
    // MARK: Properties

    @Environment(\.layoutDirection)
    private var layoutDirection

    /// <#Description#>
    @State private var isAnimating = false

    /// <#Description#>
    private let gradient: Gradient
    /// <#Description#>
    private let animation: Animation

    /// <#Description#>
    private var startPoint: UnitPoint {
        if layoutDirection == .leftToRight {
            return isAnimating ? .topLeading : .bottomTrailing
        } else {
            return isAnimating ? .bottomTrailing : .topLeading
        }
    }

    /// <#Description#>
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
    ///   - gradient: The gradient applied to the skeleton.
    ///   - animation: The animation applied to the skeleton.
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
