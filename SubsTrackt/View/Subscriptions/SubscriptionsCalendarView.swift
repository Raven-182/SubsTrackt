//
//  SubscriptionsCalendarView.swift
//  SubsTrackt
//
//  Created by Raven G on 2024-07-16.
//

import Foundation
import SwiftUI
import FirebaseAuth
struct SubscriptionsCalendarView: View{
    @StateObject private var databaseManager = DatabaseManager()
    @State private var selectedYear: Int
    @State private var selectedMonth: String
    @State private var monthlyTotal: Double = 0.99
    @State private var activeSubscriptions: [Subscription] = []
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
                    Text("Total: $\(monthlyTotal, specifier: "%.2f")")
                        .font(.Poppins.semiBold.font(size: 20))
                        .foregroundColor(.white)
                    
                }
                .padding(.horizontal, 20)
                
                
                SubTileView(subscriptions: activeSubscriptions)
                Spacer()
            

            }
            .padding(.top, 30)
            .onChange(of: selectedYear) { oldValue, newValue in
                fetchAndFilterSubscriptions()
            }
            .onChange(of: selectedMonth) { oldValue, newValue in
                fetchAndFilterSubscriptions()
            }
            .onAppear {
                fetchAndFilterSubscriptions()
            }
            
        }
    }
    private func fetchAndFilterSubscriptions() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("No authenticated user found.")
            return
        }
        
        // Fetch subscriptions
        databaseManager.fetchSubs(forUser: uid) {
         
            let calendar = Calendar.current
        
            let selectedMonthIndex = self.months.firstIndex(of: self.selectedMonth)! + 1
            
            self.activeSubscriptions = self.databaseManager.subs.filter { subscription in
                let subscriptionStartComponents = calendar.dateComponents([.year, .month], from: subscription.startDate)
                let subscriptionEndComponents = calendar.dateComponents([.year, .month], from: subscription.endDate)
                
                var startMonth = subscriptionStartComponents.month!
                var startYear = subscriptionStartComponents.year!
                var endMonth = subscriptionEndComponents.month!
                var endYear = subscriptionEndComponents.year!
                
                // If the subscription is ending in the same month, offset the end month by 1
                if startYear == endYear && endMonth == startMonth {
                    endMonth += 1
                }
                
                // Check if the subscription is active during the selected year
                let isYearValid = (self.selectedYear > startYear || (self.selectedYear == startYear && selectedMonthIndex >= startMonth))
                let isMonthValid = (self.selectedYear < endYear || (self.selectedYear == endYear && selectedMonthIndex < endMonth))
                
                return isYearValid && isMonthValid
            }
            
            // Update the total amount based on the filtered subscriptions
            self.monthlyTotal = self.activeSubscriptions.reduce(0) { $0 + $1.amount }
        }
    }


}



struct SubTileView: View {
    var subscriptions: [Subscription]
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 16) {
            ForEach(subscriptions) { subscription in
                SubTile(subscription: subscription)
            }
        }
        .padding(.horizontal)
    }
}
struct SubTile : View {
    var subscription: Subscription

    var body: some View {
        ZStack {
            TransparentView(removeFilters: true)
                .blur(radius: 9)
                .background(Color.white.opacity(0.05))
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.7), radius: 10, x: 0, y: 10)//bottom shadow
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                        .shadow(color: Color.white.opacity(0.5), radius: 5, x: -5, y: -5)  // Top-left highlight
                )
            VStack(alignment: .leading, spacing: 4) {
                Image(subscription.category)
                    .resizable()
                    .frame(width: 40, height: 40)
                Spacer()
                Text(subscription.category)
                    .font(.Poppins.semiBold.font(size: 14))
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Text(String(format: "$%.2f", subscription.amount))
                    .font(.Poppins.semiBold.font(size: 14))
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
            }
            .padding()
      
        }
        .padding(15)
        .frame(minWidth: 0, maxWidth: .infinity)
        .aspectRatio(1, contentMode: .fill)
        .cornerRadius(12)
    }
}

struct Calendar_view: PreviewProvider {
    static var previews: some View {
        SubscriptionsCalendarView()
    }
}


