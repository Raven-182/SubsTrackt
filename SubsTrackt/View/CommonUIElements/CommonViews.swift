//
//  CommonViews.swift
//  SubsTrackt
//
//  Created by Raven G on 2024-09-04.
//


import SwiftUI

struct SuccessBubble: View {
    var message: String

    var body: some View {
        Text(message)
            .font(.Poppins.semiBold.font(size: 14))
            .foregroundColor(.white)
            .padding()
            .background(Color.gray.opacity(0.8))
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}
struct primaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
        //Color(red: 0.5, green: 0.2, blue: 0.7)
            .background(Color.accentColor)
            .foregroundStyle(.black)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
