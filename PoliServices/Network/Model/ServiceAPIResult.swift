//
//  ServiceAPIResponse.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/22/22.
//

import Foundation

struct ServiceAPIResult: Decodable {
    let data: [ServiceAPIModel]
}
