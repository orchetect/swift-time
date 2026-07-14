//
//  Time Format.swift
//  SwiftTime • https://github.com/orchetect/swift-time
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension Time {
    /// Format specifier sequence templates for use in formatting time strings.
    public enum Format: CaseIterable {
        /// Uses the shortest format that will fit the time, omitting hours if `hours == 0`.
        case shortest

        /// HH:MM:SS
        case hh_mm_ss

        /// H:MM:SS
        case h_mm_ss

        /// MM:SS
        case mm_ss

        /// M:SS
        case m_ss

        /// SS
        case ss

        /// S
        case s

        /// HH:MM:SS.sss
        case hh_mm_ss_sss

        /// H:MM:SS.sss
        case h_mm_ss_sss

        /// MM:SS.sss
        case mm_ss_sss

        /// M:SS.sss
        case m_ss_sss

        /// SS.sss
        case ss_sss

        /// S.sss
        case s_sss
    }
}

extension Time.Format: Equatable { }

extension Time.Format: Hashable { }

extension Time.Format: Identifiable {
    nonisolated
    public var id: Self {
        self
    }
}

extension Time.Format: Sendable { }
