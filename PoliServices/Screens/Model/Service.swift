//
//  
//  Service.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/19/22.
//
//

import Foundation

struct Service: Codable {
    let creationDate: TimeInterval
    let startDate: TimeInterval
    let endDate: TimeInterval
    let layout: ServiceLayout

    init(startDate: TimeInterval, endDate: TimeInterval, layout: ServiceLayout) {
        self.creationDate = Date().timeIntervalSince1970
        self.startDate = startDate
        self.endDate = endDate
        self.layout = layout
    }
}

