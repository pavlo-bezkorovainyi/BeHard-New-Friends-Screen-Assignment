//
//  UserModel.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 13.08.2025.
//

import Foundation

struct UserModel: Identifiable, Codable, Hashable {
  var userId: String
  let name: String
  let photoUrl: String?
  
  var id: String { userId }
  
  enum CodingKeys: String, CodingKey {
    case userId = "user_id"
    case name
    case photoUrl = "photo_url"
  }
  
  static var mock: Self { mocks[0] }
  
  static var mocks: [Self] {
    [
      UserModel(
        userId: "user_1",
        name: "Sophie",
        photoUrl: "https://i.pravatar.cc/185"
      ),
      UserModel(
        userId: "user_2",
        name: "Michael",
        photoUrl: "https://i.pravatar.cc/192"
      ),
      UserModel(
        userId: "user_3",
        name: "Olivia",
        photoUrl: "https://i.pravatar.cc/200"
      ),
      UserModel(
        userId: "user_4",
        name: "Ethan",
        photoUrl: "https://i.pravatar.cc/212"
      ),
      UserModel(
        userId: "user_5",
        name: "Emma",
        photoUrl: "https://i.pravatar.cc/225"
      ),
      UserModel(
        userId: "user_6",
        name: "William",
        photoUrl: "https://i.pravatar.cc/235"
      ),
      UserModel(
        userId: "user_7",
        name: "Ava",
        photoUrl: "https://i.pravatar.cc/240"
      ),
      UserModel(
        userId: "user_8",
        name: "Jameson",
        photoUrl: "https://i.pravatar.cc/190"
      )
    ]
  }
}

import IdentifiableByString

extension UserModel: StringIdentifiable {}

//
//struct TaskModel: Identifiable, Codable, Hashable {
//  var id: String?
//  let taskId: String
//  let challengeId: String
//  let dayIndex: Int
//  let taskIndex: Int
//  let description: String
//  var createdAt: Date?
//}
//
//struct TaskProgressModel: Identifiable, Codable, Hashable {
//  var id: String?
//  let userId: String
//  let taskId: String
//  let challengeId: String
//  var progressKeys: [String]
//  var updatedAt: Date?
//}
