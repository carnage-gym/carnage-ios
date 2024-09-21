//
//  user.swift
//  carnage
//
//  Created by Diogo Domingos on 15/09/2024.
//

import Foundation

class User : Decodable {
    let username: String
    let age: UInt8?
    let weight: UInt8?
    let height: UInt8?
    let id: UInt8
    
    init(name: String, age: UInt8, weight: UInt8, height: UInt8, id: UInt8) {
        self.username = name
        self.age = age
        self.weight = weight
        self.height = height
        self.id = id
    }
}
