//
//  ServiceType.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/19/22.
//

import Foundation
import UIKit

enum ServiceType {
    case code
    case career
    case interview
    case feedback

    var image: UIImage {
        switch self {
        case .code:
            return .code
        case .career:
            return .career
        case .interview:
            return .interview
        case .feedback:
            return .feedback
        }
    }

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
        }
    }

    var color: UIColor {
        switch self {
        case .code:
            return .code
        case .career:
            return .career
        case .interview:
            return .interview
        case .feedback:
            return .feedback
        }
    }
}
