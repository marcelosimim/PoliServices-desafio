//
//  ServiceDataMock.swift
//  PoliServicesTests
//
//  Created by Marcelo Simim Santos on 3/15/23.
//

@testable import PoliServices
import Foundation

class ServiceDataMock: ServiceDataProtocol {

    func saveService(_ service: PoliServices.Service, completion: @escaping (() -> ())) {

    }

    func updateTotalOfServices() {

    }

    func removeService() {

    }

    let totalOfServices = 100
    var getTotalOfServicesCount = 0

    func getTotalOfServices() -> Int {
        getTotalOfServicesCount += 1
        return totalOfServices
    }

    var getServiceCount = 0
    func getService() -> PoliServices.Service? {
        let startDate = Date()
        let endDate = Calendar.current.date(byAdding: .hour, value: 1, to: startDate)!

        getServiceCount += 1
        return Service(startDate: startDate.timeIntervalSince1970, endDate: endDate.timeIntervalSince1970, layout: ServiceLayout(icon: "", color: "", name: "", duration: 0))
    }

    func getServiceDateBegin() -> TimeInterval {
        return Date().timeIntervalSince1970
    }

    func getServiceDateEnd() -> TimeInterval {
        return Date().timeIntervalSince1970
    }
}
