//
//  Int.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/23/22.
//

import Foundation

extension Int {
    func formattedTimeDigits() -> String {
        if self < 10 { return "0\(self)"}
        else { return "\(self)" }
    }
}
