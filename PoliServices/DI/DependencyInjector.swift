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
        container.register(NotificationManagerProtocol.self) { _ in NotificationManager.shared }

        // MARK: - Home
        container.register(HomeViewModelProtocol.self) { r in HomeViewModel(serviceData: r.resolve(ServiceDataProtocol.self)!) }

        // MARK: - New Service
        container.register(NewServiceViewModelProtocol.self) { r in NewServiceViewModel(networkManager: r.resolve(NetworkManagerProtocol.self)!) }

        // MARK: - Select Date
        container.register(SelectDateViewModelProtocol.self) { r in SelectDateViewModel(notificationManager: r.resolve(NotificationManager.self)!, serviceData: r.resolve(ServiceDataProtocol.self)!)}

        // MARK: - Service Details
        container.register(ServiceDetailsViewModelProtocol.self) { _ in ServiceDetailsViewModel() }

        // MARK: - Reason For Cancelation
        container.register(ReasonForCancelationViewModel.self) { r in
            ReasonForCancelationViewModel(networkManager: r.resolve(NetworkManagerProtocol.self)!, serviceData: r.resolve(ServiceDataProtocol.self)!)
        }
    }
}
