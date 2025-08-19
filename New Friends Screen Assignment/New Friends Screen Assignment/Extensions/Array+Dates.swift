//
//  Array+Dates.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 14.08.2025.
//

import Foundation

extension Array where Element == Date {
  func uniqueDays(calendar: Calendar = .current) -> [Date] {
    let days = self.map { calendar.startOfDay(for: $0) }
    return Array(Set(days)).sorted()
  }
  
  func maxConsecutiveDays(calendar: Calendar = .current) -> Int {
    let days = uniqueDays(calendar: calendar)
    guard !days.isEmpty else { return 0 }
    
    var maxStreak = 1
    var cur = 1
    
    for i in 1..<days.count {
      let diff = calendar.dateComponents([.day], from: days[i-1], to: days[i]).day ?? 0
      if diff == 1 {
        cur += 1
        maxStreak = Swift.max(maxStreak, cur)
      } else {
        cur = 1
      }
    }
    return maxStreak
  }
  
  func currentStreakFromToday(calendar: Calendar = .current, today: Date = Date()) -> Int {
    let dayStarts = self.map { calendar.startOfDay(for: $0) }
    let set = Set(dayStarts)
    let todayStart = calendar.startOfDay(for: today)

    var streak = 1
    var cursor = todayStart

    while let prev = calendar.date(byAdding: .day, value: -1, to: cursor),
          set.contains(prev) {
      streak += 1
      cursor = prev
    }
    return streak
  }
}
