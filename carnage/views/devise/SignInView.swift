//
//  SignInView.swift
//  carnage
//
//  Created by Diogo Domingos on 17/09/2024.
//

import SwiftUI

struct SignInView: View {
    @State var email: String
    @State var password: String
    
    @State var accessToken: String
    @State var refreshToken: String
    
    var body: some View {
        Form {
            VStack(alignment: .center){
                Text("Sign In")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
                    .padding()
                // $ works "similarly" to & in C and cpp. The reason one cannot simply use email is because text is of type Binding<String> and not String.
                
                Section {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .padding(.all)
                        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color(red: 220/255, green: 220/255, blue: 220/255)), alignment: .bottom)
                        
                        
                        
                    
                    Spacer()
                                    
                    SecureField("Password", text: $password)
                        .padding(.all)
                        .shadow(radius: 1)
                        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color(red: 220/255, green: 220/255, blue: 220/255)), alignment: .bottom)
                }
                
                
                Button("Sign in") {
                    Task {
                        let tokens = try! await API.getTokens(email: email, password: password)
                        
                        accessToken = tokens.token
                        refreshToken = tokens.refresh_token
                        
                        print("")
                        
                        
                    }
                }.padding()
                
                //VStack {
                //    Text("token: \(accessToken)")
                //    Text("refresh token: \(refreshToken)")
                // }
                
                
                
            }
        }
    }
}

#Preview {
    SignInView(email: "", password: "", accessToken: "", refreshToken: "")
}
