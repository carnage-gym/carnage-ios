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
    
    init(signed_in: Bool = false) {
        let token = ContentView.keychain.get("token")
        
        if token != nil {
            // todo: handle refresh token...
            
            
            self.signed_in = true
        }
    }

}

struct ContentView: View {
    @StateObject var model = ContentViewModel()
    static let keychain = KeychainSwift()

    
    var body: some View {
        
        if model.signed_in {
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
        } else {
            SignInView(signed_in: $model.signed_in)
        }
        
    }
}

#Preview {
    ContentView()
}
