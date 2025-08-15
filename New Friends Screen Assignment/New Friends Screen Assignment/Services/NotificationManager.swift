//
//  NotificationManager.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 15.08.2025.
//

//
//  LocalNotificationBootcamp.swift
//  SwiftfulThinkingIntermediate
//
//  Created by Павел Бескоровайный on 08.08.2023.
//

import SwiftUI

class NotificationManager {
   static let instance = NotificationManager()
  
   private var showingNotification: Bool = false
  
   private init() {}
  
  func requestAuthorization() {
    let options: UNAuthorizationOptions = [.alert, .sound, .badge]
    UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
      if let error = error {
        print("ERROR: \(error)")
      } else {
        print("SUCCESS")
      }
    }
  }
  
  func showLocalNotification(title: String, body: String) {
    guard !showingNotification else { return }

    let content = UNMutableNotificationContent()
    
    content.title = title
    content.sound = .default
    content.body = body
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
    
    let request = UNNotificationRequest(
      identifier: UUID().uuidString,
      content: content,
      trigger: trigger)
    
    UNUserNotificationCenter.current().add(request)
    showingNotification = true
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
      self.showingNotification = false
    }
  }
  
  func cancelNotification() {
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    UNUserNotificationCenter.current().removeAllDeliveredNotifications()
  }
}
