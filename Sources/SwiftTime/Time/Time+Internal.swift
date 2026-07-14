//
//  Time+Internal.swift
//  SwiftTime • https://github.com/orchetect/swift-time
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension Time {
    nonisolated
    var totalSeconds: Int {
        (totalMinutes * 60) + seconds
    }

    nonisolated
    var totalSecondsPadded: String {
        totalSeconds.zeroPaddedString(minimumDigitPlaces: 2)
    }

    nonisolated
    var totalMinutes: Int {
        (hours * 60) + minutes
    }

    nonisolated
    var totalMinutesPadded: String {
        totalMinutes.zeroPaddedString(minimumDigitPlaces: 2)
    }

    nonisolated
    var hPadded: String {
        hours.zeroPaddedString(minimumDigitPlaces: 2)
    }

    nonisolated
    var mPadded: String {
        minutes.zeroPaddedString(minimumDigitPlaces: 2)
    }

    nonisolated
    var sPadded: String {
        seconds.zeroPaddedString(minimumDigitPlaces: 2)
    }

    nonisolated
    var msPadded: String {
        milliseconds.zeroPaddedString(minimumDigitPlaces: 3)
    }
}
