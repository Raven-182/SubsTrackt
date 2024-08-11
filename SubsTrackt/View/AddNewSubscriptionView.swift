import Foundation
import SwiftUI

struct AddNewSubscriptionView: View {
    @State var selectedCategory: String = SubscriptionCategory.youtube.displayName
    @State var description: String = ""
    @State var startDate: Date = Date.now
    @State var endDate: Date = Date()
    @State var amount: Double = 0.0
    
    var body: some View {
        ZStack {
            AppGradients.primaryBackground
                          .ignoresSafeArea()
            
            VStack {
                VStack {
                    ZStack {
                        TransparentView(removeFilters: true)
                            .blur(radius: 9)
                            .background(Color.white.opacity(0.05))
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.7), radius: 10, x: 0, y: 10) // bottom shadow
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
                                    .shadow(color: Color.white.opacity(0.5), radius: 5, x: -5, y: -5)
                            )
                        
                        VStack {
                            Text("Add a new subscription")
                                .font(.Poppins.semiBold.font(size: 28))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 1)
                            ScrollView(.horizontal, showsIndicators: false) {
                                ScrollViewReader { _ in
                                    HStack {
                                        ForEach(SubscriptionCategory.allCases) { sub in
                                            GeometryReader { geo in
                                                // Mid point of the image within the global coordinate
                                                let midX = geo.frame(in: .global).midX
                                                // Mid point of the parent frame (scroll view)
                                                let screenMidX = UIScreen.main.bounds.width / 2
                                                
                                                Image(sub.logo)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 200, height: 180)
                                                    .cornerRadius(40)
                                                    .shadow(color: Color.black.opacity(0.5), radius: 5, x: -5, y: -8)
                                                    .scrollTransition(.animated.threshold(.visible(0.8))) { content, phase in
                                                        content.opacity(phase.isIdentity ? 1 : 0)
                                                    }
                                                    .padding(.horizontal, 25)
                                                    .onChange(of: midX) { oldValue, newValue in
                                                        if abs(newValue - screenMidX) < 35 {
                                                            selectedCategory = sub.displayName
                                                        }
                                                    }
                                            }
                                            .frame(width: 200)
                                        }
                                    }
                                }
                                .scrollTargetLayout()
                            }
                            .contentMargins(16, for: .scrollContent)
                            .scrollTargetBehavior(.viewAligned)
                            
                            Text(selectedCategory)
                                .font(.Poppins.semiBold.font(size: 22))
                                .foregroundColor(.white)

                        }
                        .padding(50)
                    }
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: .widthPer(percent: 1)) // Set a fixed height for the inner ZStack because it keeps stretching
                }
//                Text("Description")
//                .foregroundColor(.white.opacity(0.5))
//                                           .padding(.horizontal, 15)
                TextField("", text: $description, prompt: Text("Description").foregroundColor(.white))
                                               .padding()
                                               .frame(height: 60)
                                               .background(
                                                   AppGradients.primaryBackground
                                                       .cornerRadius(8)
                                               )
                                               .overlay(
                                                   RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color.white, lineWidth: 0.1)
                                               )
                                               .foregroundColor(.white)
                                               .padding(.top, 25)
                                               .padding(.horizontal)
                
                
                //date picker for end date and start date 
                HStack(spacing: 15) {
                     // Start Date DatePicker
                     DatePicker(
                         "Start",
                         selection: $startDate,
                         displayedComponents: [.date]
                     )
                     .datePickerStyle(CompactDatePickerStyle())
                     .frame(height: 80)
                     .colorScheme(.dark)
                     // End Date DatePicker
                     DatePicker(
                         "End",
                         selection: $endDate,
                         displayedComponents: [.date]
                     )
                     .datePickerStyle(CompactDatePickerStyle())
                     .colorScheme(.dark)
                    
                }.padding()
                
                HStack(alignment: .center){
                    Button{
                        amount -= 1.0
                        if amount < 0.0{
                            amount = 0.0
                        }
                    } label: {
                        Image("minus")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .cornerRadius(10)
                    }
                    Spacer()
                    VStack{
                        Text("Monthly Price").font(.Poppins.medium.font(size: 12 )).foregroundColor(.white)
                        TextField("", value: $amount, formatter: NumberFormatter())
                               
                                                    .frame(width: 100, height: 50)
                                                                           .overlay(
                                                        RoundedRectangle(cornerRadius: 8)
                                                            .stroke(Color.white, lineWidth: 0.1)
                                                    )
                                                    .foregroundColor(.white)
                                                    .multilineTextAlignment(.center)
                                                    .padding(.bottom, 28)
                                                    .padding(.top, 5)
                    }
                    
                    Spacer()
                    Button{
                        amount += 1.0
                        
                    } label: {
                        Image("plus")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .cornerRadius(10)
                    }
                    
                    
                }.padding(.horizontal, 40)

                Spacer()
                
                Button("Add subscription") {
                
                            print("Button pressed!")
                        }
                .font(.Poppins.semiBold.font(size: 16))
                        .buttonStyle(primaryButton())
                        .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    AddNewSubscriptionView()
}
