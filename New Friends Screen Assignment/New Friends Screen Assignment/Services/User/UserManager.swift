//
//  UserManager.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 14.08.2025.
//

import SwiftUI

@MainActor
@Observable
class UserManager {
  
  private let service: UserService
  
  init(service: UserService) {
    self.service = service
  }
  
  func getUsers() async throws -> [UserModel] {
    return try await service.getUsers()
  }
}
