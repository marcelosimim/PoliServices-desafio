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
    var services: [ServiceCellModel] { get }
    var didFinishFetchingServicesSuccess: (() -> ()) { get set }
    var didFinishFetchingServicesFailure: ((String) -> ()) { get set }

    func fetchServices()
}

final class NewServiceViewModel: NewServiceViewModelProtocol {
    private let serviceAPI = ServiceAPI()
    var services: [ServiceCellModel] = []
    var didFinishFetchingServicesSuccess: (() -> ()) = { }
    var didFinishFetchingServicesFailure: ((String) -> ()) = { _ in }

    func fetchServices() {
        serviceAPI.fetchServices { [weak self] result in
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
            guard let cellModel = ServiceCellModel.fromServiceAPIModel(service) else {
                return
            }
            self.services.append(cellModel)
        }

        didFinishFetchingServicesSuccess()
    }
}
