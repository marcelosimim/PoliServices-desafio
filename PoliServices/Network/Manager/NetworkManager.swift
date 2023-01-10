//
//  NetworkManager.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 1/9/23.
//

import Foundation

protocol ServiceAPIProtocol {
    func fetchServices(completion: @escaping(Result<ServiceAPIResult, Error>) -> ())
}

protocol ReasonAPIProtocol {
    func fetchReasons(completion: @escaping(Result<[Reason], Error>) -> ())
    func sendReason(reason: Reason, text: String?, completion: @escaping((Error?) -> ()))
}

struct NetworkManager {
    private let router = Router<DevPoliApi>()
}

extension NetworkManager: ServiceAPIProtocol {
    func fetchServices(completion: @escaping (Result<ServiceAPIResult, Error>) -> ()) {
        router.request(.service) { data, response, error in
            guard let data = data else {
                if let error = error {
                    print(error)
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                let results = try decoder.decode(ServiceAPIResult.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(results))
                }
            } catch {
                DispatchQueue.main.async {
                    print(error)
                    completion(.failure(error))
                }
            }
        }
    }
}

extension NetworkManager: ReasonAPIProtocol {
    func fetchReasons(completion: @escaping (Result<[Reason], Error>) -> ()) {
        router.request(.reason) { data, response, error in
            guard let data = data else {
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                let results = try decoder.decode(Array<Reason>.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(results))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

    func sendReason(reason: Reason, text: String?, completion: @escaping ((Error?) -> ())) {
        router.request(.cancel(reason: reason, text: text)) { _, _, error in
            completion(error)
        }
    }
}

