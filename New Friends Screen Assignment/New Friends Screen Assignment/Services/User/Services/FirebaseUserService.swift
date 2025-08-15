//
//  FirebaseUserService.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 14.08.2025.
//

import FirebaseFirestore
import SwiftfulFirestore
import SwiftUI

protocol UserService {
  func getUsers() async throws -> [UserModel]
}

struct FirebaseUserService: UserService {
  var collection: CollectionReference {
    Firestore.firestore().collection("users")
  }
  
  func getUsers() async throws -> [UserModel] {
    try await collection.getAllDocuments()
  }
}

struct MockUserService: UserService {
  func getUsers() async throws -> [UserModel] {
    try await Task.sleep(for: .seconds(1))
    return UserModel.mocks
  }
}
