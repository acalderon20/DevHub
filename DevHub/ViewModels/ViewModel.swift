//
//  ViewModel.swift
//  DevHub
//
//  Created by Adolfo Calderon on 2/23/24.
//

import Foundation
import FirebaseAuth
import UIKit

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false

    // Function to initiate GitHub login
    func loginWithGitHub() {
        if let url = URL(string: "https://github.com/login/oauth/authorize?client_id=Iv1.a7c85100b88fdcbd") {
            UIApplication.shared.open(url)
            isAuthenticated = true
        }
    }
}
