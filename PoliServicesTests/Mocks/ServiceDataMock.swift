//
//  ServiceDataMock.swift
//  PoliServicesTests
//
//  Created by Marcelo Simim Santos on 3/15/23.
//

@testable import PoliServices
import Foundation

class ServiceDataMock: ServiceDataProtocol {

    var saveServiceCount = 0
    func saveService(_ service: PoliServices.Service, completion: @escaping (() -> ())) {
        saveServiceCount += 1
        completion()
    }

    func updateTotalOfServices() {

    }

    var removeServiceCount = 0
    func removeService() {
        removeServiceCount += 1
    }

    let totalOfServices = 100
    var getTotalOfServicesCount = 0

    func getTotalOfServices() -> Int {
        getTotalOfServicesCount += 1
        return totalOfServices
    }

    // MARK: - getService

    var getServiceCount = 0
    var getServiceHasService = true
    var service = ServiceMock.serviceWithFullHour()

    func getService() -> PoliServices.Service? {
        getServiceCount += 1
        return getServiceHasService ? service : nil
    }

    func getServiceDateBegin() -> TimeInterval {
        return Date().timeIntervalSince1970
    }

    func getServiceDateEnd() -> TimeInterval {
        return Date().timeIntervalSince1970
    }
}
