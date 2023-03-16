//
//  
//  NewServiceViewModel.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/19/22.
//
//
import Foundation

protocol NewServiceViewModelProtocol {
    var networkManager: NetworkManagerProtocol { get }
    var services: [ServiceLayout] { get }
    var didFinishFetchingServicesSuccess: (() -> ()) { get set }
    var didFinishFetchingServicesFailure: ((String) -> ()) { get set }

    func fetchServices()
}

final class NewServiceViewModel: NewServiceViewModelProtocol {
    var networkManager: NetworkManagerProtocol
    var services: [ServiceLayout] = []
    var didFinishFetchingServicesSuccess: (() -> ()) = { }
    var didFinishFetchingServicesFailure: ((String) -> ()) = { _ in }

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func fetchServices() {
        networkManager.fetchServices { [weak self] result in
            switch result {
            case .success(let services):
                self?.updateServices(services)
            case .failure(let failure):
                self?.didFinishFetchingServicesFailure(failure.localizedDescription)
            }
        }
    }

    private func updateServices(_ result: ServiceAPIResult) {
        for service in result.data {
            let cellModel = ServiceLayout.fromServiceAPIModel(service)
            self.services.append(cellModel)
        }

        didFinishFetchingServicesSuccess()
    }
}
