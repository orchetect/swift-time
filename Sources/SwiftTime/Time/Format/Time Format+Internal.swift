//
//  Time Format+Internal.swift
//  SwiftTime • https://github.com/orchetect/swift-time
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension Time.Format {
    nonisolated
    func isPadded(for component: Time.Component) -> Bool {
        switch self {
        case .shortest:
            switch component {
            case .hours: false
            case .minutes: false
            case .seconds: true
            case .milliseconds: true
            }
        case .hh_mm_ss:
            switch component {
            case .hours: true
            case .minutes: true
            case .seconds: true
            case .milliseconds: true
            }
        case .h_mm_ss:
            switch component {
            case .hours: false
            case .minutes: true
            case .seconds: true
            case .milliseconds: true
            }
        case .mm_ss:
            switch component {
            case .hours: false
            case .minutes: true
            case .seconds: true
            case .milliseconds: true
            }
        case .m_ss:
            switch component {
            case .hours: false
            case .minutes: false
            case .seconds: true
            case .milliseconds: true
            }
        case .ss:
            switch component {
            case .hours: false
            case .minutes: false
            case .seconds: true
            case .milliseconds: true
            }
        case .s:
            switch component {
            case .hours: false
            case .minutes: false
            case .seconds: false
            case .milliseconds: true
            }
        case .hh_mm_ss_sss:
            switch component {
            case .hours: true
            case .minutes: true
            case .seconds: true
            case .milliseconds: true
            }
        case .h_mm_ss_sss:
            switch component {
            case .hours: false
            case .minutes: true
            case .seconds: true
            case .milliseconds: true
            }
        case .mm_ss_sss:
            switch component {
            case .hours: false
            case .minutes: true
            case .seconds: true
            case .milliseconds: true
            }
        case .m_ss_sss:
            switch component {
            case .hours: false
            case .minutes: false
            case .seconds: true
            case .milliseconds: true
            }
        case .ss_sss:
            switch component {
            case .hours: false
            case .minutes: false
            case .seconds: true
            case .milliseconds: true
            }
        case .s_sss:
            switch component {
            case .hours: false
            case .minutes: false
            case .seconds: false
            case .milliseconds: true
            }
        }
    }
}
