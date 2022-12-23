//
//  
//  HomeViewModel.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/19/22.
//
//
import Foundation

protocol HomeViewModelProtocol {
    var showServiceCompletion: ((Service) -> Void) { get set }
    var removeServiceCompletion: (() -> Void) { get set }

    func getCurrentDate() -> String
    func getTotalOfServices() -> Int
    func initTimer()
    func deinitTimer()
    func setupService()
}

final class HomeViewModel: HomeViewModelProtocol {
    var showServiceCompletion: ((Service) -> Void) = { _ in }
    var removeServiceCompletion: (() -> Void) = { }

    private var timer: Timer?
    private let serviceData = ServiceData()

    func getCurrentDate() -> String {
        let currentDate = Date()
        return currentDate.formatted(
            date: .long,
            time: .omitted
        )
    }

    func getTotalOfServices() -> Int {
        serviceData.getTotalOfServices()
    }

    func initTimer() {
        setTimer()
        guard let timer = timer else { return }
        RunLoop.main.add(timer, forMode: .default)
    }

    func deinitTimer() {
        guard let timer = timer else { return }
        timer.invalidate()
    }

    func setupService() {
        if hasService() {
            guard let service = serviceData.getService() else { return }
            showServiceCompletion(service)
        } else {
            serviceData.removeService()
            deinitTimer()
            removeServiceCompletion()
        }
    }

    private func setTimer() {
        let now: Date = Date()
        let calendar: Calendar = Calendar.current
        let currentSeconds: Int = calendar.component(.second, from: now)
        timer = Timer(
            fire: now.addingTimeInterval(Double(60 - currentSeconds + 1)),
            interval: 60,
            repeats: true,
            block: { [weak self] (t: Timer) in
                guard let self = self else { return }
                self.setupService()
            })
    }

    private func hasService() -> Bool {
        let serviceDateInteger = serviceData.getServiceDateEnd()
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(serviceDateInteger))
        let currentDate = Date()
        return serviceDate >= currentDate
    }
}
