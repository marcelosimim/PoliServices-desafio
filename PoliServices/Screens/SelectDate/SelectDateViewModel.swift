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
    var saveServiceCompletion: (() -> Void) { get set }
    var didFinishCalculationEndTime: ((String) -> Void) { get set }

    func setupEndTime(duration: Int)
    func recalculateEndTime(duration: Int, hour: Int, minute: Int)
    func save(_ service: Service)
}

final class SelectDateViewModel: SelectDateViewModelProtocol {
    private let serviceData = ServiceData()
    var saveServiceCompletion: (() -> Void) = { }
    var didFinishCalculationEndTime: ((String) -> Void) = { _ in }

    func setupEndTime(duration: Int) {
        let hour = Calendar.current.component(.hour, from: Date())
        let minute = Calendar.current.component(.minute, from: Date()) + 1

        calculateEndTime(duration: duration, hour: hour, minute: minute)
    }

    func recalculateEndTime(duration: Int, hour: Int, minute: Int) {
        calculateEndTime(duration: duration, hour: hour, minute: minute)
    }

    private func calculateEndTime(duration: Int, hour: Int, minute: Int) {
        let time = Time(hour: hour, minute: minute)
        let endHour = time.addToHour(duration: duration)
        let endMinute = time.addToMinute(duration: duration)
        let endTime = time.formattedTime(hour: endHour, minute: endMinute)

        didFinishCalculationEndTime(endTime)
    }

    func save(_ service: Service) {
        serviceData.saveService(service)
        saveServiceCompletion()
    }
}
