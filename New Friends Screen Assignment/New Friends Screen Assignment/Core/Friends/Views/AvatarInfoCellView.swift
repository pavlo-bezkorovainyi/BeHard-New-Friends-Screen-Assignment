//
//  AvatarView.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 14.08.2025.
//

import SwiftUI

struct AvatarInfoCellView: View {
  
  var doneTasksCount: Int? = 1
  var dailyTasksCount: Int? = 7
  var name: String? = "Patrick"
  var dayNumber: Int? = 1
  var imageName: String? = Constants.randomAvatarImage
  
  var body: some View {
    VStack(alignment: .center) {
      avatar
        .overlay(alignment: .bottomTrailing) {
          FlameView(number: dayNumber)
            .offset(x: 25, y: 15)
        }
      
      nameTitle
        .padding(.top, 6)
      tasks
    }
    .frame(height: 132)
  }
  
  private var avatar: some View {
    AvatarView(
      imageName: imageName,
      frame: (
        width: 88,
        height: 88
      ),
      cornerRadius: 24
    )
    .skeleton(isLoading: imageName == nil)
  }
  
  private var nameTitle: some View {
    Text(name ?? "")
      .font(.system(size: 15, weight: .semibold))
      .skeleton(isLoading: name == nil)
  }
  
  private var tasks: some View {
    Text("\(doneTasksCount ?? 0)/\(dailyTasksCount ?? 0) tasks")
      .foregroundColor(Color(hex: "#828285"))
      .font(.caption)
      .skeleton(isLoading: name == nil)
      .opacity(dailyTasksCount == nil && name != nil ? 0 : 1)
  }
}

#Preview {
  VStack(spacing: 16) {
    AvatarInfoCellView(doneTasksCount: nil, dailyTasksCount: nil, name: nil, dayNumber: 12, imageName: "https://i.pravatar.cc/151?")
    AvatarInfoCellView(doneTasksCount: 7, dailyTasksCount: 7, name: "Bob", dayNumber: 20, imageName: "https://i.pravatar.cc/152")
    AvatarInfoCellView(doneTasksCount: 3, dailyTasksCount: 7, name: "Charlie", dayNumber: 5, imageName: "https://i.pravatar.cc/153")
    AvatarInfoCellView(doneTasksCount: 6, dailyTasksCount: 7, name: "Diana", dayNumber: 15, imageName: "https://i.pravatar.cc/154")
    AvatarInfoCellView(doneTasksCount: 4, dailyTasksCount: 7, name: "Eve", dayNumber: 8, imageName: "https://i.pravatar.cc/155")
  }
}
