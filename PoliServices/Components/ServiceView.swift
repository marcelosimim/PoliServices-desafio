//
//  
//  ServiceView.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/19/22.
//
//

import Foundation
import UIKit

final class ServiceView: UIView {

    private lazy var nextServiceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Próximo Serviço"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var serviceNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Nome do serviço"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var dateAndHourLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.text = "Date e Hora"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var serviceDateAndHourLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.text = "30/11 as 19h"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var bookImage: UIImageView = {
        let image = UIImageView()
        image.image = .book
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .systemTeal
        layer.cornerRadius = 12
        addViews()
    }

    private func addViews() {
        addSubview(serviceNameLabel)
        addSubview(dateAndHourLabel)
        addSubview(serviceDateAndHourLabel)
        addSubview(bookImage)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            serviceNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            serviceNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            serviceNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            serviceDateAndHourLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            serviceDateAndHourLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            serviceDateAndHourLabel.trailingAnchor.constraint(equalTo: bookImage.leadingAnchor, constant: 16),

            dateAndHourLabel.bottomAnchor.constraint(equalTo: serviceDateAndHourLabel.topAnchor, constant: -4),
            dateAndHourLabel.leadingAnchor.constraint(equalTo: serviceDateAndHourLabel.leadingAnchor),
            dateAndHourLabel.trailingAnchor.constraint(equalTo: serviceDateAndHourLabel.trailingAnchor),

            bookImage.topAnchor.constraint(equalTo: serviceNameLabel.bottomAnchor, constant: 27),
            bookImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            bookImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            bookImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            bookImage.widthAnchor.constraint(equalTo: bookImage.heightAnchor)
        ])
    }

    func setupService(_ service: Service) {
        serviceNameLabel.text = service.name
        let serviceDate = Date(timeIntervalSince1970: service.date)
        serviceDateAndHourLabel.text = serviceDate.formatted(
            date: .numeric,
            time: .shortened
        )
    }
}
