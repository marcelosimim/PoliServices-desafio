//
//  NewServiceViewModelTests.swift
//  PoliServicesTests
//
//  Created by Marcelo Simim Santos on 3/16/23.
//

@testable import PoliServices
import XCTest

final class NewServiceViewModelTests: XCTestCase {
    private var sut: NewServiceViewModelProtocol!
    private weak var weakSut: NewServiceViewModel!

    override func setUp() {
        registerDependecies()
        sut = AppContainer.shared.resolve(NewServiceViewModelProtocol.self)!
        weakSut = sut as? NewServiceViewModel
    }

    func test_fetchServices_when_success() {
        let expectation = expectation(description: "Wait for completion")
        let networkManagerMock = sut.networkManager as? NetworkManagerMock

        sut.didFinishFetchingServicesSuccess = { [weak self] in
            expectation.fulfill()
            XCTAssertEqual(self?.sut.services.count, 1)
        }

        sut.didFinishFetchingServicesFailure = { error in XCTFail("Success expected") }

        sut.fetchServices()

        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(networkManagerMock?.fetchServicesCount, 1)
    }

    func test_fetchServices_when_failure() {
        let expectation = expectation(description: "Wait for completion")
        let networkManagerMock = sut.networkManager as? NetworkManagerMock
        networkManagerMock?.fetchServicesSuccess = false

        sut.didFinishFetchingServicesSuccess = { XCTFail("Error expected") }

        sut.didFinishFetchingServicesFailure = { error in
            expectation.fulfill()
            XCTAssertEqual(error, NetworkError.encodindFailed.localizedDescription)
        }

        sut.fetchServices()

        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(networkManagerMock?.fetchServicesCount, 1)
    }

    override func tearDown() {
        sut = nil
        XCTAssertNil(weakSut)
    }
    private func registerDependecies() {
        AppContainer.shared.removeAll()

        AppContainer.shared.register(NetworkManagerProtocol.self) { _ in NetworkManagerMock() }
        AppContainer.shared.register(NewServiceViewModelProtocol.self) { r in NewServiceViewModel(networkManager: r.resolve(NetworkManagerProtocol.self)!) }
    }
}
