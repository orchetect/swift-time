//
//  Time+String.swift
//  SwiftTime • https://github.com/orchetect/swift-time
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import struct Foundation.FloatingPointFormatStyle
import struct Foundation.Locale

extension Time {
    /// Initialize from a time interval string.
    nonisolated
    public init?(string: String) {
        // "00:00:00.000" is 12 characters
        guard string.count <= 20 else { return nil }

        var string = string

        if string.first == "-" {
            string = String(string.dropFirst())
            sign = .minus
        }

        var mainComponents: [String] = [""]
        var ms: String?

        for char in string {
            if char.isWholeNumber {
                if ms != nil {
                    ms?.append(char)
                } else if mainComponents.count <= 3 {
                    let lastIndex = mainComponents.endIndex.advanced(by: -1)
                    mainComponents[lastIndex].append(char)
                } else {
                    return nil
                }
            } else if char == ":", mainComponents.count < 3, ms == nil {
                mainComponents.append("")
            } else if char == ".", ms == nil {
                ms = ""
            } else {
                return nil
            }
        }

        // process main components

        guard mainComponents.allSatisfy({ !$0.isEmpty }) else { return nil }
        guard (1 ... 3).contains(mainComponents.count) else { return nil }

        switch mainComponents.count {
        case 1: // S
            seconds = Int(mainComponents[0]) ?? 0
        case 2: // M:SS
            minutes = Int(mainComponents[0]) ?? 0
            seconds = Int(mainComponents[1]) ?? 0
        case 3: // H:MM:SS
            hours = Int(mainComponents[0]) ?? 0
            minutes = Int(mainComponents[1]) ?? 0
            seconds = Int(mainComponents[2]) ?? 0
        default:
            // should never happen
            return nil
        }

        // process milliseconds

        if let ms {
            guard !ms.isEmpty else { return nil }
            milliseconds = Int(ms) ?? 0
        }
    }

    /// Returns the time formatted as an ISO 8601 extended string with the given format specifiers.
    nonisolated
    public func stringValue(format: Format = .shortest) -> String {
        let absStr = absStringValue(format: format)

        switch sign {
        case .plus: return absStr
        case .minus: return "-" + absStr
        }
    }

    /// Returns the absolute time (without sign) formatted as an ISO 8601 extended string with the given format specifiers.
    nonisolated
    private func absStringValue(format: Format = .shortest) -> String {
        switch format {
        case .shortest:
            hours != 0
            ? absStringValue(format: .h_mm_ss)
            : absStringValue(format: .m_ss)

        case .hh_mm_ss:
            "\(hPadded):\(mPadded):\(sPadded)"

        case .h_mm_ss:
            "\(hours):\(mPadded):\(sPadded)"

        case .mm_ss:
            "\(totalMinutesPadded):\(sPadded)"

        case .m_ss:
            "\(totalMinutes):\(sPadded)"

        case .ss:
            totalSecondsPadded

        case .s:
            "\(totalSeconds)"

        case .hh_mm_ss_sss:
            "\(hPadded):\(mPadded):\(sPadded).\(msPadded)"

        case .h_mm_ss_sss:
            "\(hours):\(mPadded):\(sPadded).\(msPadded)"

        case .mm_ss_sss:
            "\(totalMinutesPadded):\(sPadded).\(msPadded)"

        case .m_ss_sss:
            "\(totalMinutes):\(sPadded).\(msPadded)"

        case .ss_sss:
            "\(totalSecondsPadded).\(msPadded)"

        case .s_sss:
            "\(totalSeconds).\(msPadded)"
        }
    }
}

// 32-bit architectures don't support Int64
#if !(arch(arm) || arch(arm64_32) || arch(i386))

extension Time {
    /// Returns the time as a localized formatted string.
    @available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
    nonisolated
    public func localizedStringValue(format: Format = .shortest, locale: Locale? = nil) -> String {
        func duration(_ style: Duration.TimeFormatStyle) -> String {
            let style = if let locale { style.locale(locale) } else { style }
            return durationInterval.formatted(style)
        }
        func timeInterval(integer: some RangeExpression<Int>, fraction: some RangeExpression<Int>) -> String {
            var style: FloatingPointFormatStyle<Double> = .number
                .precision(.integerAndFractionLength(integerLimits: integer, fractionLimits: fraction))
                .grouping(.never)
                .sign(strategy: .automatic)
                .locale(.autoupdatingCurrent)
            if let locale { style = style.locale(locale) }
            return interval.formatted(style)
        }

        return switch format {
        case .shortest:
            hours != 0
            ? duration(.time(pattern: .hourMinuteSecond(
                padHourToLength: 1,
                fractionalSecondsLength: 0,
                roundFractionalSeconds: .towardZero
            )))
            : duration(.time(pattern: .minuteSecond(
                padMinuteToLength: 1,
                fractionalSecondsLength: 0,
                roundFractionalSeconds: .towardZero
            )))
        case .hh_mm_ss:
            duration(.time(pattern: .hourMinuteSecond(padHourToLength: 2, fractionalSecondsLength: 0, roundFractionalSeconds: .towardZero)))
        case .h_mm_ss:
            duration(.time(pattern: .hourMinuteSecond(padHourToLength: 1, fractionalSecondsLength: 0, roundFractionalSeconds: .towardZero)))
        case .mm_ss:
            duration(.time(pattern: .minuteSecond(padMinuteToLength: 2, fractionalSecondsLength: 0, roundFractionalSeconds: .towardZero)))
        case .m_ss:
            duration(.time(pattern: .minuteSecond(padMinuteToLength: 1, fractionalSecondsLength: 0, roundFractionalSeconds: .towardZero)))
        case .ss:
            timeInterval(integer: 2..., fraction: 0 ... 0)
        case .s:
            timeInterval(integer: 1..., fraction: 0 ... 0)
        case .hh_mm_ss_sss:
            duration(.time(pattern: .hourMinuteSecond(padHourToLength: 2, fractionalSecondsLength: 3, roundFractionalSeconds: .towardZero)))
        case .h_mm_ss_sss:
            duration(.time(pattern: .hourMinuteSecond(padHourToLength: 1, fractionalSecondsLength: 3, roundFractionalSeconds: .towardZero)))
        case .mm_ss_sss:
            duration(.time(pattern: .minuteSecond(padMinuteToLength: 2, fractionalSecondsLength: 3, roundFractionalSeconds: .towardZero)))
        case .m_ss_sss:
            duration(.time(pattern: .minuteSecond(padMinuteToLength: 1, fractionalSecondsLength: 3, roundFractionalSeconds: .towardZero)))
        case .ss_sss:
            timeInterval(integer: 2..., fraction: 3 ... 3)
        case .s_sss:
            // String(format: "%.3llf", locale: .autoupdatingCurrent, interval)
            timeInterval(integer: 1..., fraction: 3 ... 3)
        }
    }
}

#endif
