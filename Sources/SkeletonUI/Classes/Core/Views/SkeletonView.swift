//
// skeleton-ui
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - SkeletonView

/// A view that combines real content with skeleton placeholders based on a given data collection.
public struct SkeletonView<
    Data: RandomAccessCollection,
    Content: View,
    SkeletonContent: View
>: View where Data.Element: Identifiable {
    // MARK: Types

    public typealias ContentBuilder = (_ data: Data.Element?) -> Content

    // MARK: Properties

    /// The view type.
    private let viewType: SkeletonViewType
    /// The presentation behavior.
    private let behavior: SkeletonPresentationBehavior
    /// The data collection to be displayed in the view.
    private let data: Data
    /// The quantity of items to be displayed if the data collection is empty.
    private let quantity: Int
    /// The configuration for the skeleton placeholders.
    private let configuration: SkeletonConfiguration
    /// A closure that provides the real content view for each item in the data collection.
    private let builder: ContentBuilder
    /// A closure that provides the skeleton placeholder content for each item in the data collection.
    private let skeletonBuilder: (_ index: Int) -> SkeletonContent

    private var isEnabled: Bool {
        switch behavior {
        case .automatic:
            return data.isEmpty
        case let .manually(isEnabled):
            return isEnabled
        }
    }

    // MARK: Initialization

    /// Creates a new `SkeletonView` instance.
    ///
    /// - Parameters:
    ///   - viewType: The view type.
    ///   - behavior: The presentation behavior.
    ///   - data: The data collection to be displayed in the view.
    ///   - quantity: The quantity of items to be displayed if the data collection is empty.
    ///   - configuration: The configuration for the skeleton placeholders.
    ///   - builder: A closure that provides the real content view for each item in the data collection.
    ///   - skeletonBuilder: A closure that provides the skeleton placeholder content for each item in the data collection.
    public init(
        viewType: SkeletonViewType = .list,
        behavior: SkeletonPresentationBehavior = .automatic,
        data: Data,
        quantity: Int,
        configuration: SkeletonConfiguration = SkeletonConfiguration(),
        @ViewBuilder builder: @escaping ContentBuilder,
        @ViewBuilder skeletonBuilder: @escaping (_ index: Int) -> SkeletonContent =
            { _ in RoundedRectangle(cornerRadius: 8.0) }
    ) {
        self.viewType = viewType
        self.behavior = behavior
        self.data = data
        self.quantity = quantity
        self.configuration = configuration
        self.builder = builder
        self.skeletonBuilder = skeletonBuilder
    }

    // MARK: View

    public var body: some View {
        containerView(viewType) { index in
            builder(data.isEmpty ? nil : Array(data)[safe: index])
                .skeleton(
                    isEnabled: isEnabled,
                    configuration: configuration,
                    content: skeletonBuilder
                )
        }
    }

    // MARK: Private

    /// Create a container view based on the view type.
    ///
    /// - Parameters:
    ///   - viewType: The view type.
    ///   - content: A closure that provides the real content view for each item in the data collection.
    ///
    /// - Returns: A view with the specific type.
    private func containerView(
        _ viewType: SkeletonViewType,
        @ViewBuilder content: @escaping (Range<Int>.Element) -> some View
    ) -> some View {
        switch viewType {
        case .list:
            return AnyView(List(.zero ..< (isEnabled ? quantity : data.count), id: \.self, rowContent: content))
        case .plain:
            return AnyView(ForEach(.zero ..< (isEnabled ? quantity : data.count), id: \.self, content: content))
        }
    }
}
