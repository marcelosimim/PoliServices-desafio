//
//  
//  UIColor.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/19/22.
//
//

import UIKit

extension UIColor {
    static func generateColor(_ name: String) -> UIColor {
        UIColor(named: name) ?? .clear
    }

    static var background: UIColor { generateColor("background") }
    static var code: UIColor { .cyan }
    static var career: UIColor { .green }
    static var interview: UIColor { .magenta }
    static var feedback: UIColor { .brown }
}
