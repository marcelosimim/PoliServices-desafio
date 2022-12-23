//
//  
//  HomeViewController.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/19/22.
//
//
import UIKit

class HomeViewController: UIViewController {
    private lazy var customView: HomeViewProtocol = HomeView()
    private lazy var viewModel: HomeViewModelProtocol = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        viewModelBinds()
        viewModel.initTimer()
        viewModel.setupService()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.deinitTimer()
    }

    override func loadView() {
        super.loadView()
        view = customView as? UIView
    }

    private func setupView() {
        customView.setupCurrentDate(viewModel.getCurrentDate())
        customView.setupTotalOfServices(viewModel.getTotalOfServices())
    }

    private func viewModelBinds() {
        viewModel.showServiceCompletion = { [weak self] service in
            guard let self = self else { return }
            self.customView.setupService(service)
        }
        viewModel.removeServiceCompletion = { [weak self] in
            guard let self = self else { return }
            self.customView.setupServiceStack(hasService: false)
        }
    }
}

extension HomeViewController: HomeViewDelegate {
    func didTapNewService() {
        let newService = UINavigationController(rootViewController: NewServiceViewController())
        newService.modalPresentationStyle = .fullScreen
        present(newService, animated: true)
    }
}
