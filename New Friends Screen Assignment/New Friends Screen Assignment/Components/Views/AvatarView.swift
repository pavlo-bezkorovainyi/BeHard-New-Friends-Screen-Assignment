//
//  AvatarView.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 14.08.2025.
//

import SwiftUI

struct AvatarView: View {
  var imageName: String? = Constants.randomAvatarImage
  var frame: (width: CGFloat, height: CGFloat) = (88, 88)
  var cornerRadius: CGFloat = 24
  
  var body: some View {
    ZStack {
      LinearGradient(
        colors: [
          Color(hex: "#1E1E1F"),
          Color(hex: "#0B0B0D")
        ],
        startPoint: .top,
        endPoint: .bottom
      )
      if let imageName {
        ImageLoaderView(urlString: imageName)
      } else {
        Image(systemName: "person.fill")
          .resizable()
          .padding()
      }
    }
    .frame(width: frame.width, height: frame.height)
    .cornerRadius(24)
  }
}

#Preview {
  AvatarView()
}
