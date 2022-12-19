//
//  
//  NewServiceView.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/19/22.
//
//

import Foundation
import UIKit

protocol NewServiceViewProtocol {
    var serviceCollectionView: UICollectionView { get set }
}

final class NewServiceView: UIView, NewServiceViewProtocol {
    var serviceCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(Service2CollectionViewCell.self, forCellWithReuseIdentifier: Service2CollectionViewCell.identifier)
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .background
        addViews()
    }

    private func addViews() {
        addSubview(serviceCollectionView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            serviceCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            serviceCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            serviceCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            serviceCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
