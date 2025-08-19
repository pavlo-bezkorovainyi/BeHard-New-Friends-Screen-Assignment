//
//  FriendsView.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 13.08.2025.
//

import SwiftUI

struct FriendsView: View {
  
  @Environment(UserManager.self) private var userManager
  @Environment(TaskProgressManager.self) private var taskProgressManager
  @Environment(TasksManager.self) private var tasksMnager
  @Environment(ChallengesManager.self) private var challengesManager
  
  @State private var avatarsCells: [FriendAvatarCellInfo] = Array(repeating: .empty, count: 10)
  @State private var activitySections: [ActivitySection] = [.empty]
  
  @State private var tasksProgress: [TaskProgressModel] = []
  @State private var tappedText: String = ""
  
  var body: some View {
    FloatingBarScrollContainerView(onPlusButtonTapped: {
      plusButtonTapped()
    }) {
      friendsCarousel
      activityTitle
      activityList
    }
    .refreshable {
      Task {
        try? await loadData()
      }
    }
    .overlay(flyingText)
    .task {
      do {
        try await loadData()
      } catch {
        //TODO: Handle errors
        print(error.localizedDescription)
      }
    }
    .task {
      do {
        for try await progresses in taskProgressManager.streamAllProgresses() {
          if progresses.count > tasksProgress.count,
              !tasksProgress.isEmpty {
            NotificationManager.instance.showLocalNotification(title: "75 days Challenge", body: "Looks like your friends are crushing their tasks!")
          }
          tasksProgress = progresses
        }
      } catch {
        print("Failed listen to new progresses")
      }
    }
  }
  
  @MainActor
  private func loadData(newDemoTask: Bool = false, fromTaskListener: Bool = false) async throws {
    if !fromTaskListener {
      if newDemoTask {
        if Constants.isDemo {
          tasksProgress.append(.random())
        } else {
          try await taskProgressManager.addRandomTaskProgress()
        }
      } else {
        tasksProgress = try await taskProgressManager.getProgresses()
      }
    }
    
    let users = try await userManager.getUsers()
    let challenges = try await challengesManager.getChallenges()
    let tasks = try await tasksMnager.getTasks()
    
    avatarsCells = AvatarCellInfoService.getAvatarsInfo(tasksProgress: tasksProgress, users: users, challenges: challenges)
    
    activitySections = ActivitySectionService.makeActivitySections(progress: tasksProgress, users: users, tasks: tasks, challenges: challenges)
  }
  
  func plusButtonTapped() {
      Task {
        try await loadData(newDemoTask: true)
      }
  }
}

extension FriendsView {
  
  private var friendsCarousel: some View {
    ScrollView(.horizontal) {
      HStack(spacing: 16) {
        ForEach(avatarsCells) { info in
          AvatarInfoCellView(
            doneTasksCount: info.todayDoneTasksCount,
            dailyTasksCount: info.dailyTasksCount,
            name: info.userName,
            dayNumber: info.dayStreak,
            imageName: info.photoUrl
          )
          .scrollTransition(.interactive.threshold(.visible(0.95))) { content, phase in
            content
              .scaleEffect(phase.isIdentity ? 1 : 0.9)
          }
        }
        ForEach(avatarsCells.count..<(avatarsCells.count + 4), id: \.self) { _ in
          InviteFriendButton(isLoading: .constant(false)) {
            //Invite friend action
          }
        }
      }
      .padding(.horizontal)
    }
    .scrollIndicators(.hidden)
    .scrollTargetLayout()
    .scrollTargetBehavior(.viewAligned)
  }
  
  @ViewBuilder
  private var activityList: some View {
    if !activitySections.contains(where: { Calendar.current.isDateInToday($0.date ?? Date() )}) {
      todayEmptyActivityPlaceholder
    } else {
      LazyVStack {
        ForEach(activitySections, id: \.id) { section in
          Section {
            ForEach(section.items) { cell in
              ActivityCellView(info: cell) { emoji in
                flyingTextTapped(text: emoji)
              }
              .padding(.horizontal)
            }
          } header: {
            activitySectionTitle(for: section.date ?? Date())
              .padding(.vertical)
          }
        }
        Spacer().frame(height: 100)
      }
    }
  }
  
  private var activityTitle: some View {
    Text("Activity")
      .font(.system(size: 22, weight: .bold))
      .fontWidth(.condensed)
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.leading, 16)
      .padding(.top, 16)
  }
  
  private func activitySectionTitle(for date: Date) -> some View {
    let dateText = Calendar.current.isDateInToday(date) ? "Today" : date.monthDayString()
    
    return HStack {
      Rectangle()
        .fill(Color(hex: "#323136"))
        .frame(height: 0.5)
      
      Text(dateText)
        .font(.system(size: 12))
        .foregroundColor(Color(hex: "#464646"))
      
      Rectangle()
        .fill(Color(hex: "#323136"))
        .frame(height: 0.5)
    }
  }
  
  private var todayEmptyActivityPlaceholder: some View {
    VStack {
      activitySectionTitle(for: Date())
      
      VStack {
        let nameText = (avatarsCells.count == 1 ? avatarsCells.first!.userName : "Friends") ?? "Friends"
        Text("😅")
          .font(.system(size: 32, weight: .bold))
        
        Text("\(nameText) warming up")
          .font(.system(size: 32, weight: .bold))
          .fontWidth(.condensed)
        
        
        Text("Nudge \(nameText) to start")
          .font(.system(size: 15))
          .foregroundStyle(Color(hex: "#999999"))
        
        Button {
          flyingTextTapped(text: "💪")
        } label: {
          Text("Nudge 💪")
            .font(.system(size: 17, weight: .semibold))
            .foregroundStyle(.black)
            .padding(18)
            .background(Color.white)
            .cornerRadius(20)
        }
      }
      .padding(.vertical, 100)
    }
  }
  
  private var flyingText: some View {
    Text(tappedText)
      .scaleEffect(tappedText.isEmpty ? 3 : 10)
      .opacity(tappedText.isEmpty ? 0 : 1)
      .animation(.bouncy(duration: 1), value: tappedText)
  }
  
  private func flyingTextTapped(text: String) {
    tappedText = text
    Task {
      try await Task.sleep(for: .milliseconds(500))
      tappedText = ""
    }
  }
}

#Preview {
  NavigationStack {
    FriendsView()
      .environment(UserManager(service: MockUserService()))
      .environment(TaskProgressManager(service: MockTaskProgressService()))
      .environment(ChallengesManager(service: MockChallengesService()))
      .environment(TasksManager(service: MockTasksService()))
  }
}
