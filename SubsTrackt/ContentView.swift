
//  ContentView.swift
//  SubsTrackt
//
//  Created by Raven G on 2024-06-20.
//

import SwiftUI
import Firebase


struct ContentView: View {
    @State private var userLoggedIn = (Auth.auth().currentUser != nil)

       var body: some View {
           VStack {
               if userLoggedIn {
                  //SubscriptionsCalendarView()
                   TestAddSubscriptionView()
                  
               } else {
                   
                   LoginView()
                       
                   
               }
           }.onAppear{
               Auth.auth().addStateDidChangeListener{ auth, user in
                   if (user != nil) {
                       userLoggedIn = true
                   } else {
                       userLoggedIn = false
                   }
               }
           }
       }
}
#Preview {
    ContentView()
}
