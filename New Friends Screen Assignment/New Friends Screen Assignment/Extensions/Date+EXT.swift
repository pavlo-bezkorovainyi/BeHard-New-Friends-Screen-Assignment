//
//  Date+EXT.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 15.08.2025.
//

import Foundation

extension Date {
  func monthDayString(locale: Locale = .current) -> String {
    let formatter = DateFormatter()
    formatter.locale = locale
    formatter.dateFormat = "MMMM d"
    return formatter.string(from: self)
  }
}
