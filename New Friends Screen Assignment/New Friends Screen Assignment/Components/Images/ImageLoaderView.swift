//
//  ImageLoaderView.swift
//  AIChat
//
//  Created by Pavlo Bezkorovainyi on 25.03.2025.
//

import SDWebImageSwiftUI
import SwiftUI

struct ImageLoaderView: View {

  var urlString = Constants.randomAvatarImage
  var resizingMode: ContentMode = .fill

  var body: some View {
    Rectangle()
      .opacity(0.001)
      .overlay(
        WebImage(url: URL(string: urlString))
          .resizable()
          .indicator(.activity)
          .aspectRatio(contentMode: resizingMode)
          .allowsHitTesting(false)
      )
      .clipped()
  }
}

#Preview {
  ImageLoaderView()
    .frame(width: 300, height: 300)
}
