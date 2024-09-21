//
//  Ingredients.swift
//  NetworkingProviders
//
//  Created by Daniil on 22.09.2024.
//

import Foundation

struct Ingredient: Decodable, Hashable {
    let name: String
    let amount: Int
}
