//
//  
//  ServiceDetailsViewModel.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 1/3/23.
//
//
import Foundation

protocol ServiceDetailsViewModelProtocol {
    var isCancelButtonEnabledCompletion: ((Bool) -> Void) { get set }

    func setupCancelButton(service: Service)
}

final class ServiceDetailsViewModel: ServiceDetailsViewModelProtocol {
    var isCancelButtonEnabledCompletion: ((Bool) -> Void) = { _ in }
    private var service: Service?
    private var timer: Timer?

    func setupCancelButton(service: Service) {
        self.service = service
        isCancelButtonEnabled()
        setTimer()
    }

    private func isCancelButtonEnabled() {
        isCancelButtonEnabledCompletion(hasTwoHourRemaining())
    }

    private func hasTwoHourRemaining() -> Bool {
        guard let service else { return false }
        let currentDate = Date()
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(service.endDate))
        let timeRemaining = serviceDate-currentDate
        guard let minute = timeRemaining.minute else { return false }
        
        return minute >= 120
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
                guard let self else { return }
                self.isCancelButtonEnabled()
            })
        guard let timer else { return }
        RunLoop.main.add(timer, forMode: .default)
    }

    private func deinitTimer() {
        guard let timer = timer else { return }
        timer.invalidate()
    }
}
