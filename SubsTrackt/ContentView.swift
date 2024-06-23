//
//  ContentView.swift
//  SubsTrackt
//
//  Created by Raven G on 2024-06-20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(Font.Poppins.semiBold.font(size: 35)).foregroundColor(Color.textColor)
        }
        .padding()
        .background(Color.backgroundColor)
        
    }
    
}
#Preview {
    ContentView()
}
