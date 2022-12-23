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
    private let dateStartKey = "service_date"
    private let dateEndKey = "service_date_end"
    private let nameKey = "service_name"
    private let totalOfServices = "total_of_services"

    func saveService(_ service: Service) {
        UserDefaults.standard.set(service.startDate, forKey: dateStartKey)
        UserDefaults.standard.set(service.endDate, forKey: dateEndKey)
        UserDefaults.standard.set(service.name, forKey: nameKey)
        updateTotalOfServices()
    }

    func updateTotalOfServices() {
        let current = UserDefaults.standard.integer(forKey: totalOfServices)
        UserDefaults.standard.set(current+1, forKey: totalOfServices)
    }

    func removeService() {
        UserDefaults.standard.removeObject(forKey: dateStartKey)
        UserDefaults.standard.removeObject(forKey:nameKey)
        UserDefaults.standard.removeObject(forKey: dateEndKey)
    }

    func getServiceDateBegin() -> TimeInterval {
        TimeInterval(UserDefaults.standard.integer(forKey: dateStartKey))
    }

    func getServiceDateEnd() -> TimeInterval {
        TimeInterval(UserDefaults.standard.integer(forKey: dateEndKey))
    }

    func getServiceName() -> String {
        UserDefaults.standard.string(forKey: "service_name") ?? ""
    }

    func getTotalOfServices() -> Int {
        UserDefaults.standard.integer(forKey: totalOfServices)
    }

    func getService() -> Service? {
        let name = getServiceName()
        let begin = getServiceDateBegin()
        let end = getServiceDateEnd()
        return Service(startDate: begin, endDate: end, name: name)
    }
}

