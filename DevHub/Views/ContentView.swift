//
//  ContentView.swift
//  DevHub
//
//  Created by Adolfo Calderon on 2/23/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var sharedDataModel = SharedDataModel()
    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Image(systemName: "map.fill")
                }
                .environmentObject(sharedDataModel)
            
            ConversationView()
                .tabItem {
                    Image(systemName: "person.line.dotted.person")
                }
            
            TestDBView()
                .tabItem {
                    Image(systemName: "plus.app")
                }
                .environmentObject(sharedDataModel)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                }
            
        }
    }
}

#Preview {
    ContentView()
}
