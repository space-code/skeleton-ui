//
// skeleton-ui
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// A struct that provides configuration for a skeleton view.
public struct SkeletonConfiguration {
    // MARK: Properties

    /// The number of lines in the skeleton.
    public let numberOfLines: Int
    /// An array of scales for each line of the skeleton.
    public let scales: [CGFloat]
    /// The spacing between lines in the skeleton.
    public let spacing: CGFloat
    /// The insets around the skeleton.
    public let insets: EdgeInsets
    /// The gradient applied to the skeleton.
    public let gradient: Gradient
    /// The animation applied to the skeleton.
    public let animation: Animation

    // MARK: Initialization

    /// Initializes a `SkeletonConfiguration` with default values.
    ///
    /// - Parameters:
    ///   - numberOfLines: The number of lines in the skeleton.
    ///   - scales: An array of scales for each line of the skeleton.
    ///   - spacing: The spacing between lines in the skeleton.
    ///   - insets: The insets around the skeleton.
    ///   - gradient: The gradient applied to the skeleton.
    ///   - animation: The animation applied to the skeleton.
    public init(
        numberOfLines: Int = 4,
        scales: [CGFloat] = [],
        spacing: CGFloat = 8.0,
        insets: EdgeInsets = .init(.zero),
        gradient: Gradient = SkeletonConstants.gradient,
        animation: Animation = SkeletonConstants.animation
    ) {
        self.numberOfLines = numberOfLines
        self.scales = scales
        self.spacing = spacing
        self.insets = insets
        self.gradient = gradient
        self.animation = animation
    }
}
