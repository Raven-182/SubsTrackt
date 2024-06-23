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
}
