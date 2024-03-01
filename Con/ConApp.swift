//
//  ConApp.swift
//  Con
//
//  Created by Amanda on 14.02.24.
//

import SwiftUI
import Firebase

@main
struct ConApp: App {
    // Register app delegate for Firebase setup
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                TalkListView()
                    .tabItem {
                        Label("Program", systemImage: "book")
                    }
                MapView()
                    .tabItem {
                        Label("Map", systemImage: "map")
                    }
                MembersListView()
                    .tabItem {
                        Label("LOC", systemImage: "folder.badge.person.crop")
                    }
                SOCListView()
                    .tabItem {
                        Label("SOC", systemImage: "person.2.square.stack.fill")
                    }
                RichardView()
                    .tabItem {
                        Label("Richard", systemImage: "graduationcap.fill")
                    }
                
            }
        }
    }
}
