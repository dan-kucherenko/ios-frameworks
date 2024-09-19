//
//  Recipe.swift
//  NetworkingProviders
//
//  Created by Daniil on 19.09.2024.
//

struct RecipeApiResponse: Decodable {
    let results: [Recipe]
    let offset: Int
    let number: Int
    let totalResults: Int
}

struct Recipe: Decodable, Hashable {
    let id: Int
    let title: String
    let image: String?
}
