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
    @State private var userID: String? = Auth.auth().currentUser?.uid
    
    //@State private var subscription: Subscription // Holds the subscription being edited, received from previous view
    
    //MARK: Edit to get the name logo and other info from the database

    
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
                            HStack{
                                Button{
                                    print("Dismiss")
                                }      label: {
                                    Label("Dismiss", systemImage: "chevron.down")
                                        .foregroundStyle(.white)
                                    
                                } .padding()
                                Spacer()
//                                Text("Subscription info")
//                                    .multilineTextAlignment(.center)
//                                    .foregroundColor(.white)
//                                Spacer()
                                Button{
                                    
                                                                          //MARK: Ask for confirmation for deletion
//                                    databaseManager.deleteSubscription(withId: subscription.id, forUser: userID!)
//
                                        //MARK: navigate back if deleted
                                                                        
                                                                        
                                }      label: {
                                    Label("Delete", systemImage: "trash")
                                        .foregroundStyle(.white)
                                    
                                } .padding()
                                
                                
                            }
                           
                            Image("spotify")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 180, height: 180)
                                .cornerRadius(40)
                            
                            Text("Spotify")
                                .font(.Poppins.semiBold.font(size: 22))
                                .foregroundColor(.white)
                                .padding()
                            
                        }
                        
                        
                        
                    }.frame(height: .widthPer(percent: 0.8))
                        .padding()
                    Spacer()
                    
                    //MARK: Show other information here
                    
                    
                 //show the amount, editable
                    Text("$23.00").font(.Poppins.semiBold.font(size: 28)).foregroundColor(.white)
                
                    //show description
                    
                    //show end date field
//                    DatePicker(
//                        "End",
//                        selection: $endDate,
//                        displayedComponents: [.date]
//                    )
//                    .datePickerStyle(CompactDatePickerStyle())
//                    .colorScheme(.dark)
                    
                    //do update
                    
                    
                    
                }
            }
     
            
          
        }
    }
}


#Preview {
    EditSubscriptionView()
}
