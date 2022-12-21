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
    var saveServiceCompletion: (() -> Void) { get set }

    func save(_ service: Service)
}

final class SelectDateViewModel: SelectDateViewModelProtocol {
    private let serviceData = ServiceData()
    var saveServiceCompletion: (() -> Void) = { }

    func save(_ service: Service) {
        serviceData.saveService(service)
        saveServiceCompletion()
    }
}
