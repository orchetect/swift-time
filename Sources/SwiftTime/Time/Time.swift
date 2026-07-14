//
//  Time.swift
//  SwiftTime • https://github.com/orchetect/swift-time
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// Value type offering basic convenience methods related to manipulating time and formatting time
/// strings.
public struct Time {
    /// Hours time component.
    nonisolated
    public var hours = 0

    /// Minutes time component.
    nonisolated
    public var minutes = 0

    /// Seconds time component.
    nonisolated
    public var seconds = 0

    /// Milliseconds time component.
    nonisolated
    public var milliseconds = 0

    /// Sign (indicating positive or negative time duration).
    nonisolated
    public var sign: FloatingPointSign = .plus

    /// Initialize with discrete time component values.
    /// Note: negative values may cause undefined behavior.
    nonisolated
    public init(
        hours: Int,
        minutes: Int,
        seconds: Int,
        milliseconds: Int = 0,
        sign: FloatingPointSign = .plus
    ) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        self.milliseconds = milliseconds
        self.sign = sign
    }
}

extension Time: Equatable {
    nonisolated
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.interval == rhs.interval
    }
}

extension Time: Comparable {
    nonisolated
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.interval < rhs.interval
    }
}

extension Time: Hashable { }

extension Time: Identifiable {
    nonisolated
    public var id: Self {
        self
    }
}

extension Time: Sendable { }

extension Time: CustomStringConvertible {
    nonisolated
    public var description: String {
        stringValue()
    }
}
