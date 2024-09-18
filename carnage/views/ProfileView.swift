//
//  profileView.swift
//  carnage
//
//  Created by Diogo Domingos on 15/09/2024.
//

import SwiftUI
import KeychainWrapper

struct ProfileView: View {
    private let keychain: KeychainWrapper = KeychainWrapper(serviceName: "carnage.carnage")
    
    // Wrap this inside an observedobject
    private var accessToken: String?
    private var refreshToken: String?
    
    private func isSignedIn() -> Bool {
        guard let token = accessToken else { return false }
        return !token.isEmpty
    }
    
    var body: some View {
        Text("\(Image(systemName: "info.circle")) profile will appear here... ").bold()
    }
    
}

#Preview {
    ProfileView()
}
