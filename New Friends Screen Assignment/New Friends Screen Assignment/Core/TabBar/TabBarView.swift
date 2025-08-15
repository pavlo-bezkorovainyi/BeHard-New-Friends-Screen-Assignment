//
//  TabBarView.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 13.08.2025.
//

import SwiftUI

struct TabBarView: View {
  
  @State private var selectedTab = 1
  
  var body: some View {
    TabView(selection: $selectedTab) {
      Text("Home")
        .tabItem {
          Label("Home", systemImage: "house.fill")
        }
        .tag(0)
      
      FriendsView()
        .tabItem {
          Label("Friends", systemImage: "person.3.fill")
        }
        .tag(1)
        .toolbarBackground(.black, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
      
      Text("Insights")
        .tabItem {
          Label("Insights", systemImage: "chart.bar.fill")
        }
        .tag(2)
      
      Text("Gallery")
        .tabItem {
          Label("Gallery", systemImage: "photo.on.rectangle")
        }
        .tag(3)
      
      Text("Profile")
        .tabItem {
          Label("Profile", systemImage: "person.crop.circle")
        }
        .tag(4)
    }
    .onAppear() {
      NotificationManager.instance.requestAuthorization()
      NotificationManager.instance.cancelNotification()
    }
  }
}

#Preview {
  TabBarView()
    .environment(UserManager(service: MockUserService()))
    .environment(TaskProgressManager(service: MockTaskProgressService()))
    .environment(ChallengesManager(service: MockChallengesService()))
    .environment(TasksManager(service: MockTasksService()))
}
