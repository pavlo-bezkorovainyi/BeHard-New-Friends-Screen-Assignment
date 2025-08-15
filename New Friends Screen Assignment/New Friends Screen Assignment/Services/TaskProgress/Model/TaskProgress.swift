//
//  TaskProgress.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 14.08.2025.
//

import Foundation
import FirebaseFirestore

struct TaskProgressModel: Identifiable, Codable, Hashable {
  let taskProgressId: String
  let taskId: String
  let userId: String
  let challengeId: String
  
  var progressDates: [Date]
  
  var id: String { taskProgressId }
  
  enum CodingKeys: String, CodingKey {
    case taskProgressId = "task_progress_id"
    case taskId = "task_id"
    case userId = "user_id"
    case challengeId = "challenge_id"
    case progressDates = "progress_dates"
  }
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.taskProgressId = try container.decode(String.self, forKey: .taskProgressId)
    self.taskId = try container.decode(String.self, forKey: .taskId)
    self.userId = try container.decode(String.self, forKey: .userId)
    self.challengeId = try container.decode(String.self, forKey: .challengeId)
    
    let timestamps = try container.decode([Timestamp].self, forKey: .progressDates)
    self.progressDates = timestamps.map { $0.dateValue() }
  }
  
  init(taskProgressId: String, taskId: String, userId: String, challengeId: String, progressDates: [Date]) {
    self.taskProgressId = taskProgressId
    self.taskId = taskId
    self.userId = userId
    self.challengeId = challengeId
    self.progressDates = progressDates
  }
  
  
  static var mocks: [TaskProgressModel] {
    let now = Date()
    let cal = Calendar.current
    
    return [
      TaskProgressModel(taskProgressId: "task_progress_1",
                        taskId: "task_1", userId: "user_1", challengeId: "challenge_1",
                        progressDates: [now, cal.date(byAdding: .hour, value: -4, to: now)!]),
      
      TaskProgressModel(taskProgressId: "task_progress_1",
                        taskId: "task_2", userId: "user_1", challengeId: "challenge_1",
                        progressDates: [now, cal.date(byAdding: .hour, value: -4, to: now)!]),
      
      TaskProgressModel(taskProgressId: "task_progress_2",
                        taskId: "task_2", userId: "user_2", challengeId: "challenge_1",
                        progressDates: [cal.date(byAdding: .hour, value: -2, to: now)!,
                                        cal.date(byAdding: .day, value: -1, to: now)!]),
      
      TaskProgressModel(taskProgressId: "task_progress_3",
                        taskId: "task_3", userId: "user_3", challengeId: "challenge_2",
                        progressDates: [cal.date(byAdding: .minute, value: -30, to: now)!,
                                        cal.date(bySettingHour: 20, minute: 0, second: 0, of: cal.date(byAdding: .day, value: -1, to: now)!)!]),
      
      TaskProgressModel(taskProgressId: "task_progress_4",
                        taskId: "task_4", userId: "user_4", challengeId: "challenge_2",
                        progressDates: [cal.date(byAdding: .hour, value: -6, to: now)!,
                                        cal.date(byAdding: .hour, value: -12, to: now)!]),
      
      TaskProgressModel(taskProgressId: "task_progress_5",
                        taskId: "task_5", userId: "user_5", challengeId: "challenge_3",
                        progressDates: [cal.date(bySettingHour: 8, minute: 15, second: 0, of: now)!,
                                        cal.date(bySettingHour: 21, minute: 45, second: 0, of: cal.date(byAdding: .day, value: -1, to: now)!)!]),
      
      TaskProgressModel(taskProgressId: "task_progress_6",
                        taskId: "task_1", userId: "user_6", challengeId: "challenge_3",
                        progressDates: [cal.date(byAdding: .hour, value: -1, to: now)!,
                                        cal.date(byAdding: .hour, value: -23, to: now)!]),
      
      TaskProgressModel(taskProgressId: "task_progress_7",
                        taskId: "task_2", userId: "user_7", challengeId: "challenge_1",
                        progressDates: [cal.date(bySettingHour: 7, minute: 0, second: 0, of: now)!,
                                        cal.date(byAdding: .day, value: -1, to: now)!]),
      
      TaskProgressModel(taskProgressId: "task_progress_8",
                        taskId: "task_3", userId: "user_8", challengeId: "challenge_2",
                        progressDates: [cal.date(byAdding: .minute, value: -10, to: now)!,
                                        cal.date(bySettingHour: 19, minute: 30, second: 0, of: cal.date(byAdding: .day, value: -1, to: now)!)!]),
      
      TaskProgressModel(taskProgressId: "task_progress_9",
                        taskId: "task_4", userId: "user_1", challengeId: "challenge_3",
                        progressDates: [cal.date(byAdding: .hour, value: -8, to: now)!,
                                        cal.date(byAdding: .hour, value: -16, to: now)!]),
      
      TaskProgressModel(taskProgressId: "task_progress_10",
                        taskId: "task_5", userId: "user_2", challengeId: "challenge_2",
                        progressDates: [cal.date(byAdding: .minute, value: -90, to: now)!,
                                        cal.date(bySettingHour: 22, minute: 15, second: 0, of: cal.date(byAdding: .day, value: -1, to: now)!)!]),
      
      TaskProgressModel(taskProgressId: "task_progress_10",
                        taskId: "task_5", userId: "user_2", challengeId: "challenge_2",
                        progressDates: [now])
    ]
  }
  
  static func random() -> TaskProgressModel {
    let users = (1...8).map { "user_\($0)" }
    let tasks = (1...5).map { "task_\($0)" }
    let challenges = (1...3).map { "challenge_\($0)" }
    
    return TaskProgressModel(
      taskProgressId: UUID().uuidString,
      taskId: tasks.randomElement()!,
      userId: users.randomElement()!,
      challengeId: challenges.randomElement()!,
      progressDates: [Date()]
    )
  }
  
  static func randomFrom(
          users: [String],
          tasks: [String],
          challenges: [String],
          date: Date = Date()
      ) -> TaskProgressModel {
          TaskProgressModel(
              taskProgressId: UUID().uuidString,
              taskId: tasks.randomElement()!,
              userId: users.randomElement()!,
              challengeId: challenges.randomElement()!,
              progressDates: [date]
          )
      }
}

import IdentifiableByString

extension TaskProgressModel: StringIdentifiable {}

extension TaskProgressModel {
  func toFirestoreDict() -> [String: Any] {
    return [
      "task_progress_id": taskProgressId,
      "task_id": taskId,
      "user_id": userId,
      "challenge_id": challengeId,
      // Firestore хоче Timestamp, конвертуємо з Date
      "progress_dates": progressDates.map { Timestamp(date: $0) }
    ]
  }
}

