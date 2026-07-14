//
//  Time+Operators.swift
//  SwiftTime • https://github.com/orchetect/swift-time
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension Time {
    // MARK: - Add

    nonisolated
    public static func + (lhs: Self, rhs: Time) -> Time {
        let ms = lhs.millisecondsInterval + rhs.millisecondsInterval
        return Time(milliseconds: ms)
    }

    nonisolated
    public static func += (lhs: inout Self, rhs: Time) {
        lhs = lhs + rhs
    }

    // MARK: - Subtract

    nonisolated
    public static func - (lhs: Self, rhs: Time) -> Time {
        let ms = lhs.millisecondsInterval - rhs.millisecondsInterval
        return Time(milliseconds: ms)
    }

    nonisolated
    public static func -= (lhs: inout Self, rhs: Time) {
        lhs = lhs - rhs
    }

    // MARK: - Multiply

    nonisolated
    public static func * (lhs: Self, rhs: some FixedWidthInteger) -> Time {
        let ms = lhs.millisecondsInterval * Int(rhs)
        return Time(milliseconds: ms)
    }

    nonisolated
    public static func *= (lhs: inout Self, rhs: some FixedWidthInteger) {
        lhs = lhs * rhs
    }

    nonisolated
    public static func * <T: BinaryFloatingPoint>(lhs: Self, rhs: T) -> Time {
        let ms = T(lhs.millisecondsInterval) * rhs
        return Time(milliseconds: Int(ms))
    }

    nonisolated
    public static func *= (lhs: inout Self, rhs: some BinaryFloatingPoint) {
        lhs = lhs * rhs
    }

    // MARK: - Divide

    nonisolated
    public static func / (lhs: Self, rhs: some FixedWidthInteger) -> Time {
        let ms = lhs.millisecondsInterval / Int(rhs)
        return Time(milliseconds: ms)
    }

    nonisolated
    public static func /= (lhs: inout Self, rhs: some FixedWidthInteger) {
        lhs = lhs / rhs
    }

    nonisolated
    public static func / <F: BinaryFloatingPoint>(lhs: Self, rhs: F) -> Time {
        let ms = F(lhs.millisecondsInterval) / rhs
        return Time(milliseconds: Int(ms))
    }

    nonisolated
    public static func /= (lhs: inout Self, rhs: some BinaryFloatingPoint) {
        lhs = lhs / rhs
    }
}
