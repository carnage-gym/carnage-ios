//
//  SignInView.swift
//  carnage
//
//  Created by Diogo Domingos on 17/09/2024.
//

import SwiftUI
import KeychainSwift

class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var error_message = ""
}

struct SignInView: View {
    @StateObject var model = SignInViewModel()
    @Binding var signed_in: Bool
    
    @State var button_disabled = false
    
    private func sign_in() async {
        do {
            let tokens = try await API.getTokens(email: model.email.lowercased(), password: model.password)
            carnageApp.keychain.set(tokens.token, forKey: "token")
            carnageApp.keychain.set(tokens.refresh_token, forKey: "refresh_token")
            
            DispatchQueue.main.async {
                signed_in = true
            }
            
        } catch {
            DispatchQueue.main.async { // error_message must be updated in main thread...
                model.error_message = "Invalid credentials.\nMake sure your username and password are correct."
                button_disabled = false
            }
        }
    }
        
    var body: some View {
        Form {
            VStack(alignment: .center){
                Text("Sign In")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
                    .padding()
                
                if !model.error_message.isEmpty {
                    Text(model.error_message).foregroundStyle(.red)
                }
                
                Section {
                    TextField("Email", text: $model.email)
                        .textInputAutocapitalization(TextInputAutocapitalization.never)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.emailAddress)
                        .padding(.all)
                                    
                    SecureField("Password", text: $model.password)
                        .textFieldStyle(.roundedBorder)
                        .padding(.all)
                        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color(red: 220/255, green: 220/255, blue: 220/255)), alignment: .bottom)
                }
                
                Button("Sign in") {
                    model.error_message = "" // resets error message
                    button_disabled = true // prevents user from sending further requests.
                    Task {
                        await sign_in()
                    }
                    
                }.padding().disabled((model.email.isEmpty || model.password.isEmpty) || button_disabled)
                
                //VStack {
                //    Text("token: \(accessToken)")
                //    Text("refresh token: \(refreshToken)")
                // }
            }
        }
    }
}
#Preview {
    // bruh
    let d = ContentView()
    return SignInView(signed_in: d.$model.signed_in)
}

