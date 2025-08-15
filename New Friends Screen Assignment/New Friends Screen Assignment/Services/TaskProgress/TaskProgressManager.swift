//
//  TaskProgressManager.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 14.08.2025.
//

import SwiftUI

@MainActor
@Observable
class TaskProgressManager {
  
  private let service: TaskProgressService
  
  init(service: TaskProgressService) {
    self.service = service
  }
  
  func getProgresses() async throws -> [TaskProgressModel] {
    try await service.getTaskProgress()
  }
  
  func addRandomTaskProgress() async throws {
    try await service.addRandomTaskProgress()
  }
  
  func streamAllProgresses() -> AsyncThrowingStream<[TaskProgressModel], Error> {
    service.streamAllProgresses()
  }
}
