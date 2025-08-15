//
//  AvatarInfoService.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 15.08.2025.
//

import Foundation

struct AvatarCellInfoService {
  
  static func getAvatarsInfo(
    tasksProgress: [TaskProgressModel],
    users: [UserModel],
    challenges: [ChallengeModel]
  ) -> [FriendAvatarCellInfo] {
    
    var createdAvatarsInfo: [FriendAvatarCellInfo] = []
    
    for user in users {
      let progress = tasksProgress.filter { taskProgress in
        user.userId == taskProgress.userId
      }
      
      let streak = progress.flatMap({$0.progressDates}).maxConsecutiveDays()
      
      var dailyTasksCount: Int?
      
      if let challengeId = progress.first?.challengeId,
         let challenge = challenges.first(where: {$0.challengeId == challengeId}) {
        dailyTasksCount = challenge.tasksPerDay
      }
      
      let todayTasksCount = progress.filter { progress in
        progress.progressDates.contains(where: { Calendar.current.isDateInToday($0)})
      }.count
      
      let avatarCellInfo = FriendAvatarCellInfo(
        userName: user.name,
        photoUrl: user.photoUrl,
        dayStreak: streak + 1,
        dailyTasksCount: dailyTasksCount,
        todayDoneTasksCount: todayTasksCount
      )
      
      createdAvatarsInfo.append(avatarCellInfo)
    }
    
    return createdAvatarsInfo
  }
}
