//
//  profileView.swift
//  carnage
//
//  Created by Diogo Domingos on 15/09/2024.
//

import SwiftUI
import KeychainWrapper

class ProfileViewModel : ObservableObject {
    @Published var user : User? = nil
    
    func set_user() async throws {
        let user = try! await API.getUser()

        DispatchQueue.main.async {
            self.user = user
        }
    }
}

struct ProfileView: View {
    @StateObject var model = ProfileViewModel()
    
    var body: some View {
        VStack {
            Text("Profile").bold()
            
            if model.user != nil {
                Text(model.user!.username)
                
            } else {
                Text("Loading...").bold()
            }
        }.onAppear(perform: {
            Task { 
                try await model.set_user()
            }
        })
    }
    
}

#Preview {
    ProfileView()
}
