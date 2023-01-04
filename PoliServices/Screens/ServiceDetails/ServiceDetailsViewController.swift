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
    }

    override func loadView() {
        super.loadView()
        view = customView as? UIView
    }
}
