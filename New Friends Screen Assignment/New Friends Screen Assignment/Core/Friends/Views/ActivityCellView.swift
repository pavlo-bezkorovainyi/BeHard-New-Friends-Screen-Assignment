//
//  ActivityCellView.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 15.08.2025.
//

import SwiftUI

struct ActivityCellView: View {
  
  let info: ActivityCellInfo
  let onReactionTapped: (String) -> Void
  
  var body: some View {
    VStack {
      
      HStack(alignment: .center) {
        ImageLoaderView(urlString: info.userPhotoUrl ?? "")
          .frame(width: 36, height: 36)
          .cornerRadius(12)
          .skeleton(isLoading: info.userPhotoUrl == nil)
        
        Text(info.userName ?? "")
          .font(.system(size: 15, weight: .semibold))
          .skeleton(isLoading: info.userName == nil)
        Circle()
          .fill(Color(hex: "#464646"))
          .frame(width: 3, height: 3)
        Text(info.progressTime ?? "")
          .font(.system(size: 13, weight: .regular))
          .foregroundStyle(Color(hex: "#646466"))
          .skeleton(isLoading: info.progressTime == nil)
        Spacer()
      }
      
      
      VStack {
        HStack {
          Text(info.challengeName ?? "")
            .font(.system(size: 11, weight: .regular))
            .foregroundStyle(Color(hex: "#5B5A5D"))
            .frame(maxWidth: .infinity, alignment: .leading)
            .skeleton(isLoading: info.challengeName == nil)
          Spacer()
          Text("\(info.toGo ?? 0) to go")
            .font(.system(size: 11, weight: .regular))
            .foregroundStyle(Color(hex: "#5B5A5D"))
            .frame(maxWidth: .infinity, alignment: .trailing)
            .skeleton(isLoading: info.toGo == nil)
        }
        
        ForEach(info.tasksDone ?? [""], id: \.self) { task in
          HStack {
            Image(.iconCheckBox)
              .resizable()
              .frame(width: 25, height: 25)
            Text(task)
              .font(.system(size: 16))
              .frame(maxWidth: .infinity, alignment: .leading)
          }
          .skeleton(isLoading: task.isEmpty)
        }
      }
      .padding()
      .background(
        Rectangle()
          .fill(Color(hex: "#252526"))
          .shadow(color: Color(hex: "#0F0F0F"), radius: 12, x: 0, y: 16)
      )
      .background(
        Image(.cardShadow)
          .resizable()
      )
      .shadow(color: Color(hex: "#0F0F0F"), radius: 12, x: 0, y: 16)
      .cornerRadius(20)
      .padding(.leading, 40)
      .overlay(alignment: .bottomTrailing) {
        reactionsButtons
          .offset(x: -32, y: 16)
        
      }
    }
  }
  
  private var reactionsButtons: some View {
    HStack {
      ForEach(["🔥", "🎉", "🚀"], id: \.self) { emoji in
        Button {
          onReactionTapped(emoji)
        } label: {
          Text(emoji)
            .font(.system(size: 21))
        }
      }
    }
    .padding(8)
    .background(
      RoundedRectangle(cornerRadius: 100)
        .fill(Color(hex: "#1C1C1F"))
        .stroke(.black, lineWidth: 2)
        .shadow(color: Color(hex: "#858585").opacity(0.04), radius: 22, x: 0, y: 10)
      
    )
    .skeleton(isLoading: info.isEmpty)
  }
}

#Preview {
  VStack {
    ActivityCellView(info: .mock1) { _ in }
    ActivityCellView(info: .mock2) { _ in }
    ActivityCellView(
      info: .init(
        id: "",
        progressTime: nil,
        userName: nil,
        userPhotoUrl: nil,
        challengeName: nil,
        tasksDone: nil,
        toGo: nil
      )) { _ in }
  }
}
