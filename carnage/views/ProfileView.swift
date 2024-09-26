//
//  profileView.swift
//  carnage
//
//  Created by Diogo Domingos on 15/09/2024.
//

import SwiftUI

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
        VStack(alignment: .leading) {
            HStack {
                Group {
                    Circle().frame(width: 75, height: 75).backgroundStyle(.gray)
                        .baselineOffset(0)
                    
                    if model.user != nil {
                        Text(model.user!.username).bold().padding(.leading, 10)
                        
                    } else {
                        Text("Loading...").bold()
                    }
                }
                Spacer()
                Button {
                    
                } label: {
                    Label("", systemImage: "gear").font(.title2)
                }

            }
            Divider()
            
            Text("\(Image(systemName: "info.circle")) statistics will appear here... ").bold()
            Spacer()

            
        }.onAppear(perform: {
            Task {
                try await model.set_user()
            }
        }).frame(alignment: .top).padding(.all, 16)
    }
}
