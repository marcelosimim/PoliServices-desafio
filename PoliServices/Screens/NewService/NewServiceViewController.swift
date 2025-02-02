//
//  
//  NewServiceViewController.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/19/22.
//
//
import UIKit

class NewServiceViewController: UIViewController {
    private lazy var customView: NewServiceViewProtocol = NewServiceView()
    private lazy var viewModel: NewServiceViewModelProtocol = NewServiceViewModel()
    private var serviceName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
    }

    override func loadView() {
        super.loadView()
        view = customView as? UIView
    }

    private func setupNavigationBar() {
        title = "Novo Serviço"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
    }

    private func setupCollectionView() {
        customView.serviceCollectionView.delegate = self
        customView.serviceCollectionView.dataSource = self
    }

    @objc private func didTapCancel() {
        dismiss(animated: true)
    }

    private func goToSelectDate(serviceName: String) {
         navigationController?.pushViewController(SelectDateViewController(servico: serviceName), animated: true)
    }
}

extension NewServiceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.services.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceCollectionViewCell.identifier, for: indexPath) as? ServiceCollectionViewCell else { fatalError() }
        let service = viewModel.services[indexPath.row]
        cell.configure(service)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let serviceName = viewModel.services[indexPath.row].title
        goToSelectDate(serviceName: serviceName)
    }
}
