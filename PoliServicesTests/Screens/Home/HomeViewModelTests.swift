//
//  HomeViewModelTests.swift
//  PoliServicesTests
//
//  Created by Marcelo Simim Santos on 3/15/23.
//

@testable import PoliServices
import XCTest

final class HomeViewModelTests: XCTestCase {
    private var sut: HomeViewModelProtocol!
    private weak var weakSut: HomeViewModel!

    override func setUp() {
        registerDependecies()
        sut = AppContainerTests.shared.resolve(HomeViewModelProtocol.self)!
        weakSut = sut as? HomeViewModel
    }

    override func tearDown() {
        sut = nil
        XCTAssertNil(weakSut)
        removeDependecies()
    }

    func test_getCurrentDate_isReturningCurrentDate() {
        let currentDate = Date().timeIntervalSince1970.formatInLongDate()

        XCTAssertEqual(sut.getCurrentDate(), currentDate)
    }
 
    func test_getTotalOfServices() {
        let serviceDataMock = sut.serviceData as? ServiceDataMock
        let totalOfServices = sut.getTotalOfServices()

        XCTAssertEqual(serviceDataMock?.getTotalOfServicesCount, 1)
        XCTAssertEqual(totalOfServices, serviceDataMock?.totalOfServices)
    }

    func test_initTimer_when_hasService() {
        let expectation = expectation(description: "Wait for completion")
        let serviceDataMock = sut.serviceData as? ServiceDataMock

        sut.showServiceCompletion = { service in
            expectation.fulfill()
            XCTAssertEqual(serviceDataMock?.getServiceCount, 1)
            XCTAssertEqual(service.layout.name, "teste")
        }

        sut.initTimer()
        waitForExpectations(timeout: 1.0)
    }

    private func registerDependecies() {
        AppContainerTests.shared.register(ServiceDataProtocol.self) { _ in ServiceDataMock() }
        AppContainerTests.shared.register(HomeViewModelProtocol.self) { r in HomeViewModel(serviceData: ServiceDataMock()) }
    }

    private func removeDependecies() {
        AppContainerTests.shared.removeAll()
    }
}
