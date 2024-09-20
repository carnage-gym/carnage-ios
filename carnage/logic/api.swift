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
            print(data)
            let dec = JSONDecoder()
            tokens = try! dec.decode(Tokens.self, from: data)
        }
        return tokens
    }
}
