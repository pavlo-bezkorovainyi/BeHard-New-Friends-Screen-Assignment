//
//  New_Friends_Screen_AssignmentApp.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 13.08.2025.
//

import SwiftUI
import FirebaseCore
import UserNotifications

@main
struct YourApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        TabBarView()
          .environment(UserManager(service: Constants.isDemo ? MockUserService() : FirebaseUserService()))
          .environment(ChallengesManager(service: Constants.isDemo ? MockChallengesService() : FirebaseChallengesService()))
          .environment(TasksManager(service: Constants.isDemo ? MockTasksService() : FirebaseTasksService()))
          .environment(TaskProgressManager(service: Constants.isDemo ? MockTaskProgressService() : FirebaseTaskProgressService()))
      }
    }
  }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    
    let center = UNUserNotificationCenter.current()
    center.delegate = self
    center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
      if let error = error {
        print("Notification permission error: \(error)")
      } else {
        print("Notifications granted: \(granted)")
      }
    }
    application.registerForRemoteNotifications()
    
    return true
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.banner, .sound, .badge])
  }
}
