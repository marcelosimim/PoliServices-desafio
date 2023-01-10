//
//  ParameterEncoding.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 1/9/23.
//

import Foundation

public typealias Parameters = [String:Any]

public protocol ParameterEncoder {
 static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
