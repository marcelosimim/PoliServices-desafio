//
//  
//  ServiceCollectionViewCell.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/19/22.
//
//

import UIKit

class Service2CollectionViewCell: UICollectionViewCell {
    static let identifier = "\(ServiceCollectionViewCell.self)"
    var type: ServiceType?

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

    func configure(_ model: ServiceType) {
        self.type = model
        serviceImage.image = model.image
        serviceImage.tintColor = model.color
        serviceLabel.text = model.title
    }
}

