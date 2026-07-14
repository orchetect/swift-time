//
//  Time+Properties.swift
//  SwiftTime • https://github.com/orchetect/swift-time
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import typealias Foundation.TimeInterval

extension Time {
    /// Get or set the time interval in seconds.
    nonisolated
    public var interval: TimeInterval {
        get {
            let s = TimeInterval(totalMinutes * 60)
                + TimeInterval(seconds)
                + (TimeInterval(milliseconds) / 1000)
            return sign == .plus ? s : -s
        }
        set {
            self = Time(seconds: newValue)
        }
    }

    /// Get or set the time interval in milliseconds.
    nonisolated
    public var millisecondsInterval: Int {
        get {
            let ms = (totalMinutes * 60 * 1000)
                + (seconds * 1000)
                + milliseconds
            return sign == .plus ? ms : -ms
        }
        set {
            self = Time(milliseconds: newValue)
        }
    }
}

// 32-bit architectures don't support Int64
#if !(arch(arm) || arch(arm64_32) || arch(i386))

extension Time {
    /// Get or set the time interval using [`Duration`](https://developer.apple.com/documentation/swift/duration).
    /// Note that setting this property reduces precision to 1 millisecond when stored in a `Time` instance.
    @available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
    nonisolated
    public var durationInterval: Duration {
        get {
            let seconds = Int64(totalSeconds)
            let atto = Int64(milliseconds * 1_000_000_000_000_000)
            let duration = sign == .plus
                ? Duration(secondsComponent: seconds, attosecondsComponent: atto)
                : Duration(secondsComponent: -seconds, attosecondsComponent: -atto)
            return duration
        }
        set {
            self = Time(duration: newValue)
        }
    }
}

#endif
