//
//  InvivteFriendButton.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 14.08.2025.
//

import SwiftUI

struct InviteFriendButton: View {
  
  @Binding var isLoading: Bool
  var onInviteTapped: () -> Void
 
  var body: some View {
    VStack {
      Button {
        onInviteTapped()
      } label: {
        ZStack {
          RoundedRectangle(cornerRadius: 24, style: .continuous)
            .fill(
              LinearGradient(
                colors: [
                  Color(hex: "#1E1E1F"),
                  Color(hex: "#0B0B0D")
                ],
                startPoint: .top,
                endPoint: .bottom
              )
            )
            .strokeBorder(
              LinearGradient(
                colors: [Color(hex: "#3A3A3B"), Color(hex: "#202021")],
                startPoint: .top,
                endPoint: .bottom
              ),
              style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round, dash: [8, 8])
            )
          
          Image(.iconPlus)
            .resizable()
            .frame(width: 88, height: 88)
        }
        .frame(width: 88, height: 88)
      }
      .skeleton(isLoading: isLoading)
      .cornerRadius(24)

      Text("Invite")
        .font(.system(size: 15, weight: .semibold))
        .padding(.top, 6)
        .skeleton(isLoading: isLoading)
      
      Spacer()
    }
    .frame(height: 132)
  }
}

#Preview {
  VStack {
    InviteFriendButton(isLoading: .constant(true)) {
      
    }
    
    InviteFriendButton(isLoading: .constant(false)) {
      
    }
  }
}
