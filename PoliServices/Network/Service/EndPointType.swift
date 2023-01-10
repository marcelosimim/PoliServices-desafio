//
//  EndPointType.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 1/9/23.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
}
