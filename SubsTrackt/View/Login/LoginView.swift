//
//  LoginView.swift
//  SubsTrackt
//
//  Created by Raven G on 2024-06-25.
//

import Foundation
import SwiftUI
import Firebase
import GoogleSignInSwift

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    var authenticator = Authentication()
    var body: some View {
        ZStack{
            
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "#22313F"), Color(hex: "#1A252F"), Color(hex: "#16222A")]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .edgesIgnoringSafeArea(.all)
            VStack{
                VStack{
                    Text("Welcome Back!").font(Font.Poppins.medium.font(size: 28)).foregroundColor(Color.white)
                        .padding(.bottom,35)
                        .padding(.top, 35)
                    
                    VStack(alignment: .leading, spacing: 10, content: {
                        Text("Username").font(Font.Poppins.semiBold.font())
                            .foregroundColor(.white)
                        
                        CustomTextField(placeholder: "xyz@mail.com", text: $username)
                        Text("Password").font(Font.Poppins.semiBold.font())
                            .padding(.top, 15)
                            .foregroundColor(.white)
                        CustomTextField(placeholder: "*******", text: $password, isPassword: true)
                        
                        
                    })
                    .padding()
                    
                    CustomLoginButton(title: "Login", iconName: "person.fill", backgroundColor: .pink, textColor: .white) {
                        //using Task because it provides an async context whereas the body is not so using an async function cannot be done if not in an sync context
                        Task {
                            do {
                                try await authenticator.emailSignIn(email: username, password: password)
                            } catch let error as AuthError {
                                alertMessage = error.localizedDescription
                                showAlert = true
                            } catch {
                                alertMessage = "An unexpected error occurred."
                                showAlert = true
                            }
                        }
                    }

                    .padding(.bottom, 35)
             
                    
                    
                }
                .background(
                    ZStack {
                        TransparentView(removeFilters: true)
                            .blur(radius: 9)
                            .background(Color.white.opacity(0.05))
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.7), radius: 10, x: 0, y: 10)//bottom shadow
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
                                    .shadow(color: Color.white.opacity(0.5), radius: 5, x: -5, y: -5)  // Top-left highlight
                            )
                            .padding(.horizontal, 20)
                    }
                    
                )
                .padding(.horizontal, 10)
                .padding(.bottom, 30)
                .frame(maxWidth: 350)
                
        
                VStack(spacing: 12){
                    Text("New here?")
                        .font(.Poppins.semiBold.font(size: 14))
                        .foregroundColor(.white)
                    CustomSignUpButton(title: "Email Sign in", iconName: "google"){
                        print("sign up")
                        Task{
                            do {
                                try await authenticator.emailSignUP(email: username, password: password)
                            }
                            catch let error as AuthError {
                                alertMessage = error.localizedDescription
                                showAlert = true
                            } catch {
                                alertMessage = "An unexpected error occurred."
                                showAlert = true
                            }
    
                        }
                    }
                    //MARK: Google sign in button
                    CustomSignUpButton(title: "Google Sign In",iconName: "google") {
                                    Task {
                                        do {
                                            try await authenticator.googleOauth()
                                        }catch let error as AuthError {
                                            alertMessage = error.localizedDescription
                                            showAlert = true
                                        } catch {
                                            alertMessage = "An unexpected error occurred."
                                            showAlert = true
                                        }
                                    }
                                }
                
                    
                }
                .padding(.top, 30)
                
            }
            
        }
        .alert(isPresented: $showAlert) {
                  Alert(
                      title: Text("Error"),
                      message: Text(alertMessage),
                      dismissButton: .default(Text("OK"))
                  )
              }
        
    }
    

}

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var isPassword: Bool = false

    var body: some View {
        Group {
            if isPassword {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
        }
    }            .padding(.vertical, 10)
            .padding(.horizontal, 10)
            .background(Color.gray.opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}
struct CustomSignUpButton: View {
    var title: String
    var iconName: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(iconName)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .aspectRatio(contentMode: .fit)
                Text(title)
                    .font(Font.Poppins.semiBold.font(size: 18))
                    
            }
            .padding(10)
            .foregroundColor(.secondaryText)
            .background(Color.buttonColor)
            .cornerRadius(10)
        }
    }
    
}

struct CustomLoginButton: View {
    var title: String
    var iconName: String
    var backgroundColor: Color
    var textColor: Color
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: iconName)
                    .font(.system(size: 24))
                    .frame(width: 30, height: 30)
                
                Text(title)
                    .font(Font.Poppins.semiBold.font(size: 18))
                    .foregroundColor(textColor)
            }
            .padding(10)
            .background(backgroundColor)
            .cornerRadius(10)
            .frame(minWidth: 0, maxWidth: .infinity)
        }
        .frame(width: 400)
      
    }
}
#Preview {
    LoginView().preferredColorScheme(.dark)
}
