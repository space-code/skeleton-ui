//
// skeleton-ui
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - ShimmerViewModifier

public struct ShimmerViewModifier: ViewModifier {
    // MARK: Properties

    /// The gradient applied to the shimmer effect.
    private let gradient: Gradient
    /// The animation applied to the shimmer effect.
    private let animation: Animation

    @Environment(\.layoutDirection)
    private var layoutDirection

    // MARK: Initialization

    /// Initializes a `ShimmerModifier` with specified gradient, animation, and phase.
    ///
    /// - Parameters:
    ///   - gradient: The gradient applied to the shimmer effect.
    ///   - animation: The animation applied to the shimmer effect.
    public init(gradient: Gradient, animation: Animation) {
        self.gradient = gradient
        self.animation = animation
    }

    // MARK: ViewModifier

    public func body(content: Content) -> some View {
        content
            .mask(GradientAnimationView(gradient: gradient, animation: animation))
    }
}

// MARK: - Extensions

public extension View {
    @ViewBuilder
    func shimmering(
        isActive: Bool,
        gradient: Gradient = SkeletonConstants.gradient,
        animation: Animation = SkeletonConstants.animation
    ) -> some View {
        if isActive {
            modifier(ShimmerViewModifier(gradient: gradient, animation: animation))
        } else {
            self
        }
    }
}
