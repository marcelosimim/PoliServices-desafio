//
//  
//  SelectDateViewModel.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/19/22.
//
//
import Foundation

protocol SelectDateViewModelProtocol {
    func save(_ service: Service, completion: @escaping(() -> ()))
}

final class SelectDateViewModel: SelectDateViewModelProtocol {
    private let serviceData = ServiceData()

    func save(_ service: Service, completion: @escaping(() -> ())) {
        serviceData.saveService(service)
        completion()
    }
}
