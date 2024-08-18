//
//  HelperFunctions.swift
//  SubsTrackt
//
//  Created by Raven G on 2024-06-23.
//

import SwiftUI

extension CGFloat{
    static var screenWidth: Double{
        return UIScreen.main.bounds.size.width
    }
    
    static var screenHeight: Double{
        return UIScreen.main.bounds.size.height
    }
    
    static func widthPer(percent: Double) -> Double{
        return screenWidth * percent
    }
    
    static func heightPer(percent: Double) -> Double{
        return screenHeight * percent
    }
    
    static var topInsets: Double {
        if let keyWindow = UIApplication.shared.keyWindow {
            return keyWindow.safeAreaInsets.top
        }
        return 0.0
    }
    static var bottomInsets: Double {
        if let keyWindow = UIApplication.shared.keyWindow {
            return keyWindow.safeAreaInsets.bottom
        }
        return 0.0
    }
    
    static var horizontalInsets: Double {
        if let keyWindow = UIApplication.shared.keyWindow {
            return keyWindow.safeAreaInsets.left + keyWindow.safeAreaInsets.right
        }
        return 0.0
    }
    
    static var verticalInsets: Double {
        if let keyWindow = UIApplication.shared.keyWindow {
            return keyWindow.safeAreaInsets.top + keyWindow.safeAreaInsets.bottom
        }
        return 0.0
    }
}
