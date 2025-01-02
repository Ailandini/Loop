//
//  LoopDataManagerTests.swift
//  LoopTests
//
//  Created by Anna Quinlan on 8/4/20.
//  Copyright © 2020 LoopKit Authors. All rights reserved.
//

import XCTest
import HealthKit
import LoopKit
@testable import LoopCore
@testable import Loop

public typealias JSONDictionary = [String: Any]

enum DosingTestScenario {
    case liveCapture // Includes actual dosing history, bg history, etc.
    case flatAndStable
    case highAndStable
    case highAndRisingWithCOB
    case lowAndFallingWithCOB
    case lowWithLowTreatment
    case highAndFalling

    var fixturePrefix: String {
        switch self {
        case .liveCapture:
            return "live_capture_"
        case .flatAndStable:
            return "flat_and_stable_"
        case .highAndStable:
            return "high_and_stable_"
        case .highAndRisingWithCOB:
            return "high_rising_with_cob_"
        case .lowAndFallingWithCOB:
            return "low_and_falling_with_cob_"
        case .lowWithLowTreatment:
            return "low_with_low_treatment_"
        case .highAndFalling:
            return "high_and_falling_"
        }
    }

    static let localDateFormatter = ISO8601DateFormatter.localTimeDate()

    static var dateFormatter: ISO8601DateFormatter = {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime]
        return dateFormatter
    }()


    var currentDate: Date {
        switch self {
        case .liveCapture:
            return Self.dateFormatter.date(from: "2023-07-29T19:21:00Z")!
        case .flatAndStable:
            return Self.localDateFormatter.date(from: "2020-08-11T20:45:02")!
        case .highAndStable:
            return Self.localDateFormatter.date(from: "2020-08-12T12:39:22")!
        case .highAndRisingWithCOB:
            return Self.localDateFormatter.date(from: "2020-08-11T21:48:17")!
        case .lowAndFallingWithCOB:
            return Self.localDateFormatter.date(from: "2020-08-11T22:06:06")!
        case .lowWithLowTreatment:
            return Self.localDateFormatter.date(from: "2020-08-11T22:23:55")!
        case .highAndFalling:
            return Self.localDateFormatter.date(from: "2020-08-11T22:59:45")!
        }
    }

}

extension TimeZone {
    static var fixtureTimeZone: TimeZone {
        return TimeZone(secondsFromGMT: 25200)!
    }
    
    static var utcTimeZone: TimeZone {
        return TimeZone(secondsFromGMT: 0)!
    }
}

extension ISO8601DateFormatter {
    static func localTimeDate(timeZone: TimeZone = .fixtureTimeZone) -> Self {
        let formatter = self.init()

        formatter.formatOptions = .withInternetDateTime
        formatter.formatOptions.subtract(.withTimeZone)
        formatter.timeZone = timeZone

        return formatter
    }
}

class LoopDataManagerTests: XCTestCase {
    var loopDataManager: LoopDataManager!
    
    func setUp(for test: DosingTestScenario)
    {
        loopDataManager = MockLoopDataManager(for: <#DosingTestScenario#>).loopDataManager
    }
    
    override func tearDownWithError() throws {
        loopDataManager = nil
    }
}
