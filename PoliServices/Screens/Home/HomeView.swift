//
//  
//  HomeView.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/19/22.
//
//

import Foundation
import UIKit

protocol HomeViewDelegate: AnyObject {
    func didTapNewService()
}

protocol HomeViewProtocol {
    var delegate: HomeViewDelegate? { get set }
    func setupServiceStack(hasService: Bool)
    func setupService(_ service: Service)
    func setupCurrentDate(_ date: String)
    func setupTotalOfServices(_ total: Int)
}

final class HomeView: UIView, HomeViewProtocol {
    weak var delegate: HomeViewDelegate?

    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.text = "Bem-Vindo ao Dev Services"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .thin)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var infoView: InfoView = {
        let view = InfoView()
        view.setupTexts(title: "Sobre nós", description: "A DevServices é o melhor aplicativo para reservar seu agendamento com serviços. Aqui é um espaço que você consegue reservar um espaço na minha agenda e vamos resolver suas dúvidas.\nSelecione o tipo de atendimento e vamos pra cima!\n\n*Ilustrativo")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemIndigo
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var totalOfServicesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var serviceStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [serviceView, newServiceButton])
        stack.axis = .vertical
        stack.spacing = 22
        stack.clipsToBounds = true
        stack.autoresizesSubviews = true
        stack.contentMode = .scaleToFill
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var serviceView: NextServiceView = {
        let view = NextServiceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var newServiceButton: UIButton = {
        let button = UIButton(configuration: .tinted())
        button.setTitle("Solicitar novo serviço", for: .normal)
        button.configuration?.cornerStyle = .capsule
        button.addTarget(self, action: #selector(didTapNewService), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .background
        addViews()
    }

    private func addViews() {
        addSubview(welcomeLabel)
        addSubview(dateLabel)
        addSubview(infoView)
        addSubview(separatorLine)
        addSubview(totalOfServicesLabel)
        addSubview(serviceStack)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            welcomeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            dateLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),

            infoView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 32),
            infoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            infoView.centerXAnchor.constraint(equalTo: centerXAnchor),

            separatorLine.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 32),
            separatorLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 55),
            separatorLine.centerXAnchor.constraint(equalTo: centerXAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 1),

            totalOfServicesLabel.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 16),
            totalOfServicesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            totalOfServicesLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            serviceStack.topAnchor.constraint(equalTo: totalOfServicesLabel.bottomAnchor, constant: 16),
            serviceStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            serviceStack.centerXAnchor.constraint(equalTo: centerXAnchor),

            newServiceButton.heightAnchor.constraint(equalToConstant: 55),
        ])
    }

    @objc private func didTapNewService() {
        delegate?.didTapNewService()
    }

    func setupServiceStack(hasService: Bool) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.serviceView.alpha = hasService ? 1 : 0
            self.serviceView.isHidden = !hasService
            self.newServiceButton.alpha = hasService ? 0 : 1
            self.newServiceButton.isHidden = hasService
        }
    }

    func setupCurrentDate(_ date: String) {
        dateLabel.text = date
    }

    func setupTotalOfServices(_ total: Int) {
        let attrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .bold)]
        let text = NSMutableAttributedString(string: "Total de serviços já solicitados: ", attributes:attrs)
        let total = NSMutableAttributedString(string: "\(total)")

        text.append(total)
        totalOfServicesLabel.attributedText = text
    }

    func setupService(_ service: Service) {
        setupServiceStack(hasService: true)
        serviceView.setupService(service)
    }
}
