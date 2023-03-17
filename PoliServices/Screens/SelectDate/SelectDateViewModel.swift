//
//  
//  SelectDateViewModel.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/19/22.
//
//
import Foundation

protocol SelectDateViewModelProtocol {
    var endDate: TimeInterval? { get }
    var saveServiceCompletion: (() -> Void) { get set }
    var didFinishCalculationEndTime: ((String) -> Void) { get set }
    var notificationManager: NotificationManagerProtocol { get }
    var serviceData: ServiceDataProtocol { get }

    func setupEndTime(selectedDate: Date, duration: Int)
    func save(_ service: Service)
}

final class SelectDateViewModel: SelectDateViewModelProtocol {
    var notificationManager: NotificationManagerProtocol
    var serviceData: ServiceDataProtocol
    var endDate: TimeInterval?
    var saveServiceCompletion: (() -> Void) = { }
    var didFinishCalculationEndTime: ((String) -> Void) = { _ in }

    init(notificationManager: NotificationManagerProtocol, serviceData: ServiceDataProtocol) {
        self.notificationManager = notificationManager
        self.serviceData = serviceData
    }

    func setupEndTime(selectedDate: Date, duration: Int) {
        let endDate = Calendar.current.date(byAdding: .minute, value: duration, to: selectedDate) ?? Date()
        let endHour = Calendar.current.component(.hour, from: endDate)
        let endMinute = Calendar.current.component(.minute, from: endDate)
        let endTime = "\(endHour.formattedTimeDigits()):\(endMinute.formattedTimeDigits())"

        self.endDate = endDate.timeIntervalSince1970
        didFinishCalculationEndTime(endTime)
    }

    func save(_ service: Service) {
        notificationManager.shared.requestAutorization { _ in }
        serviceData.saveService(service) { [weak self] in
            self?.notificationManager.shared.scheduleNotification()
            self?.saveServiceCompletion()
        }
    }
}
