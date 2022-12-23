//
//  
//  SelectDateView.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/19/22.
//
//

import Foundation
import UIKit

protocol SelectDateViewDelegate: AnyObject {
    func calculateEndTime(date: Date)
}

protocol SelectDateViewProtocol {
    var delegate: SelectDateViewDelegate? { get set }

    func getSelectedDate() -> TimeInterval
    func setEndTime(_ hour: String)
}

final class SelectDateView: UIView, SelectDateViewProtocol {
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
        datePicker.addTarget(self, action: #selector(didChangeDateValue), for: .valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        delegate?.calculateEndTime(date: datePicker.date)
        return datePicker
    }()

    private lazy var endLabel: UILabel = {
        let label = UILabel()
        label.text = "End"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var endHourView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .tertiarySystemFill
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var endHourLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var delegate: SelectDateViewDelegate?

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .background
        addViews()
    }

    private func addViews() {
        addSubview(selectLabel)
        addSubview(datePicker)
        addSubview(endLabel)
        addSubview(endHourView)
        endHourView.addSubview(endHourLabel)
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

            endHourView.topAnchor.constraint(equalTo: datePicker.bottomAnchor),
            endHourView.trailingAnchor.constraint(equalTo: datePicker.trailingAnchor, constant: -8),
            endHourView.widthAnchor.constraint(equalToConstant: 70),

            endHourLabel.topAnchor.constraint(equalTo: endHourView.topAnchor, constant: 7),
            endHourLabel.centerYAnchor.constraint(equalTo: endHourView.centerYAnchor),
            endHourLabel.centerXAnchor.constraint(equalTo: endHourView.centerXAnchor),

            endLabel.leadingAnchor.constraint(equalTo: datePicker.leadingAnchor, constant: 8),
            endLabel.centerYAnchor.constraint(equalTo: endHourView.centerYAnchor),
        ])
    }

    @objc private func didChangeDateValue() {
        delegate?.calculateEndTime(date: datePicker.date)
    }

    func getSelectedDate() -> TimeInterval {
        datePicker.date.timeIntervalSince1970
    }

    func setEndTime(_ hour: String) {
        endHourView.isHidden = false
        endHourLabel.text = hour
    }
}
