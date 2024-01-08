//
// skeleton-ui
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// Represents different presentation behaviors for skeleton loading effects.
public enum SkeletonPresentationBehavior {
    /// The skeleton loading effect is presented automatically based on context.
    case automatic

    /// The skeleton loading effect is presented manually with an optional isEnabled flag.
    case manually(isEnabled: Bool)
}
