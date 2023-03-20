//
//  UserDefaultsMock.swift
//  PoliServicesTests
//
//  Created by Marcelo Simim Santos on 3/20/23.
//

import Foundation
@testable import PoliServices

class UserDefaultsMock: UserDefaults {
    let serviceMock = ServiceMock.serviceWithFullHour()
    var persistedService: Any? = nil
    var persistenceKey: String? = nil
    var totalOfServices = 10

    var setCount = 0
    override func set(_ value: Any?, forKey defaultName: String) {
        persistedService = value
        persistenceKey = defaultName
        setCount += 1
    }

    var removeObjectCount = 0
    override func removeObject(forKey defaultName: String) {
        persistenceKey = defaultName
        removeObjectCount += 1
        totalOfServices -= 1
    }

    override func integer(forKey defaultName: String) -> Int {
        totalOfServices
    }

    override func object(forKey defaultName: String) -> Any? {
        persistenceKey = defaultName
        return serviceMock
    }
}
