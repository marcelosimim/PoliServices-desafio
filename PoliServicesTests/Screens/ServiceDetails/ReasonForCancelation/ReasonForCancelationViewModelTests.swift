//
//  ReasonForCancelationViewModelTests.swift
//  PoliServicesTests
//
//  Created by Marcelo Simim Santos on 3/19/23.
//

@testable import PoliServices
import XCTest

final class ReasonForCancelationViewModelTests: XCTestCase {
    private var sut: ReasonForCancelationViewModelProtocol!
    private weak var weakSut: ReasonForCancelationViewModel!

    override func setUp() {
        registerDependecies()
        sut = AppContainer.shared.resolve(ReasonForCancelationViewModelProtocol.self)!
        weakSut = sut as? ReasonForCancelationViewModel
    }

    override func tearDown() {
        sut = nil
        XCTAssertNil(weakSut)
    }

    func test_fetchReasons_when_result_is_success() {
        let expectation = expectation(description: "Wait for expectation")
        #warning("Fiquei pensando se fazia o acesso ao network manager dessa maneira ou se colocava no protocolo.")
        let viewModel = sut as? ReasonForCancelationViewModel
        let networkManagerMock = viewModel?.networkManager as? NetworkManagerMock

        networkManagerMock?.fetchReasonsCompletionHandler = { result in
            expectation.fulfill()
            switch result {
            case .success(let reason): XCTAssertEqual(reason[0].id, "test_id")
            case .failure(_): XCTFail("Wait for success") }
        }

        sut.fetchReasons()

        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(networkManagerMock?.fetchReasonsCount, 1)
    }

    func test_fetchReasons_when_result_is_failure() {
        let expectation = expectation(description: "Wait for expectation")
        let viewModel = sut as? ReasonForCancelationViewModel
        let networkManagerMock = viewModel?.networkManager as? NetworkManagerMock
        networkManagerMock?.fetchReasonsHasError = true

        networkManagerMock?.fetchReasonsCompletionHandler = { result in
            expectation.fulfill()
            switch result {
            case .success(_): XCTFail("Wait for failure")
                case .failure(let error):  XCTAssertEqual(error.localizedDescription, NetworkError.missingURL.localizedDescription)}
        }

        sut.fetchReasons()

        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(networkManagerMock?.fetchReasonsCount, 1)
    }

    func test_didSelectCell() {
        sut.fetchReasons()
        sut.didSelectCell(0)

        XCTAssertEqual(sut.reasons.count, 1)
        XCTAssertEqual(sut.reasons[0].id, "test_id")
    }

    func test_sendReason_when_has_no_cell_selected() {
        let expectation = expectation(description: "Wait for expectation")
        let viewModel = sut as? ReasonForCancelationViewModel
        let networkManagerMock = viewModel?.networkManager as? NetworkManagerMock

        networkManagerMock?.sendReasonCompletionHandler = { _ in
            XCTFail("No cell selected")
        }

        sut.didFinishSendingReasonsFailure = { title, message in
            expectation.fulfill()
            XCTAssertEqual(title, "Motivo não selecionado.")
            XCTAssertEqual(message, "Escolha um motivo antes de prosseguir.")
        }

        sut.sendReason("test_reason")

        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(networkManagerMock?.sendReasonCount, 0)
    }

    func test_sendReason_when_service_has_error() {
        let networkExpectation = expectation(description: "Wait for network expectation")
        let viewModelExpectation = expectation(description: "Wait for view model expectation")
        let viewModel = sut as? ReasonForCancelationViewModel
        let networkManagerMock = viewModel?.networkManager as? NetworkManagerMock
        networkManagerMock?.sendReasonHasError = true

        networkManagerMock?.sendReasonCompletionHandler = { error in
            networkExpectation.fulfill()
            XCTAssertNotNil(error)
            XCTAssertEqual(error?.localizedDescription, NetworkError.parametersNil.localizedDescription)
        }

        sut.didFinishSendingReasonsFailure = { title, message in
            viewModelExpectation.fulfill()
            XCTAssertEqual(title, "Erro ao enviar motivo.")
            XCTAssertEqual(message, "The operation couldn’t be completed. (PoliServices.NetworkError error 0.)")
        }

        sut.fetchReasons()
        sut.didSelectCell(0)
        sut.sendReason("test_reason")

        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(networkManagerMock?.sendReasonCount, 1)
    }

    func test_sendReason_when_reason_text_is_not_valid() {
        let networkExpectation = expectation(description: "Wait for network expectation")
        let viewModelExpectation = expectation(description: "Wait for view model expectation")
        let viewModel = sut as? ReasonForCancelationViewModel
        let networkManagerMock = viewModel?.networkManager as? NetworkManagerMock

        networkManagerMock?.sendReasonCompletionHandler = { error in
            networkExpectation.fulfill()
            XCTAssertNil(error)
        }

        sut.didFinishSendingReasonsFailure = { title, message in
            viewModelExpectation.fulfill()
            XCTAssertEqual(title, "Número de caracteres inválido.")
            XCTAssertEqual(message, "Por favor, preencha novamente respeitando os limites definidos.")
        }

        sut.fetchReasons()
        sut.didSelectCell(0)
        sut.sendReason("test")

        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(networkManagerMock?.sendReasonCount, 1)
    }

    func test_sendReason_when_reason_text_is_valid() {
        let networkExpectation = expectation(description: "Wait for network expectation")
        let viewModelExpectation = expectation(description: "Wait for view model expectation")
        let viewModel = sut as? ReasonForCancelationViewModel
        let networkManagerMock = viewModel?.networkManager as? NetworkManagerMock
        let serviceDataMock = viewModel?.serviceData as? ServiceDataMock

        networkManagerMock?.sendReasonCompletionHandler = { error in
            networkExpectation.fulfill()
            XCTAssertNil(error)
        }

        sut.didFinishSendingReasonsFailure = { _, _ in XCTFail("Reason is valid") }
        sut.didFinishSendingReasonsSuccess = { viewModelExpectation.fulfill() }
        sut.fetchReasons()
        sut.didSelectCell(0)
        sut.sendReason("test_reason")

        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(networkManagerMock?.sendReasonCount, 1)
        XCTAssertEqual(serviceDataMock?.removeServiceCount, 1)
    }

    private func registerDependecies() {
        AppContainer.shared.removeAll()

        AppContainer.shared.register(ReasonForCancelationViewModelProtocol.self) { _ in ReasonForCancelationViewModel(networkManager: NetworkManagerMock(), serviceData: ServiceDataMock()) }
    }
}
