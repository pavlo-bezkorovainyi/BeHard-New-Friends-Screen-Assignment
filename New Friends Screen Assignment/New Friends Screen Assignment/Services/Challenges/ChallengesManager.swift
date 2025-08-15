//
//  ChallengesManager.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 14.08.2025.
//

import SwiftUI

@MainActor
@Observable
class ChallengesManager {
  
  private let service: ChallengesService
  
  init(service: ChallengesService) {
    self.service = service
  }
  
  func getChallenges() async throws -> [ChallengeModel] {
    return try await service.getChallenges()
  }
}
