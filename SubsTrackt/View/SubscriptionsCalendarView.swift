//
//  SubscriptionsCalendarView.swift
//  SubsTrackt
//
//  Created by Raven G on 2024-07-16.
//

import Foundation
import SwiftUI
struct SubscriptionsCalendarView: View{
    @State private var selectedYear: Int
    @State private var selectedMonth: String

    var months = ["jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov","dec"]
    let years = Array(2023...2030)
    
    init() {
         let currentDate = Date()
         let calendar = Calendar.current
         let currentYear = calendar.component(.year, from: currentDate)
 
         let monthFormatter = DateFormatter()
         monthFormatter.dateFormat = "MMM"
         let monthString = monthFormatter.string(from: currentDate).lowercased()
         
         _selectedYear = State(initialValue: currentYear)
         _selectedMonth = State(initialValue: monthString)
     }
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "#22313F"), Color(hex: "#1A252F"), Color(hex: "#16222A")]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Your Bills")
                        .font(.Poppins.semiBold.font(size: 25))
                        .foregroundColor(.white)
                        .padding(.horizontal, 25)
                    Spacer()
                    Picker("Select Year", selection: $selectedYear) {
                        ForEach(years, id: \.self) { year in
                            Text(String(year)).tag(year).font(.Poppins.semiBold.font())
                        }
                    }
                    .pickerStyle(MenuPickerStyle())  // Dropdown style
                    .padding(.horizontal)
                    .foregroundColor(.white)
                }
                
                GeometryReader { geometry in
                    ScrollView(.horizontal, showsIndicators: false) {
                        ScrollViewReader { scrollView in
                            HStack{
                                ForEach(months, id: \.self) { month in
                                    GeometryReader { geo in
                                        //mid point of the image within th eglobal coordinate
                                        let midX = geo.frame(in: .global).midX
                                        //mid point of the parent frame(scrollview)
                                        let screenMidX = geometry.size.width / 2

                                        Image(month)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: geometry.size.width - 60, height: 250)
                                            .cornerRadius(40)
                                            .shadow(color: Color.black.opacity(0.5), radius: 5, x: -5, y: -8)
                                        
                                        //adding animation, reduce the size
                                            .scrollTransition(.animated.threshold(.visible(0.9))) { content, phase in
                                                        content
                                                    .opacity(phase.isIdentity ? 1 : 0)
                                                            .scaleEffect(phase.isIdentity ? 1 : 0.8)
                                             
                                                    }
                                //is image's center within 20 points of the screen center, newValue id the new imagi=e center
                                        //When using .onChange(of:), the parameter in the closure represents the new value of the observed state or value.
                                            .onChange(of: midX) {oldValue, newValue in
                                                if abs(newValue - screenMidX) < 20 {
                                                    selectedMonth = month
                                                }
                                            }
                                    }
                                    //offsetting frame size by 60
                                    .frame(width: geometry.size.width - 40, height: 250)
                                }
                                .padding(.horizontal, 10)
                            }
                            //when hstack appears on screen scroll to the current month
                            .onAppear {
                                if let index = months.firstIndex(of: selectedMonth) {
                                    scrollView.scrollTo(months[index], anchor: .center)
                                }
                            }
                        }
                        .scrollTargetLayout()
                        .padding(.horizontal, 10)
                    }
                    .contentMargins(16, for: .scrollContent)
                    .scrollTargetBehavior(.viewAligned)
                }
                //need to ensure that the scrollview has fixed height because geometry reader takes the entire available spance
                .frame(height: 250)
                .padding(.bottom, 20)
                
                HStack {
                    Text("\(selectedMonth.capitalized)")
                        .font(.Poppins.semiBold.font(size: 20))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.horizontal, 20)
                Spacer()
                
                Button("Logout"){Task {
                    do {
                        try await Authentication().logout()
                    } catch {

                    print(error.localizedDescription)
                        // Handle error
                    }
                }
                }
                // Display the selected month

            }
            .padding(.top, 30)
            
        }
    }
}

struct Calendar_view: PreviewProvider {
    static var previews: some View {
        SubscriptionsCalendarView()
    }
}


