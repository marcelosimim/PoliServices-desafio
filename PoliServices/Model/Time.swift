//
//  Time.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/22/22.
//

import Foundation

struct Time {
    let hour: Int
    let minute: Int

    func addToHour(duration: Int) -> Int {
        let addingDuration = minute + duration
        let hourAdded = Int(addingDuration/60) + hour

        print(hourAdded)
        if hourAdded >= 24 { return hourAdded - 24}
        return hourAdded
    }

    func addToMinute(duration: Int) -> Int {
        let addingDuration = minute + duration
        return addingDuration%60
    }

    func formattedTime(hour: Int, minute: Int) -> String {
        Time.formattedTimeDigits(hour) + ":" + Time.formattedTimeDigits(minute)
    }

    static func formattedTimeDigits(_ value: Int) -> String {
        if value < 10 { return "0\(value)"}
        else { return "\(value)" }
    }
}
