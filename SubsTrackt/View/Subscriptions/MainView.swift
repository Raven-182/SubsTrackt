//
//  MainView.swift
//  SubsTrackt
//
//  Created by Raven G on 2024-09-01.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
                    SubscriptionsCalendarView()
                        .tabItem {
                            Label("Bills", systemImage: "list.dash")
                        }

           AddNewSubscriptionView()
                        .tabItem {
                            Label("Add", systemImage: "square.and.pencil")
                        }
                }    }
}

struct MainView_Preview: PreviewProvider {
    static var previews: some View {
        MainView() 
    }
}

