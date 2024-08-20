//
//  AuthViewModel.swift
//  SubsTrackt
//
//  Created by Raven G on 2024-07-02.
//
import SwiftUI
import Firebase
import GoogleSignIn
enum AuthError: Error, LocalizedError {
case signUpError(String)
case signInError(String)
case unknownError
    var errorDescription: String? {
        switch self {
        case .signUpError(let message),
             .signInError(let message):
            return message
        case .unknownError:
            return "An unknown error occurred."
        }
    }
    

}
struct Authentication {
    


    func googleOauth() async throws {
        // google sign in
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("no firbase clientID found")
        }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        //get rootView
        let scene = await UIApplication.shared.connectedScenes.first as? UIWindowScene
        guard let rootViewController = await scene?.windows.first?.rootViewController
        else {
            fatalError("There is no root view controller!")
        }
        
        //google sign in authentication response
        let result = try await GIDSignIn.sharedInstance.signIn(
            withPresenting: rootViewController
        )
        let user = result.user
        guard let idToken = user.idToken?.tokenString else {
            throw "Unexpected error occurred, please retry"
        }
        
        //Firebase auth
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken, accessToken: user.accessToken.tokenString
        )
        try await Auth.auth().signIn(with: credential)
    }
    
    
    
//    func emailSignUP(email: String, password: String) throws{
//        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//            if error != nil{
//                
//                //MARK: add an alert for the error
//                print(error! .localizedDescription)
//            }
//        }
//        
//    }
//        
//        func emailSignIn(email: String, password: String) throws{
//            Auth.auth().signIn(withEmail: email, password: password){authResult, error in
//                if error != nil{
//                    
//                    //MARK: add an alert for the error
//                    print(error! .localizedDescription)
//                }
//            }
//
//    }
//    
    // MARK: Email Sign Up Method
        func emailSignUP(email: String, password: String) async throws {
            do {
                _ = try await Auth.auth().createUser(withEmail: email, password: password)
            } catch {
                throw AuthError.signUpError(error.localizedDescription)
            }
        }
        
        // MARK: Email Sign In Method
        func emailSignIn(email: String, password: String) async throws {
            do {
                _ = try await Auth.auth().signIn(withEmail: email, password: password)
            } catch {
                throw AuthError.signInError(error.localizedDescription)
            }
        }
    
    
   func logout() async throws {
        GIDSignIn.sharedInstance.signOut()
        try Auth.auth().signOut()
    }
}


extension String: Error {}
