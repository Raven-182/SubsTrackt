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

        let newSubscription = Subscription(
            id: "", // ID will be auto-generated
            amount: 15.99,
            category: "Entertainment",
            description: "Monthly streaming service",
            startDate: Date(),
            endDate: Date().addingTimeInterval(30*24*60*60) // 1 month later
        )

        dbManager.addSubscription(newSubscription, forUser: userID)
    }
}
