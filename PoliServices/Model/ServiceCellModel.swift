//
//  ServiceCellModel.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/22/22.
//

import Foundation
import UIKit

struct ServiceCellModel {
    private let icon: String
    private let color: String
    let type: ServiceType
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

        return "\(Time.formattedTimeDigits(hours)):\(Time.formattedTimeDigits(minutes))h"
    }

    static func fromServiceAPIModel(_ model: ServiceAPIModel) -> ServiceCellModel? {
        guard let type = ServiceType(rawValue: model.id) else { return nil }
        return ServiceCellModel(icon: model.icon, color: model.color, type: type, name: model.name, duration: model.duration)
    }
}
