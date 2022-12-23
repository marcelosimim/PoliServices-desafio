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
    private let serviceKey = "service"
    private let totalOfServices = "total_of_services"

    func saveService(_ service: Service) {
        if let encoded = try? JSONEncoder().encode(service) {
            UserDefaults.standard.set(encoded, forKey: serviceKey)
            updateTotalOfServices()
        }
    }

    func updateTotalOfServices() {
        let current = UserDefaults.standard.integer(forKey: totalOfServices)
        UserDefaults.standard.set(current+1, forKey: totalOfServices)
    }

    func removeService() {
        UserDefaults.standard.removeObject(forKey: serviceKey)
    }

    func getTotalOfServices() -> Int {
        UserDefaults.standard.integer(forKey: totalOfServices)
    }

    func getService() -> Service? {
        if let data = UserDefaults.standard.object(forKey: serviceKey) as? Data,
           let service = try? JSONDecoder().decode(Service.self, from: data) {
            return service
        }
        return nil
    }

    func getServiceDateBegin() -> TimeInterval {
        let service = UserDefaults.standard.object(forKey: serviceKey) as! Service
        return service.startDate
    }

    func getServiceDateEnd() -> TimeInterval {
        let service = UserDefaults.standard.object(forKey: serviceKey) as! Service
        return service.endDate
    }
}

