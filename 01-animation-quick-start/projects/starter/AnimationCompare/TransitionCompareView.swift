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

struct TransitionCompareView: View {
  @State var transitions: [TransitionData] = []
  @State var showSquares = true

  func deleteTransitions(at offsets: IndexSet) {
    transitions.remove(atOffsets: offsets)
  }

  func moveTransitions(source: IndexSet, destination: Int) {
    transitions.move(fromOffsets: source, toOffset: destination)
  }
  // 1
  var squareTransition: AnyTransition {
    // 2
    let insertTransition = AnyTransition.scale(scale: 0.2, anchor: .leading)
    // let insertTransition = AnyTransition.move(edge: .leading)
    let removeTransition = AnyTransition.scale(scale: 0.2, anchor: .trailing)
    
    // 3
    return AnyTransition.asymmetric(
      insertion: insertTransition,
      removal: removeTransition
    )
  }
  var fogTransition: AnyTransition {
    return AnyTransition.opacity
  }

  var body: some View {
    NavigationStack {
      VStack {
        Button("Transition!") {
          withAnimation {
            showSquares.toggle()
          }
        }
        .font(.title)
        .disabled(transitions.isEmpty)
        List {
          ForEach($transitions) { $transition in
            NavigationLink {
              EditTransition(transition: $transition)
            } label: {
              VStack(alignment: .leading) {
                Text(transition.description)
                  .fixedSize(horizontal: true, vertical: true)
                TransitionView(
                  transition: transition,
                  showTheView: $showSquares
                )
                .frame(height: 160)
              }
            }
          }
          .onDelete(perform: deleteTransitions)
          .onMove(perform: moveTransitions)
          Button {
            let newTransition = TransitionData()
            transitions.append(newTransition)
          } label: {
            Label(
              "Add Transition",
              systemImage: "plus"
            ).font(.title2)
          }
        }
        .toolbar {
          EditButton()
        }
        .navigationBarTitle("Transition Compare")
      }
    }
  }
}

struct TransitionCompareView_Previews: PreviewProvider {
  static var previews: some View {
    TransitionCompareView()
  }
}
