//
//  ServiceDataTests.swift
//  PoliServicesTests
//
//  Created by Marcelo Simim Santos on 3/20/23.
//

@testable import PoliServices
import XCTest

final class ServiceDataTests: XCTestCase {
    private var sut: ServiceDataProtocol!
    private weak var weakSut: ServiceData!
    private let defaultsMock = UserDefaultsMock()

    override func setUp() {
        registerDependencies()
        sut = AppContainer.shared.resolve(ServiceDataProtocol.self)
        weakSut = sut as? ServiceData
    }

    override func tearDown() {
        sut = nil
        XCTAssertNil(weakSut)
    }

    func test_saveService() {
        let expectation = expectation(description: "Wait for expectation")
        let service = ServiceMock.serviceWithFullHour()

        sut.saveService(service) { expectation.fulfill() }

        waitForExpectations(timeout: 1.0)
        let totalOfServices = defaultsMock.persistedService as? Int

        XCTAssertEqual(defaultsMock.persistenceKey, "total_of_services")
        XCTAssertEqual(totalOfServices, 11)
        XCTAssertEqual(defaultsMock.setCount, 2)
    }

    func test_removeService() {
        sut.removeService()

        XCTAssertEqual(defaultsMock.removeObjectCount, 1)
        XCTAssertEqual(defaultsMock.persistenceKey, "service")
        XCTAssertEqual(defaultsMock.totalOfServices, 9)
    }

    func test_getTotalOfServices() {
        XCTAssertEqual(sut.getTotalOfServices(), defaultsMock.totalOfServices)
    }

    func test_getService() {
        let service = sut.getService()

        XCTAssertEqual(defaultsMock.persistenceKey, "service")
        XCTAssertEqual(service?.layout.name, "test_name")
    }

    func test_getServiceDateBegin() {
        let timeInterval = sut.getServiceDateBegin()

        XCTAssertEqual(timeInterval, defaultsMock.serviceMock.startDate)
    }

    func test_getServiceDateEnd() {
        let timeInterval = sut.getServiceDateEnd()

        XCTAssertEqual(timeInterval, defaultsMock.serviceMock.endDate)
    }

    private func registerDependencies() {
        AppContainer.shared.removeAll()

        AppContainer.shared.register(ServiceDataProtocol.self) { _ in
            ServiceData(defaults: self.defaultsMock)
        }
    }

}
