//
//  DevHubApp.swift
//  DevHub
//
//  Created by Adolfo Calderon on 2/23/24.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}



@main
struct DevHubApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
    WindowGroup {
      NavigationView {
          LoginView()
              .onOpenURL { url in
              // Handle the URL
              print("URL received: \(url)")
              guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }
              guard let queryItems = urlComponents.queryItems else { return }
              var parameters: [String: String] = [:]

              for queryItem in queryItems {
                  if let value = queryItem.value {
                      parameters[queryItem.name] = value
                  }
              }

              // Now you can access the parameters dictionary for any value you need
              if let param1Value = parameters["code"] {
                  print("Value of param1 is \(param1Value)")
                  
                  fetchPosts(code: param1Value){
                      parameters, error in
                              if let error = error {
                                  print("An error occurred: \(error.localizedDescription)")
                              } else if let parameters = parameters {
                                  print("URL parameters: \(parameters)")
                              }
                  }
              }
              
              
              
          }
      }
    }
  }
    
    

}

struct Post: Decodable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String
    let refresh_token_expires_in: Int
    let scope: String
    let token_type: String
}

func fetchPosts(code: String, completion: @escaping (String?, Error?) -> Void) {
    let urlString = "https://github.com/login/oauth/access_token"
    guard let url = URL(string: urlString) else { return }
    
    var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = [
            "client_id": "Iv1.a7c85100b88fdcbd",
            "client_secret": "96727e561ceb5d30665a706440e6f5b2efb20129",
            "code": code,
            "redirect_uri":"com-myapp-oauth://"
            
        ]
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
    } catch {
        print("Failed to serialize JSON: \(error.localizedDescription)")
        return
    }
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        // Check for errors or no data
        

        
        if let error = error {
            completion(nil, error)
            return
        }
        
        guard let data = data else {
            completion(nil, nil)
            return
        }
        
        if let jsonString = String(data: data, encoding: .utf8) {
                print("Received data: \(jsonString)")
            }
        
        // Parse JSON data
        do {
            if let responseString = String(data: data, encoding: .utf8) {
                let params = responseString.components(separatedBy: "&").reduce(into: [String: String]()) { result, param in
                    let parts = param.components(separatedBy: "=")
                    if parts.count == 2 {
                        result[parts[0]] = parts[1]
                    }
                }
                completion(params["access_token"], nil)
            }
            
                
        } catch {
            print("hmm")
            completion(nil, error)
        }
    }
    task.resume()
}
