//
//  Shimmer.swift
//  New Friends Screen Assignment
//
//  Created by Pavlo Bezkorovainyi on 15.08.2025.
//

import SwiftUI

struct ShimmeringModifier: ViewModifier {
  func body(content: Content) -> some View {
    TimelineView(.animation) { timeline in
      let phase = CGFloat(timeline.date.timeIntervalSinceReferenceDate
        .truncatingRemainder(dividingBy: 1))
      content.modifier(AnimatedMask(phase: phase))
    }
  }
}

struct AnimatedMask: AnimatableModifier {
  var phase: CGFloat
  var animatableData: CGFloat { get { phase } set { phase = newValue } }
  
  func body(content: Content) -> some View {
    content.mask(GradientMask(phase: phase).scaleEffect(3))
  }
}

struct GradientMask: View {
  let phase: CGFloat
  
  var body: some View {
    GeometryReader { geo in
      LinearGradient(
        gradient: Gradient(stops: [
          .init(color: .white.opacity(0.3), location: phase),
          .init(color: .white.opacity(0.6), location: phase + 0.1),
          .init(color: .white.opacity(0.3), location: phase + 0.2),
        ]),
        startPoint: .leading,
        endPoint: .trailing
      )
      .rotationEffect(.degrees(-45))
      .offset(x: -geo.size.width, y: -geo.size.height)
      .frame(width: geo.size.width * 3,
             height: geo.size.height * 3)
    }
  }
}

extension View {
  func skeleton<S>(_ shape: S? = nil as Rectangle?, isLoading: Bool) -> some View where S: Shape {
    guard isLoading else { return AnyView(self) }
    
    let shapeView: AnyShape = shape.map(AnyShape.init)
    ?? AnyShape(RoundedRectangle(cornerRadius: 20))
    
    return AnyView(
      self
        .opacity(0)
        .overlay(
          shapeView
            .fill(Color.white.opacity(0.3))
            .shimmering()
        )
    )
  }
  
  func shimmering() -> some View {
    modifier(ShimmeringModifier())
  }
}
