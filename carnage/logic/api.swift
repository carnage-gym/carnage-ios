//
//  api.swift
//  carnage
//
//  Created by Diogo Domingos on 15/09/2024.
//

import Foundation

enum APIError : Error {
    case InvalidResponse
    case InvalidRequest
}

struct API {
    static var session = URLSession.shared
    static var API_URL = "http://carnage.test"
    
    /// Retrieves access and refresh tokens from carnage api.
    static func getTokens(email: String, password: String) async throws -> Tokens {
        var tokens : Tokens
        let url = URL.init(string: "\(API_URL)/users/tokens/sign_in")!
        let parameters = ["email" : email, "password" : password]
        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
        let (data, response) = try await session.data(for: request)
        
        // Only gets past this line if response is successful
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw APIError.InvalidRequest }
        
        do {
            let dec = JSONDecoder()
            tokens = try! dec.decode(Tokens.self, from: data)
        }
        return tokens
    }

    // TODO: get this to work
    static func getUser() async throws -> User {
        var user: User
        let token = carnageApp.keychain.get("token")!
        let url = URL.init(string: "\(API_URL)/api/profiles")!
        
        
        let (data, _) = try! await getRequest(url: url, token: token)

        do {
            let dec = JSONDecoder()
            user = try! dec.decode(User.self, from: data)
        }
        return user
    }
    
    /// refreshes access and refresh tokens.
    static func refresh() async throws -> Tokens {
        var tokens: Tokens
        let url = URL.init(string: "\(API_URL)/users/tokens/refresh")!
        let rtoken = carnageApp.keychain.get("refresh_token")!
        
        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(rtoken)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await session.data(for: request)
        print((response as! HTTPURLResponse).statusCode)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.InvalidRequest
        }
    
        do {
            let dec = JSONDecoder()
            tokens = try! dec.decode(Tokens.self, from: data)
        }
        
        
        return tokens
    }
    
    /// GET request helper.
    private static func getRequest(url: URL, token: String) async throws -> (Data, URLResponse) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await session.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw APIError.InvalidRequest }
        
        return (data, response)
    }
}
