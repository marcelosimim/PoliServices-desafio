//
//  ServiceAPI.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/22/22.
//

import Foundation

protocol ServiceAPIProtocol {
    func fetchServices(completion: @escaping(Result<ServiceAPIResult, Error>) -> ())
}

class ServiceAPI: ServiceAPIProtocol {
    private let urlString = "https://9a1c098c-8f75-47ad-a938-ad3f9179490a.mock.pstmn.io/services"

    func fetchServices(completion: @escaping(Result<ServiceAPIResult, Error>) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _ , error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                let results = try decoder.decode(ServiceAPIResult.self, from: data)
                completion(.success(results))
            } catch(let decoderError) {
                completion(.failure(decoderError))
            }
        }.resume()
    }
}
