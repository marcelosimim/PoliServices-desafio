//
//  ServiceAPIModel.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/22/22.
//

import Foundation

struct ServiceAPIModel: Decodable {
    let id: Int
    let name: String
    let icon: String
    let color: String
    let duration: Int
}
