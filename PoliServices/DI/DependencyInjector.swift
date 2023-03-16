//
//  DependencyInjector.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 3/15/23.
//

import Foundation
import Swinject

class DependecyInjector {
    static func inject(container: Container) {
        container.register(ServiceDataProtocol.self) { _ in ServiceData() }
        container.register(NetworkManagerProtocol.self) { _ in NetworkManager() }

        // MARK: - Home
        container.register(HomeViewModelProtocol.self) { r in HomeViewModel(serviceData: r.resolve(ServiceDataProtocol.self)!) }

        // MARK: - New Service
        container.register(NewServiceViewModelProtocol.self) { r in NewServiceViewModel(networkManager: r.resolve(NetworkManagerProtocol.self)!) }
    }
}
