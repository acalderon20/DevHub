//
//  LoginView.swift
//  DevHub
//
//  Created by Adolfo Calderon on 2/23/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var authViewModel = AuthViewModel()
    @State var buttonText = "Login with github"
    var body: some View {
        VStack {
            if authViewModel.isAuthenticated {
                // User is authenticated, proceed to the main content
                ContentView()
            } else {
                // User is not authenticated, show login button
                Button(action: {
                    authViewModel.loginWithGitHub()
                }) {
                    Text(self.buttonText)
                    
                }
            }
        }
    }
}


#Preview {
    LoginView()
}
