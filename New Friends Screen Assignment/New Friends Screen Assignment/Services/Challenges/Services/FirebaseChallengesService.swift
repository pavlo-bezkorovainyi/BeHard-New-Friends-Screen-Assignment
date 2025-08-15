//
//  UserService.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 14.08.2025.
//

import FirebaseFirestore
import SwiftfulFirestore
import SwiftUI

protocol ChallengesService {
  func getChallenges() async throws -> [ChallengeModel]
}

struct FirebaseChallengesService: ChallengesService {
  var collection: CollectionReference {
    Firestore.firestore().collection("challenges")
  }
  
  func getChallenges() async throws -> [ChallengeModel] {
    try await collection.getAllDocuments()
  }
}

struct MockChallengesService: ChallengesService {
  func getChallenges() async throws -> [ChallengeModel] {
    try await Task.sleep(for: .seconds(1))
    return ChallengeModel.mocks
  }
}
