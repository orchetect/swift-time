//
//  BinaryInteger+String.swift
//  SwiftTime • https://github.com/orchetect/swift-time
//

#if canImport(Foundation)

import Foundation

extension BinaryInteger {
    /// Convenience method to return a String, padded to `digitPlaces` number of leading zeros.
    @inlinable @_disfavoredOverload
    nonisolated
    func zeroPaddedString(minimumDigitPlaces: Int) -> String {
        let numberString = "\(self)"
        let padCount = minimumDigitPlaces - numberString.count
        guard padCount > 0 else { return numberString }
        let padded = String(repeating: "0", count: padCount) + numberString
        return padded
    }
}

#endif
