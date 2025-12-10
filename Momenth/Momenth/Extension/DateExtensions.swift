//
//  DateExtensions.swift
//  Momenth
//
//  Created by 김현중 on 11/28/25.
//

import Foundation

extension Date {
    func toMonthKey() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        return formatter.string(from: self)
    }
}
