//
//  AlamofireNetworkManager.swift
//  NetworkingProviders
//
//  Created by Daniil on 19.09.2024.
//

import Alamofire
import Foundation

class AlamofireNetworkManager: NetworkingProvider {
    private let headers = HTTPHeaders( [NetworkingConstants.headerKey: NetworkingConstants.apiKey] )
    
    func searchRecipes(recipeName: String) async throws -> [Recipe] {
        try await AF.request(
            NetworkingConstants.searchRecipe + recipeName,
            headers: headers
        )
        .serializingDecodable(RecipeApiResponse.self).value.results
    }
    
    func getDetailedRecipe(id: Int) async throws -> RecipeDetails {
        try await AF.request(
            NetworkingConstants.recipeDetails + String(id) + "/information",
            headers: headers
        )
        .serializingDecodable(RecipeDetails.self).value
    }
    
    func guessNutrition(dishName: String) async throws -> Nutrition {
        try await AF.request(
            NetworkingConstants.guessNutrition + dishName,
            headers: headers
        )
        .serializingDecodable(Nutrition.self).value
    }
    
    func classifyCuisine(dishName: String, ingredients: String) async throws -> Cuisine {
        let data = [
            "title": dishName,
            "ingredients": ingredients
        ]
        
        return try await AF.request(
            NetworkingConstants.classifyCuisine,
            method: .post,
            parameters: data,
            encoding: JSONEncoding.default,
            headers: headers
        ).serializingDecodable(Cuisine.self).value
    }
}
