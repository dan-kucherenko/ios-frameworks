//
//  RecipeDetails.swift
//  NetworkingProviders
//
//  Created by Daniil on 19.09.2024.
//

struct RecipeInfoResponse: Decodable {
    let extendedIngredients: [RecipeDetails]
}

struct RecipeDetails: Decodable {
    let id: Int
    let title: String
    let readyInMinutes: Int
    let image: String
    let summary: String
}
