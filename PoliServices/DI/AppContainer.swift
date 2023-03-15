//
//  AppContainer.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 3/15/23.
//

import Foundation
import Swinject

class AppContainer {
    public static let shared: Container = {
        let container = Container()

        container.register(ServiceDataProtocol.self) { _ in ServiceData() }

        // MARK: - Home
        container.register(HomeViewModelProtocol.self) { r in HomeViewModel(serviceData: r.resolve(ServiceDataProtocol.self)!) }

        return container
    }()
}
