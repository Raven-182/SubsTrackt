//
//  EditSubscriptionView.swift
//  SubsTrackt
//
//  Created by Raven G on 2024-08-11.
//

import SwiftUI


struct EditSubscriptionView: View {
    
    
    //MARK: Edit to get the name logo and other info from the database
    var sample = Subscription(id: "123", endDate: Date(), startDate: Date(), description: "Something something", amount: 12.00, category: "food")
    
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
                                    print("Hello")
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
                    ZStack{
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
                        
    
                    }.padding()
                }
            }
     
            
          
        }
    }
}


#Preview {
    EditSubscriptionView()
}
