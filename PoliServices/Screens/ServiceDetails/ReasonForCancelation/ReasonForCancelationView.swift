//
//  
//  ReasonForCancelationView.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 1/4/23.
//
//

import Foundation
import UIKit

protocol ReasonForCancelationViewDelegate: AnyObject {
    func didTapSend()
}

protocol ReasonForCancelationViewProtocol {
    var delegate: ReasonForCancelationViewDelegate? { get set }
    var reasonsTableView: UITableView { get set }

    func didFinishFetchingReasons()
}

final class ReasonForCancelationView: UIView, ReasonForCancelationViewProtocol {

    private lazy var pageTitle: UILabel = {
        let label = UILabel()
        label.text = "Motivo do cancelamento"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var reasonsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ReasonsTableView")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Enviar motivo", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapSend), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var delegate: ReasonForCancelationViewDelegate?

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        addViews()
    }

    private func addViews() {
        addSubview(pageTitle)
        addSubview(reasonsTableView)
        addSubview(activityIndicator)
        addSubview(sendButton)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            pageTitle.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            pageTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 64),

            reasonsTableView.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 32),
            reasonsTableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            reasonsTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            reasonsTableView.heightAnchor.constraint(equalToConstant: 200),

            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: reasonsTableView.centerYAnchor),

            sendButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -120),
            sendButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            sendButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        ])
    }

    @objc private func didTapSend() {
        delegate?.didTapSend()
    }

    func didFinishFetchingReasons() {
        activityIndicator.stopAnimating()
        reasonsTableView.reloadData()
    }
}
