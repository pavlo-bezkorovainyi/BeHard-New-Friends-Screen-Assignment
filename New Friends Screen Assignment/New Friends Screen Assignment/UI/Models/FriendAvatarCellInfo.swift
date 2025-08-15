//
//  FriendAvatarCellInfo.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 14.08.2025.
//

import Foundation

struct FriendAvatarCellInfo: Identifiable {
  var userName: String?
  var photoUrl: String?
  var dayStreak: Int?
  var dailyTasksCount: Int?
  var todayDoneTasksCount: Int?
  
  var id: String {
    UUID().uuidString
  }
  
  static let empty: FriendAvatarCellInfo = .init()
}
