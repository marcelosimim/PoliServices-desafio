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

    var fetchReasonsCount = 0
    var fetchReasonsHasError = false
    var fetchReasonsCompletionHandler: ((Result<[PoliServices.Reason], Error>) -> ())?
    func fetchReasons(completion: @escaping (Result<[PoliServices.Reason], Error>) -> ()) {
        fetchReasonsCount += 1
        fetchReasonsHasError ? fetchReasonsCompletionHandler?(.failure(NetworkError.missingURL)) : fetchReasonsCompletionHandler?(.success([Reason(id: "test_id", description: "test_description")]))
        fetchReasonsHasError ? completion(.failure(NetworkError.missingURL)) : completion(.success([Reason(id: "test_id", description: "test_description")]))
    }

    var sendReasonCount = 0
    var sendReasonHasError = false
    var sendReasonCompletionHandler: ((Error?) -> ())?
    func sendReason(reason: PoliServices.Reason, text: String?, completion: @escaping ((Error?) -> ())) {
        sendReasonCount += 1
        sendReasonHasError ? sendReasonCompletionHandler?(NetworkError.parametersNil) : sendReasonCompletionHandler?(nil)
        sendReasonHasError ? completion(NetworkError.parametersNil) : completion(nil)
    }
}
