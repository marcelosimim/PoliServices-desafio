//
//  NotificationManager.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 1/4/23.
//

import Foundation
import UserNotifications

protocol NotificationManagerProtocol {
    func requestAutorization(completion: @escaping  (Bool) -> Void)
    func scheduleNotification()
}

class NotificationManager: NotificationManagerProtocol {
    private let center = UNUserNotificationCenter.current()
    static let shared = NotificationManager()

    func requestAutorization(completion: @escaping  (Bool) -> Void) {
        center.requestAuthorization(options: [.alert, .sound]) { granted, _ in
           completion(granted)
        }
    }

    func scheduleNotification() {
        guard let service = ServiceData().getService() else { return }
        let content = UNMutableNotificationContent()
        content.title = "Você possui um atendimento em aberto."
        content.body = "\(service.layout.name) começa em 15 minutos."
        content.categoryIdentifier = "DetailsCategory"

        let dateToNotify = Date(timeIntervalSince1970: service.startDate).addingTimeInterval((15*60)*(-1))
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute,. second], from: dateToNotify)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: NotificationIdentifier.details.rawValue, content: content, trigger: trigger)

        center.add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }
}
