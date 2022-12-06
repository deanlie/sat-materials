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

struct EditTransition: View {
  @Binding var transition: TransitionData
  @State var showTheView = true

  var firstTypeString: String {
    if transition.isSymmetric {
      return "Type"
    } else {
      return "InsertionType"
    }
  }
  var body: some View {
    Form {
      Section("Symmetry") {
        Toggle("Is Symmetric", isOn: $transition.isSymmetric)
      }
      Section(firstTypeString) {
        Picker(firstTypeString, selection: $transition.insertionType) {
          Text("Slide").tag(TransitionType.slide)
          Text("Offset").tag(TransitionType.offset)
          Text("Scale").tag(TransitionType.scale)
          Text("Opacity").tag(TransitionType.opacity)
          Text("Move").tag(TransitionType.move)
        }
      }
      Section("\(firstTypeString) Parameters") {
        if transition.insertionType == .move {
          Picker("Edge", selection: $transition.edge) {
            Text("Leading").tag(Edge.leading)
            Text("Top").tag(Edge.top)
            Text("Trailing").tag(Edge.trailing)
            Text("Bottom").tag(Edge.bottom)
          }
        } else if transition.insertionType == .scale {
          Stepper("Scale \(transition.scale.formatted())",
                  value: $transition.scale,
                  in: 0...2,
                  step: 0.1)
          /*          Picker("Anchor", selection: $transition.anchor) {
           Text("Top Leading").tag(TransitionType.Anchor.topLeading)
           Text("Top").tag(Anchor.top)
           Text("TopTrailing").tag(Anchor.topTrailing)
           // RED_FLAG there's more
           } */
        } else if transition.insertionType == .offset {
          Stepper("X \(transition.x.formatted())",
                  value: $transition.x,
                  in: 0...200,
                  step: 20)
          Stepper("Y \(transition.y.formatted())",
                  value: $transition.y,
                  in: 0...200,
                  step: 20)
        }
        // RED_FLAG there's more
      }
      Section("Description") {
        Text(transition.description)
      }
      Section("Tap to Preview") {
        TransitionView(transition: transition,
                       showTheView: $showTheView)
        .contentShape(Rectangle())
        .onTapGesture {
          if showTheView {
            showTheView = false
          } else {
            showTheView = true
          }
        }
      }
      .textFieldStyle(.roundedBorder)
    }
    .navigationTitle("Edit Transition")
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct EditTransition_Previews: PreviewProvider {
    static var previews: some View {
      let data = TransitionData()
      EditTransition(transition: .constant(data))
    }
}
