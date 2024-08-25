//
//  testview.swift
//  SubsTrackt
//
//  Created by Raven G on 2024-08-18.
//


import SwiftUI
import FirebaseAuth

struct TestAddSubscriptionView: View {
    @StateObject private var dbManager = DatabaseManager()
    
    var body: some View {
        VStack {
            
            
            if dbManager.subs.isEmpty {
                         Text("No subscriptions found.")
                     } else {
                         List(dbManager.subs) { subscription in
                             VStack(alignment: .leading) {
                                 Text(subscription.description)
                                     .font(.headline)
                                 Text("Category: \(subscription.category)")
                                 Text("Amount: $\(subscription.amount, specifier: "%.2f")")
                                 Text("Start Date: \(subscription.startDate, formatter: dateFormatter)")
                                 Text("End Date: \(subscription.endDate, formatter: dateFormatter)")
                             }
                         }
                     }
                     
                     Button(action: fetchSubscriptionsForCurrentUser) {
                         Text("Load Subscriptions")
                     }
            Button(action: {
                addSubscriptionForCurrentUser()
            }) {
                Text("Add Subscription")
            }
            .padding()
        }
    }

    func addSubscriptionForCurrentUser() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("No user is logged in.")
            return
        }

        var newSubscription = Subscription(
            id: "", // ID will be auto-generated
            amount: 15.99,
            category: "youtube",
            description: "Monthly streaming service",
            startDate: Date(),
            endDate: Date().addingTimeInterval(30*24*60*60) // 1 month later
        )

        dbManager.addSubscription(&newSubscription, forUser: userID)
        newSubscription.category = "New one"
        dbManager.updateSubscription(newSubscription, forUser: userID)
        
        
    }
    
    func fetchSubscriptionsForCurrentUser() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("No user is logged in.")
            return
        }
        print("hello")
        dbManager.fetchSubs(forUser: userID){
            
        }
      }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}
