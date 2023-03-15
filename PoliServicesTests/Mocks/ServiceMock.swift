//
//  ServiceMock.swift
//  PoliServicesTests
//
//  Created by Marcelo Simim Santos on 3/15/23.
//

@testable import PoliServices
import Foundation

struct ServiceMock {
    static func serviceFinishedMock() -> Service {
        let startDate = Date()
        let endDate = Calendar.current.date(byAdding: .hour, value: 1, to: startDate)!
        return Service(startDate: startDate.timeIntervalSince1970, endDate: endDate.timeIntervalSince1970, layout: ServiceLayout(icon: "", color: "", name: "test_name", duration: 0))
    }

    static func serviceWithFullHour() -> Service {
        let currentDate = Date()
        let startDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!
        let endDate = Calendar.current.date(byAdding: .hour, value: 1, to: startDate)!

        return Service(startDate: startDate.timeIntervalSince1970, endDate: endDate.timeIntervalSince1970, layout: ServiceLayout(icon: "", color: "", name: "test_name", duration: 0))
    }

    static func serviceWithOneDay() -> Service {
        let currentDate = Date()
        let startDate = Calendar.current.date(byAdding: .day, value: 2, to: currentDate)!
        let endDate = Calendar.current.date(byAdding: .hour, value: 1, to: startDate)!

        return Service(startDate: startDate.timeIntervalSince1970, endDate: endDate.timeIntervalSince1970, layout: ServiceLayout(icon: "", color: "", name: "test_name", duration: 0))
    }

    static func serviceWithLastThanDay() -> Service {
        let currentDate = Date()
        let startDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        let endDate = Calendar.current.date(byAdding: .hour, value: 1, to: startDate)!

        return Service(startDate: startDate.timeIntervalSince1970, endDate: endDate.timeIntervalSince1970, layout: ServiceLayout(icon: "", color: "", name: "test_name", duration: 0))
    }

    static func serviceWithBrokenHour() -> Service {
        let currentDate = Date()
        var startDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!
        startDate = Calendar.current.date(byAdding: .minute, value: 30, to: startDate)!
        let endDate = Calendar.current.date(byAdding: .hour, value: 1, to: startDate)!

        return Service(startDate: startDate.timeIntervalSince1970, endDate: endDate.timeIntervalSince1970, layout: ServiceLayout(icon: "", color: "", name: "test_name", duration: 0))
    }

    static func serviceWithLastThanOneHour() -> Service {
        let currentDate = Date()
        let startDate = Calendar.current.date(byAdding: .minute, value: 10, to: currentDate)!
        let endDate = Calendar.current.date(byAdding: .hour, value: 1, to: startDate)!

        return Service(startDate: startDate.timeIntervalSince1970, endDate: endDate.timeIntervalSince1970, layout: ServiceLayout(icon: "", color: "", name: "test_name", duration: 0))
    }
}
