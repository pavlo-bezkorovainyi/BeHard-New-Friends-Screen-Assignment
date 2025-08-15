//
//  ActivityCellInfo.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 14.08.2025.
//

import Foundation

struct ActivitySection: Identifiable, Hashable {
  var id: String { date?.ISO8601Format() ?? UUID().uuidString }
  let date: Date?
  let items: [ActivityCellInfo]
  
  static let mock: ActivitySection = .init(
    date: Date(),
    items: [.mock1, .mock2]
  )
  
  static var empty: ActivitySection {
    .init(date: nil, items: [.empty1, .empty2, .empty3])
  }
  
  var isEmpty: Bool { date == nil }
}

struct ActivityCellInfo: Identifiable, Hashable {
  var id: String
  
  let progressTime: String?
  let userName: String?
  let userPhotoUrl: String?
  
  let challengeName: String?
  let tasksDone: [String]?
  let toGo: Int?
  
  static let mock1: ActivityCellInfo = .init(
    id: "1",
    progressTime: "12:34",
    userName: "John Doe",
    userPhotoUrl: Constants.randomAvatarImage,
    challengeName: "75 Hard",
    tasksDone: ["Run 1km", "Run 2km"],
    toGo: 1
  )
  
  static let mock2: ActivityCellInfo = .init(
    id: "2",
    progressTime: "20:00",
    userName: "Rebecca",
    userPhotoUrl: Constants.randomAvatarImage,
    challengeName: "75 Medium",
    tasksDone: ["Run 1km", "Run 2km", "Run 3km"],
    toGo: 5
  )
  
  static let empty1: ActivityCellInfo = .init(
    id: UUID().uuidString,
    progressTime: nil,
    userName: nil,
    userPhotoUrl: nil,
    challengeName: nil,
    tasksDone: nil,
    toGo: nil
  )
  
  static let empty2: ActivityCellInfo = .init(
    id: UUID().uuidString,
    progressTime: nil,
    userName: nil,
    userPhotoUrl: nil,
    challengeName: nil,
    tasksDone: nil,
    toGo: nil
  )
  
  static let empty3: ActivityCellInfo = .init(
    id: UUID().uuidString,
    progressTime: nil,
    userName: nil,
    userPhotoUrl: nil,
    challengeName: nil,
    tasksDone: nil,
    toGo: nil
  )
  
  var isEmpty: Bool {
    self.progressTime == nil && self.userName == nil && self.userPhotoUrl == nil
  }
}

