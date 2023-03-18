//
//  SelectDateViewModelTests.swift
//  PoliServicesTests
//
//  Created by Marcelo Simim Santos on 3/17/23.
//

@testable import PoliServices
import XCTest

final class SelectDateViewModelTests: XCTestCase {
    private var sut: SelectDateViewModelProtocol!
    private weak var weakSut: SelectDateViewModel!

    override func setUp() {
        registerDependecies()
        sut = AppContainer.shared.resolve(SelectDateViewModelProtocol.self)!
        weakSut = sut as? SelectDateViewModel
    }

    override func tearDown() {
        sut = nil
        XCTAssertNil(weakSut)
    }

    func test_setupEndTime() {
        let expectation = expectation(description: "Wait for expectation")
        let selectedDate = Calendar.current.date(byAdding: .minute, value: 20, to: Date(timeIntervalSince1970: 1679087433.504564)) ?? Date()

        sut.didFinishCalculationEndTime = { endTime in
            expectation.fulfill()
            XCTAssertEqual(endTime, "18:30")
        }

        sut.setupEndTime(selectedDate: selectedDate, duration: 0)

        waitForExpectations(timeout: 1.0)
    }

    func test_save() {
        let notificationExpectation = expectation(description: "Wait for notification expectation")
        let serviceExpectation = expectation(description: "Wait for service expectation")
        let notificationMock = sut.notificationManager as? NotificationManagerMock
        let serviceDataMock = sut.serviceData as? ServiceDataMock
        let service = ServiceMock.serviceWithFullHour()

        notificationMock?.requestAutorizationCompletionHandler = { authorized in
            notificationExpectation.fulfill()
            XCTAssertEqual(authorized, true)
        }

        #warning("usando a linha 54 o teste na linha 67 conta 2 vezes. O correto é usar o completion handler no mock em vez da completion da função? ")
//        notificationMock?.requestAutorization(completion: { authorized in
//            notificationExpectation.fulfill()
//            XCTAssertEqual(authorized, true)
//        })

        sut.saveServiceCompletion = {
            serviceExpectation.fulfill()
            XCTAssertEqual(notificationMock?.scheduleNotificationCount, 1)
        }

        sut.save(service)
        waitForExpectations(timeout: 1.0)

        XCTAssertEqual(notificationMock?.requestAutorizationCount, 1)
        XCTAssertEqual(serviceDataMock?.saveServiceCount, 1)
    }
    
    private func registerDependecies() {
        AppContainer.shared.removeAll()

        AppContainer.shared.register(NotificationManagerProtocol.self) { _ in NotificationManagerMock() }
        AppContainer.shared.register(ServiceDataProtocol.self) { _ in ServiceDataMock() }
        AppContainer.shared.register(SelectDateViewModelProtocol.self) { r in SelectDateViewModel(notificationManager: r.resolve(NotificationManagerProtocol.self)!, serviceData: r.resolve(ServiceDataProtocol.self)!) }
    }
}
