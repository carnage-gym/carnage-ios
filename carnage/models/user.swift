//
//  user.swift
//  carnage
//
//  Created by Diogo Domingos on 15/09/2024.
//

import Foundation

class User : Decodable {
    let name: String
    let age: UInt8
    let weight: UInt8
    let height: UInt8
    let id: UInt8
    var access_token: String
    var refresh_token: String
    
    init(name: String, age: UInt8, weight: UInt8, height: UInt8, id: UInt8, access_token: String, refresh_token: String) {
        self.name = name
        self.age = age
        self.weight = weight
        self.height = height
        self.id = id
        self.access_token = access_token
        self.refresh_token = refresh_token
    }
}
