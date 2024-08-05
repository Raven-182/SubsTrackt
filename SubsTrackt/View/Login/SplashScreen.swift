//
//  SplashScreen.swift
//  SubsTrackt
//
//  Created by Raven G on 2024-06-23.
//

import Foundation
import SwiftUI


struct SplashScreen: View {
    var body: some View {
        ZStack {
            // Three-Color Gradient Background
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "#22313F"), Color(hex: "#1A252F"), Color(hex: "#16222A")]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .edgesIgnoringSafeArea(.all)
            
            // Floating Icons
            ZStack {
                FloatingIcon(iconName: "linkedin", size: 125, xOffset: -40, yOffset: -300, angle: -10)
                FloatingIcon(iconName: "spotify", size: 125, xOffset: 30, yOffset: -210,angle: 20)
                FloatingIcon(iconName: "reddit", size: 125, xOffset: -90, yOffset: -40, angle: 10)
                FloatingIcon(iconName: "netflix", size: 120, xOffset: 85, yOffset: 50, angle: -10)
            }

            VStack {
                Spacer(minLength: -30)
                            Text("Substrackt")
                    .font(Font.Poppins.semiBold.font(size: 42))
                    .padding(80)
                    .fixedSize(horizontal: false, vertical: true)
                
            }
            
        }
    }
}


struct FloatingIcon: View {
    @State private var offset: CGFloat = 0
    let iconName: String
    let size: CGFloat
    let xOffset: CGFloat
    let yOffset: CGFloat
    let angle: Double

    var body: some View {
        Image(iconName)
            .resizable()
            .frame(width: size, height: size)
            .offset(x: xOffset, y: yOffset + offset)
            .rotationEffect(.degrees(angle))
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                    offset = 20
                }
            }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen().preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
