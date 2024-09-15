//
//  api.swift
//  carnage
//
//  Created by Diogo Domingos on 15/09/2024.
//

import Foundation

struct API {
    var access_token: String
    var refresh_token: String
    var session = URLSession.shared
    
    func getTokens(username: String, password: String) async throws -> Dictionary<String, String> {

        let url = URL.init(string: "192.168.1.233/users/token/sign_in")!
        var request = URLRequest(url: url)
        let parameters = ["username" : username, "password" : password]
        
        request.httpMethod = "POST"
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        
    
        let s = try session.dataTask(with: request) {data,response,error in
            if let error = error {
                fatalError("Failed to send form data....")
                
            } else if let data = data {
                let dec = JSONDecoder()
                let s = try dec.decode(Dictionary<String, String>, from: data)
                
                
                
            }
        }.resume()
        
        return s
        
        
    }
}
