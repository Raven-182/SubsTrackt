//
//  FontStyles.swift
//  SubsTrackt
//
//  Created by Raven G on 2024-06-23.
//

import SwiftUI
import Foundation


extension Font {
    
    
    enum Poppins {
            case medium, semiBold, regular
            
            func font(size: CGFloat = 18) -> Font {
                switch self {
                case .medium:
                    return .custom("Poppins-Medium", size: size)
                case .semiBold:
                    return .custom("Poppins-SemiBold", size: size)
                case .regular:
                    return .custom("Poppins-Regular", size: size)
                }
            }
        }
}

extension Color{
    static let backgroundColor = Color("BackgroundColor")
    static let textColor = Color("Text")
    static let secondaryTextColor = Color("SecondaryTextColor")
    static let buttonColor = Color("AccentColor")
    init(hex: String) {
            let scanner = Scanner(string: hex)
            scanner.scanLocation = hex.hasPrefix("#") ? 1 : 0

            var rgbValue: UInt64 = 0
            scanner.scanHexInt64(&rgbValue)

            let red = Double((rgbValue >> 16) & 0xff) / 255
            let green = Double((rgbValue >> 8) & 0xff) / 255
            let blue = Double(rgbValue & 0xff) / 255

            self.init(red: red, green: green, blue: blue)
        }
}

enum AppGradients {
    static let primaryBackground = LinearGradient(
        gradient: Gradient(colors: [Color(hex: "#22313F"), Color(hex: "#1A252F"), Color(hex: "#16222A")]),
        startPoint: .leading,
        endPoint: .trailing
    )
}



struct primaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.88, green: 0.55, blue: 0.65), 
                        Color(red: 0.78, green: 0.24, blue: 0.41)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
//LinearGradient(
//    gradient: Gradient(colors: [
//        Color(red: 0.7, green: 0.5, blue: 0.9), // Lighter purple shade
//        Color(red: 0.5, green: 0.2, blue: 0.7) // Darker purple shade
//    ]),
//    startPoint: .topLeading,
//    endPoint: .bottomTrailing
//)


//pink gradient
//LinearGradient(
//    gradient: Gradient(colors: [
//        Color(red: 0.88, green: 0.55, blue: 0.65), // Lighter pink shade
//        Color(red: 0.78, green: 0.24, blue: 0.41) // Darker pink shade
//    ]),
//    startPoint: .topLeading,
//    endPoint: .bottomTrailing
//)
