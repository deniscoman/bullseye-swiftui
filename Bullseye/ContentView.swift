//
//  ContentView.swift
//  Bullseye
//
//  Created by Denis Coman on 15/06/2020.
//  Copyright © 2020 Denis Coman. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible: Bool = false
    
    @State var whoIsThereIsVisible: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                Text("Welcome to my first app")
                    .fontWeight(.bold)
                    .foregroundColor(Color.green)
                Button(action: {
                    print("Button Pressed")
                    self.whoIsThereIsVisible = true
                }) {
                    Text("Hit me!")
                }
                .alert(isPresented: $alertIsVisible) { () ->
                    Alert in
                    return Alert(title: Text("Hello There"),
                                 message: Text("This is my first pop up"),
                                 dismissButton: .default(Text("Awesome!")))
                }
                Button(action: {
                    self.whoIsThereIsVisible = true
                }) {
                    Text("Knock Knock")
                }
                .alert(isPresented: $whoIsThereIsVisible) { () ->
                    Alert in
                    return Alert(title: Text("Who's there?"),
                                 message: Text("Litle old lady"),
                                 dismissButton: .default(Text("Little old lady who?")))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
