//
//  Time+Component.swift
//  SwiftTime • https://github.com/orchetect/swift-time
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension Time {
    /// Returns the value of the given time component.
    nonisolated
    public func value(of component: Component) -> Int {
        switch component {
        case .hours: hours
        case .minutes: minutes
        case .seconds: seconds
        case .milliseconds: milliseconds
        }
    }

    /// Sets the value of the given time component.
    nonisolated
    public mutating func setValue(of component: Component, to newValue: Int) {
        switch component {
        case .hours: hours = newValue
        case .minutes: minutes = newValue
        case .seconds: seconds = newValue
        case .milliseconds: milliseconds = newValue
        }
    }

    /// Returns the string value of the given time component, optionally applying standard padding.
    nonisolated
    public func stringValue(of component: Component, padded: Bool = false) -> String {
        switch component {
        case .hours: padded ? hPadded : "\(hours)"
        case .minutes: padded ? mPadded : "\(minutes)"
        case .seconds: padded ? sPadded : "\(seconds)"
        case .milliseconds: padded ? msPadded : "\(milliseconds)"
        }
    }

    /// Returns the string value of the given time component, formatted for the given time string
    /// ``Format``.
    nonisolated
    public func stringValue(of component: Component, format: Format) -> String {
        let isPadded = format.isPadded(for: component)
        return stringValue(of: component, padded: isPadded)
    }
}
