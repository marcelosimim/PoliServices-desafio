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
        let endHour = hour + hoursToAdd(minute: minute, duration: duration)
        let endMinute = defineEndMinutes(minute: minute, duration: duration)
        let endTime = formattedHour(endHour) + ":" + formattedTime(endMinute)

        didFinishCalculationEndTime(endTime)
    }

    func save(_ service: Service) {
        serviceData.saveService(service)
        saveServiceCompletion()
    }

    private func defineEndMinutes(minute: Int, duration: Int) -> Int {
        let addingDuration = minute + duration
        return addingDuration%60
    }

    private func hoursToAdd(minute: Int, duration: Int) -> Int {
        let addingDuration = minute + duration
        return Int(addingDuration/60)
    }

    private func formattedTime(_ value: Int) -> String {
        if value < 10 { return "0\(value)"}
        else { return "\(value)" }
    }

    private func formattedHour(_ value: Int) -> String {
        if value >= 24 { return formattedTime(value-24) }
        else { return formattedTime(value) }
    }
}
