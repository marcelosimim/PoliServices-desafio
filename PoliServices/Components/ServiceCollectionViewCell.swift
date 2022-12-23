//
//  
//  ServiceCollectionViewCell.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/19/22.
//
//

import UIKit

class ServiceCollectionViewCell: UICollectionViewCell {
    static let identifier = "\(ServiceCollectionViewCell.self)"

    private lazy var serviceImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var serviceNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var serviceDurationLabel: UILabel = {
        let label = UILabel()
        // label.text = "0:30h"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        layer.cornerRadius = 8
        addViews()
    }

    private func addViews() {
        addSubview(serviceImage)
        addSubview(serviceNameLabel)
        addSubview(serviceDurationLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            serviceImage.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            serviceImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            serviceImage.heightAnchor.constraint(equalToConstant: 50),

            serviceNameLabel.topAnchor.constraint(equalTo: serviceImage.bottomAnchor, constant: 12),
            serviceNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            serviceNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            serviceDurationLabel.topAnchor.constraint(equalTo: serviceNameLabel.bottomAnchor, constant: 4),
            serviceDurationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            serviceDurationLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            serviceDurationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
        ])
    }

    func configure(_ model: ServiceLayout) {
        serviceImage.image = model.getImage()
        serviceImage.tintColor = model.getColor()
        serviceNameLabel.text = model.name
        serviceDurationLabel.text = model.getDuration()
    }
}

