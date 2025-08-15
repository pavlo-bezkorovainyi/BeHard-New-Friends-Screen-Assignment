//
//  ChallengeModel.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 14.08.2025.
//

struct ChallengeModel: Identifiable, Codable, Hashable {
  var challengeId: String
  let name: String
  let tasksPerDay: Int?
  
  var id: String { challengeId }
  
  enum CodingKeys: String, CodingKey {
    case challengeId = "challenge_id"
    case name
    case tasksPerDay = "tasks_per_day"
  }
  
  static var mocks: [ChallengeModel] = [
    ChallengeModel(challengeId: "challenge_1", name: "50 Hard", tasksPerDay: 6),
    ChallengeModel(challengeId: "challenge_2", name: "75 Soft", tasksPerDay: 7),
    ChallengeModel(challengeId: "challenge_3", name: "30 Hard", tasksPerDay: 5)
  ]
}

import IdentifiableByString

extension ChallengeModel: StringIdentifiable {}
