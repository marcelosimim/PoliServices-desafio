//
//  ServiceType.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/19/22.
//

import Foundation
import UIKit

enum ServiceType: Int {
    case code = 1
    case career = 2
    case interview = 3
    case feedback = 4
    case personalizedClass = 5
    case revision

    var title: String {
        switch self {
        case .code:
            return "Código"
        case .career:
            return "Carreira"
        case .interview:
            return "Entrevista"
        case .feedback:
            return "Feedback"
        case .personalizedClass:
            return "Aula personalizada"
        case .revision:
            return "Revisão"
        }
    }
}
