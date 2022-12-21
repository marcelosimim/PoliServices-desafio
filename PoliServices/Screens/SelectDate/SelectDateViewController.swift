//
//  
//  SelectDateViewController.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/19/22.
//
//
import UIKit

class SelectDateViewController: UIViewController {
    private lazy var customView: SelectDateViewProtocol = SelectDateView()
    private lazy var viewModel: SelectDateViewModelProtocol = SelectDateViewModel()
    private let serviceName: String

    init(servico: String) {
        self.serviceName = servico
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        viewModelBinds()
    }

    override func loadView() {
        super.loadView()
        view = customView as? UIView
    }

    private func setupNavigationBar() {
        title = "Novo Serviço"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(didTapSave))
    }

    private func viewModelBinds() {
        viewModel.saveServiceCompletion = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)}
    }

    @objc private func didTapSave() {
        let selectedDate = customView.getSelectedDate()
        let service = Service(date: selectedDate, name: serviceName)
        viewModel.save(service)
    }
}
