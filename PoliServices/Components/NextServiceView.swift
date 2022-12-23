//
//  
//  NextServiceView.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/19/22.
//
//

import Foundation
import UIKit

final class NextServiceView: UIView {

    private lazy var nextServiceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Próximo Serviço"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var countdownLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var serviceView: ServiceView = {
        let view = ServiceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear 
        addViews()
    }

    private func addViews() {
        addSubview(nextServiceLabel)
        addSubview(countdownLabel)
        addSubview(serviceView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nextServiceLabel.topAnchor.constraint(equalTo: topAnchor),
            nextServiceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nextServiceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            countdownLabel.topAnchor.constraint(equalTo: nextServiceLabel.bottomAnchor, constant: 4),
            countdownLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            countdownLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            serviceView.topAnchor.constraint(equalTo: countdownLabel.bottomAnchor, constant: 16),
            serviceView.leadingAnchor.constraint(equalTo: leadingAnchor),
            serviceView.trailingAnchor.constraint(equalTo: trailingAnchor),
            serviceView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setupService(_ service: Service) {
        serviceView.setupService(service)
    }

    func setupCountdown(_ time: Time) {
          if time.isMoreThanOneDay() {
              countdownLabel.text = "\(countdownStart(time.days)) \(countdownDay(time.days))"
          } else if time.isMoreThanHalfDay() {
              countdownLabel.text = "Faltam menos de 1 dia."
          } else if time.isBrokenHour() {
              countdownLabel.text = "\(countdownStart(time.hours)) \(countdownHour(time.hours)) e \(countdownMinutes(time.minutes)) \(countDownEnd())"
          } else if time.isFullHour() {
              countdownLabel.text = "\(countdownStart(time.hours+1)) \(countdownHour(time.hours+1))."
          } else if time.isLessThanOneHour() {
              countdownLabel.text = "\(countdownStart(time.minutes)) \(countdownMinutes(time.minutes)) \(countDownEnd())"
          } else {
              countdownLabel.text = ""
          }
    }

    private func countdownStart(_ value: Int) -> String {
        value == 1 ? "Falta" : "Faltam"
    }

    private func countdownDay(_ day: Int) -> String {
        day == 1 ? "\(day) dia." : "\(day) dias."
    }

    private func countdownHour(_ hour: Int) -> String {
        hour == 1 ? "\(hour) hora" : "\(hour) horas"
    }

    private func countdownMinutes(_ minutes: Int) -> String {
        minutes == 1 ? "\(minutes) minuto" : "\(minutes) minutos"
    }

    private func countDownEnd() -> String {
        "para o atendimento."
    }
}
