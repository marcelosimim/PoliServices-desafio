//
//  
//  SelectDate2ViewController.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/19/22.
//
//
import UIKit

class SelectDate2ViewController: UIViewController {
    private lazy var customView: SelectDate2ViewProtocol = SelectDate2View()
    private lazy var viewModel: SelectDate2ViewModelProtocol = SelectDate2ViewModel()
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
    }

    override func loadView() {
        super.loadView()
        view = customView as? UIView
    }

    private func setupNavigationBar() {
        title = "Novo Serviço"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(didTapSave))
    }

    @objc private func didTapSave() {
        let selectedDate = customView.getSelectedDate()
        let service = Service(date: selectedDate, name: serviceName)
        viewModel.save(service) { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
    }
}
