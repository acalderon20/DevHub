//
//  ViewModel.swift
//  DevHub
//
//  Created by Adolfo Calderon on 2/23/24.
//

import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false

    // Function to initiate GitHub login
    func loginWithGitHub() {
        // Define the OAuth provider for GitHub
        let provider = OAuthProvider(providerID: "github.com")
        provider.scopes = ["read:user", "user:email"] // Adjust the scopes based on your needs

        // Perform the login
        provider.getCredentialWith(nil) { credential, error in
            if let error = error {
                print("Error during GitHub auth: \(error.localizedDescription)")
                return
            }
            
            if let credential = credential {
                // Use the credential to sign in with Firebase
                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        print("Firebase sign in error: \(error.localizedDescription)")
                        return
                    }
                    
                    // User is signed in
                    // Update the UI based on authentication
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                    }
                }
            }
        }
    }
}
