/// Copyright (c) 2022 Kodeco Inc.
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct TransitionData: Identifiable {
  var id = UUID()
  var insertionType: TransitionType = .slide
  var removalType: TransitionType = .slide
  var isSymmetric = true

  // Slide -- no parameters
  // Scale
  var scale: Double = 1.0
  var anchor: UnitPoint = .center
  // Move
  var edge: Edge = .leading
  // Offset
  var x: Double = 0.75
  var y: Double = 0.25
  // Opacity -- no parameters

  var transitionScaleFormatter:
  NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 1
    return formatter
  }
  
  var description: String {
    var insertionTypeString = "??"
    var removalTypeString = "??"

    switch insertionType {
    case .slide:
      insertionTypeString = "Slide"
    case .scale:
      insertionTypeString = "Scale"
    case .move:
      insertionTypeString = "Move"
    case .offset:
      insertionTypeString = "Offset"
    case .opacity:
      insertionTypeString = "Opacity"
    }
    if isSymmetric {
      removalTypeString = insertionTypeString
    } else {
      switch removalType {
      case .slide:
        removalTypeString = "Slide"
      case .scale:
        removalTypeString = "Scale"
      case .move:
        removalTypeString = "Move"
      case .offset:
        removalTypeString = "Offset"
      case .opacity:
        removalTypeString = "Opacity"
      }
    }
    let scaleString = transitionScaleFormatter.string(for: scale) ?? "??"
    let offsetXString = transitionScaleFormatter.string(for: x) ?? "??"
    let offsetYString = transitionScaleFormatter.string(for: y) ?? "??"

    if isSymmetric {
      return "\(insertionTypeString) Transition"
    } else {
      return("Asymmetric Transition,\n  Insertion: \(insertionTypeString)\n  Removal: \(removalTypeString)")
    }
/*    if type == .slide {
      return "\(typeString) Transition\n"
    }
    if type == .scale {
      return "\(typeString) Transition\nScale: \(scaleString)"
    }
    return "\(typeString) Transition\n Parameters not implemented" */
  }
}

enum TransitionType {
  case slide
  case scale
  case move
  case offset
  case opacity
}

struct TransitionProperties {
  var scale: Double = 0.0
  var anchorPoint: UnitPoint = .center
  var edge: Edge = .leading
  var offsetX: Double = 0.0
  var offsetY: Double = 0.0
}
