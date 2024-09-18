//
//  carnageApp.swift
//  carnage
//
//  Created by Diogo Domingos on 04/09/2024.
//

import SwiftUI
import SwiftData
import KeychainWrapper

@main
struct carnageApp: App {
    static let keychain: KeychainWrapper = KeychainWrapper(serviceName: "carnage.carnage")
    
    private func isLoggedIn() -> Bool {
        let token = carnageApp.keychain.object(of: String.self, forKey: "key.string.token")
        
        guard token != nil else { return false }
        
        // might want to handle expiration too...
        
        return true
    }
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()


    var body: some Scene {
        WindowGroup {
            if isLoggedIn() {
                ContentView()
            } else {
                SignInView()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
