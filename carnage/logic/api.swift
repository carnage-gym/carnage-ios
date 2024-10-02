//
//  api.swift
//  carnage
//
//  Created by Diogo Domingos on 15/09/2024.
//

import Foundation

enum APIError : Error {
    case InvalidResponse
    case APIError
}

struct API {
    static var session = URLSession.shared
    static var API_URL = "http://carnage.test"
    
    /// Retrieves access and refresh tokens from carnage api.
    static func getTokens(email: String, password: String) async throws -> Tokens {
        var tokens : Tokens
        let url = URL.init(string: "\(API_URL)/users/tokens/sign_in")!
        let params = ["email" : email, "password" : password]
        let headers = ["Content-Type" : "application/json"]
            
        let (data, response) = try await request(url: url, method: "POST", headers: headers, params: params)
        
        // Only gets past this line if response is successful
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print((response as! HTTPURLResponse).statusCode) // Sometimes req errors out.
            throw APIError.APIError }
        
        do {
            let dec = JSONDecoder()
            tokens = try! dec.decode(Tokens.self, from: data)
        }
        return tokens
    }

    static func getUser() async throws -> User {
        let token = carnageApp.keychain.get("token")!
        let dec = JSONDecoder()
        let url = URL.init(string: "\(API_URL)/api/profiles")!
        
        let headers = ["Content-Type" : "application/json",
                       "Authorization" : "Bearer \(token)"]
        
        let (data, _) = try! await request(url: url, method: "GET", headers: headers, params: [:])
        let user = try! dec.decode(User.self, from: data)
        
        return user
    }
    
    /// refreshes access and refresh tokens.
    static func refresh() async throws -> Tokens {
        var tokens: Tokens
        let url = URL.init(string: "\(API_URL)/users/tokens/refresh")!
        let rtoken = carnageApp.keychain.get("refresh_token")!
        
        let headers = ["Content-Type" : "application/json",
                       "Authorization" : "Bearer \(rtoken)"]
        
        let (data, response) = try await request(url: url, method: "POST", headers: headers, params: [:])
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.APIError
        }
    
        do {
            let dec = JSONDecoder()
            tokens = try! dec.decode(Tokens.self, from: data)
        }
        
        return tokens
    }
    
    static func getRoutines() async throws -> [Routine] {
        let routines: [Routine]
        let url = URL.init(string: "\(API_URL)/api/routines")!
        let token = carnageApp.keychain.get("token")!
        let headers = ["Authorization" : "Bearer \(token)",
                       "Content-Type" : "application/json"]
        
        let (data, response) = try! await request(url: url, method: "GET", headers: headers, params: [:])
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw APIError.APIError }
        
        do {
            let dec = JSONDecoder()
            routines = try! dec.decode([Routine].self, from: data)
        }

        
        return routines
    }

    /// helper function to make requests
    private static func request(url: URL, method: String, headers: [String : String], params: [String : String]) async throws -> (Data, URLResponse) {
        var req = URLRequest(url: url)
        req.httpMethod = method
        
        if (method != "GET") {
            req.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        }
        
        for (key, value) in headers {
            req.setValue(value, forHTTPHeaderField: key)
        }
        
        return try! await API.session.data(for: req)
    }
}
