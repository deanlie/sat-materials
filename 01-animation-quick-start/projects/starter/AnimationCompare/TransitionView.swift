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

struct TransitionView: View {
  @State var transition: TransitionData
  @Binding var showTheView: Bool

  var currentInsertTrx: AnyTransition {
    switch transition.insertionType {
    case .slide:
      return AnyTransition.slide
    case .offset:
      return AnyTransition.offset(x: transition.x,
                                  y: transition.y)
    case .scale:
      return AnyTransition.scale(scale: transition.scale,
                                 anchor: .topTrailing) // RED_FLAG
    case .opacity:
      return AnyTransition.opacity
    case .move:
      return AnyTransition.move(edge: transition.edge)
    }
  }
  var currentRemoveTrx: AnyTransition {
    if transition.isSymmetric {
      return currentInsertTrx
    } else {
      switch transition.removalType {
      default:
        return AnyTransition.opacity
      }
    }
  }
  
  var currentTransition: AnyTransition {
    return AnyTransition.asymmetric(insertion: currentInsertTrx, removal: currentRemoveTrx)
  }

  var body: some View {
    VStack {
      HStack {
        if showTheView {
          VStack {
            RoundedRectangle(cornerRadius: 15)
              .frame(width: 150, height: 150)
              .foregroundColor(.red)
              .transition(currentTransition)
          }
        }
      }
      .frame(width: 160, height: 160)
    }
  }
}

var fogTransition: AnyTransition {
  return AnyTransition.opacity
}

struct TransitionView_Previews: PreviewProvider {
    static var previews: some View {
      TransitionView(
        transition: TransitionData(),
        showTheView: .constant(true)
      )
    }
}
