//
//  MainView.swift
//  SubsTrackt
//
//  Created by Raven G on 2024-09-01.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView {
            SubscriptionsCalendarView()
                .tabItem {
                    Label("Bills", systemImage: "list.dash")
                }
                .tag(0)
            
            
            AddNewSubscriptionView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Add", systemImage: "square.and.pencil")
                }
                .tag(1)
        }
    }
    
}
//
//struct MainView_Preview: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}

