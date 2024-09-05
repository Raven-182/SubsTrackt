//
//  EditSubscriptionView.swift
//  SubsTrackt
//
//  Created by Raven G on 2024-08-11.
//

import SwiftUI
import FirebaseAuth


struct EditSubscriptionView: View {
    
    @ObservedObject var databaseManager = DatabaseManager()
    // Holds the subscription being edited, received from previous view
    @State private var subscription: Subscription // No default value, will be passed in
    //MARK: Edit to get the name logo and other info from the database
    @State private var subscriptionCategory: SubscriptionCategory = .other
    @Environment(\.dismiss) var dismiss
    // state to show confirmation alert
    @State private var showDeleteConfirmation: Bool = false
    @State private var showSuccessBubble: Bool = false
    @State private var successMessage = "Updated!"
    init(subscription: Subscription) {
        _subscription = State(initialValue: subscription) // Initialize with the passed subscription
    }
    
    var body: some View {
        ZStack {
            AppGradients.primaryBackground
                .ignoresSafeArea()
            
            ScrollView{
                VStack{
                    ZStack {
                        
                        TransparentView(removeFilters: true)
                            .blur(radius: 9)
                            .background(Color.white.opacity(0.05))
                            .cornerRadius(24)
                            .shadow(color: Color.black.opacity(0.7), radius: 10, x: 0, y: 10) // bottom shadow
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
                                    .shadow(color: Color.white.opacity(0.5), radius: 5, x: -5, y: -5)
                            )
                        
                        VStack{
                            let subscriptionCategory = SubscriptionCategory(rawValue: subscription.category) ?? .other
                            HStack{
                                Button{
                                    dismiss()
                                }      label: {
                                    Label("Dismiss", systemImage: "chevron.down")
                                        .foregroundStyle(.white)
                                    
                                } .padding()
                                Spacer()
                                Button{
                                    
                                    //MARK: Ask for confirmation for deletion
                                    showDeleteConfirmation = true
                                    
                                }      label: {
                                    Label("Delete", systemImage: "trash")
                                        .foregroundStyle(.white)
                                    
                                } .padding()
                                
                            }
                            
                            Image(subscriptionCategory.logo)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 180, height: 180)
                                .cornerRadius(40)
                            
                            Text(subscription.category)
                                .font(.Poppins.semiBold.font(size: 22))
                                .foregroundColor(.white)
                                .padding()
                            
                        }
                        
                    }.frame(height: .widthPer(percent: 0.8))
                        .padding()
                    Spacer()
                    
                    
                    //show the amount, editable
                    Text(String(format: "%.2f", subscription.amount)).font(.Poppins.semiBold.font(size: 28)).foregroundColor(.white)
                    Divider().background().frame(width: 350)
                    
                    // Description TextField
                    // Multi-line Description TextEditor
                    TextEditor(text: $subscription.description)
                        .font(.Poppins.regular.font(size: 18))
                        .foregroundColor(.white)
                        .padding()
                    //to hide its default white background
                        .scrollContentBackground(.hidden)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white.opacity(0.1))
                        )
                        .frame(minHeight: 100) // Minimum height, expands as needed
                    
                        .padding()
                    
                    DatePicker(
                        "End",
                        selection: $subscription.endDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(CompactDatePickerStyle())
                    .colorScheme(.dark)
                    .padding(.horizontal, 30)
                    .padding()
                    
                    Divider().background().frame(width: 350)
                    
                    Button("Update subscription") {
                        guard let userID = Auth.auth().currentUser?.uid else {
                            print("No user is logged in.")
                            return
                        }
                        databaseManager.updateSubscription(subscription, forUser: userID) { success in
                            if success {
                                withAnimation {
                                    successMessage = "Updated!"
                                    showSuccessBubble = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation {
                                        showSuccessBubble = false
                                    }
                                }
                            } else {
                                withAnimation {
                                    successMessage = "Couldn't update!"
                                    showSuccessBubble = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation {
                                        showSuccessBubble = false
                                    }
                                }
                            }
                        }
                    }
                    .font(.Poppins.semiBold.font(size: 16))
                    .buttonStyle(primaryButton())
                    .padding()
                    
                    
                }
            }
            // Present the confirmation alert
            .alert(isPresented: $showDeleteConfirmation) {
                Alert(
                    title: Text("Delete Subscription"),
                    message: Text("Are you sure you want to delete this subscription? This action cannot be undone."),
                    primaryButton: .destructive(Text("Delete")) {
                        guard let userID = Auth.auth().currentUser?.uid else {
                            print("No user is logged in.")
                            return
                        }
                        databaseManager.deleteSubscription(withId: subscription.id, forUser: userID)
                        dismiss() // Dismiss modal after deletion
                    },
                    secondaryButton: .cancel()
                )
            }
            
            if showSuccessBubble {
                SuccessBubble(message: successMessage)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .offset(y: 30)
            }
            
        }
    }
}
