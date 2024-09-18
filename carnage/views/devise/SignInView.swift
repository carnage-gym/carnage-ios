//
//  SignInView.swift
//  carnage
//
//  Created by Diogo Domingos on 17/09/2024.
//

import SwiftUI

class SignInViewModel : ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func sign_in() {
        Task {
            let tokens = try! await API.getTokens(email: email.lowercased(), password: password)
            
            carnageApp.keychain.set(tokens.token, forKey: "key.string.token")
            
            print(tokens.token)
        }
    }
}

struct SignInView: View {
    @StateObject var model = SignInViewModel()
        
    var body: some View {
        Form {
            VStack(alignment: .center){
                Text("Sign In")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
                    .padding()
                // $ works "similarly" to & in C and cpp. The reason one cannot simply use email is because text is of type Binding<String> and not String.
                
                Section {
                    TextField("Email", text: $model.email)
                        .keyboardType(.emailAddress)
                        .padding(.all)
                        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color(red: 220/255, green: 220/255, blue: 220/255)), alignment: .bottom)
                        
                    Spacer()
                                    
                    SecureField("Password", text: $model.password)
                        .padding(.all)
                        .shadow(radius: 1)
                        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color(red: 220/255, green: 220/255, blue: 220/255)), alignment: .bottom)
                }
                
                
                Button("Sign in") {
                    
                    model.sign_in()
                }.padding().disabled(model.email.isEmpty || model.password.isEmpty)
                
                //VStack {
                //    Text("token: \(accessToken)")
                //    Text("refresh token: \(refreshToken)")
                // }
                
                
                
            }
        }
    }
}

#Preview {
    SignInView()
}
