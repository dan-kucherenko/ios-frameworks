//
//  RecipeDetails.swift
//  NetworkingProviders
//
//  Created by Daniil on 19.09.2024.
//

struct RecipeInfoResponse: Decodable {
    let extendedIngredients: [RecipeDetails]
}

struct RecipeDetails: Decodable, Hashable {
    let id: Int
    let title: String
    let readyInMinutes: Int
    let image: String
    let summary: String
    let extendedIngredients: [Ingredient]
    
    static var mock: Self {
        RecipeDetails(id: 123, title: "123", readyInMinutes: 123, image: "asdasd", summary: "asdadad", extendedIngredients: [])
    }
}
