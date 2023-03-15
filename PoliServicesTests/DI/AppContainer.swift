//
//  AppContainer.swift
//  PoliServicesTests
//
//  Created by Marcelo Simim Santos on 3/15/23.
//

import Foundation
import Swinject

class AppContainerTests {
    static let shared: Container = {
        let container = Container()
        return container
    }()
}
