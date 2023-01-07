//
//  String.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 1/7/23.
//

import Foundation

extension String {

    func makePlural(plural: String, count: Int) -> String {
        count > 1 ? plural : self
    }
}
