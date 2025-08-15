//
//  ActivitySectionService.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 15.08.2025.
//

import Foundation

struct ActivitySectionService {
  
  static func makeActivitySections(
    progress: [TaskProgressModel],
    users: [UserModel],
    tasks: [TaskModel],
    challenges: [ChallengeModel],
    calendar: Calendar = .current,
    locale: Locale = .current
  ) -> [ActivitySection] {

    let usersById = Dictionary(uniqueKeysWithValues: users.map { ($0.userId, $0) })
    let tasksById = Dictionary(uniqueKeysWithValues: tasks.map { ($0.taskId, $0) })
    let challengesById = Dictionary(uniqueKeysWithValues: challenges.map { ($0.challengeId, $0) })

    let allDays = progress
      .flatMap { $0.progressDates }
      .map { calendar.startOfDay(for: $0) }
    
    let uniqueDays = Array(Set(allDays)).sorted(by: >)

    // Форматер часу "HH:mm"
    let timeFormatter: DateFormatter = {
      let df = DateFormatter()
      df.locale = locale
      df.timeZone = calendar.timeZone
      df.dateFormat = "HH:mm"
      return df
    }()

    var result: [ActivitySection] = []
    result.reserveCapacity(uniqueDays.count)

    for dayStart in uniqueDays {
      guard let dayEnd = calendar.date(byAdding: .day, value: 1, to: dayStart) else { continue }

      // key: "userId|challengeId" -> (набір taskId, останній час цього дня)
      var acc: [String: (taskIds: Set<String>, last: Date)] = [:]

      // Агрегуємо події у межах дня
      for tp in progress {
        let inDay = tp.progressDates.filter { $0 >= dayStart && $0 < dayEnd }
        if inDay.isEmpty { continue }

        let key = "\(tp.userId)|\(tp.challengeId)"
        let maxInDay = inDay.max()!

        if var entry = acc[key] {
          entry.taskIds.insert(tp.taskId)
          if maxInDay > entry.last { entry.last = maxInDay }
          acc[key] = entry
        } else {
          acc[key] = (Set([tp.taskId]), maxInDay)
        }
      }

      // Будуємо ActivityCellInfo
      var temp: [(info: ActivityCellInfo, sortKey: Date)] = []
      temp.reserveCapacity(acc.count)

      for (key, val) in acc {
        let parts = key.split(separator: "|")
        guard parts.count == 2 else { continue }
        let userId = String(parts[0])
        let challengeId = String(parts[1])

        guard let user = usersById[userId],
              let challenge = challengesById[challengeId] else { continue }

        let taskNames = val.taskIds.compactMap { tasksById[$0]?.name }.sorted()
        let plan = challenge.tasksPerDay ?? taskNames.count
        let toGo = max(plan - taskNames.count, 0)
        let timeStr = timeFormatter.string(from: val.last)

        // стабільний id для елемента
        let stableId = "\(user.userId)|\(challenge.challengeId)|\(Int(dayStart.timeIntervalSince1970))"

        let item = ActivityCellInfo(
          id: stableId,
          progressTime: timeStr,
          userName: user.name,
          userPhotoUrl: user.photoUrl ?? "",
          challengeName: challenge.name,
          tasksDone: taskNames,
          toGo: toGo
        )

        temp.append((item, val.last))
      }

      // Сортуємо елементи в межах секції за останнім часом (спадання)
      let items = temp.sorted { $0.sortKey > $1.sortKey }.map { $0.info }

      if !items.isEmpty {
        result.append(ActivitySection(date: dayStart, items: items))
      }
    }

    // Секції вже відсортовані за датою (новіші спочатку)
    return result
  }
}
