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

protocol NextServiceViewDelegate: AnyObject {
    func didTapServiceView()
}

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
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapServiceView)))
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

    var delegate: NextServiceViewDelegate?

    func setupService(_ service: Service) {
        serviceView.setupService(service)
    }

    func setupCountdown(_ time: String) {
        countdownLabel.text = time
    }

    @objc private func didTapServiceView() {
        delegate?.didTapServiceView()
    }
}
