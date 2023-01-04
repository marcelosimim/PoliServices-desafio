//
//  
//  ServiceDetailsView.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 1/3/23.
//
//

import Foundation
import UIKit

protocol ServiceDetailsViewDelegate: AnyObject {
    func didTapCancelButton()
}

protocol ServiceDetailsViewProtocol {
    var delegate: ServiceDetailsViewDelegate? { get set }

    func configure(service: Service)
    func setupCancelButton(_ isEnabled: Bool)
}

final class ServiceDetailsView: UIView, ServiceDetailsViewProtocol {
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [serviceImage, serviceName, creationDate, startDate, startHour, endDate, endHour, cancelButton, cancelMessage])
        stack.axis = .vertical
        stack.spacing = 8
        stack.setCustomSpacing(64, after: creationDate)
        stack.setCustomSpacing(128, after: endHour)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var serviceImage: UIImageView = {
        let image = UIImageView()
        image.image = .book
        image.contentMode = .scaleAspectFit
        image.tintColor = .systemYellow
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var serviceName: UILabel = {
        let label = UILabel()
        label.text = "Feedback"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var creationDate: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var startDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var startHour: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var endDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var endHour: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancelar serviço", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .disabled)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var cancelMessage: UILabel = {
        let label = UILabel()
        label.text = "Não é possível cancelar o serviço. O horário restante é menor que 2 horas."
        label.textColor = .lightGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var delegate: ServiceDetailsViewDelegate?

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        addViews()
    }

    private func addViews() {
        addSubview(contentStack)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: topAnchor, constant: 120),
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentStack.centerXAnchor.constraint(equalTo: centerXAnchor),

            serviceImage.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    func configure(service: Service) {
        serviceImage.image = service.layout.getImage()
        serviceImage.tintColor = service.layout.getColor()

        serviceName.text = service.layout.name
        creationDate.text = "Data de criação: \(service.creationDate.formatInLongDate())"

        startDate.text = "Data de início: \(service.startDate.formatInLongDate())"
        startHour.text = "Hora de início: \(service.startDate.formatInHour("h:mm a"))"

        endDate.text = "Data de encerramento: \(service.endDate.formatInLongDate())"
        endHour.text = "Hora de encerramento: \(service.endDate.formatInHour("h:mm a"))"
    }

    func setupCancelButton(_ isEnabled: Bool) {
        cancelButton.isEnabled = isEnabled
        cancelMessage.isHidden = isEnabled
    }

    @objc private func didTapCancelButton() {
        delegate?.didTapCancelButton()
    }
}
