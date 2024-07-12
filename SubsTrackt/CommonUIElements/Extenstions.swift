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
