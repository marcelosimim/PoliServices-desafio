//
//  DevPoliServiceAPI.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/22/22.
//

import Foundation

protocol ServiceAPIProtocol {
    func fetchServices(completion: @escaping(Result<ServiceAPIResult, Error>) -> ())
}

protocol ReasonAPIProtocol {
    func fetchReasons(completion: @escaping(Result<[Reason], Error>) -> ())
    func sendReason(reason: Reason, text: String?, completion: @escaping((Error?) -> ()))
}

class DevPoliServiceAPI {
    private let baseURL = "https://9a1c098c-8f75-47ad-a938-ad3f9179490a.mock.pstmn.io/"
    private let servicePath = "services"
    private let reasonPath = "reasons"
    private let cancelReasonPath = "cancel/reason"
}

extension DevPoliServiceAPI: ServiceAPIProtocol {
    func fetchServices(completion: @escaping(Result<ServiceAPIResult, Error>) -> ()) {
        let finalURL = baseURL + servicePath
        guard let url = URL(string: finalURL) else { return }
        URLSession.shared.dataTask(with: url) { data, _ , error in
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
                let results = try decoder.decode(ServiceAPIResult.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(results))
                }
            } catch(let decoderError) {
                DispatchQueue.main.async {
                    completion(.failure(decoderError))
                }
            }
        }.resume()
    }
}

extension DevPoliServiceAPI: ReasonAPIProtocol {
    func fetchReasons(completion: @escaping (Result<[Reason], Error>) -> ()) {
        let finalURL = baseURL + reasonPath
        guard let url = URL(string: finalURL) else { return }
        URLSession.shared.dataTask(with: url) { data, _ , error in
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
            } catch(let decoderError) {
                DispatchQueue.main.async {
                    completion(.failure(decoderError))
                }
            }
        }.resume()
    }

    func sendReason(reason: Reason, text: String?, completion: @escaping((Error?) -> ())) {
        let finalURL = baseURL + cancelReasonPath
        guard let url = URL(string: finalURL) else { return }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        let parameters: [String: Any] = [
            "reason": text ?? reason.description
        ]

        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        request.timeoutInterval = 20

        URLSession.shared.dataTask(with: request) { _, _, error in
            completion(error)
        }.resume()
    }
}
