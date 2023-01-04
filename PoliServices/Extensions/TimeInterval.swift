//
//  TimeInterval.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 1/4/23.
//

import Foundation

extension TimeInterval {
    // MARK: - Hour
    func formatInHour(_ dateFormat: String = "HH:mm") -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }

    // MARK: - Date
    func formatDefaultDate() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt-br")
        dateFormatter.dateFormat = "dd/MMMM/yyyy"
        return dateFormatter.string(from: date)
    }

    func formatInLongDate() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt-br")
        dateFormatter.dateFormat = "dd 'de' MMMM 'de' yyyy"
        return dateFormatter.string(from: date)
    }

    // MARK: - Date and Hour
    func formatInDateAndHour(_ dateFormat: String = "dd/MM/yyyy HH:mm") -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
}
