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
    var body: some View{
        
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "#22313F"), Color(hex: "#1A252F"), Color(hex: "#16222A")]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                    HStack {
                        Text("Your Bills")
                            .font(.Poppins.semiBold.font(size: 25))
                            .padding(.horizontal, 25)
                        Spacer()
                        Picker("Select Year", selection: $selectedYear) {
                            ForEach(years, id: \.self) { year in
                                Text(String(year)).tag(year)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())  // Dropdown style
                        .padding(.horizontal)
                        .foregroundColor(.white)
                    }
                
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        ScrollViewReader { scrollView in
                            HStack {
                                ForEach(months, id: \.self) { month in
                                    Image(month)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 250, height: 250)
                                        .cornerRadius(40)
                                        .shadow(color: Color.black.opacity(0.5), radius: 5, x: -5, y: -8)
                                    //MARK: binding selected month state variable to the month being selected. make it bound to which month is in focus
                                        .onTapGesture {
                                            selectedMonth = month
                                        }
                                }
                                .padding(.horizontal)
                                .scrollTransition {
                                    content, phase in content
                                        .opacity(phase.isIdentity ? 1.0 : 0.5)
                                }
                            }
                            //shows the current month
                            .onAppear {
                                if let index = months.firstIndex(of: selectedMonth) {
                                    scrollView.scrollTo(months[index], anchor: .center )
                                }
                            }
                        }
                        .scrollTargetLayout()
                        //remove padding to center when onAppear
                        .padding(.horizontal, 40)
                        
            
                    }
                    
                    .contentMargins(16, for: .scrollContent)
                    .scrollTargetBehavior(.viewAligned)
                
                  
                
//            MARK: display the data for that month
                HStack{
                    Text("\(selectedMonth.capitalized)")
                        .font(.Poppins.semiBold.font(size: 20))
                                         .foregroundColor(.white)
                    Spacer()
                  
                }
                .padding()
                Spacer()
                }
                .padding(.top, 30)
            
            }
        
    }
}

struct Calendar_view: PreviewProvider {
    static var previews: some View {
        SubscriptionsCalendarView().preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}


