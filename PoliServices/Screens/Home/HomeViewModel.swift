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
    var countdownCompletion: ((String) -> Void) { get set }
    var removeServiceCompletion: (() -> Void) { get set }
    var serviceData: ServiceDataProtocol { get }

    func getCurrentDate() -> String
    func getTotalOfServices() -> Int
    func initTimer()
    func deinitTimer()
    func setupService()
}

final class HomeViewModel: HomeViewModelProtocol {
    var showServiceCompletion: ((Service) -> Void) = { _ in }
    var countdownCompletion: ((String) -> Void) = { _ in }
    var removeServiceCompletion: (() -> Void) = { }
    var serviceData: ServiceDataProtocol
    private var timer: Timer?
    private var countdownIsZero = false

    init(serviceData: ServiceDataProtocol) {
        self.serviceData = serviceData
    }

    func getCurrentDate() -> String {
        Date().timeIntervalSince1970.formatInLongDate()
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
            calculateCountdown(start: service.startDate)
            showServiceCompletion(service)
        } else {
            countdownIsZero = false
            serviceData.removeService()
            deinitTimer()
            removeServiceCompletion()
        }
    }

    private func calculateCountdown(start: TimeInterval) {
        let currentDate = Date()
        let startDate = Date(timeIntervalSince1970: start)
        let timeLeft = currentDate-startDate
        guard let minuteLeft = timeLeft.minute, let secondLeft = timeLeft.second else { return }

        if minuteLeft <= 0 && secondLeft < 0 {
            calculateTime(minuteLeft)
        } else {
            countdownCompletion("")
        }
    }

    private func calculateTime(_ timeLeft: Int) {
        var minutesLeft = timeLeft*(-1)
        let days = minutesLeft/1440
        let hour = minutesLeft/60
        minutesLeft %= 60
        let time = Time(days: days, hours: hour, minutes: minutesLeft+1)

        defineCountDownMessage(time)
    }

    private func defineCountDownMessage(_ time: Time) {
        var text = ""

        if time.isMoreThanOneDay() {
            text = "Falta ".makePlural(plural: "Faltam ", count: time.days) + "\(time.days)" + " dia.".makePlural(plural: " dias.", count: time.days)
        } else if time.isMoreThanHalfDay() {
            text = "Faltam menos de 1 dia."
        } else if time.isBrokenHour() {
            text = "Falta ".makePlural(plural: "Faltam ", count: time.hours) + "\(time.hours)" + " hora".makePlural(plural: " horas", count: time.hours) + " e " + "\(time.minutes)" + " minuto".makePlural(plural: " minutos", count: time.minutes) + " para o atendimento."
        } else if time.isFullHour() {
            text = "Falta ".makePlural(plural: "Faltam ", count: time.hours+1) + "\(time.hours)" + " hora".makePlural(plural: " horas", count: time.hours)
        } else if time.isLessThanOneHour() {
            text = "Falta ".makePlural(plural: "Faltam ", count: time.minutes) + "\(time.minutes)" + " minuto".makePlural(plural: " minutos", count: time.minutes) + " para o atendimento."
        }

        countdownCompletion(text)
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
        guard let service = serviceData.getService() else { return false }
        let serviceDateInteger = service.endDate
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(serviceDateInteger))
        let currentDate = Date()
        return serviceDate >= currentDate
    }
}
