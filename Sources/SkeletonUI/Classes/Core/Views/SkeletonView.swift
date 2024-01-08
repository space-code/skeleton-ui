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
    ///   - behavior: The presentation behavior.
    ///   - data: The data collection to be displayed in the view.
    ///   - quantity: The quantity of items to be displayed if the data collection is empty.
    ///   - configuration: The configuration for the skeleton placeholders.
    ///   - builder: A closure that provides the real content view for each item in the data collection.
    ///   - skeletonBuilder: A closure that provides the skeleton placeholder content for each item in the data collection.
    public init(
        behavior: SkeletonPresentationBehavior = .automatic,
        data: Data,
        quantity: Int,
        configuration: SkeletonConfiguration = SkeletonConfiguration(),
        @ViewBuilder builder: @escaping ContentBuilder,
        @ViewBuilder skeletonBuilder: @escaping (_ index: Int) -> SkeletonContent =
            { _ in RoundedRectangle(cornerRadius: .cornerRadius) }
    ) {
        self.behavior = behavior
        self.data = data
        self.quantity = quantity
        self.configuration = configuration
        self.builder = builder
        self.skeletonBuilder = skeletonBuilder
    }

    // MARK: View

    public var body: some View {
        List(.zero ..< (data.isEmpty ? quantity : data.count), id: \.self) { [self] index in
            builder(data.isEmpty ? nil : Array(data)[safe: index])
                .skeleton(
                    isEnabled: isEnabled,
                    configuration: configuration,
                    content: skeletonBuilder
                )
        }
    }
}

// MARK: - Constants

private extension CGFloat {
    /// Skeleton corner radius.
    static let cornerRadius = 8.0
}

// MARK: - Previews

#if DEBUG
    struct ContentView_Previews: PreviewProvider {
        struct Item: Identifiable {
            let id = UUID()
            let text: String
        }

        static let data: [Item] = [Item(text: "1")]

        static var previews: some View {
            ForEach(ColorScheme.allCases, id: \.self) {
                defaultView.preferredColorScheme($0)
            }
        }

        private static var defaultView: some View {
            SkeletonView(
                behavior: .manually(isEnabled: true),
                data: data,
                quantity: 7,
                configuration: SkeletonConfiguration(
                    numberOfLines: 2,
                    scales: [0.7, 0.5],
                    insets: .init(top: 8, leading: 0, bottom: 8, trailing: 0)
                )
            ) { data in
                Text(data?.text ?? "")
            }
        }
    }
#endif
