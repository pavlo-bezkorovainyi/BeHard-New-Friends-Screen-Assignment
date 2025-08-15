//
//  TaskModel.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 14.08.2025.
//

struct TaskModel: Identifiable, Codable, Hashable {
  var taskId: String
  let name: String
  
  var id: String { taskId }
  
  enum CodingKeys: String, CodingKey {
    case taskId = "task_id"
    case name
  }
  
  static var mocks: [TaskModel] = [
    TaskModel(taskId: "task_1", name: "First workout"),
    TaskModel(taskId: "task_2", name: "Fasting"),
    TaskModel(taskId: "task_3", name: "Cold shower"),
    TaskModel(taskId: "task_4", name: "100 push ups"),
    TaskModel(taskId: "task_5", name: "Read 10 pages"),
  ]
}

import IdentifiableByString

extension TaskModel: StringIdentifiable {}
