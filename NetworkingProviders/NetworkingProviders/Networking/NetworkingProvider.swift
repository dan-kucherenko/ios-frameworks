//
//  NetworkingProvider.swift
//  NetworkingProviders
//
//  Created by Daniil on 19.09.2024.
//

struct NetworkingConstants {
    static let headerKey = "x-rapidapi-key"
    static let apiKey = "ece58ba9e9msh75ca3470495a3abp103e68jsnafe49400e7bf"
    
    static let searchRecipe = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/complexSearch?query="
    static let guessNutrition = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/guessNutrition?title="
    static let recipeDetails = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/"
    static let classifyCuisine = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/cuisine"
}

protocol NetworkingProvider: AnyObject {
    func searchRecipes(recipeName: String) async throws -> [Recipe]
    func getDetailedRecipe(id: Int) async throws -> RecipeDetails
    func guessNutrition(dishName: String) async throws -> Nutrition
    func classifyCuisine(dishName: String, ingredients: String) async throws -> Cuisine
}
