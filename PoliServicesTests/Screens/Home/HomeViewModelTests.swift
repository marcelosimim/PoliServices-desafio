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
        sut = AppContainer.shared.resolve(HomeViewModelProtocol.self)!
        weakSut = sut as? HomeViewModel
    }

    override func tearDown() {
        sut = nil
        XCTAssertNil(weakSut)
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

    func test_setupService_when_HasService() {
        let expectation = expectation(description: "Wait for completion")
        let serviceDataMock = sut.serviceData as? ServiceDataMock
        serviceDataMock?.service = ServiceMock.serviceFinishedMock()

        sut.showServiceCompletion = { service in
            expectation.fulfill()
            XCTAssertEqual(serviceDataMock?.getServiceCount, 2)
            XCTAssertEqual(service.layout.name, "test_name")
        }

        sut.setupService()
        waitForExpectations(timeout: 1.0)
    }

    func test_setupService_when_hasNoService() {
        let expectation = expectation(description: "Wait for completion")
        let serviceDataMock = sut.serviceData as? ServiceDataMock
        serviceDataMock?.getServiceHasService = false

        sut.removeServiceCompletion = { expectation.fulfill() }
        sut.setupService()

        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(serviceDataMock?.removeServiceCount, 1)
    }

    func test_calculateTime_when_isLeftingFullhour() {
        let expectation = expectation(description: "Wait for completion")

        sut.countdownCompletion = { text in
            expectation.fulfill()
            XCTAssertEqual(text, "Falta 0 hora")
        }

        sut.setupService()
        waitForExpectations(timeout: 1.0)
    }

    func test_calculateTime_when_isLeftingOneDay() {
        let expectation = expectation(description: "Wait for completion")
        let serviceDataMock = sut.serviceData as? ServiceDataMock

        serviceDataMock?.service = ServiceMock.serviceWithOneDay()

        sut.countdownCompletion = { text in
            expectation.fulfill()
            XCTAssertEqual(text, "Falta 1 dia.")
        }

        sut.setupService()
        waitForExpectations(timeout: 1.0)
    }

    func test_calculateTime_when_isLeftingLastThanOneDay() {
        let expectation = expectation(description: "Wait for completion")
        let serviceDataMock = sut.serviceData as? ServiceDataMock

        serviceDataMock?.service = ServiceMock.serviceWithLastThanDay()

        sut.countdownCompletion = { text in
            expectation.fulfill()
            XCTAssertEqual(text, "Faltam menos de 1 dia.")
        }

        sut.setupService()
        waitForExpectations(timeout: 1.0)
    }

    func test_calculateTime_when_isLeftingBrokenHour() {
        let expectation = expectation(description: "Wait for completion")
        let serviceDataMock = sut.serviceData as? ServiceDataMock

        serviceDataMock?.service = ServiceMock.serviceWithBrokenHour()

        sut.countdownCompletion = { text in
            expectation.fulfill()
            XCTAssertEqual(text, "Falta 1 hora e 30 minutos para o atendimento.")
        }

        sut.setupService()
        waitForExpectations(timeout: 1.0)
    }

    func test_calculateTime_when_isLeftingLastThanOneHour() {
        let expectation = expectation(description: "Wait for completion")
        let serviceDataMock = sut.serviceData as? ServiceDataMock

        serviceDataMock?.service = ServiceMock.serviceWithLastThanOneHour()

        sut.countdownCompletion = { text in
            expectation.fulfill()
            XCTAssertEqual(text, "Faltam 10 minutos para o atendimento.")
        }

        sut.setupService()
        waitForExpectations(timeout: 1.0)
    }

    private func registerDependecies() {
        AppContainer.shared.removeAll()
        
        AppContainer.shared.register(ServiceDataProtocol.self) { _ in ServiceDataMock() }
        AppContainer.shared.register(HomeViewModelProtocol.self) { r in HomeViewModel(serviceData: r.resolve(ServiceDataProtocol.self)!) }
    }
}
