//
//  
//  SelectDate2View.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/19/22.
//
//

import Foundation
import UIKit

protocol SelectDate2ViewProtocol {
    func getSelectedDate() -> TimeInterval
}

final class SelectDate2View: UIView, SelectDate2ViewProtocol {
    private lazy var selectLabel: UILabel = {
        let label = UILabel()
        label.text = "Selecione a data e hora para reservar"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.locale = Locale(identifier: "pt_BR")
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .dateAndTime
        datePicker.minuteInterval = 1
        datePicker.minimumDate = .now
        datePicker.contentMode = .scaleToFill
        datePicker.date = Calendar.current.date(byAdding: .minute, value: 1, to: Date()) ?? Date()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .background
        addViews()
    }

    private func addViews() {
        addSubview(selectLabel)
        addSubview(datePicker)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            selectLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 22),
            selectLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            selectLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            datePicker.topAnchor.constraint(equalTo: selectLabel.bottomAnchor, constant: 32),
            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            datePicker.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }

    func getSelectedDate() -> TimeInterval {
        datePicker.date.timeIntervalSince1970
    }
}
