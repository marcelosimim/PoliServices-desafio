//
//  DevPoliServiceEndPoint.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 1/9/23.
//

import Foundation

enum DevPoliApi: EndPointType {
    case cancel(reason: Reason, text: String?)
    case reason
    case service

    var baseURL: URL {
        guard let url = URL(string: "https://9a1c098c-8f75-47ad-a938-ad3f9179490a.mock.pstmn.io/") else { fatalError() }
        return url
    }

    var path: String {
        switch self {
        case .cancel(_):
            return "cancel/reason"
        case .reason:
            return "reasons"
        case .service:
            return "services"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .cancel(_):
            return .post
        case .reason, .service:
            return .get
        }
    }

    var task: HTTPTask {
        switch self {
        case .cancel(let reason, let text):
            let parameters: [String: Any] = ["reason": text ?? reason.description]
            return .requestParameters(bodyParameters: parameters, urlParameters: nil)
        case .reason, .service:
            return .request
        }
    }
}
