//
//  LoginView.swift
//  DevHub
//
//  Created by Adolfo Calderon on 2/23/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var authViewModel = AuthViewModel()

    var body: some View {
        VStack {
            if authViewModel.isAuthenticated {
                // User is authenticated, proceed to the main content
                Text("User is authenticated")
            } else {
                // User is not authenticated, show login button
                Button("Login with GitHub") {
                    authViewModel.loginWithGitHub()
                }
            }
        }
    }
}


#Preview {
    LoginView()
}
