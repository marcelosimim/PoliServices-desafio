//
//  
//  Services.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/19/22.
//
//

import Foundation

struct ServiceData {
    private let serviceDateKey = "service_date"
    private let serviceNameKey = "service_name"

    func saveService(_ service: Service) {
        UserDefaults.standard.set(service.date, forKey: "service_date")
        UserDefaults.standard.set(service.name, forKey: "service_name")
    }
}

