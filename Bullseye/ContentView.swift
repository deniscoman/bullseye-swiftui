//
//  ContentView.swift
//  Bullseye
//
//  Created by Denis Coman on 15/06/2020.
//  Copyright © 2020 Denis Coman. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var totalScore = 0
    @State var roundNumber = 1
    let midnightBlue = Color(red: 0.0/255.0, green: 51.0/255.0, blue: 102.0 / 255)
    
    struct LabelStyle : ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(Color.white)
                .modifier(ShadowStyle())
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ValueStyle : ViewModifier{
        func body(content: Content) -> some View {
            content
                .foregroundColor(Color.yellow)
                .modifier(ShadowStyle())
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
        }
    }
    
    struct ButtonLargeTextStyle : ViewModifier{
        func body(content: Content) -> some View {
            content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ButtonSmallTextStyle : ViewModifier{
        func body(content: Content) -> some View {
            content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
    }
    
    struct ShadowStyle : ViewModifier {
        func body(content: Content) -> some View {
            content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            // Target row
            HStack {
                Text("Put the bullseye as close as you can to:")
                    .modifier(LabelStyle())
                Text("\(self.target)").modifier(ValueStyle())
            }
            Spacer()
            
            // Slider row
            HStack {
                Text("1")
                    .modifier(LabelStyle())
                Slider(value: self.$sliderValue, in: 1...100)
                    .accentColor(Color.green)
                Text("100")
                    .modifier(LabelStyle())
            }
            Spacer()
            
            //Button row
            Button(action: {
                self.alertIsVisible = true
            }) {
                Text("Hit me!").modifier(ButtonLargeTextStyle())
            }
            .alert(isPresented: $alertIsVisible) { () -> Alert  in
                Alert(title: Text("\(self.alertTitle())"),
                      message: Text("The slider's value is \(sliderValueRounded()).\n"
                        + "You scrode \(self.pointsForCurrentRound())"),
                      dismissButton: .default(Text("Awesome!")){
                        self.totalScore += self.pointsForCurrentRound()
                        self.target = Int.random(in: 1...100)
                        self.roundNumber += 1
                    })
            }
            .background(Image("Button")).modifier(ShadowStyle())
            Spacer()
            //Score row
            HStack {
                Button(action: {
                    self.resetGame()
                }) {
                    HStack {
                        Image("StartOverIcon")
                        Text("Start over").modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button")).modifier(ShadowStyle())
                Spacer()
                Text("Score:").modifier(LabelStyle())
                Text("\(totalScore)").modifier(ValueStyle())
                Spacer()
                Text("Round:").modifier(LabelStyle())
                Text("\(roundNumber)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView()) {
                    HStack {
                        Image("InfoIcon")
                        Text("Info").modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button")).modifier(ShadowStyle())
            }
            .padding(.bottom, 20)
        }
        .background(Image("Background"), alignment: .center)
        .accentColor(midnightBlue)
        .navigationBarTitle("Bullseye")
    }
    
    func resetGame() {
        roundNumber = 1
        totalScore = 0
        sliderValue = 50.0
    }
    
    func sliderValueRounded() -> Int {
        Int(self.sliderValue.rounded())
    }
    
    func amountOff() -> Int {
        abs(self.target - sliderValueRounded())
    }
    
    func pointsForCurrentRound() -> Int {
        let maximumScore = 100
        let bonus: Int
        switch amountOff() {
        case 0:
            bonus = 100
        case 1:
            bonus = 50
        default:
            bonus = 0
        }
        
        return maximumScore - amountOff() + bonus
    }
    
    func alertTitle() -> String {
        let title: String
        
        switch amountOff() {
        case 0:
            title = "Perfect!"
        case 1...5:
            title = "You almost had it!"
        case 6...10:
            title = "Not bad!"
        default:
            title = "Are you even trying?!"
        }
        
        return title
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
