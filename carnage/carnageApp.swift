//
//  carnageApp.swift
//  carnage
//
//  Created by Diogo Domingos on 04/09/2024.
//

import SwiftUI
import SwiftData
import KeychainSwift

@main
struct carnageApp: App {
    static let keychain = KeychainSwift()
    
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
    
    init() {
        if carnageApp.keychain.get("token") != nil { // Refreshes token if needed.
            Task {
                let tokens = try! await API.refresh()
                carnageApp.keychain.set(tokens.token, forKey: "token")
                carnageApp.keychain.set(tokens.refresh_token, forKey: "refresh_token")
            }
        }
    }


    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
