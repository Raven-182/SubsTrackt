//
//  SubscriptionsCalendarView.swift
//  SubsTrackt
//
//  Created by Raven G on 2024-07-16.
//

import Foundation
import SwiftUI
struct SubscriptionsCalendarView: View{
    
    var month_ills = ["jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep"]
    var body: some View{
        
        ZStack {
            // Three-Color Gradient Background
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "#22313F"), Color(hex: "#1A252F"), Color(hex: "#16222A")]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack() {
                                ForEach(month_ills, id: \.self) { month in
                                    Image(month)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 300, height: 300)
                                        .cornerRadius(50)
                                        .shadow(color: Color.black.opacity(0.5), radius: 5, x: -5, y: -8)
                                }
                                .padding(.horizontal, 15)
                                //image animation, iIdentity means when the image is in the view not entering or leaving the view
                                .scrollTransition{
                                    content, phase in content
                                        .opacity(phase.isIdentity ? 1.0: 0.5)
                                }
                               
                            }
                            
                            .scrollTargetLayout()
                            .padding(.horizontal)
                        }
                        .contentMargins(16, for: .scrollContent)
                        .scrollTargetBehavior(.viewAligned)
                        Spacer()
                    }
                    .padding(.top, 50) // Adjust the top padding as needed
        }
    }
}

struct Calendar_view: PreviewProvider {
    static var previews: some View {
        SubscriptionsCalendarView().preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}


