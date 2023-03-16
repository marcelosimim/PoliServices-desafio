//
//  NetworkManagerMock.swift
//  PoliServicesTests
//
//  Created by Marcelo Simim Santos on 3/16/23.
//

import Foundation
@testable import PoliServices

class NetworkManagerMock: NetworkManagerProtocol {
    var fetchServicesCount = 0
    var fetchServicesSuccess = true
    func fetchServices(completion: @escaping (Result<PoliServices.ServiceAPIResult, Error>) -> ()) {
        fetchServicesCount += 1
        fetchServicesSuccess ? completion(.success(ServiceAPIResult(data: [ServiceAPIModel(id: 1, name: "test_name", icon: "test_icon", color: "test_color", duration: 2)]))) : completion(.failure(NetworkError.encodindFailed))
    }

    func fetchReasons(completion: @escaping (Result<[PoliServices.Reason], Error>) -> ()) {

    }

    func sendReason(reason: PoliServices.Reason, text: String?, completion: @escaping ((Error?) -> ())) {

    }
}
