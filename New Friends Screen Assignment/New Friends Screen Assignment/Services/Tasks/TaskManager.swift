//
//  TaskManager.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 14.08.2025.
//

import SwiftUI

@MainActor
@Observable
class TasksManager {
  
  private let service: TasksService
  
  init(service: TasksService) {
    self.service = service
  }
  
  func getTasks() async throws -> [TaskModel] {
    return try await service.getTasks()
  }
}
