//
//  ChallengesService.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 14.08.2025.
//

import FirebaseFirestore
import SwiftfulFirestore

typealias ListenerRegistration = FirebaseFirestore.ListenerRegistration

struct FirebaseTaskProgressService: TaskProgressService {

  var collection: CollectionReference {
    Firestore.firestore().collection("task_progress")
  }
  
  func getTaskProgress() async throws -> [TaskProgressModel] {
    try await collection.getAllDocuments()
  }
  
  @discardableResult
  func addRandomTaskProgress() async throws -> TaskProgressModel {
    let progress = TaskProgressModel.randomFrom(
                users: FixedFirebaseIDs.users,
                tasks: FixedFirebaseIDs.tasks,
                challenges: FixedFirebaseIDs.challenges,
                date: Date()
            )
    try await collection
                .document(progress.taskProgressId)
                .setData(progress.toFirestoreDict(),
                         merge: false)
    return progress
  }
  
  func streamAllProgresses() -> AsyncThrowingStream<[TaskProgressModel], Error> {
    collection.streamAllDocuments()
  }
}


