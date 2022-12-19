//
//  
//  SelectDate2ViewModel.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/19/22.
//
//
import Foundation

protocol SelectDate2ViewModelProtocol {
    func save(_ service: Service, completion: @escaping(() -> ()))
}

final class SelectDate2ViewModel: SelectDate2ViewModelProtocol {
    private let serviceData = ServiceData()

    func save(_ service: Service, completion: @escaping(() -> ())) {
        serviceData.saveService(service)
        completion()
    }
}
