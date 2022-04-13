//
//  ContentView.swift
//  SuggestionTextField
//
//  Created by we on 2022/04/13.
//

import SwiftUI

enum EditMode {
    case none
    case english
    case korean
}

struct ContentView: View {
    @State var english: String = ""
    @State var korean: String = ""
    @FocusState var englishFocused: Bool
    @FocusState var koreanFocused: Bool
    @FocusState var inputFocused: Bool
    @State var editMode: EditMode = .none
    @State var input: String = ""
    init() {
    }
    
    var body: some View {
        VStack {
            Group {
                if editMode == .none {
                    Text("Hello, world!")
                        .padding()
                    TextField("english", text: $english, onEditingChanged: { state in
                        print("english \(state)")
                        if state == true {
                            withAnimation {
                                editMode = .english
                            }
                            input = english
                            inputFocused = true
                        }
                    })
                    .focused($englishFocused)
                    TextField("korean", text: $korean, onEditingChanged: { state in
                        if state == true {
                            withAnimation {
                                editMode = .korean
                            }
                            input = korean
                            inputFocused = true
                        }
                    })
                    .focused($koreanFocused)
                    Button {
                        englishFocused = true
                    } label: {
                        Text("English")
                    }
                    Button {
                        koreanFocused = true
                    } label: {
                        Text("Korean")
                    }
                }
                else {
                    HStack {
                    TextField("input", text: $input)
                            .focused($inputFocused)
                    Button {
                        if editMode == .korean {
                            korean = input
                        }
                        else {
                            english = input
                        }
                        inputFocused = false
                        withAnimation {
                            editMode = .none
                        }
                    } label: {
                        Text("Done")
                    }
                    }
                    GeometryReader { proxy in
                        List {
                            Text("Hello")
                            Text("Nice")
                            Text("Good")
                        }
                        .listStyle(.plain)
                    }
                }
            }.transition(.scale)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
