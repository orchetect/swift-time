//
//  Time+Inits.swift
//  SwiftTime • https://github.com/orchetect/swift-time
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if canImport(Foundation)
import struct Foundation.Calendar
import struct Foundation.Date
import typealias Foundation.TimeInterval
#else
import struct FoundationEssentials.Calendar
import struct FoundationEssentials.Date
import typealias FoundationEssentials.TimeInterval
#endif

extension Time {
    /// Initialize with current system time.
    nonisolated
    public init() {
        let date = Date()
        let calendar = Calendar.current

        hours = calendar.component(.hour, from: date)
        minutes = calendar.component(.minute, from: date)
        seconds = calendar.component(.second, from: date)
        milliseconds = calendar.component(.nanosecond, from: date) / 1_000_000
    }

    /// Initialize from a time interval in seconds.
    nonisolated
    public init(seconds: Int, milliseconds: Int = 0) {
        sign = seconds < 0 ? .minus : .plus

        let seconds = abs(seconds)

        if seconds < 60 { // early return for added performance
            self.seconds = seconds
        } else {
            hours = (seconds / 60 / 60)
            minutes = (seconds / 60) % 60
            self.seconds = seconds % 60
        }

        self.milliseconds = milliseconds
    }

    /// Initialize from a time interval in seconds.
    @_disfavoredOverload
    nonisolated
    public init(seconds: TimeInterval) {
        let absSeconds = abs(seconds)
        let truncSeconds = Int(seconds)
        let absTruncSeconds = abs(truncSeconds)

        self.init(seconds: truncSeconds)
        milliseconds = Int((absSeconds - Double(absTruncSeconds)) * 1000)
    }

    /// Initialize from a time interval in milliseconds.
    nonisolated
    public init(milliseconds: Int) {
        sign = milliseconds < 0 ? .minus : .plus

        let milliseconds = abs(milliseconds)

        if milliseconds < 1000 { // early return for added performance
            self.milliseconds = milliseconds
        } else {
            hours = (milliseconds / 60 / 60 / 1000) // % 24
            minutes = (milliseconds / 60 / 1000) % 60
            seconds = (milliseconds / 1000) % 60
            self.milliseconds = milliseconds % 1000
        }
    }

    /// Initialize from a time interval in milliseconds.
    @_disfavoredOverload
    nonisolated
    public init(milliseconds: Double) {
        self.init(milliseconds: Int(milliseconds))
    }
    
    /// Initialize from a time interval using [`Duration`](https://developer.apple.com/documentation/swift/duration).
    /// Note that this conversion reduces precision to 1 millisecond when stored in a `Time` instance.
    @available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
    nonisolated
    public init(duration: Duration, rounding rule: FloatingPointRoundingRule = .towardZero) {
        let (seconds, attoseconds) = duration.components
        let ms = Int(seconds * 1000) + Int((Double(attoseconds) / 1_000_000_000_000_000.0).rounded(rule))
        self.init(milliseconds: ms)
    }
}
