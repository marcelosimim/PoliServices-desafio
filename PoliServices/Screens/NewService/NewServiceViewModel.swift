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
    var didFinishFetchingServices: (() -> ()) { get set }

    func fetchServices()
}

final class NewServiceViewModel: NewServiceViewModelProtocol {
    private let serviceAPI = ServiceAPI()
    var services: [ServiceCellModel] = []
    var didFinishFetchingServices: (() -> ()) = { }

    func fetchServices() {
        serviceAPI.fetchServices { [weak self] result in
            switch result {
            case .success(let services):
                self?.updateServices(services)
                print(services)
            case .failure(let failure):
                print(failure)
            }
        }
    }

    private func updateServices(_ result: ServiceAPIResult) {
        for service in result.data {
            guard let cellModel = ServiceCellModel.fromServiceAPIModel(service) else {
                print("ue", service.id, service.name)
                return
            }
            self.services.append(cellModel)
        }

        didFinishFetchingServices()
    }
}
