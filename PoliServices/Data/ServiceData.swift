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
    private let defaults = UserDefaults.standard

    func saveService(_ service: Service, completion: @escaping(() -> ())) {
        if let encoded = try? JSONEncoder().encode(service) {
            defaults.set(encoded, forKey: serviceKey)
            updateTotalOfServices()
        }
    }

    func updateTotalOfServices() {
        let current = UserDefaults.standard.integer(forKey: totalOfServices)
        defaults.set(current+1, forKey: totalOfServices)
    }

    func removeService() {
        defaults.removeObject(forKey: serviceKey)
    }

    func getTotalOfServices() -> Int {
        defaults.integer(forKey: totalOfServices)
    }

    func getService() -> Service? {
        if let data = UserDefaults.standard.object(forKey: serviceKey) as? Data,
           let service = try? JSONDecoder().decode(Service.self, from: data) {
            return service
        }
        return nil
    }

    func getServiceDateBegin() -> TimeInterval {
        let service = defaults.object(forKey: serviceKey) as! Service
        return service.startDate
    }

    func getServiceDateEnd() -> TimeInterval {
        let service = defaults.object(forKey: serviceKey) as! Service
        return service.endDate
    }
}

