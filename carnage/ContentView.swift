//
//  ContentView.swift
//  carnage
//
//  Created by Diogo Domingos on 04/09/2024.
//

import SwiftUI
import SwiftData
import KeychainSwift


class ContentViewModel: ObservableObject {
    @Published var signed_in = false
    @Published var done = false
    
    init() {
        Task { try await setup() }
    }
    
    /// runs code essential for app to function properly. Loading screen is shown while not complete.
    func setup() async throws {
        let token = carnageApp.keychain.get("token")
        
        if token != nil {
            let tokens = try! await API.refresh()
            carnageApp.keychain.set(tokens.token, forKey: "token")
            carnageApp.keychain.set(tokens.refresh_token, forKey: "refresh_token")
        }
        
        DispatchQueue.main.async {
            self.signed_in = token != nil
            self.done = true
        }
    }

}

struct ContentView: View {
    @StateObject var model = ContentViewModel()
    
    var body: some View {    
        if model.done {
            if model.signed_in{
                TabView() {
                    HomeView().tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    
                    LogbookView().tabItem {
                        Label("Logbook", systemImage: "book.closed.fill")
                    }
                    
                    FitnessView().tabItem {
                        Label("Routines", systemImage: "checklist")
                    }
                    
                    ProfileView().tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
                }.tint(.carnageRed)
            } else {
                SignInView(signed_in: $model.signed_in)
            }
            
        } else {
            // future loading screen will appear here.
            Text("Loading...").bold()
        }
    }
}

#Preview {
    ContentView()
}
