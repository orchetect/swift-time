//
//  Time+Static.swift
//  SwiftTime • https://github.com/orchetect/swift-time
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension Time {
    /// Current system time.
    nonisolated
    public static var now: Time {
        Time()
    }

    /// Zero time (`0:00`).
    nonisolated
    public static let zero = Time(hours: 0, minutes: 0, seconds: 0, milliseconds: 0, sign: .plus)
}
