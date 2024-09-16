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
    static var API_URL = "https://127.0.0.1:3000"
    
    /// Retrieves access and refresh token from carnage api.
    static func getTokens(username: String, password: String) async throws {
        let url = URL.init(string: "\(API_URL)/users/tokens/sign_in")!
        var request = URLRequest(url: url)
        let parameters = ["username" : username, "password" : password]
        
        request.httpMethod = "POST"
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        request.setValue("Content-Type", forHTTPHeaderField: "application/json")
        
        let (data, response) = try await session.data(for: request)
        
        // Only gets past this line if response is successful
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw APIError.InvalidRequest }
        
        
            
        print(data.base64EncodedString())
    }
}
