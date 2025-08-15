//
//  FloatingBarScrollContainerView.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 14.08.2025.
//

import SwiftUI

struct FloatingBarScrollContainerView<Content: View>: View {
  
  var title: String = "Friends"
  var onPlusButtonTapped: () -> Void = { }
  @ViewBuilder var content: () -> Content
  @State private var isLargeTitle: Bool = true
  
  var body: some View {
    VStack {
      navigationBar
      ScrollView(showsIndicators: false) {
        floatingNavigationTitle
        content()
      }
    }
    .animation(.smooth(duration: 0.2), value: isLargeTitle)
  }
  
  private var navigationBar: some View {
    HStack(spacing: 4) {
      Button {
        onPlusButtonTapped()
      } label: {
        Image(.iconPlus)
          .resizable()
          .frame(width: 44, height: 44)
      }
      Spacer()
      Button {
        
      } label: {
        Image(.iconNotification)
          .resizable()
          .frame(width: 44, height: 44)
      }
      Button {
        
      } label: {
        Image(.iconAddFriend)
          .resizable()
          .frame(width: 44, height: 44)
      }
    }
    .padding(.horizontal)
    .frame(height: 44)
    .overlay {
      Text(title)
        .font(.system(size: 24, weight: .bold))
        .fontWidth(.condensed)
        .opacity(isLargeTitle ? 0 : 1)
    }
  }
  
  private var floatingNavigationTitle: some View {
    Text(title)
      .font(.system(size: 50, weight: .bold))
      .fontWidth(.condensed)
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.horizontal)
      .opacity(isLargeTitle ? 1 : 0)
      .onScrollVisibilityChange { value in
        isLargeTitle = value
      }
  }
}

#Preview {
  FloatingBarScrollContainerView() {
    
  }
}
