//
//  DefaultNetworkManager.swift
//  NetworkingProviders
//
//  Created by Daniil on 22.09.2024.
//

import Foundation

class DefaultNetworkManager: NetworkingProvider {    
    private let headers: [String: String] = [NetworkingConstants.headerKey: NetworkingConstants.apiKey]

    func searchRecipes(recipeName: String) async throws -> [Recipe] {
        let url = URL(string: NetworkingConstants.searchRecipe + recipeName)
        guard let url else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let recipeResponse = try JSONDecoder().decode(RecipeApiResponse.self, from: data)
        return recipeResponse.results
    }
    
    func getDetailedRecipe(id: Int) async throws -> RecipeDetails {
        let url = URL(string: NetworkingConstants.recipeDetails + id.description + "/information")
        guard let url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(RecipeDetails.self, from: data)
    }
    
    func guessNutrition(dishId: Int) async throws -> Nutrition {
        let url = URL(string: NetworkingConstants.guessNutrition + dishId.description + "/nutritionWidget.json")
        guard let url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Nutrition.self, from: data)
    }
    
    func classifyCuisine(dishName: String, ingredients: String) async throws -> Cuisine {
        let url = URL(string: NetworkingConstants.classifyCuisine)
        guard let url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = try JSONSerialization.data(withJSONObject: [
            "title": dishName,
            "ingredients": ingredients
        ], options: [])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Cuisine.self, from: data)
    }
}
