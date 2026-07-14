//
//  Time Component.swift
//  SwiftTime • https://github.com/orchetect/swift-time
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension Time {
    /// Individual time component.
    public enum Component {
        /// Hours time component.
        case hours

        /// Minutes time component.
        case minutes

        /// Seconds time component.
        case seconds

        /// Milliseconds time component.
        case milliseconds
    }
}

extension Time.Component: Equatable { }

extension Time.Component: Hashable { }

extension Time.Component: CaseIterable { }

extension Time.Component: Sendable { }
