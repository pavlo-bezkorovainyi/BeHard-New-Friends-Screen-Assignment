//
//  TaskProgressService.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 15.08.2025.
//


protocol TaskProgressService {
  func getTaskProgress() async throws -> [TaskProgressModel]
  @discardableResult func addRandomTaskProgress() async throws -> TaskProgressModel
  func streamAllProgresses() -> AsyncThrowingStream<[TaskProgressModel], Error>
}
