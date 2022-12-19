//
//  
//  UIImage.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/19/22.
//
//

import UIKit

extension UIImage {
    static func generateImage(_ name: String) -> UIImage {
        UIImage(named: name) ?? UIImage(systemName: "xmark.octagon.fill")!
    }

    static func generateSystemImage(_ name: String) -> UIImage {
        UIImage(systemName: name) ?? UIImage(systemName: "xmark.octagon.fill")!
    }

    static var code: UIImage { generateSystemImage("pencil.slash") }
    static var career: UIImage { generateSystemImage("graduationcap.circle.fill") }
    static var interview: UIImage { generateSystemImage("books.vertical.fill") }
    static var feedback: UIImage { generateSystemImage("scribble.variable") }

    static var book: UIImage { generateSystemImage("book.fill") }
}
