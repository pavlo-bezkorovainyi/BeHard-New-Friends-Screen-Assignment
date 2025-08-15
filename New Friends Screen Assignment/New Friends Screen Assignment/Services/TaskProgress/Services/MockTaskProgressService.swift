//
//  MockTaskProgressService.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 15.08.2025.
//


struct MockTaskProgressService: TaskProgressService {
  func getTaskProgress() async throws -> [TaskProgressModel] {
    try await Task.sleep(for: .seconds(1))
    return TaskProgressModel.mocks
  }
  
  @discardableResult
  func addRandomTaskProgress() async throws -> TaskProgressModel {
    .random()
  }
  
  func streamAllProgresses() -> AsyncThrowingStream<[TaskProgressModel], Error> {
    AsyncThrowingStream { continuation in
      continuation.yield([])
    }
  }
}
