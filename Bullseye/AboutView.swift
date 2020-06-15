//
//  AboutView.swift
//  Bullseye
//
//  Created by Denis Coman on 15/06/2020.
//  Copyright © 2020 Denis Coman. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    struct HeadingStyle : ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 30))
                .padding(.vertical, 20.0)
        }
    }
    
    struct DescriptionStyle : ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(Font.custom("Arial Rounded MT Bold", size: 16))
                .padding(.leading, 60.0)
                .padding(.trailing, 60.0)
                .padding(.bottom, 20.0)
                .foregroundColor(Color.black)
        }
    }
    
    var body: some View {
        Group {
            VStack {
                Text("🎯 Bullseye 🎯")
                    .modifier(HeadingStyle())
                Text("This is Bullseye, the game where you can win points and earn frame by draging a slider").modifier(DescriptionStyle())
                Text("Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.").modifier(DescriptionStyle())
                Text("Enjoy!").modifier(DescriptionStyle())
            }
            .navigationBarTitle("About Bullseye")
            .background(Color(red: 1, green: 214 / 255, blue: 179 / 255))
        }
    .background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
