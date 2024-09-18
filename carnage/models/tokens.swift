//
//  tokens.swift
//  carnage
//
//  Created by Diogo Domingos on 17/09/2024.
//

import Foundation

class Tokens : Decodable, ObservableObject {
    let token: String
    let refresh_token: String
}
