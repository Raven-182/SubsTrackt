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
          
          if databaseRef == nil {
              print("Database reference is still nil.")
          } else {
              print("Database reference is successfully initialized.")
          }
      }
    func fetchSubs(forUser uid: String) {
        databaseRef.child("subscriptions").child(uid).observeSingleEvent(of: .value) { snapshot in
            var subscriptions: [Subscription] = []
            
            // Loop through the children of the "subscriptions" node
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let subscription = try? snapshot.decode(Subscription.self) {
                    subscriptions.append(subscription)
                }
            }
            
            // Assign the fetched subscriptions to the subs array
            DispatchQueue.main.async {
                self.subs = subscriptions
            }
        }
    }
    
    func addSubscription(_ subscription: Subscription, forUser uid: String) {
         let subscriptionData: [String: Any] = [
             "amount": subscription.amount,
             "category": subscription.category,
             "description": subscription.description,
             "startDate": subscription.startDate.timeIntervalSince1970,
             "endDate": subscription.endDate.timeIntervalSince1970
         ]

         let userSubscriptionsRef = databaseRef.child("subscriptions").child(uid)
         
         // Generate a new unique ID for the subscription
         let newSubscriptionRef = userSubscriptionsRef.childByAutoId()
         
         newSubscriptionRef.setValue(subscriptionData) { error, _ in
             if let error = error {
                 print("Failed to add subscription: \(error.localizedDescription)")
             } else {
                 print("Subscription successfully added.")
             }
         }
     }

    
    
    //MARK: add methods to add update and delete 
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



//{
//  "rules": {
//    ".read": true,
//    ".write": true
//  }
//}
