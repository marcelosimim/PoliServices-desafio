//
//  ServiceDetailsViewModelTests.swift
//  PoliServicesTests
//
//  Created by Marcelo Simim Santos on 3/19/23.
//

@testable import PoliServices
import XCTest

final class ServiceDetailsViewModelTests: XCTestCase {
    private var sut: ServiceDetailsViewModelProtocol!
    private weak var weakSut: ServiceDetailsViewModel!

    override func setUp() {
        registerDependecies()
        sut = AppContainer.shared.resolve(ServiceDetailsViewModelProtocol.self)!
        weakSut = sut as? ServiceDetailsViewModel
    }

    override func tearDown() {
        sut = nil
        XCTAssertNil(weakSut)
    }

    func test_setupCancelButton_when_serviceHasMoreThanTwoHourRemaining() {
        let expectation = expectation(description: "Wait for expectation")
        let service = ServiceMock.serviceWithLastThanDay()

        sut.isCancelButtonEnabledCompletion = { isEnabled in
            expectation.fulfill()
            XCTAssertTrue(isEnabled)
        }

        sut.setupCancelButton(service: service)
        waitForExpectations(timeout: 1.0)
    }

    func test_setupCancelButton_when_serviceHasLessThanTwoHourRemaining() {
        let expectation = expectation(description: "Wait for expectation")
        let service = ServiceMock.serviceWithLastThanOneHour()

        sut.isCancelButtonEnabledCompletion = { isEnabled in
            expectation.fulfill()
            XCTAssertFalse(isEnabled)
        }

        sut.setupCancelButton(service: service)
        waitForExpectations(timeout: 1.0)
    }

    private func registerDependecies() {
        AppContainer.shared.removeAll()

        AppContainer.shared.register(ServiceDetailsViewModelProtocol.self) { _ in ServiceDetailsViewModel() }
    }
}
