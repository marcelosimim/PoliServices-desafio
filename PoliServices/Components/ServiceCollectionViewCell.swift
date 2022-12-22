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

    private lazy var serviceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
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
        addSubview(serviceLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            serviceImage.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            serviceImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            serviceImage.heightAnchor.constraint(equalToConstant: 60),

            serviceLabel.topAnchor.constraint(equalTo: serviceImage.bottomAnchor, constant: 12),
            serviceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            serviceLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            serviceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }

    func configure(_ model: ServiceCellModel) {
        serviceImage.image = model.getImage()
        serviceImage.tintColor = model.getColor()
        serviceLabel.text = model.name
    }
}

