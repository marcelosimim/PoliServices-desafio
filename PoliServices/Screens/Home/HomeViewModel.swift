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
    var newServiceCompletion: ((Service) -> Void) { get set }
    var removeServiceCompletion: (() -> Void) { get set }

    func getCurrentDate() -> String
    func initTimer()
    func setupService()
}

final class HomeViewModel: HomeViewModelProtocol {
    var newServiceCompletion: ((Service) -> Void) = { _ in }
    var removeServiceCompletion: (() -> Void) = { }

    func getCurrentDate() -> String {
        let currentDate = Date()
        return currentDate.formatted(
            date: .long,
            time: .omitted
        )
    }

    func initTimer() {
        let now: Date = Date()
        let calendar: Calendar = Calendar.current
        let currentSeconds: Int = calendar.component(.second, from: now)
        let timer = Timer(
            fire: now.addingTimeInterval(Double(60 - currentSeconds + 1)),
            interval: 60,
            repeats: true,
            block: { [weak self] (t: Timer) in
                self?.setupService()
            })
        RunLoop.main.add(timer, forMode: .default)
    }

    func setupService() {
        let currentDate = Date()
        let serviceDateInteger = UserDefaults.standard.integer(forKey: "service_date")
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(serviceDateInteger))
        let hasService = serviceDate >= currentDate

        if hasService {
            guard let serviceName = UserDefaults.standard.string(forKey: "service_name") else { return }
            let service = Service(date: TimeInterval(serviceDateInteger), name: serviceName)
            newServiceCompletion(service)
        } else {
            UserDefaults.standard.removeObject(forKey: "service_date")
            UserDefaults.standard.removeObject(forKey: "service_name")
            removeServiceCompletion()
        }

    }
}
