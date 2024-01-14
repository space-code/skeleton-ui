//
// skeleton-ui
// Copyright © 2024 Space Code. All rights reserved.
//

import SkeletonUI
import SnapshotTesting
import SwiftUI
import XCTest

// MARK: - SkeletonUITests

final class SkeletonUITests: XCTestCase {
    // MARK: Properties

    #if os(iOS) || os(tvOS)
        private var config: ViewImageConfig {
            #if os(iOS)
                return .iPhone13ProMax
            #else
                return .tv
            #endif
        }

        private var prefix: String {
            #if os(iOS)
                return "iphone"
            #else
                return "tv"
            #endif
        }
    #endif

    #if os(iOS) || os(tvOS)
        func test_thatSkeletonViewShowsAndAnimatesASingleView_whenViewHasCustomConfiguration() {
            assertSnapshots(
                of: SkeletonView(
                    behavior: .manually(isEnabled: true),
                    data: [Item.fake()],
                    quantity: 1,
                    configuration: SkeletonConfiguration(
                        numberOfLines: 2,
                        scales: [1.0, 0.5],
                        spacing: .spacing,
                        insets: EdgeInsets(top: .spacing, leading: .spacing, bottom: .spacing, trailing: .spacing)
                    ),
                    builder: { text, _ in Text(text?.text ?? "") }
                ),
                as: [.image(layout: .device(config: config), traits: .dark)],
                testName: #function + prefix
            )
        }

        func test_thatSkeletonViewShowsAndAnimatesMultiplesView_whenViewHasCustomLayout() {
            assertSnapshots(
                of: SkeletonView(
                    behavior: .manually(isEnabled: true),
                    data: [Item.fake()],
                    quantity: .quantity,
                    builder: builder
                ),
                as: [.image(layout: .device(config: config), traits: .dark)],
                testName: #function + prefix
            )
        }

        func test_thatSkeletonViewShowsViewContent_whenSkeletonIsDisabled() {
            assertSnapshots(
                of: SkeletonView(
                    behavior: .manually(isEnabled: false),
                    data: [Item.fake()],
                    quantity: .quantity,
                    builder: builder
                ),
                as: [.image(layout: .device(config: config), traits: .dark)],
                testName: #function + prefix
            )
        }

        func test_thatSkeletonViewShowsAndAnimationMultiplesView_whenViewTypeIsPlain() {
            assertSnapshots(
                of: SkeletonView(
                    viewType: .plain,
                    behavior: .manually(isEnabled: false),
                    data: [Item.fake()],
                    quantity: .quantity,
                    builder: builder
                ),
                as: [.image(layout: .device(config: config), traits: .dark)],
                testName: #function + prefix
            )
        }
    #endif

    #if os(iOS)
        func test_thatSkeletonViewShowsAndAnimationMultiplesView_whenDeviceIsIpad() {
            assertSnapshots(
                of: SkeletonView(
                    behavior: .manually(isEnabled: true),
                    data: [Item.fake()],
                    quantity: .quantity,
                    builder: builder
                ),
                as: [.image(layout: .device(config: .iPad9_7), traits: .dark)]
            )
        }
    #endif

    // MARK: Private

    @ViewBuilder
    private func builder(_ item: Item?, index _: Int) -> some View {
        item.map { Text($0.text) }
    }
}

// MARK: - Constants

#if os(iOS) || os(tvOS)
    private extension UITraitCollection {
        static let dark = UITraitCollection(userInterfaceStyle: .dark)
    }
#endif

private extension CGFloat {
    static let spacing = 8.0
}

private extension Int {
    static let quantity = 8
}

private extension Item {
    static func fake(text: String = "text") -> Item {
        Item(text: text)
    }
}
