//
// skeleton-ui
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - SkeletonConstants

/// Constants used for configuring the skeleton view.
public enum SkeletonConstants {
    /// Default animation for the skeleton view.
    public static let animation: Animation = .linear(duration: .animationDuration).repeatForever(autoreverses: false)

    /// Default gradient for the skeleton view.
    public static let gradient: Gradient = .init(
        stops: [
            .init(color: .gray.opacity(.opacity), location: 0.8),
            .init(color: .gray, location: 0.9),
            .init(color: .gray.opacity(.opacity), location: 1.0),
        ]
    )
}

// MARK: - Constants

private extension Double {
    static let animationDuration: Double = 1.5
    static let opacity: Double = 0.3
}
