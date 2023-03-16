//
//  ServiceCellModel.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/22/22.
//

import Foundation
import UIKit

struct ServiceLayout: Codable {
    let icon: String
    let color: String
    let name: String
    let duration: Int

    func getImage() -> UIImage {
        UIImage.generateSystemImage(icon)
    }

    func getColor() -> UIColor {
        UIColor.hexStringToUIColor(hex: color)
    }

    func getDuration() -> String {
        let hours = duration/60
        let minutes = duration%60

        return "\(hours.formattedTimeDigits()):\(minutes.formattedTimeDigits())h"
    }

    static func fromServiceAPIModel(_ model: ServiceAPIModel) -> ServiceLayout {
        ServiceLayout(icon: model.icon, color: model.color, name: model.name, duration: model.duration)
    }
}
