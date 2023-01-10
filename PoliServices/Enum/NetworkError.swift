//
//  NetworkError.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 1/9/23.
//

import Foundation

enum NetworkError: String, Error {
    case parametersNil = "Parametros são nulos"
    case encodindFailed = "A codificação do parâmetro falhou"
    case missingURL = "URL é nula"
}
