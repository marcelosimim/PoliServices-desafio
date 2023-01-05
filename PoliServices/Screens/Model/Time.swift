//
//  Time.swift
//  PoliServices
//
//  Created by Marcelo Simim Santos on 12/23/22.
//

import Foundation

struct Time {
    let days: Int
    let hours: Int
    let minutes: Int

    func isMoreThanOneDay() -> Bool {
        (days > 1) || (days == 1 && minutes > 0)
    }

    func isMoreThanHalfDay() -> Bool {
        (hours > 12) || (hours == 12 && minutes > 0)
    }

    func isBrokenHour() -> Bool {
        hours != 0 && minutes != 0 && minutes != 60
    }

    func isFullHour() -> Bool {
        hours >= 0 && minutes == 60
    }

    func isLessThanOneHour() -> Bool {
        minutes != 0
    }
}
