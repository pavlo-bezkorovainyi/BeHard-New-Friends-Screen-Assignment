//
//  FirebaseTasksService.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 14.08.2025.
//

import FirebaseFirestore
import SwiftfulFirestore
import SwiftUI

protocol TasksService {
  func getTasks() async throws -> [TaskModel]
}

struct FirebaseTasksService: TasksService {
  var collection: CollectionReference {
    Firestore.firestore().collection("tasks")
  }
  
  func getTasks() async throws -> [TaskModel] {
    try await collection.getAllDocuments()
  }
}

struct MockTasksService: TasksService {
  func getTasks() async throws -> [TaskModel] {
    try await Task.sleep(for: .seconds(1))
    return TaskModel.mocks
  }
}
