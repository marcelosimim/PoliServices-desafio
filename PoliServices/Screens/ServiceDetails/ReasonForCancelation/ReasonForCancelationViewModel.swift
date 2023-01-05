//
//  
//  ReasonForCancelationViewModel.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 1/4/23.
//
//
import Foundation

protocol ReasonForCancelationViewModelProtocol {
    var selectedCell: Reason? { get }
    var reasons: [Reason] { get }
    var didFinishFetchingReasonsSuccess: (() -> ()) { get set }
    var didFinishFetchingReasonsFailure: ((String, String) -> ()) { get set }
    var didFinishSendingReasonsSuccess: (() -> ()) { get set }
    var didFinishSendingReasonsFailure: ((String, String) -> ()) { get set }

    func fetchReasons()
    func didSelectCell(_ index: Int)
    func sendReason()
    func sendReason(_ text: String)
}

final class ReasonForCancelationViewModel: ReasonForCancelationViewModelProtocol {
    private let devpoliServiceAPI = DevPoliServiceAPI()
    private let serviceData = ServiceData()
    var selectedCell: Reason? = nil
    var reasons: [Reason] = []
    var didFinishFetchingReasonsSuccess: (() -> ()) = { }
    var didFinishFetchingReasonsFailure: ((String, String) -> ()) = { _, _ in }
    var didFinishSendingReasonsSuccess: (() -> ()) = { }
    var didFinishSendingReasonsFailure: ((String, String) -> ()) = { _, _ in }

    func fetchReasons() {
        devpoliServiceAPI.fetchReasons { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let reasons):
                self.reasons = reasons
                self.didFinishFetchingReasonsSuccess()
            case .failure(let error):
                self.didFinishFetchingReasonsFailure("Erro ao obter informações", error.localizedDescription)
            }
        }
    }

    func didSelectCell(_ index: Int) {
        selectedCell = reasons[index]
    }

    func sendReason() {
        guard let selectedCell else {
            didFinishSendingReasonsFailure("Motivo não selecionado.", "Escolha um motivo antes de prosseguir.")
            return
        }

        devpoliServiceAPI.sendReason(reason: selectedCell, text: nil) { [weak self] error in
            guard let self else { return }

            if let error = error {
                self.didFinishSendingReasonsFailure("Erro ao enviar motivo.", error.localizedDescription)
                return
            }

            self.serviceData.removeService()
            self.didFinishSendingReasonsSuccess()
        }
    }

    func sendReason(_ text: String) {
        guard let selectedCell else {
            didFinishSendingReasonsFailure("Motivo não selecionado.", "Escolha um motivo antes de prosseguir.")
            return
        }

        if !isNumberOfCharactersValid(text) {
            didFinishSendingReasonsFailure("Número de caracteres inválido.", "Por favor, preencha novamente respeitando os limites definidos.")
            return
        }

        devpoliServiceAPI.sendReason(reason: selectedCell, text: text) { error in

        }
    }

    private func isNumberOfCharactersValid(_ text: String) -> Bool {
        text.count >= 5 && text.count <= 100
    }
}
