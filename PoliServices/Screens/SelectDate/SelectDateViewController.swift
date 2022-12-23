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
    private let service: ServiceLayout

    init(service: ServiceLayout) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
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
            self.dismiss(animated: true)
        }

        viewModel.didFinishCalculationEndTime = { [weak self] endTime in
            guard let self = self else { return }
            self.customView.setEndTime(endTime)
        }
    }

    @objc private func didTapSave() {
        guard let endDate = viewModel.endDate else { return }
        let selectedDate = customView.getSelectedDate()
        let service = Service(startDate: selectedDate, endDate: endDate, layout: service)
        viewModel.save(service)
    }
}

extension SelectDateViewController: SelectDateViewDelegate {
    func calculateEndTime(date: Date) {
        viewModel.setupEndTime(selectedDate: date, duration: service.duration)
    }
}
