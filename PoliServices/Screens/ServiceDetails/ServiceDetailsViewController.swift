//
//  
//  ServiceDetailsViewController.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 1/3/23.
//
//
import UIKit

class ServiceDetailsViewController: UIViewController {
    private lazy var customView: ServiceDetailsViewProtocol = ServiceDetailsView()
    private lazy var viewModel: ServiceDetailsViewModelProtocol = ServiceDetailsViewModel()
    private let service: Service
    private var isPresenting = false

    init(service: Service) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
        self.customView.configure(service: service)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
        viewModelBinds()
        viewModel.setupCancelButton(service: service)
    }

    override func loadView() {
        super.loadView()
        view = customView as? UIView
    }

    private func viewModelBinds() {
        viewModel.isCancelButtonEnabledCompletion = { [weak self] isEnabled in
            guard let self else { return }
            self.customView.setupCancelButton(isEnabled)
            if self.isPresenting && !isEnabled {
                self.isPresenting = false
                self.dismiss(animated: true)
            }
        }
    }
}

extension ServiceDetailsViewController: ServiceDetailsViewDelegate {
    func didTapCancelButton() {
        let reasonForCancelation = ReasonForCancelationViewController()
        reasonForCancelation.delegate = self
        present(reasonForCancelation, animated: true)
        isPresenting = true
    }
}

extension ServiceDetailsViewController: ReasonForCancelationViewControllerDelegate {
    func didFinishSendingReason() {
        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
}
