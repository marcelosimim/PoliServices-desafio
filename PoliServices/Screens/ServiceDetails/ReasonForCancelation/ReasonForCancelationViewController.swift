//
//  
//  ReasonForCancelationViewController.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 1/4/23.
//
//
import UIKit

protocol ReasonForCancelationViewControllerDelegate: AnyObject {
    func didFinishSendingReason()
}

class ReasonForCancelationViewController: UIViewController {
    private lazy var customView: ReasonForCancelationViewProtocol = ReasonForCancelationView()
    private lazy var viewModel: ReasonForCancelationViewModelProtocol = ReasonForCancelationViewModel()
    weak var delegate: ReasonForCancelationViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
        customView.reasonsTableView.delegate = self
        customView.reasonsTableView.dataSource = self
        viewModelBinds()
        viewModel.fetchReasons()
    }

    override func loadView() {
        super.loadView()
        view = customView as? UIView
    }

    private func viewModelBinds() {
        viewModel.didFinishFetchingReasonsSuccess = { [weak self] in
            guard let self else { return }
            self.customView.didFinishFetchingReasons()
        }

        viewModel.didFinishFetchingReasonsFailure = { [weak self] title, message in
            guard let self else { return }
            self.showError(title: title, message: message)
        }

        viewModel.didFinishSendingReasonsSuccess = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.delegate?.didFinishSendingReason()
            }
        }

        viewModel.didFinishSendingReasonsFailure = { [weak self] title, message in
            guard let self else { return }
            self.showError(title: title, message: message)
        }
    }

    private func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel) { _ in }
        alert.addAction(action)
        present(alert, animated: true)
    }

    private func getOtherReason() {
        let alert = UIAlertController(title: "Insira o motivo", message: "O campo deve ter no mínimo 5 e máximo 100 caracteres.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { _ in }
        let sendAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            guard let self, let text = alert.textFields?[0].text else { return }
            self.viewModel.sendReason(text)
        }
        alert.addAction(cancelAction)
        alert.addAction(sendAction)
        alert.addTextField()
        present(alert, animated: true)
    }
}

extension ReasonForCancelationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.reasons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReasonsTableView") else { fatalError() }
        let reason = viewModel.reasons[indexPath.row]
        cell.textLabel?.text = reason.description
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCell(indexPath.row)

        if isLastCell(indexPath) {
            getOtherReason()
        }
    }

    private func isLastCell(_ indexPath: IndexPath) -> Bool {
        viewModel.reasons.count-1 == indexPath.row
    }
}

extension ReasonForCancelationViewController: ReasonForCancelationViewDelegate {
    func didTapSend() {
        viewModel.sendReason()
    }
}
