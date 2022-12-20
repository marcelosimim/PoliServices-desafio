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
        addSubview(serviceView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nextServiceLabel.topAnchor.constraint(equalTo: topAnchor),
            nextServiceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nextServiceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            serviceView.topAnchor.constraint(equalTo: nextServiceLabel.bottomAnchor, constant: 8),
            serviceView.leadingAnchor.constraint(equalTo: leadingAnchor),
            serviceView.trailingAnchor.constraint(equalTo: trailingAnchor),
            serviceView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setupService(_ service: Service) {
        serviceView.setupService(service)
    }
}
