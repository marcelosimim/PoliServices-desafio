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

    private lazy var startLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.text = "Início:"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var startDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var endLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.text = "Encerramento:"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var endDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.text = "30/11 as 19h"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var serviceImage: UIImageView = {
        let image = UIImageView()
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 12
        addViews()
    }

    private func addViews() {
        addSubview(serviceNameLabel)
        addSubview(startLabel)
        addSubview(startDateLabel)
        addSubview(endLabel)
        addSubview(endDateLabel)
        addSubview(serviceImage)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            serviceNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            serviceNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            serviceNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            endDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            endDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            endDateLabel.trailingAnchor.constraint(equalTo: serviceImage.leadingAnchor, constant: 16),

            endLabel.bottomAnchor.constraint(equalTo: endDateLabel.topAnchor, constant: -4),
            endLabel.leadingAnchor.constraint(equalTo: endDateLabel.leadingAnchor),
            endLabel.trailingAnchor.constraint(equalTo: endDateLabel.trailingAnchor),

            startDateLabel.bottomAnchor.constraint(equalTo: endLabel.topAnchor, constant: -4),
            startDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            startDateLabel.trailingAnchor.constraint(equalTo: serviceImage.leadingAnchor, constant: 16),

            startLabel.bottomAnchor.constraint(equalTo: startDateLabel.topAnchor, constant: -4),
            startLabel.leadingAnchor.constraint(equalTo: startDateLabel.leadingAnchor),

            serviceImage.topAnchor.constraint(equalTo: serviceNameLabel.bottomAnchor, constant: 27),
            serviceImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            serviceImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            serviceImage.heightAnchor.constraint(equalToConstant: 70),
            serviceImage.widthAnchor.constraint(equalTo: serviceImage.heightAnchor)
        ])
    }

    func setupService(_ service: Service) {
        startDateLabel.text = formatDate(service.startDate)
        endDateLabel.text = formatDate(service.endDate)
        serviceNameLabel.text = service.layout.name
        backgroundColor = service.layout.getColor()
        serviceImage.image = service.layout.getImage()
    }

    private func formatDate(_ timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
}
