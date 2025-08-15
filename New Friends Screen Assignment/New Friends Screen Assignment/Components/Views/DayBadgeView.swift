//
//  DayBadgeView.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 14.08.2025.
//

import SwiftUI

struct DayBadgeView: View {
  var text: String = "Day"
  
  var body: some View {
    Text(text)
      .font(.system(size: 9, weight: .bold))
      .foregroundColor(Color(hex: "#C5C5C7"))
      .padding(.vertical, 4)
      .padding(.horizontal, 5)
      .background(
        LinearGradient(
          colors: [
            Color(hex: "#363636"),
            Color(hex: "#171717")
          ],
          startPoint: .top,
          endPoint: .bottom
        )
      )
      .overlay(
        RoundedRectangle(cornerRadius: 111)
          .stroke(
            LinearGradient(
              colors: [
                Color(hex: "#464646"),
                Color(hex: "#222222")
              ],
              startPoint: .top,
              endPoint: .bottom
            ), lineWidth: 0.5)
      )
      .frame(height: 15)
      .cornerRadius(111)
    
  }
}

#Preview {
  DayBadgeView(text: "Day")
    .scaleEffect(5)
}
