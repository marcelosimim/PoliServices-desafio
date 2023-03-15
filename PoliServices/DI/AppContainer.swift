//
//  AppContainer.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 3/15/23.
//

import Foundation
import Swinject

class AppContainer {
    public static let shared = Container()

    public static func resolve<Service>(_ serviceType: Service.Type) -> Service {
        if let service = shared.resolve(serviceType) {
            return service
        }
        fatalError("DI Manager: Service resolution failed")
    }

    public static func register<Service>(_ serviceType: Service.Type, factory: @escaping (Resolver) -> Service) -> ServiceEntry<Service> {
        return shared.register(serviceType, factory: factory)
    }

    public static func removeAll() {
        shared.removeAll()
    }
}


