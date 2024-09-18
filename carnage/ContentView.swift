//
//  ContentView.swift
//  carnage
//
//  Created by Diogo Domingos on 04/09/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView() {
            HomeView().tabItem {
                Label("Home", systemImage: "house.fill")
                    .foregroundStyle(.carnageRed)
            }
            
            LogbookView().tabItem {
                Label("Logbook", systemImage: "book.closed.fill")
                    .foregroundStyle(.carnageRed)
            }
            
            ProfileView().tabItem {
                Label("Profile", systemImage: "person.fill")
                    .foregroundStyle(.carnageRed)
            }
            
        }
        
    }
}

#Preview {
    ContentView()
}
