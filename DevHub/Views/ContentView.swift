//
//  ContentView.swift
//  DevHub
//
//  Created by Adolfo Calderon on 2/23/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Image(systemName: "map.fill")
                }
            
            ConversationView()
                .tabItem {
                    Image(systemName: "person.line.dotted.person")
                }
            
            TestDBView()
                .tabItem {
                    Image(systemName: "plus.app")
                }
            
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
