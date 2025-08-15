//
//  FlameView.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 14.08.2025.
//

import SwiftUI

struct FlameView: View {
  
  var number: Int? = 2
  
  var body: some View {
    ZStack {
      Image(.iconFlame)
        .resizable()
        .frame(width: 60, height: 60)
      
      if let number {
        Text("\(number)")
          .foregroundColor(.black)
          .font(.system(size: 14, weight: .bold))
          .fontWidth(.condensed)
          .padding(.top, 10)
          .shadow(color: Color.black.opacity(0.16), radius: 2, x: 0, y: 1)
      } else {
        ProgressView()
      }
    }
    .overlay(alignment: .bottomLeading) {
      DayBadgeView()
        .offset(x: 5, y: -3)
    }
  }
}

#Preview {
  VStack {
    FlameView(number: 12)
    FlameView(number: nil)
    FlameView(number: 1)
    FlameView(number: 70)
    FlameView(number: nil)
  }
}
