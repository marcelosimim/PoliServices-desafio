//
//  NotificationManagerMock.swift
//  PoliServicesTests
//
//  Created by Marcelo Simim Santos on 3/17/23.
//

import Foundation
@testable import PoliServices

class NotificationManagerMock: NotificationManagerProtocol {
    var requestAutorizationCount = 0
    var requestAutorizationCompletionHandler: ((Bool) -> Void)?
    func requestAutorization(completion: @escaping (Bool) -> Void) {
        requestAutorizationCount += 1
        requestAutorizationCompletionHandler?(true)
        // completion(true)
    }

    var scheduleNotificationCount = 0
    func scheduleNotification() {
        scheduleNotificationCount += 1
    }
}
