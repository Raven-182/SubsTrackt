//
//  FirebaseManager.swift
//  SubsTrackt
//
//  Created by Raven G on 2024-08-16.
//

import SwiftUI
import FirebaseCore
import FirebaseDatabase

class DatabaseManager: ObservableObject{
    private var databaseRef: DatabaseReference!
    @Published var subs: [Subscription] = []
    
    
    
    init() {
        databaseRef = Database.database().reference()
        //check for a nil value and end application if no reference
        if databaseRef == nil {
            print("Database reference is still nil.")
        } else {
            print("Database reference is successfully initialized.")
        }
    }
    
    //added completion handler
    func fetchSubs(forUser uid: String, completion: @escaping () -> Void) {
        databaseRef.child("subscriptions").child(uid).observeSingleEvent(of: .value) { snapshot in
            var subscriptions: [Subscription] = []
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot {
                    do {
                        var subscription = try snapshot.decode(Subscription.self)
                        subscription.id = snapshot.key // not redundant because not included in decoding key
                        subscriptions.append(subscription)
                    } catch {
                        print("Failed to decode subscription: \(error)")
                        print("Snapshot value: \(snapshot.value ?? "No value")")
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.subs = subscriptions
                completion() // Call the completion handler when fetching is done
            }
        }
    }
    
    
    func addSubscription(_ subscription: inout Subscription, forUser uid: String, completion: @escaping (Bool) -> Void) {
        let userSubscriptionsRef = databaseRef.child("subscriptions").child(uid)
        
        // Generate a new unique ID for the subscription
        let newSubscriptionRef = userSubscriptionsRef.childByAutoId()
        
        // Assign the generated ID to the subscription model
        let newSubscriptionId = newSubscriptionRef.key
        subscription.id = newSubscriptionId ?? UUID().uuidString  // Use a fallback UUID if for some reason key is nil
        
        let subscriptionData: [String: Any] = [
            "amount": subscription.amount,
            "category": subscription.category,
            "description": subscription.description,
            "startDate": subscription.startDate.timeIntervalSince1970,
            "endDate": subscription.endDate.timeIntervalSince1970
        ]
        
        newSubscriptionRef.setValue(subscriptionData) { error, _ in
            if let error = error {
                print("Failed to add subscription: \(error.localizedDescription)")
                //Mark: Use better error handling in the completion
                completion(false)
            } else {
                print("Subscription successfully added.")
                completion(true)
            }
        }
    }

    
    
    func updateSubscription(_ subscription: Subscription, forUser uid: String, completion: @escaping (Bool) -> Void) {
        let subscriptionData: [String: Any] = [
            "amount": subscription.amount,
            "category": subscription.category,
            "description": subscription.description,
            "startDate": subscription.startDate.timeIntervalSince1970,
            "endDate": subscription.endDate.timeIntervalSince1970
        ]
        
        let userSubscriptionRef = databaseRef.child("subscriptions").child(uid).child(subscription.id)
        
        userSubscriptionRef.updateChildValues(subscriptionData) { error, _ in
            if let error = error {
                print("Failed to update subscription: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Subscription successfully updated.")
                completion(true)
            }
        }
     }
    
    func deleteSubscription(withId subscriptionId: String, forUser uid: String) {
        let userSubscriptionRef = databaseRef.child("subscriptions").child(uid).child(subscriptionId)
        
        userSubscriptionRef.removeValue { error, _ in
            if let error = error {
                print("Failed to delete subscription: \(error.localizedDescription)")
            } else {
                print("Subscription successfully deleted.")
            }
        }
    }
    
}



extension DataSnapshot {
    // Decode DataSnapshot into a Codable type
    func decode<T: Codable>(_ type: T.Type) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: self.value as Any, options: [])
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return try decoder.decode(T.self, from: data)
    }
}
