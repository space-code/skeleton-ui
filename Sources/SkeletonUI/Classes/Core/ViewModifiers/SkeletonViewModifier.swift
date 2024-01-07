//
// skeleton-ui
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - SkeletonViewModifier

public struct SkeletonViewModifier<ContentView: View>: ViewModifier {
    // MARK: Properties

    /// A boolean indicating whether the skeleton view is active or not.
    private let isEnabled: Bool
    /// The configuration for the skeleton view.
    private let configuration: SkeletonConfiguration
    /// A closure providing the content view for each line of the skeleton.
    private let content: (Int) -> ContentView

    // MARK: Initialization

    /// Initializes a `SkeletonViewModifier` with specified parameters.
    ///
    /// - Parameters:
    ///   - isEnabled: A boolean indicating whether the skeleton view is active or not.
    ///   - configuration: The configuration for the skeleton view.
    ///   - content: A closure providing the content view for each line of the skeleton.
    public init(
        isEnabled: Bool,
        configuration: SkeletonConfiguration,
        @ViewBuilder content: @escaping (Int) -> ContentView
    ) {
        self.isEnabled = isEnabled
        self.configuration = configuration
        self.content = content
    }

    // MARK: ViewModifier

    public func body(content: Content) -> some View {
        if isEnabled {
            placeholderView
        } else {
            content
        }
    }

    // MARK: Private

    private var placeholderView: some View {
        VStack(spacing: configuration.spacing) {
            ForEach(.zero ..< configuration.numberOfLines, id: \.self) { index in
                GeometryReader { geometry in
                    content(index)
                        .frame(width: (configuration.scales[safe: index] ?? 1) * geometry.size.width)
                }
            }
            .shimmering(isActive: true, gradient: configuration.gradient, animation: configuration.animation)
        }
        .padding(configuration.insets)
    }
}

// MARK: - Extensions

public extension View {
    func skeleton<ContentView: View>(
        isEnabled: Bool,
        configuration: SkeletonConfiguration = SkeletonConfiguration(),
        @ViewBuilder content: @escaping ((Int) -> ContentView)
    ) -> some View {
        modifier(
            SkeletonViewModifier(
                isEnabled: isEnabled,
                configuration: configuration,
                content: content
            )
        )
    }
}

// MARK: - Constants

private extension CGFloat {
    static let cornerRadius: CGFloat = 8.0
}
