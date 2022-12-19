//
//  
//  NewServiceViewModel.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/19/22.
//
//
import Foundation

protocol NewServiceViewModelProtocol {
    var services: [ServiceType] { get }
}

final class NewServiceViewModel: NewServiceViewModelProtocol {
    var services: [ServiceType] = [.code, .career, .interview, .feedback]
}
